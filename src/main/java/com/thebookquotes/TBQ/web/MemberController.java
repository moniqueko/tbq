package com.thebookquotes.TBQ.web;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.common.PageMaker;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.member.MemberService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class MemberController {


    private final MemberService memberService;


    @GetMapping("/findPw") //비밀번호 찾기
    public String findPw(Model model, Member member) {

        return "member/findPw";
    }

    @GetMapping("/signin") //회원가입 페이지 이동
    public String signin(Model model, Member member) {

        return "member/signin";
    }

    @GetMapping("/login") //회원가입 페이지 이동
    public String login(Model model, Member member) {

        return "member/login";
    }

    @GetMapping("/loginOk") //일반회원 로그인 성공 페이지
    public String loginOk(Model model, Member member) {

        return "member/loginOk";
    }

    @GetMapping("/logout") //로그아웃
    public String logout(Model model, Member member, HttpSession session) {
        session.invalidate();

        return "member/login";
    }

    @GetMapping("/adminOk") //관리자 로그인 성공 페이지
    public String admin(Model model, Member member) {

        return "member/adminOk";
    }

    @GetMapping("/accessFail") //접근제한 페이지
    public String accessFail(Model model, Member member) {

        return "member/accessFail";
    }

    @GetMapping("/memberList") //회원목록
    public String memberList(Model model, Member member, Criteria cri) {


        List<Member> mem = memberService.selectMemberList(cri); //criteria로 페이지 수 세서 보드 조회
        model.addAttribute("member", mem);

        PageMaker pm = new PageMaker();
        pm.setCri(cri);
        pm.setTotalCount(memberService.selectCount());
        model.addAttribute("pm", pm);


        return "member/memberList";
    }


    @GetMapping("/member/edit/{memberUuid}")
    public String editMember(@PathVariable("memberUuid") String memberUuid, Model model, Member member) {

        Member mem = memberService.selectByUuid(memberUuid);

        model.addAttribute("member", mem);

        return "sample/memberEdit";
    }



}