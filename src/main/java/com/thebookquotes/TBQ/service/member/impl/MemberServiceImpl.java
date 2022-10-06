package com.thebookquotes.TBQ.service.member.impl;


import java.util.List;
import java.util.UUID;

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
    GeneratePw generatePw;
    String memberUuid = "M" + UUID.randomUUID().toString().replace("-", "").substring(20);

    @Override
    public void insertMember(Member member) {

        Member newMember = new Member(memberUuid, member.getMemberId(), Sha256.encrypt(member.getMemberPw()),
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
        Member mem =  mapper.selectByUuid(memberUuid);
        return mem;

    }

    @Override
    public void updateMember(Member member) {

        Member mem = new Member(member.getMemberUuid(), member.getMemberId(), member.getMemberEmail(), Sha256.encrypt(member.getMemberPw()), null);

        mapper.updateMember(mem);

    }

    @Override
    public void delMember(Member member) {

        Member mem = new Member(member.getMemberUuid(), 0, null); //inuse 상태 0:탈퇴

        mapper.delMember(mem);
    }


    @Override
    public Integer idCheck(String memberId) {
        return mapper.idCheck(memberId);
    }

    @Override
    public int selectCount() {
        return mapper.selectCount();

    }

    @Override
    public int emailCheck(Member member) {
        int cnt = mapper.emailCheck(member);
        return cnt;
    }

    @Override
    public int emailDuplication(String memberEmail) {
        return mapper.emailDuplication(memberEmail);
    }

    @Override
    public String pwGenerate(Member member) {

        String temp = generatePw.excuteGenerate(); //비밀번호 생성

        Member mem = new Member(member.getMemberId(), Sha256.encrypt(temp), null); //pw, date

        mapper.pwGenerate(mem);

        return temp;
    }

    @Override
    public Member selectByEmail(String memberEmail) {
        Member emailCheck =  mapper.selectByEmail(memberEmail);
        return emailCheck;
    }





}