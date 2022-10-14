package com.thebookquotes.TBQ.service.member;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.dto.Member;

import java.util.List;

public interface MemberService {

    void insertMember(Member member);

    Member selectById(String memberId);

    Member selectByUuid(String memberUuid);

    Member selectByEmail(String memberEmail);

    void lastLoginUpdate(String memberUuid);

    List<Member> selectMemberList(Criteria cri);

    void updateMember(Member member);

    void deleteMember(Member member);

    Integer idCheck(String memberId);

    int selectCount();

    void findPw(Member member);

    int emailDuplication(String memberEmail);

    int emailCheck(Member member);


}