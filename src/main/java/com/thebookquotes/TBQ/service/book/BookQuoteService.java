package com.thebookquotes.TBQ.service.book;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.dto.BookQuotes;
import java.util.List;

public interface BookQuoteService {
    List<BookQuotes> bookList(Criteria cri);
    List<BookQuotes> listKor(Criteria cri);
    List<BookQuotes> listEng(Criteria cri);

    List<BookQuotes> myBookList(BookQuotes.ListRequest listRequest);
    List<BookQuotes> myScrapList(BookQuotes.ListRequest listRequest);

    int selectCount();
    int selectCountMyBook(String memberUuid);
    int selectCountMyScrap(String memberUuid);

    int selectCountKor();
    int selectCountEng();
    void insertBook(BookQuotes.BookQuotesWrite bookQuotesWrite);
    BookQuotes updateBook(BookQuotes.BookQuotesWrite bookQuotesWrite);
    void deleteBook(String bookUuid);
    BookQuotes selectBookByUuid(String bookUuid);

    void insertCmt(BookQuotes.Comment cmt);
    List<BookQuotes.Comment> cmtList(String bookUuid);
    BookQuotes.CommentList selectByCmtUuid(BookQuotes.Comment cmt);
    void insertScrap(BookQuotes.Scrap scrap);
    void updateCountBook(String bookUuid);
    int checkScrap(BookQuotes.Scrap scrap);
}
