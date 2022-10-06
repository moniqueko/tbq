package com.thebookquotes.TBQ.web;

import com.thebookquotes.TBQ.common.ErrorCode;
import com.thebookquotes.TBQ.common.Sha256;
import com.thebookquotes.TBQ.common.SingleResult;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.MailService;
import com.thebookquotes.TBQ.service.ResponseService;
import com.thebookquotes.TBQ.service.member.MemberService;
import lombok.AllArgsConstructor;
import org.springframework.ui.Model;
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


    @PostMapping("/signin")
    public SingleResult<?> signin(@RequestBody Member member) throws IOException {

        String regex = "^[a-zA-Z]{1}[a-zA-Z0-9_]{4,11}$"; //아이디 정규식
        String pw_regex = "^.*(?=^.{8,16}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"; //패스워드 정규식 8~16자 이내
        String email_regex = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$"; //이메일 형식

        try {
            if (member.getMemberId() == null || member.getMemberId().equals("") || member.getMemberPw() == null || member.getMemberPw().equals("") ||
                    member.getMemberEmail() == null || member.getMemberEmail().equals("")) { // 받아온값이 null - 아이디, 패스워드 따로하면 유추가능하니까 안됨.

                return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);
            }

             if (member.getMemberGrant() != 0 && member.getMemberGrant() != 1) { //&& 주의할것, 0도 아니고 1도 아닐때

                 return responseService.getFailResult(ErrorCode.TYPE_NOT_SELECTED);
             }

           if (!Pattern.matches(pw_regex, member.getMemberPw())) {//비밀번호가 정규식에 부합하는지

                return responseService.getFailResult(ErrorCode.PW_NOT_FOLLOW_REGEX);

            }

           if (!Pattern.matches(email_regex, member.getMemberEmail())) { //이메일이 정규식에 부합하는지

               return responseService.getFailResult(ErrorCode.EMAIL_NOT_FOLLOW_REGEX);

           }

           if (!Pattern.matches(regex, member.getMemberId())) {//아이디가 정규식에 부합하는지

                return responseService.getFailResult(ErrorCode.ID_NOT_FOLLOW_REGEX);

            }

                Member mem = memberService.selectById(member.getMemberId()); //멤버 존재여부 Member mem = null;
                //Member memByEmail = memberService.selectByEmail(member.getMemberEmail());

                if (mem == null) {//새로 회원가입

                    memberService.insertMember(member); //회원가입진행
                    mailService.sendNotiMail("[안내] 회원가입을 축하합니다!", member.getMemberEmail(), "오늘부터 당신은 OOO의 회원입니다. 많은 이용 바랍니다.");

                    return responseService.getSingleResult(member);

                } else if (mem.getMemberId().equals(member.getMemberId()) && mem.getMemberInuse() == 1) { //아이디 이미 존재 & 사용하는중이면

                    return responseService.getFailResult(ErrorCode.ID_DUPLICATION);

                } else if (mem.getMemberEmail().equals(member.getMemberEmail()) && mem.getMemberInuse() == 1) { //이메일 이미 존재 & 사용하는중이면

                    return responseService.getFailResult(ErrorCode.EMAIL_DUPLICATION);
                }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseService.getSingleResult(member);
    }

    @PostMapping("/login") //로그인 실행
    public SingleResult<?> login(@RequestBody Member member, HttpSession session) throws IOException {

        try {

            String memberId = member.getMemberId();
            String memberPw = member.getMemberPw();//폼에서 가져온 아이디
            String encodingPw = Sha256.encrypt(memberPw); //폼에서 가져온 아이디 encoding
            int memberType = 0; //0:로그인안됨 1:일반회원 2:관리자

            if (memberId == null || memberId.equals("")) { // 받아온값이 null - 아이디, 패스워드 따로하면 유추가능하니까 안됨.

                return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);

            } else if (memberPw == null || memberPw.equals("")) {

                return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);
            }

            Member check = memberService.selectById(member.getMemberId()); //아이디로 db에서 찾은정보

            if (check != null) { //아이디는 있을때

                if (memberId.equals(check.getMemberId()) && encodingPw.equals(check.getMemberPw())) { //사용자가 입력한 pw 가db와 일치하는지
                    System.out.print("로그인 정보가 일치합니다");
                    memberType = 1;

                    if (memberId.equals("admin")) {
                        memberType = 2;
                        System.out.print("#############관리자 로그인");

                        //로그인 성공시 마지막 로그인 날짜 수정
                        memberService.lastLoginUpdate(check.getMemberUuid());

                    }

                    //로그인 성공시 마지막 로그인 날짜 수정
                    memberService.lastLoginUpdate(check.getMemberUuid());

                    //세션에 저장
                    session.setAttribute("memberInfo", member);

                    return responseService.getSingleResult(memberType);


                } else if (!memberId.equals(check.getMemberId()) || !encodingPw.equals(check.getMemberPw())) {
                    System.out.print("아이디와 패스워드가 일치하지 않습니다.");
                    //memberType=3;

                    return responseService.getFailResult(ErrorCode.ID_PW_NOT_MATCHING);
                }

            } else if (check == null) {
                System.out.print("회원정보 존재하지않음");
                //memberType=0;
                return responseService.getFailResult(ErrorCode.MEMBER_NOT_FOUND);
            }

        } catch (NullPointerException e) {
            e.printStackTrace();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }


    @PostMapping("/member/del")
    public SingleResult<?> deleteMember(@RequestBody String uuid) throws IOException {

        if (uuid == null || uuid.equals("")) { //받은값 null
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }
        Member mem = memberService.selectByUuid(uuid);

        if (mem == null) { //조회한값 null
            return responseService.getFailResult(ErrorCode.MEMBER_NOT_FOUND);
        }
        memberService.delMember(mem); //inuse 번호만 바꿈.

        return responseService.getSuccessResult();
    }


    @PostMapping("/idCheck") // 중복 아이디 체크
    public SingleResult<?> idCheck(@RequestBody String memberId) throws IOException {

        if (memberId == null) { //받은값 null
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }
        Integer check = memberService.idCheck(memberId);    //갯수 카운트

        System.out.println("check print<<<<<<<<<<<<<<<<<<<<<<"+check);

        if (check > 1) {
            return responseService.getFailResult(ErrorCode.ID_DUPLICATION);
        }
        return responseService.getSingleResult(check);
    }

    @PostMapping("/emailDupl") // 중복 이메일 체크
    public SingleResult<?> emailDuplication(@RequestBody String memberEmail) throws IOException {

        int check = 1;

        if (memberEmail == null) { //받은값 null
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }

        check = memberService.emailDuplication(memberEmail);

        System.out.println("check print<<<<<<<<<<<<<<<<<<<<<<"+check);

        if (check > 1) {
            return responseService.getFailResult(ErrorCode.EMAIL_DUPLICATION);

        } else if (check == 1) {
            return responseService.getSingleResult(check); //200과 함께 데이터 보냄

        } else if (check == 0) {
            return responseService.getSingleResult(check); //200과 함께 데이터 보냄
        }

        return responseService.getSuccessResult();
    }

    @PostMapping("/emailCheck") // 아이디, 이메일 일치 체크
    public SingleResult<?> emailCheck(@RequestBody Member member) throws IOException {

        if (member.getMemberEmail() == null || member.getMemberEmail().equals("") || member.getMemberId() == null || member.getMemberId().equals("")) { //받은값 null
            return responseService.getFailResult(ErrorCode.NO_INPUT_DATA);
        }

        int check = memberService.emailCheck(member);

        if (check == 0) {//아이디 이메일 불일치
            return responseService.getFailResult(ErrorCode.ID_EMAIL_NOT_MATCHING); //411
        }
        return responseService.getSingleResult(check);
    }

    @PostMapping("/member/editMember") // 수정된 정보 받아오기
    public SingleResult<?> editMemberPost(Model model, @RequestBody Member member) throws IOException {

        String pw_regex = "^.*(?=^.{8,16}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"; //패스워드 정규식 8~16자 이내
        String email_regex = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$"; //이메일 형식

        try {

            if (member.getMemberPw() == null || member.getMemberPw().equals("") ||
                    member.getMemberEmail() == null || member.getMemberEmail().equals("") ||
                    member.getMemberUuid() == null || member.getMemberUuid().equals("")) { // 받아온값이 null - 아이디, 패스워드 따로하면 유추가능하니까 안됨.

                return responseService.getFailResult(ErrorCode.NULL_EXCEPTION);

            } else if (!Pattern.matches(pw_regex, member.getMemberPw())) {//비밀번호가 정규식에 부합하는지

                return responseService.getFailResult(ErrorCode.PW_NOT_FOLLOW_REGEX);

            } else if (!Pattern.matches(email_regex, member.getMemberEmail())) { //이메일이 정규식에 부합하는지

                return responseService.getFailResult(ErrorCode.EMAIL_NOT_FOLLOW_REGEX);

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
                        return responseService.getFailResult(ErrorCode.EMAIL_DUPLICATION);

                    } else if (checkDupl == 1) {
                        System.out.println("다른 아이디 + 중복이메일 db에 1개 있는 경우");
                        return responseService.getFailResult(ErrorCode.EMAIL_CURRENTLY_USED);

                    } else if (checkDupl == 0) {
                        System.out.println("사용가능한 이메일");
                        memberService.updateMember(member);
                        return responseService.getSingleResult(member);

                    }

                }
            }


        } catch (NullPointerException e) {
            e.printStackTrace();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseService.getSingleResult(member);
    }
}