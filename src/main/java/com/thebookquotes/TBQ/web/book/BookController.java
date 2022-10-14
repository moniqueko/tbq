package com.thebookquotes.TBQ.web.book;

import com.thebookquotes.TBQ.common.*;
import com.thebookquotes.TBQ.dto.BookQuotes;
import com.thebookquotes.TBQ.dto.Maxim;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.book.BookQuoteService;
import com.thebookquotes.TBQ.service.maxim.MaximService;
import com.thebookquotes.TBQ.service.member.MemberService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class BookController {
    private static final Logger LOGGER = LoggerFactory.getLogger(BookController.class);
    private final BookQuoteService bookQuoteService;
    private final MemberService memberService;
    private final MaximService maximService;


    @GetMapping("/")
    public String index(Model model, Criteria cri) {

        List<BookQuotes> board = bookQuoteService.bookList(cri);
        model.addAttribute("board", board);

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        return "/index";
    }

    @GetMapping("/bookList")
    public String searchList(Model model, Criteria cri) {
        if(cri.getKeyword()==null) {
            List<BookQuotes> board = bookQuoteService.bookList(cri);
            model.addAttribute("board", board);

            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCri(cri);
            pageMaker.setTotalCount(bookQuoteService.selectCount());
            pageMaker.setTotalPage(bookQuoteService.selectCount());

            model.addAttribute("pageMaker", pageMaker);

        }else if(cri.getKeyword()!=null){

            List<BookQuotes> board = bookQuoteService.bookList(cri);
            model.addAttribute("board", board);

            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCri(cri);
            pageMaker.setKeyword(cri.getKeyword());
            pageMaker.setTotalCount(bookQuoteService.selectCountSearch(cri.getKeyword()));
            pageMaker.setTotalPage(bookQuoteService.selectCountSearch(cri.getKeyword()));

            model.addAttribute("keyword", cri.getKeyword());
            model.addAttribute("pageMaker", pageMaker);
        }

        return "/book/bookList";
    }

//    @GetMapping("/bookList") 검색기능 없음
//    public String bookList(Model model, Criteria cri) {
//
//        List<BookQuotes> board = bookQuoteService.bookList(cri);
//        System.out.println(board+"board <<<<<<<<<<<<<<<<<<<<<<<<<");
//        model.addAttribute("board", board);
//
//        List<Maxim> maxim = maximService.maximList();
//        model.addAttribute("maxim", maxim);
//
//        PageMaker pageMaker = new PageMaker();
//        pageMaker.setCri(cri);
//        pageMaker.setTotalCount(bookQuoteService.selectCount());
//        pageMaker.setTotalPage(bookQuoteService.selectCount());
//
//        model.addAttribute("pageMaker", pageMaker);
//
//
//        return "/book/bookList";
//    }

    @GetMapping("/book/eng")
    public String langEng(Model model, Criteria cri) {

        if(cri.getKeyword()==null) {
            List<BookQuotes> board = bookQuoteService.listEng(cri);
            model.addAttribute("english", board);

            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCri(cri);
            pageMaker.setTotalCount(bookQuoteService.selectCountEng(cri.getKeyword()));
            pageMaker.setTotalPage(bookQuoteService.selectCountEng(cri.getKeyword()));

            model.addAttribute("pageMaker", pageMaker);

        }else if(cri.getKeyword()!=null){
            List<BookQuotes> board = bookQuoteService.listEng(cri);
            model.addAttribute("english", board);

            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCri(cri);
            pageMaker.setTotalCount(bookQuoteService.selectCountEng(cri.getKeyword()));
            pageMaker.setTotalPage(bookQuoteService.selectCountEng(cri.getKeyword()));
            pageMaker.setKeyword(cri.getKeyword());

            model.addAttribute("pageMaker", pageMaker);
            model.addAttribute("keyword", cri.getKeyword());

        }

        return "/book/bookList";
    }

    @GetMapping("/book/kor")
    public String langKor(Model model, Criteria cri) {
        if(cri.getKeyword()==null) {
            List<BookQuotes> board = bookQuoteService.listKor(cri);
            model.addAttribute("korean", board);

            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCri(cri);
            pageMaker.setTotalCount(bookQuoteService.selectCountKor(cri.getKeyword()));
            pageMaker.setTotalPage(bookQuoteService.selectCountKor(cri.getKeyword()));

            model.addAttribute("pageMaker", pageMaker);

        }else if(cri.getKeyword()!=null){
            List<BookQuotes> board = bookQuoteService.listKor(cri);
            model.addAttribute("korean", board);

            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCri(cri);
            pageMaker.setKeyword(cri.getKeyword());
            pageMaker.setTotalCount(bookQuoteService.selectCountKor(cri.getKeyword()));
            pageMaker.setTotalPage(bookQuoteService.selectCountKor(cri.getKeyword()));

            model.addAttribute("pageMaker", pageMaker);
            model.addAttribute("keyword", cri.getKeyword());
        }

        return "/book/bookList";
    }

    @GetMapping("/scrapBook")
    public String scrapBook(BookQuotes.ListRequest listRequest, Model model, HttpSession session, Criteria cri) {
        Member member = (Member) session.getAttribute("memberInfo");

        if(member==null){
            return "/member/login";
        }
        listRequest.setCriteria(cri);
        listRequest.setMemberUuid(member.getMemberUuid());

        List<BookQuotes> board = bookQuoteService.myScrapList(listRequest);
        model.addAttribute("scrap", board);

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(bookQuoteService.selectCountMyScrap(member.getMemberUuid()));
        pageMaker.setTotalPage(bookQuoteService.selectCountMyScrap(member.getMemberUuid()));

        model.addAttribute("pageMaker", pageMaker);

        return "/my/myBook";
    }

    @GetMapping("/myBook")
    public String myBook(BookQuotes.ListRequest listRequest, HttpSession session, Model model, Criteria cri) {
        Member member = (Member) session.getAttribute("memberInfo");

        if(member==null){
            return "/member/login";
        }
        listRequest.setCriteria(cri);
        listRequest.setMemberUuid(member.getMemberUuid());

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(bookQuoteService.selectCountMyBook(member.getMemberUuid()));
        pageMaker.setTotalPage(bookQuoteService.selectCountMyBook(member.getMemberUuid()));

        model.addAttribute("pageMaker", pageMaker);

        List<BookQuotes> board = bookQuoteService.myBookList(listRequest);
        model.addAttribute("board", board);

        return "/my/myBook";
    }


    @GetMapping("/book") //글쓰기
    public String addBook(HttpSession session, Model model) {
        Member member = (Member) session.getAttribute("memberInfo");

        if(member==null){
            return "/member/login";
        }

        Member info = memberService.selectByUuid(member.getMemberUuid());
        model.addAttribute("memberInfo", info);

        return "/book/addBook";
    }

    @GetMapping("/view/{bookUuid}") //상세보기
    public String viewBook(@PathVariable("bookUuid") String bookUuid, Model model, Criteria cri) {
        BookQuotes bookQuotes = bookQuoteService.selectBookByUuid(bookUuid); //view
        model.addAttribute("book", bookQuotes);

        List<Maxim> maxim = maximService.maximList(); //maxim
        model.addAttribute("maxim", maxim);

        List<BookQuotes> board = bookQuoteService.bookList(cri); //for more
        model.addAttribute("board", board);

        List<BookQuotes.Comment> comment = bookQuoteService.cmtList(bookUuid);
        model.addAttribute("cmt", comment);

        bookQuoteService.updateReadNum(bookUuid);

        return "/book/viewBook";
    }

    @GetMapping("/editBook/{bookUuid}") //수정폼연결
    public String editBook(@PathVariable("bookUuid") String bookUuid,Model model) {
        BookQuotes bookQuotes = bookQuoteService.selectBookByUuid(bookUuid);
        model.addAttribute("book", bookQuotes);

        return "/book/editBook";
    }

    @GetMapping(value="/bookImg/{bookUuid}")
    public @ResponseBody byte[] getBookImg(@PathVariable("bookUuid") String bookUuid) throws IOException {
        BookQuotes bookQuotes = bookQuoteService.selectBookByUuid(bookUuid);
        String url = bookQuotes.getImg();

        InputStream in = new FileInputStream(url);
        return IOUtils.toByteArray(in);
    }

}