package com.thebookquotes.TBQ.web.book;

import com.thebookquotes.TBQ.common.ErrorCode;
import com.thebookquotes.TBQ.common.FileHandler;
import com.thebookquotes.TBQ.common.SingleResult;
import com.thebookquotes.TBQ.dto.BookQuotes;
import com.thebookquotes.TBQ.service.ResponseService;
import com.thebookquotes.TBQ.service.book.BookQuoteService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class BookRestController {
    private static final Logger LOGGER = LoggerFactory.getLogger(BookRestController.class);
    private final ResponseService responseService;

    private final BookQuoteService bookQuoteService;
    private static final String path = System.getProperty("user.home") + "Downloads/bookImg";

    @PostMapping("/addBook")
    public SingleResult<?> post(BookQuotes.BookQuotesWrite bookQuotesWrite, @RequestParam("memberUuid") String memberUuid, @RequestParam("bookImg") MultipartFile multipartFile,
                                HttpServletRequest request, HttpSession session) throws Exception {

        List<String> list = Arrays.asList(bookQuotesWrite.getTitle(), bookQuotesWrite.getContents());
        if (list.stream().anyMatch(String::isEmpty)) return responseService.getFailResult(ErrorCode.PARAMETER_IS_EMPTY);

        if (multipartFile.isEmpty()) {
            return responseService.getFailResult(ErrorCode.NO_FILE);
        }

        String filePath = FileHandler.saveFileFromMultipart(multipartFile, path + "/" + memberUuid); //멤버아이디 넣기

        bookQuotesWrite.setImg(filePath);
        bookQuotesWrite.setMemberUuid(memberUuid);
        bookQuoteService.insertBook(bookQuotesWrite);


//        BookQuotes.BookQuotesWrite bookUpdate = new BookQuotes.BookQuotesWrite();
//        bookUpdate.setBookUid(adMedia.getTvUid());
//        bookUpdate.setImgFile(filePath);
//        bookUpdate.setImgFileReal(path + "/" + adMedia.getTvUid() + "/" + multipartFile.getOriginalFilename());
//
//        adMediaService.updateAdMedia(adMediaUpdate);

        return responseService.getSuccessResult();
    }

    @PostMapping("/addBook/{memberUuid}")
    public SingleResult<?> modify(BookQuotes.BookQuotesWrite bookQuotesWrite, @PathVariable String memberUuid, @RequestParam("bookImg") MultipartFile multipartFile,
                                  HttpServletRequest request) throws Exception {

        List<String> list = Arrays.asList(bookQuotesWrite.getTitle(), bookQuotesWrite.getContents());
        if (list.stream().anyMatch(String::isEmpty)) return responseService.getFailResult(ErrorCode.PARAMETER_IS_EMPTY);

        BookQuotes bookQuotes = bookQuoteService.selectBookByUid(memberUuid);

        if (bookQuotes == null) {
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }

        if (!multipartFile.isEmpty()) {
            FileHandler.fileDelete(bookQuotes.getImg());

            String filePath = FileHandler.saveFileFromMultipart(multipartFile, path + "/" + memberUuid);
            bookQuotesWrite.setImg(filePath);
        }

        bookQuoteService.updateBook(bookQuotesWrite);

        return responseService.getSuccessResult();
    }

    @PostMapping("/book/delete")
    public SingleResult<?> delete(@RequestBody String uuid, BookQuotes.BookQuotesWrite bookQuotesWrite) throws Exception {
        if (uuid == null) {
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }
        BookQuotes bookQuotes = bookQuoteService.selectBookByUid(uuid);

        if (bookQuotes == null) {
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }

        FileHandler.folderDelete(path + "/" + bookQuotes.getImg());

        bookQuotesWrite.setInuse(0);
        bookQuotesWrite.setBookUuid(uuid);
        bookQuoteService.deleteBook(bookQuotesWrite);

        return responseService.getSuccessResult();
    }
}