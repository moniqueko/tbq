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

    void delMember(Member member);

    int idCheck(String memberId);

    int emailCheck(Member member);

    int selectCount();

    String pwGenerate(Member member);

    int emailDuplication(String memberEmail);




}