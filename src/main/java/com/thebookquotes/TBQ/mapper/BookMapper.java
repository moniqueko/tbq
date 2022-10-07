package com.thebookquotes.TBQ.mapper;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.dto.BookQuotes;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookMapper {
    List<BookQuotes> bookList(Criteria cri);
    int selectCount();
    void insertBook(BookQuotes bookQuotes);
    BookQuotes updateBook(BookQuotes.BookQuotesWrite bookQuotesWrite);
    void deleteBook(BookQuotes.BookQuotesWrite bookQuotesWrite);
    BookQuotes selectBookByUuid(String bookUuid);

    void insertCmt(BookQuotes.Comment cmt);

}
