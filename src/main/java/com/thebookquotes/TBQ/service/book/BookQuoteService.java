package com.thebookquotes.TBQ.service.book;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.dto.BookQuotes;
import java.util.List;

public interface BookQuoteService {
    List<BookQuotes> bookList(Criteria cri);
    int selectCount();
    void insertBook(BookQuotes.BookQuotesWrite bookQuotesWrite);
    BookQuotes updateBook(BookQuotes.BookQuotesWrite bookQuotesWrite);
    void deleteBook(String bookUuid);
    BookQuotes selectBookByUuid(String bookUuid);

    void insertCmt(BookQuotes.Comment cmt);
}
