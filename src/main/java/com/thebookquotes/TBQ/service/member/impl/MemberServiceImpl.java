package com.thebookquotes.TBQ.service.member.impl;

import java.util.List;
import javax.annotation.Resource;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.common.Sha256;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.mapper.MemberMapper;
import com.thebookquotes.TBQ.service.GeneratePw;
import com.thebookquotes.TBQ.service.member.MemberService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("MemberService")
@Transactional
public class MemberServiceImpl implements MemberService {
    @Resource
    MemberMapper mapper;

    @Override
    public void insertMember(Member member) {
        Member newMember = new Member(null, member.getMemberId(), Sha256.encrypt(member.getMemberPw()),
                member.getMemberGrant(), null, 1, null, null, member.getMemberEmail());
        mapper.insertMember(newMember);
    }
    @Override
    public List<Member> selectMemberList(Criteria cri) {
        List<Member> member =  mapper.selectMemberList(cri);
        return member;
    }
    @Override
    public Member selectById(String memberId) {
        Member loginCheck =  mapper.selectById(memberId);
        return loginCheck;
    }
    @Override
    public void lastLoginUpdate(String memberUuid) {
        mapper.lastLoginUpdate(memberUuid);
    }
    @Override
    public Member selectByUuid(String memberUuid) {
        Member member =  mapper.selectByUuid(memberUuid);
        return member;
    }
    @Override
    public void updateMember(Member member) {
        Member mem = new Member(member.getMemberUuid(), member.getMemberId(), member.getMemberEmail(), Sha256.encrypt(member.getMemberPw()), null);
        mapper.updateMember(mem);
    }
    @Override
    public void deleteMember(Member member) {
        Member mem = new Member(member.getMemberUuid(), 0, null); //inuse 상태 0:탈퇴
        mapper.deleteMember(mem);
    }
    @Override
    public int idCheck(String memberId) {
        return mapper.idCheck(memberId);
    }
    @Override
    public int selectCount() { return mapper.selectCount(); }
    @Override
    public int emailDuplication(String memberEmail) {
        return mapper.emailDuplication(memberEmail);
    }
    @Override
    public int emailCheck(Member member) {
        return mapper.emailCheck(member);
    }
    @Override
    public void findPw(Member member) {
        Member mem = new Member(member.getMemberId(), member.getMemberPw(), null);
        mapper.findPw(mem);
    }
    @Override
    public Member selectByEmail(String memberEmail) {
        Member member =  mapper.selectByEmail(memberEmail);
        return member;
    }

}