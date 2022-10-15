package com.thebookquotes.TBQ.service.member;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.dto.Member;

import java.util.List;

public interface MemberService {
    Member selectById(String memberId);
    Member selectByUuid(String memberUuid);
    Member selectByEmail(String memberEmail);
    List<Member> selectMemberList(Criteria cri);
    void lastLoginUpdate(String memberUuid);

    void insertMember(Member member);
    void updateMember(Member member);
    void deleteMember(Member member);

    int idCheck(String memberId);
    int emailCheck(Member member);
    int emailDuplication(String memberEmail);
    void findPw(Member member);
    int selectCount();
}