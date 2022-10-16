package com.thebookquotes.TBQ.service.book.impl;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.dto.BookQuotes;
import com.thebookquotes.TBQ.mapper.BookMapper;
import com.thebookquotes.TBQ.service.book.BookQuoteService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class BookQuoteServiceImpl implements BookQuoteService {
    @Resource
    BookMapper mapper;

    @Override
    public List<BookQuotes> bookList(Criteria cri) {
        return mapper.bookList(cri);
    }
    @Override
    public List<BookQuotes> listKor(Criteria cri) {
        return mapper.listKor(cri);
    }
    @Override
    public List<BookQuotes> listEng(Criteria cri) {
        return mapper.listEng(cri);
    }
    @Override
    public List<BookQuotes> myBookList(BookQuotes.ListRequestBoard listRequest) {
        return mapper.myBookList(listRequest);
    }
    @Override
    public List<BookQuotes> myScrapList(BookQuotes.ListRequestBoard listRequest) {
        return mapper.myScrapList(listRequest);
    }

    @Override
    public int selectCountSearch(String keyword) {
        return mapper.selectCountSearch(keyword);
    }
    @Override
    public int selectCount() {
        return mapper.selectCount();
    }

    @Override
    public int selectCountMyBook(String memberUuid) {
        return mapper.selectCountMyBook(memberUuid);
    }

    @Override
    public int selectCountMyScrap(String memberUuid) {
        return mapper.selectCountMyScrap(memberUuid);
    }

    @Override
    public int selectCountKor(String keyword) { return mapper.selectCountKor(keyword); }
    @Override
    public int selectCountEng(String keyword) { return mapper.selectCountEng(keyword); }

    @Override
    public void insertBook(BookQuotes.BookQuotesWrite bookQuotesWrite) {
        BookQuotes insert = new BookQuotes(null, bookQuotesWrite.getTitle(), bookQuotesWrite.getWriter(), bookQuotesWrite.getMemberUuid(),
                bookQuotesWrite.getContents(),0, bookQuotesWrite.getImg(), null, null, 1,bookQuotesWrite.getLang(),
                bookQuotesWrite.getQuotes(), bookQuotesWrite.getQuotes1(), bookQuotesWrite.getQuotes2(), bookQuotesWrite.getQuotes3(), 0);

        mapper.insertBook(insert);
    }

    @Override
    public void updateBook(BookQuotes.BookQuotesWrite bookQuotesWrite) {
        BookQuotes insert = new BookQuotes(bookQuotesWrite.getBookUuid(), bookQuotesWrite.getTitle(), bookQuotesWrite.getWriter(), bookQuotesWrite.getMemberUuid(),
                bookQuotesWrite.getContents(),0, bookQuotesWrite.getImg(), null,
                bookQuotesWrite.getQuotes(), bookQuotesWrite.getQuotes1(), bookQuotesWrite.getQuotes2(), bookQuotesWrite.getQuotes3());

        mapper.updateBook(insert);
    }

    @Override
    public void deleteBook(String bookUuid) {
        mapper.deleteBook(bookUuid);
    }

    @Override
    public void updateReadNum(String bookUuid) {
        mapper.updateReadNum(bookUuid);
    }

    @Override
    public BookQuotes selectBookByUuid(String bookUuid) {
        return mapper.selectBookByUuid(bookUuid);
    }

    @Override
    public void insertCmt(BookQuotes.Comment cmt) {
        BookQuotes.Comment insert = new BookQuotes.Comment(null, cmt.getBookUuid(),cmt.getMemberUuid(),cmt.getContents(), null, 1);
        mapper.insertCmt(insert);
    }

    @Override
    public List<BookQuotes.Comment> cmtList(String bookUuid) {
        return mapper.cmtList(bookUuid);
    }

    @Override
    public BookQuotes.Comment selectByCmtUuid(String cmtUuid) {
        return mapper.selectByCmtUuid(cmtUuid);
    }

    @Override
    public void deleteCmt(String cmtUuid) {
        mapper.deleteCmt(cmtUuid);
    }

    @Override
    public void insertScrap(BookQuotes.Scrap scrap) {
        BookQuotes.Scrap insert = new BookQuotes.Scrap(null,scrap.getBookUuid(),scrap.getMemberUuid(), 1, null);
        mapper.insertScrap(insert);
    }

    @Override
    public void updateCountBook(String bookUuid) {
        mapper.updateCountBook(bookUuid);
    }

    @Override
    public int checkScrap(BookQuotes.Scrap scrap) {
        int cnt = mapper.checkScrap(scrap);
        return cnt;
    }

}