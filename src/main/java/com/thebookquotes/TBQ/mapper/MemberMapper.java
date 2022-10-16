package com.thebookquotes.TBQ.mapper;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.common.CriteriaBoard;
import com.thebookquotes.TBQ.dto.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface MemberMapper {
    List<Member> selectMemberList(CriteriaBoard cri);
    Member selectById(String memberId);
    Member selectByUuid(String memberUuid);
    Member selectByEmail(String memberEmail);
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
