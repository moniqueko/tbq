package com.thebookquotes.TBQ.web;

import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.MailService;
import com.thebookquotes.TBQ.service.member.MemberService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import javax.mail.MessagingException;

@Controller
@AllArgsConstructor
public class MailSenderController {

    private final MemberService memberService;
    private final MailService mailService;

    @PostMapping("/findPw") // 패스워드 변경 실행(이메일 보내기)
    public String sendEmail(Member member) throws MessagingException {

        String temp = memberService.pwGenerate(member); //아이디와 이메일 정보 넘겨받아 비밀번호 생성

        Member mem = memberService.selectById(member.getMemberId());

        String memberAddress = mem.getMemberEmail();


        StringBuffer stringBuffer = new StringBuffer();

        stringBuffer.append("회원님의 임시 비밀번호는 "+ temp +"입니다. \n 로그인 후 꼭 비밀번호를 바꿔주세요."); // 엔터 수정하기

        String body = stringBuffer.toString();

        mailService.sendNotiMail("[안내] 임시 비밀번호 발급", memberAddress, body);


        return "sample/sendOk";

    }


}