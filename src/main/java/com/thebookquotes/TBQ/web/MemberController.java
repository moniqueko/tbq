package com.thebookquotes.TBQ.web;

import com.thebookquotes.TBQ.common.CriteriaBoard;
import com.thebookquotes.TBQ.common.PageMakerBoard;
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
    @GetMapping("/error")
    public String error(Model model, Member member) {
        return "error";
    }
    @GetMapping("/findPw")
    public String findPw(Model model, Member member) {
        return "member/find";
    }

    @GetMapping("/join")
    public String join(Model model) {
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

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();

        return "member/login";
    }

    @GetMapping("/admin") //관리자 페이지
    public String admin(Model model, HttpSession session) {
        Member memberSession = (Member) session.getAttribute("memberInfo");

        if (memberSession.getMemberGrant()==1){
            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);
            return "admin/admin";
        }
        return "member/login";
    }

    @GetMapping("/memberList")
    public String memberList(Model model, Member member, CriteriaBoard cri, HttpSession session) {
        Member memberSession = (Member) session.getAttribute("memberInfo");

        if (memberSession.getMemberGrant()==1){

            List<Member> mem = memberService.selectMemberList(cri);
            model.addAttribute("member", mem);

            PageMakerBoard pageMakerBoard = new PageMakerBoard();
            pageMakerBoard.setCri(cri);
            pageMakerBoard.setTotalCount(memberService.selectCount());
            pageMakerBoard.setTotalPage(memberService.selectCount());
            model.addAttribute("pageMaker", pageMakerBoard);

            List<Maxim> maxim = maximService.maximList();
            model.addAttribute("maxim", maxim);
            return "admin/memberList";
        }

        return "member/login";
    }


    @GetMapping("/member/{memberUuid}")
    public String editMember(@PathVariable("memberUuid") String memberUuid, Model model, HttpSession session) {
        Member memberSession = (Member) session.getAttribute("memberInfo");

        if (memberSession.getMemberGrant()==1) {
            Member mem = memberService.selectByUuid(memberUuid);
            model.addAttribute("member", mem);
            return "admin/editMember";

        }else if (memberSession.getMemberGrant()==0){
            Member mem = memberService.selectByUuid(memberUuid);
            model.addAttribute("member", mem);
            return "member/modifyInfo";
        }
        return "member/login";

    }

}