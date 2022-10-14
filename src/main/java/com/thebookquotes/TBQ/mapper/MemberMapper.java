package com.thebookquotes.TBQ.mapper;

import com.thebookquotes.TBQ.common.Criteria;
import com.thebookquotes.TBQ.dto.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface MemberMapper {
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
