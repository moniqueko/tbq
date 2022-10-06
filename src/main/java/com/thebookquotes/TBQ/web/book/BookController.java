package com.thebookquotes.TBQ.web.book;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.common.PageMaker;
import com.thebookquotes.TBQ.dto.BookQuotes;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.book.BookQuoteService;
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

    @GetMapping("/")
    public String index(HttpSession session, Model model, Criteria cri) {

        List<BookQuotes> board = bookQuoteService.bookList(cri);
        model.addAttribute("board", board);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(bookQuoteService.selectCount());
        pageMaker.setTotalPage(bookQuoteService.selectCount());

        model.addAttribute("pageMaker", pageMaker);

        return "/index";
    }

    @GetMapping("/book")
    public String addBook(HttpSession session, Model model) {
        Member member = (Member) session.getAttribute("memberInfo");

        System.out.println(member);

        if(member==null){
            return "/member/login";
        }

        Member info = memberService.selectByUuid(member.getMemberUuid());
        model.addAttribute("memberInfo", info);

        return "/book/addBook";
    }


    @GetMapping("/book/{bookUuid}")
    public String modify(@PathVariable("bookUuid") String bookUuid, Model model, HttpServletRequest request) {
        BookQuotes bookQuotes = bookQuoteService.selectBookByUid(bookUuid);
        model.addAttribute("board", bookQuotes);

        return "/book/addBook";
    }

    @GetMapping("/bookList")
    public String bookList(Criteria cri, Model model, HttpServletRequest request){
        System.out.println(cri +"cri <<<<<<<<<<<<<<<<<<<<<<");
        List<BookQuotes> board = bookQuoteService.bookList(cri);
        model.addAttribute("board", board);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(bookQuoteService.selectCount());
        pageMaker.setTotalPage(bookQuoteService.selectCount());

        model.addAttribute("pageMaker", pageMaker);

        return "book/bookList";
    }

    @GetMapping(value="/bookImg/{bookUuid}")
    public @ResponseBody byte[] getBookImg(HttpServletRequest request, @PathVariable("bookUuid") String bookUuid) throws IOException {
        BookQuotes bookQuotes = bookQuoteService.selectBookByUid(bookUuid);
        String url = bookQuotes.getImg();

        InputStream in = new FileInputStream(url);
        return IOUtils.toByteArray(in);
    }
}