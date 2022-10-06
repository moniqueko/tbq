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

    }

}
