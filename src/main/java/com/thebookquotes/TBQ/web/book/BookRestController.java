package com.thebookquotes.TBQ.web.book;

import com.thebookquotes.TBQ.common.ErrorCode;
import com.thebookquotes.TBQ.common.FileHandler;
import com.thebookquotes.TBQ.common.SingleResult;
import com.thebookquotes.TBQ.dto.BookQuotes;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.ResponseService;
import com.thebookquotes.TBQ.service.book.BookQuoteService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class BookRestController {
    private static final Logger LOGGER = LoggerFactory.getLogger(BookRestController.class);
    private final ResponseService responseService;

    private final BookQuoteService bookQuoteService;
    private static final String path = System.getProperty("user.home") + "/Downloads/bookImg";

    @PostMapping("/addBook")
    public SingleResult<?> post(BookQuotes.BookQuotesWrite bookQuotesWrite, @RequestParam("bookImg") MultipartFile multipartFile,
                                HttpSession session) throws Exception {

        Member member = (Member) session.getAttribute("memberInfo");
        String memberUuid = member.getMemberUuid();

        List<String> list = Arrays.asList(bookQuotesWrite.getTitle(), bookQuotesWrite.getContents(), bookQuotesWrite.getWriter(), bookQuotesWrite.getQuotes());
        if (list.stream().anyMatch(String::isEmpty)) return responseService.getFailResult(ErrorCode.PARAMETER_IS_EMPTY);

        if (multipartFile.isEmpty()) {
            return responseService.getFailResult(ErrorCode.NO_FILE);
        }

        String filePath = FileHandler.saveFileFromMultipart(multipartFile, path + "/" + memberUuid);

        bookQuotesWrite.setImg(filePath);
        bookQuotesWrite.setMemberUuid(memberUuid);

        String quotes = bookQuotesWrite.getQuotes(); //1,2,3
        String[] array=  quotes.split(",");

        if(array.length==1){
            bookQuotesWrite.setQuotes1(array[0]);
            bookQuotesWrite.setQuotes(array[0]);

        }else if(array.length==2){
            bookQuotesWrite.setQuotes1(array[0]);
            bookQuotesWrite.setQuotes2(array[1]);
            bookQuotesWrite.setQuotes(array[0] + "," + array[1]);

        }else if(array.length==3){
            bookQuotesWrite.setQuotes1(array[0]);
            bookQuotesWrite.setQuotes2(array[1]);
            bookQuotesWrite.setQuotes3(array[2]);
        }

        bookQuoteService.insertBook(bookQuotesWrite);

        return responseService.getSuccessResult();
    }

    @PostMapping("/book/delete")
    public SingleResult<?> delete(@RequestBody String bookUuid) throws Exception {
        if (bookUuid == null) {
            return responseService.getFailResult(ErrorCode.PARAMETER_IS_EMPTY);
        }
        BookQuotes bookQuotes = bookQuoteService.selectBookByUuid(bookUuid);

        if (bookQuotes == null) {
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }

        bookQuoteService.deleteBook(bookUuid);
        FileHandler.folderDelete(path + "/" + bookQuotes.getImg());

        return responseService.getSuccessResult();
    }

    @PostMapping("/cmtWrite")
    public SingleResult<?> cmtWrite(@RequestBody BookQuotes.Comment cmt, HttpSession session, BookQuotes.CommentList cmtList) throws Exception {
        Member member = (Member) session.getAttribute("memberInfo");
        if(member==null){
            return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);
        }

        if (!StringUtils.hasText(cmt.getBookUuid()) || !StringUtils.hasText(cmt.getContents())) {
            return responseService.getFailResult(ErrorCode.PARAMETER_IS_EMPTY);
        }

        String uuid = member.getMemberUuid();
        cmt.setMemberUuid(uuid);

        bookQuoteService.insertCmt(cmt);
        return responseService.getSuccessResult();
    }

    @PostMapping("/addScrap")
    public SingleResult<?> addScrap(BookQuotes.Scrap scrap, @RequestBody String bookUuid, HttpSession session) throws Exception {
        Member member = (Member) session.getAttribute("memberInfo");
        String memberUuid = member.getMemberUuid();

        if(member==null){
            return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);
        }
        if (!StringUtils.hasText(bookUuid)) {
            return responseService.getFailResult(ErrorCode.PARAMETER_IS_EMPTY);
        }

        scrap.setMemberUuid(memberUuid);
        scrap.setBookUuid(bookUuid);
        int result = bookQuoteService.checkScrap(scrap);

        if(result==0){
            bookQuoteService.insertScrap(scrap);
            bookQuoteService.updateCountBook(bookUuid);

            BookQuotes bookQuotes = bookQuoteService.selectBookByUuid(bookUuid); //이미 스크랩된수
            int count = bookQuotes.getCount();
            return responseService.getSingleResult(count);

        }else if(result>=1){
            return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);
        }
        return responseService.getSuccessResult();
    }

    @PostMapping("/editBook")
    public SingleResult<?> editBook(BookQuotes.BookQuotesWrite bookQuotesWrite, @RequestParam("bookImg") MultipartFile multipartFile,
                                  HttpSession session) throws Exception {
        Member member = (Member) session.getAttribute("memberInfo");
        String memberUuid = member.getMemberUuid();

        if (member == null) {
            return responseService.getFailResult(ErrorCode.NO_PARAMETERS);
        }

        List<String> list = Arrays.asList(bookQuotesWrite.getTitle(), bookQuotesWrite.getContents(), bookQuotesWrite.getQuotes());
        if (list.stream().anyMatch(String::isEmpty)) return responseService.getFailResult(ErrorCode.PARAMETER_IS_EMPTY);

        BookQuotes bookQuotes = bookQuoteService.selectBookByUuid(bookQuotesWrite.getBookUuid());

        if (!member.getMemberUuid().equals(bookQuotes.getMemberUuid())){ // 글쓴이와 로그인한 uuid 다를때
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }

        if (!multipartFile.isEmpty()) {
        FileHandler.fileDelete(bookQuotes.getImg()); //이전 파일 삭제

        String filePath = FileHandler.saveFileFromMultipart(multipartFile, path + "/" + memberUuid);
        bookQuotesWrite.setImg(filePath);

        }else if(multipartFile.isEmpty()){
            bookQuotesWrite.setImg(bookQuotes.getImg());
        }

        String quotes = bookQuotesWrite.getQuotes(); //1,2,3
        String[] array=  quotes.split(",");

        if(array.length==1){
            bookQuotesWrite.setQuotes1(array[0]);
            bookQuotesWrite.setQuotes(array[0]);

        }else if(array.length==2){
            bookQuotesWrite.setQuotes1(array[0]);
            bookQuotesWrite.setQuotes2(array[1]);
            bookQuotesWrite.setQuotes(array[0] + "," + array[1]);

        }else if(array.length==3){
            bookQuotesWrite.setQuotes1(array[0]);
            bookQuotesWrite.setQuotes2(array[1]);
            bookQuotesWrite.setQuotes3(array[2]);
        }

        bookQuoteService.updateBook(bookQuotesWrite);

        return responseService.getSuccessResult();
    }
}