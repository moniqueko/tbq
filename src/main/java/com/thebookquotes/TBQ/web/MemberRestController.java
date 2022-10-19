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

        } else if (mem.getMemberId().equals(member.getMemberId()) && mem.getMemberInuse() == 1) { //아이디 이미 존재 & 사용하는중이면
            return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);

        } else if (mem.getMemberEmail().equals(member.getMemberEmail()) && mem.getMemberInuse() == 1) { //이메일 이미 존재 & 사용하는중이면
            return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);
        }

        return responseService.getSingleResult(member);
    }

    @PostMapping("/login")
    public SingleResult<?> login(@RequestBody Member member, HttpSession session) throws IOException {

        String memberId = member.getMemberId();
        String memberPw = member.getMemberPw();
        String encodingPw = Sha256.encrypt(memberPw);
        int memberType = 0; //0:로그인안됨 1:일반회원 2:관리자

        if (!StringUtils.hasText(memberId) || !StringUtils.hasText(memberPw)) {
            return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);
        }

        Member check = memberService.selectById(member.getMemberId());

        if(check.getMemberInuse()==0){ //탈퇴한 회원
            memberType = 3;
            return responseService.getSingleResult(memberType);
        }

        if (check != null) { //아이디는 있을때

            if (memberId.equals(check.getMemberId()) && encodingPw.equals(check.getMemberPw())) {
                memberType = 1;

                if (memberId.equals("admin") || check.getMemberGrant() == 1) {
                    memberType = 2;
                }

                //로그인 성공시 마지막 로그인 날짜 수정, 세션 저장
                memberService.lastLoginUpdate(check.getMemberUuid());
                session.setAttribute("memberInfo", check);

                return responseService.getSingleResult(memberType);

            } else if (!memberId.equals(check.getMemberId()) || !encodingPw.equals(check.getMemberPw())) {
                System.out.print("아이디와 패스워드가 일치하지 않습니다.");
                //memberType=3;
                return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
            }

        } else if (check == null) {
            System.out.print("회원정보 존재하지않음");
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
        memberService.deleteMember(mem); //inuse 번호만 바꿈.
        session.invalidate();

        return responseService.getSuccessResult();
    }

    @PostMapping("/idCheck") // 중복 아이디 체크
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

    @PostMapping("/emailCheck") // 아이디, 이메일 일치 체크
    public SingleResult<?> emailCheck(@RequestBody Member member) throws IOException {

        if (!StringUtils.hasText(member.getMemberId()) || !StringUtils.hasText(member.getMemberEmail())) {
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }
        int check = memberService.emailCheck(member);

        if(check==0) {//아이디 이메일 불일치
            return responseService.getFailResult(ErrorCode.NO_MATCHING_DATA);
        }
        return responseService.getSingleResult(check);
    }

    @PostMapping("/member/editMember") // 수정된 정보 받아오기
    public SingleResult<?> editMember(@RequestBody Member member) throws IOException {

    String pw_regex = "^.*(?=^.{8,16}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"; //패스워드 정규식 8~16자 이내
    String email_regex = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$"; //이메일 형식

        if (!StringUtils.hasText(member.getMemberPw()) || !StringUtils.hasText(member.getMemberEmail()) ||
               !StringUtils.hasText(member.getMemberUuid()) ){
            return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);

        } else if (!Pattern.matches(pw_regex, member.getMemberPw())) {
            return responseService.getFailResult(ErrorCode.NOT_FOLLOW_REGEX);

        } else if (!Pattern.matches(email_regex, member.getMemberEmail())) {
            return responseService.getFailResult(ErrorCode.NOT_FOLLOW_REGEX);

        } else {

            //중복테스트 : inuse가 1인것만 가져옴
            int checkDupl = memberService.emailDuplication(member.getMemberEmail()); //0: 새로운이메일 , 1:존재이메일, 2:다중
            int checkId = memberService.emailCheck(member); // 0:아이디 이메일 불일치, 1:일치

            if (checkId == 1) {
                System.out.println("사용가능한 이메일(기존메일)");
                memberService.updateMember(member);
                return responseService.getSingleResult(member);

            } else if (checkId == 0) {

                if (checkDupl > 1) {
                    System.out.println("이미 db에 두개 있는경우");
                    return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);

                } else if (checkDupl == 1) {
                    System.out.println("다른 아이디 + 중복이메일 db에 1개 있는 경우");
                    return responseService.getFailResult(ErrorCode.DUPLICATION_ERROR);

                } else if (checkDupl == 0) {
                    System.out.println("사용가능한 이메일");
                    memberService.updateMember(member);
                    return responseService.getSingleResult(member);

                }

            }
        }
        return responseService.getSingleResult(member);
    }

}