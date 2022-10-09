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
    public int selectCount() {
        return mapper.selectCount();
    }

    @Override
    public int selectCountKor() {
        return mapper.selectCountKor();

    }

    @Override
    public int selectCountEng() {
        return mapper.selectCountEng();

    }

    @Override
    public void insertBook(BookQuotes.BookQuotesWrite bookQuotesWrite) {
        BookQuotes insert = new BookQuotes(null, bookQuotesWrite.getTitle(), bookQuotesWrite.getWriter(), bookQuotesWrite.getMemberUuid(),
                        bookQuotesWrite.getContents(),0, bookQuotesWrite.getImg(), null, null, 1,bookQuotesWrite.getLang(),bookQuotesWrite.getQuotes());

        mapper.insertBook(insert);
    }

    @Override
    public BookQuotes updateBook(BookQuotes.BookQuotesWrite bookQuotesWrite) {
        mapper.updateBook(bookQuotesWrite);

        return selectBookByUuid(bookQuotesWrite.getBookUuid());
    }

    @Override
    public void deleteBook(String bookUuid) {
        mapper.deleteBook(bookUuid);
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
    public BookQuotes.CommentList selectByCmtUuid(BookQuotes.Comment cmt) {
        return mapper.selectByCmtUuid(cmt);
    }

}