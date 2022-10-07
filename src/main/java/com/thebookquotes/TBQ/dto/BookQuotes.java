package com.thebookquotes.TBQ.dto;

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
    private Date sysRegDt;
    private Date sysUdtDt;
    private int inuse;
    private String lang;

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

    }
    @Data
    public static class Comment {
        private int cmtNum;
        private String bookUuid;
        private String memberUuid;
        private String contents;
        private Date sysRegDt;
        private int inuse;

        public Comment(String bookUuid, String memberUuid, String contents, int inuse, Date sysRegDt) {
            this.bookUuid = bookUuid;
            this.memberUuid = memberUuid;
            this.contents = contents;
            this.inuse = inuse;
            this.sysRegDt = sysRegDt;
        }
    }

}
