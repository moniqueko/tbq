package com.thebookquotes.TBQ.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;

@Data
@AllArgsConstructor
public class Member {
    private String memberUuid;
    private String memberId;
    private String memberPw;
    private String memberEmail;
    private int memberGrant;
    private Date memberLastLogin;
    private int memberInuse ;
    private Date memberRegiDate;
    private Date memberEditDate;

    public Member() {}

    public Member(String memberUuid, String memberId, String memberPw, int memberGrant, Date memberLastLogin,
                  int memberInuse, Date memberRegiDate, Date memberEditDate, String memberEmail) {
        this.memberUuid = memberUuid;
        this.memberId = memberId;
        this.memberPw = memberPw;
        this.memberEmail = memberEmail;
        this.memberGrant = memberGrant;
        this.memberLastLogin = memberLastLogin;
        this.memberInuse = memberInuse;
        this.memberRegiDate = memberRegiDate;
        this.memberEditDate = memberEditDate;
    }


    public Member(String memberUuid, String memberId, String memberEmail, String memberPw, Date memberEditDate) {
        super();
        this.memberUuid = memberUuid;
        this.memberId = memberId;
        this.memberEmail = memberEmail;
        this.memberPw = memberPw;
        this.memberEditDate = memberEditDate;
    }


    public Member(String memberUuid, int memberInuse, Date memberEditDate) {
        super();
        this.memberUuid = memberUuid;
        this.memberInuse = memberInuse;
        this.memberEditDate = memberEditDate;
    }


    public Member(String memberId, String memberPw, Date memberEditDate) {
        this.memberId = memberId;
        this.memberPw = memberPw;
        this.memberEditDate = memberEditDate;
    }

}
