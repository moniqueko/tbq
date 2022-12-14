package com.thebookquotes.TBQ.web;

import com.thebookquotes.TBQ.common.ErrorCode;
import com.thebookquotes.TBQ.common.Sha256;
import com.thebookquotes.TBQ.common.SingleResult;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.MailService;
import com.thebookquotes.TBQ.service.ResponseService;
import com.thebookquotes.TBQ.service.member.MemberService;
import lombok.AllArgsConstructor;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.regex.Pattern;

@RestController
@AllArgsConstructor
public class MemberRestController {
    private final MemberService memberService;
    private final ResponseService responseService;
    private final MailService mailService;

    @PostMapping("/join")
    public SingleResult<?> join(@RequestBody Member member) throws IOException {

        String regex = "^[a-zA-Z]{1}[a-zA-Z0-9_]{4,11}$";
        String pw_regex = "^.*(?=^.{8,16}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$";
        String email_regex = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";

        if (!StringUtils.hasText(member.getMemberId()) || !StringUtils.hasText(member.getMemberPw()) ||
                !StringUtils.hasText(member.getMemberEmail())) {
            return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);
        }
       if (!Pattern.matches(pw_regex, member.getMemberPw())) {
            return responseService.getFailResult(ErrorCode.NOT_FOLLOW_REGEX);
        }
       if (!Pattern.matches(email_regex, member.getMemberEmail())) {
           return responseService.getFailResult(ErrorCode.NOT_FOLLOW_REGEX);
       }
       if (!Pattern.matches(regex, member.getMemberId())) {
            return responseService.getFailResult(ErrorCode.NOT_FOLLOW_REGEX);
        }
        Member mem = memberService.selectById(member.getMemberId());
        Member memByEmail = memberService.selectByEmail(member.getMemberEmail());

        if (mem == null && memByEmail == null) {
            memberService.insertMember(member);
            mailService.sendNotiMail("[TBQ] Congratulations, You are now a member of The Book Quotes", member.getMemberEmail(),
                    "Welcome "+member.getMemberId()+", Thank you for joining us.");

            return responseService.getSingleResult(member);

        } else if (mem.getMemberId().equals(member.getMemberId()) && mem.getMemberInuse() == 1) { //????????? ?????? ?????? & ?????????????????????
            return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);

        } else if (mem.getMemberEmail().equals(member.getMemberEmail()) && mem.getMemberInuse() == 1) { //????????? ?????? ?????? & ?????????????????????
            return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);
        }

        return responseService.getSingleResult(member);
    }

    @PostMapping("/login")
    public SingleResult<?> login(@RequestBody Member member, HttpSession session) throws IOException {

        String memberId = member.getMemberId();
        String memberPw = member.getMemberPw();
        String encodingPw = Sha256.encrypt(memberPw);
        int memberType = 0; //0:??????????????? 1:???????????? 2:?????????

        if (!StringUtils.hasText(memberId) || !StringUtils.hasText(memberPw)) {
            return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);
        }

        Member check = memberService.selectById(member.getMemberId());

        if(check.getMemberInuse()==0){ //????????? ??????
            memberType = 3;
            return responseService.getSingleResult(memberType);
        }

        if (check != null) { //???????????? ?????????

            if (memberId.equals(check.getMemberId()) && encodingPw.equals(check.getMemberPw())) {
                memberType = 1;

                if (memberId.equals("admin") || check.getMemberGrant() == 1) {
                    memberType = 2;
                }

                //????????? ????????? ????????? ????????? ?????? ??????, ?????? ??????
                memberService.lastLoginUpdate(check.getMemberUuid());
                session.setAttribute("memberInfo", check);

                return responseService.getSingleResult(memberType);

            } else if (!memberId.equals(check.getMemberId()) || !encodingPw.equals(check.getMemberPw())) {
                System.out.print("???????????? ??????????????? ???????????? ????????????.");
                //memberType=3;
                return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
            }

        } else if (check == null) {
            System.out.print("???????????? ??????????????????");
            //memberType=0;
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }
        return responseService.getSuccessResult();
    }

    @PostMapping("/member/del")
    public SingleResult<?> deleteMember(@RequestBody String uuid, Member member, HttpSession session) throws IOException {

        if (!StringUtils.hasText(uuid)) {
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }
        Member mem = memberService.selectByUuid(uuid);

        if (mem == null) {
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }
        member.setMemberUuid(uuid);
        memberService.deleteMember(mem); //inuse ????????? ??????.
        session.invalidate();

        return responseService.getSuccessResult();
    }

    @PostMapping("/idCheck") // ?????? ????????? ??????
    public SingleResult<?> idCheck(@RequestBody String memberId) throws IOException {

        if (memberId == null) {
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }
        Integer check = memberService.idCheck(memberId);

        if (check > 1) {
            return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);
        }
        return responseService.getSingleResult(check);
    }

    @PostMapping("/emailDupl")
    public SingleResult<?> emailDuplication(@RequestBody String memberEmail) throws IOException {
        if (memberEmail == null) {
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }
        int check = memberService.emailDuplication(memberEmail);

        if (check > 1) {
            return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);

        } else if (check == 1) {
            return responseService.getSingleResult(check);

        } else if (check == 0) {
            return responseService.getSingleResult(check);
        }
        return responseService.getSuccessResult();
    }

    @PostMapping("/emailCheck") // ?????????, ????????? ?????? ??????
    public SingleResult<?> emailCheck(@RequestBody Member member) throws IOException {

        if (!StringUtils.hasText(member.getMemberId()) || !StringUtils.hasText(member.getMemberEmail())) {
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }
        int check = memberService.emailCheck(member);

        if(check==0) {//????????? ????????? ?????????
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }
        return responseService.getSingleResult(check);
    }

    @PostMapping("/member/editMember") // ????????? ?????? ????????????
    public SingleResult<?> editMember(@RequestBody Member member) throws IOException {

    String pw_regex = "^.*(?=^.{8,16}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"; //???????????? ????????? 8~16??? ??????
    String email_regex = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$"; //????????? ??????

        if (!StringUtils.hasText(member.getMemberPw()) || !StringUtils.hasText(member.getMemberEmail()) ||
               !StringUtils.hasText(member.getMemberUuid()) ){
            return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);

        } else if (!Pattern.matches(pw_regex, member.getMemberPw())) {
            return responseService.getFailResult(ErrorCode.NOT_FOLLOW_REGEX);

        } else if (!Pattern.matches(email_regex, member.getMemberEmail())) {
            return responseService.getFailResult(ErrorCode.NOT_FOLLOW_REGEX);

        } else {

            //??????????????? : inuse??? 1????????? ?????????
            int checkDupl = memberService.emailDuplication(member.getMemberEmail()); //0: ?????????????????? , 1:???????????????, 2:??????
            int checkId = memberService.emailCheck(member); // 0:????????? ????????? ?????????, 1:??????

            if (checkId == 1) {
                System.out.println("??????????????? ?????????(????????????)");
                memberService.updateMember(member);
                return responseService.getSingleResult(member);

            } else if (checkId == 0) {

                if (checkDupl > 1) {
                    System.out.println("?????? db??? ?????? ????????????");
                    return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);

                } else if (checkDupl == 1) {
                    System.out.println("?????? ????????? + ??????????????? db??? 1??? ?????? ??????");
                    return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);

                } else if (checkDupl == 0) {
                    System.out.println("??????????????? ?????????");
                    memberService.updateMember(member);
                    return responseService.getSingleResult(member);

                }

            }
        }
        return responseService.getSingleResult(member);
    }

}