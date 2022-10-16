package com.thebookquotes.TBQ.mapper;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.common.CriteriaBoard;
import com.thebookquotes.TBQ.dto.BookQuotes;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookMapper {
    List<BookQuotes> bookList(Criteria cri);
    List<BookQuotes> bookListAdmin(CriteriaBoard cri);
    List<BookQuotes> listKor(Criteria cri);
    List<BookQuotes> listEng(Criteria cri);
    List<BookQuotes> myBookList(BookQuotes.ListRequestBoard listRequest);
    List<BookQuotes> myScrapList(BookQuotes.ListRequestBoard listRequest);
    int selectCount();
    int selectCountSearch(String keyword);
    int selectCountMyBook(String memberUuid);
    int selectCountMyScrap(String memberUuid);
    int selectCountKor(String keyword);
    int selectCountEng(String keyword);

    void insertBook(BookQuotes bookQuotes);
    void updateBook(BookQuotes bookQuotes);
    void deleteBook(String bookUuid);

    BookQuotes selectBookByUuid(String bookUuid);
    void updateReadNum(String bookUuid);
    void updateCountBook(String bookUuid);

    void insertCmt(BookQuotes.Comment cmt);
    List<BookQuotes.Comment> cmtList(String bookUuid);
    BookQuotes.Comment selectByCmtUuid(String cmtUuid);
    void deleteCmt(String cmtUuid);

    void insertScrap(BookQuotes.Scrap scrap);
    int checkScrap(BookQuotes.Scrap scrap);
}
