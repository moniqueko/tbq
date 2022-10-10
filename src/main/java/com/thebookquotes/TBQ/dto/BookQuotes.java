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
    private Date sysRegDt;
    private Date sysUdtDt;
    private int inuse;
    private String lang;
    private String quotes;

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
}