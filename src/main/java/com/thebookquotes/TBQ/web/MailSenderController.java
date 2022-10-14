package com.thebookquotes.TBQ.web;

import com.thebookquotes.TBQ.common.Sha256;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.GeneratePw;
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
    private final GeneratePw generatePw;

    @PostMapping("/findPw")
    public String sendEmail(Member member) throws MessagingException {

        String temp = generatePw.excuteGenerate(); //비밀번호 생성
        member.setMemberPw(Sha256.encrypt(temp));

        memberService.findPw(member);
        System.out.println(temp+"1");

        Member mem = memberService.selectById(member.getMemberId());


        System.out.println(mem+"2");

        String memberAddress = mem.getMemberEmail();


        StringBuffer stringBuffer = new StringBuffer();

        stringBuffer.append("회원님의 임시 비밀번호는 "+ temp +"입니다. \n 로그인 후 꼭 비밀번호를 바꿔주세요."); // 엔터 수정하기

        String body = stringBuffer.toString();

        mailService.sendNotiMail("[안내] 임시 비밀번호 발급", memberAddress, body);

        return "/member/sendOk";

    }


}