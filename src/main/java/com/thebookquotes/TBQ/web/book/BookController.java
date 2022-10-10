package com.thebookquotes.TBQ.web.book;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.common.PageMaker;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
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
    public String index(HttpSession session, Model model, Criteria cri) {

        List<BookQuotes> board = bookQuoteService.bookList(cri);
        model.addAttribute("board", board);

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        return "/index";
    }

    @GetMapping("/bookList")
    public String bookList(HttpSession session, Model model, Criteria cri) {

        List<BookQuotes> board = bookQuoteService.bookList(cri);
        model.addAttribute("board", board);

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(bookQuoteService.selectCount());
        pageMaker.setTotalPage(bookQuoteService.selectCount());

        model.addAttribute("pageMaker", pageMaker);


        return "/book/bookList";
    }

    @GetMapping("/book/eng")
    public String langKor(HttpSession session, Model model, Criteria cri) {

        List<BookQuotes> board = bookQuoteService.listEng(cri);
        model.addAttribute("english", board);

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(bookQuoteService.selectCountEng());
        pageMaker.setTotalPage(bookQuoteService.selectCountEng());

        model.addAttribute("pageMaker", pageMaker);

        return "/book/bookList";
    }

    @GetMapping("/book/kor")
    public String langEng(HttpSession session, Model model, Criteria cri) {

        List<BookQuotes> board = bookQuoteService.listKor(cri);
        model.addAttribute("korean", board);

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(bookQuoteService.selectCountKor());
        pageMaker.setTotalPage(bookQuoteService.selectCountKor());

        model.addAttribute("pageMaker", pageMaker);

        return "/book/bookList";
    }

//    @GetMapping("/scrapBook")
//    public String scrapBook(HttpSession session, Model model, Criteria cri) {
//
//        List<BookQuotes> board = bookQuoteService.scrapBookList(cri);
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

        return "/book/addBook2";
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


        return "/book/viewBook";
    }

    @GetMapping("/editBook/{bookUuid}") //수정폼연결
    public String editBook(@PathVariable("bookUuid") String bookUuid,Model model, HttpServletRequest request) {
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