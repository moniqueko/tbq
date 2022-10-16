package com.thebookquotes.TBQ.web;

import com.thebookquotes.TBQ.common.ErrorCode;
import com.thebookquotes.TBQ.common.Sha256;
import com.thebookquotes.TBQ.common.SingleResult;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.GeneratePw;
import com.thebookquotes.TBQ.service.MailService;
import com.thebookquotes.TBQ.service.ResponseService;
import com.thebookquotes.TBQ.service.member.MemberService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.MessagingException;

@RestController
@AllArgsConstructor
public class MailSenderController {

    private final MemberService memberService;
    private final MailService mailService;
    private final GeneratePw generatePw;
    private final ResponseService responseService;

    @PostMapping("/findPw")
    public SingleResult<?> sendEmail(@RequestBody Member member) throws MessagingException {
        if (member == null) {
            return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);
        }
        Member checkMemberEmail = memberService.selectByEmail(member.getMemberEmail());
        if (checkMemberEmail == null) {
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }

        Member checkMemberId = memberService.selectById(member.getMemberId());
        if (checkMemberId == null) {
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }

        int check = memberService.emailCheck(member);
        if (check == 1) {
            String temp = generatePw.excuteGenerate();
            member.setMemberPw(Sha256.encrypt(temp));
            memberService.findPw(member);

            Member mem = memberService.selectById(member.getMemberId());

            String memberAddress = mem.getMemberEmail();
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("Your temporary password is " + temp + ". \n Please change your password after login.");

            String body = stringBuffer.toString();
            mailService.sendNotiMail("[TBQ] Your temporary password is " + temp, memberAddress, body);
            return responseService.getSuccessResult();

        } else if (check == 0) {
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }

        return responseService.getSuccessResult();
    }
}