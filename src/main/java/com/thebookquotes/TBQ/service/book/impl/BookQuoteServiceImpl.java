package com.thebookquotes.TBQ.service.book.impl;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.dto.BookQuotes;
import com.thebookquotes.TBQ.mapper.BookMapper;
import com.thebookquotes.TBQ.service.book.BookQuoteService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class BookQuoteServiceImpl implements BookQuoteService {

    @Resource
    BookMapper mapper;
    private String bookUuid = "TBQ" + UUID.randomUUID().toString().replace("-", "").substring(20);
    private String cmtUuid = "CMT" + UUID.randomUUID().toString().replace("-", "").substring(20);


    @Override
    public List<BookQuotes> bookList(Criteria cri) {
        return mapper.bookList(cri);
    }

    @Override
    public int selectCount() {
        return mapper.selectCount();
    }

    @Override
    public void insertBook(BookQuotes.BookQuotesWrite bookQuotesWrite) {
        BookQuotes insert = new BookQuotes(bookUuid, bookQuotesWrite.getTitle(), bookQuotesWrite.getWriter(), bookQuotesWrite.getMemberUuid(),
                        bookQuotesWrite.getContents(),0, bookQuotesWrite.getImg(), null, null, 1,bookQuotesWrite.getLang());

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
        BookQuotes.Comment insert = new BookQuotes.Comment(cmtUuid, cmt.getBookUuid(),cmt.getMemberUuid(),cmt.getContents(), null, 1);
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