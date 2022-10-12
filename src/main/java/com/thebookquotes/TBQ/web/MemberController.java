package com.thebookquotes.TBQ.web;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.common.PageMaker;
import com.thebookquotes.TBQ.dto.Maxim;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.maxim.MaximService;
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
    private final MaximService maximService;

    @GetMapping("/findPw") //비밀번호 찾기
    public String findPw(Model model, Member member) {

        return "member/findPw";
    }

    @GetMapping("/join")
    public String signin(Model model) {

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);
        return "member/join";
    }

    @GetMapping("/login")
    public String login(Model model) {

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        return "member/login";
    }

    @GetMapping("/loginOk")
    public String loginOk(Model model) {

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);

        return "member/loginOk";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();

        return "member/login";
    }

    @GetMapping("/admin") //관리자 페이지
    public String admin(Model model, Member member, HttpSession session) {
        Member memberSession = (Member) session.getAttribute("memberInfo");

        if (memberSession.getMemberGrant()==1){
            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);
            return "member/admin";
        }
        return "member/login";
    }

    @GetMapping("/accessFail") //접근제한 페이지
    public String accessFail(Model model, Member member) {

        return "member/accessFail";
    }

    @GetMapping("/memberList") //회원목록
    public String memberList(Model model, Member member, Criteria cri, HttpSession session) {

        Member memberSession = (Member) session.getAttribute("memberInfo");

        if (memberSession.getMemberGrant()==1){

        List<Member> mem = memberService.selectMemberList(cri);
        model.addAttribute("member", mem);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(memberService.selectCount());
        pageMaker.setTotalPage(memberService.selectCount());
        model.addAttribute("pageMaker", pageMaker);

        List<Maxim> maxim = maximService.maximList();
        model.addAttribute("maxim", maxim);
        return "member/memberList";

        }

        return "member/login";
    }


    @GetMapping("/member/{memberUuid}")
    public String editMember(@PathVariable("memberUuid") String memberUuid, Model model, Member member, HttpSession session) {
        Member memberSession = (Member) session.getAttribute("memberInfo");

        if (memberSession.getMemberGrant()==1) {
            Member mem = memberService.selectByUuid(memberUuid);
            model.addAttribute("member", mem);
            return "member/editMember";

        }else if (memberSession.getMemberGrant()==0){
            Member mem = memberService.selectByUuid(memberUuid);
            model.addAttribute("member", mem);
            return "member/modifyInfo";
        }
        return "member/login";

    }



}