package com.thebookquotes.TBQ.dto;

import com.thebookquotes.TBQ.common.Criteria;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookQuotes {
    private String bookUuid;
    private String title;
    private String writer;
    private String memberUuid;
    private String contents;
    private int readNum;
    private String img;
    private Date regiDate;
    private Date editDate;
    private int inuse;
    private String lang;
    private String quotes;
    private String quotes1;
    private String quotes2;
    private String quotes3;
    private int count;

    public BookQuotes(String bookUuid, String title, String writer, String memberUuid, String contents, int readNum,
                      String img, Date regiDate, Date editDate, int inuse, String lang, String quotes1, String quotes2, String quotes3) {
        this.bookUuid = bookUuid;
        this.title = title;
        this.writer = writer;
        this.memberUuid = memberUuid;
        this.contents = contents;
        this.readNum = readNum;
        this.img = img;
        this.regiDate = regiDate;
        this.editDate = editDate;
        this.inuse = inuse;
        this.lang = lang;
        this.quotes1 = quotes1;
        this.quotes2 = quotes2;
        this.quotes3 = quotes3;
    }

    public BookQuotes(String bookUuid, String title, String writer, String memberUuid, String contents, int readNum,
                      String img, Date editDate, String quotes, String quotes1, String quotes2, String quotes3) {
        this.bookUuid = bookUuid;
        this.title = title;
        this.writer = writer;
        this.memberUuid = memberUuid;
        this.contents = contents;
        this.readNum = readNum;
        this.img = img;
        this.editDate = editDate;
        this.quotes = quotes;
        this.quotes1 = quotes1;
        this.quotes2 = quotes2;
        this.quotes3 = quotes3;
    }

    @Data
    public static class BookQuotesWrite {
        private String bookUuid;
        private String title;
        private String memberUuid;
        private String writer;
        private String contents;
        private int readNum;
        private String img;
        private MultipartFile bookImg;
        private int inuse;
        private String lang;
        private String quotes;
        private String quotes1;
        private String quotes2;
        private String quotes3;

    }

    @Data
    public static class ListRequest {
        private Criteria criteria;
        private String memberUuid;
    }

    @Data
    public static class Comment {
        private Integer cmtNum;
        private String cmtUuid;
        private String bookUuid;
        private String memberUuid;
        private String contents;

        private String quotes;
        private Date sysRegDt;
        private int inuse;
        private String memberId;

        public Comment(String cmtUuid, String bookUuid, String memberUuid, String contents, Date sysRegDt, int inuse) {
            this.cmtUuid = cmtUuid;
            this.bookUuid = bookUuid;
            this.memberUuid = memberUuid;
            this.contents = contents;
            this.sysRegDt = sysRegDt;
            this.inuse = inuse;
        }
    }

    @Data
    public static class CommentList {
        private Integer cmtNum;
        private String cmtUuid;
        private String bookUuid;
        private String memberUuid;
        private String contents;
        private Date sysRegDt;
        private int inuse;
        private String memberId;
    }

    @Data
    public static class Scrap {
        private int scrapNum;
        private String scrapUuid;
        private String bookUuid;
        private String memberUuid;
        private Integer inuseScrap;
        private Date sysRegDt;

        public Scrap(String scrapUuid, String bookUuid, String memberUuid, Integer inuseScrap, Date sysRegDt) {
            this.scrapUuid = scrapUuid;
            this.bookUuid = bookUuid;
            this.memberUuid = memberUuid;
            this.inuseScrap = inuseScrap;
            this.sysRegDt = sysRegDt;
        }
    }
}