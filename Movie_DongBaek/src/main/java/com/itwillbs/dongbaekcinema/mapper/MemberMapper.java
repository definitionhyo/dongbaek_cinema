package com.itwillbs.dongbaekcinema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

import com.itwillbs.dongbaekcinema.vo.MemberVO;

//DAO대신 활용하는 MAPPER
//인터페이스 내의 추상메서드 이름은 XML 파일의 태그 ID 속성값과 동일하게 지정하기

@Mapper
public interface MemberMapper {
	
	// 회원 가입 
	int insertMember(MemberVO member);
	
	// 로그인 작업 (id로 조회, passwd받아오기)
	String selectPasswd(MemberVO member_id);

	// 회원 정보 조회 id로 구별
	MemberVO selectMember(String member_id);
	
	// 회원정보 멤버십 위해 추가 0626정의효
	MemberVO selectMemberWithGradeName(String member_id);

	
	// 회원 목록 조회 -0622 완
	List<MemberVO> selectMemberList(
			@Param("memberSearchType") String memberSearchType, 
			@Param("memberSearchKeyword") String memberSearchKeyword, 
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);

	//전체 글 목록 갯수 조회 - 페이징처리중 0621 정의효 - 0622 완
	int selectMemberListCount(@Param("memberSearchType") String memberSearchType, @Param("memberSearchKeyword") String memberSearchKeyword);
	// 아이디 중복 체크 (카카오 로그인에서도 사용 - 값이 있으면 > 0)
	int idCheck(String member_id);
	
	// 비회원 로그인(가입) 작업을 위한 메서드
	int insertNoMember(MemberVO noMember);
	
	// 비회원 중복되면 안되는 정보 (member_phone)이 중복 확인 메서드
	MemberVO selectMemberByPhone(String member_phone);
	
	// 비회원 로그인(정보조회) 작업을 위한 메서드
	String selectNoMemberPasswd(@Param("member_name") String member_name, @Param("member_phone") String member_phone);
	

	//0619정의효 - 멤버 등급 변경
	void changeMemberGrade(@Param("grade_name") String grade_name, @Param("member_id") String member_id);

	//0619정의효 - 멤버 상태 변경
	void changeMemberStatus(@Param("member_status") String member_status, @Param("member_id") String member_id);

	//0619정의효 - 멤버 삭제
	void memberDelete(String member_id);
	
//	// 회원정보 비밀번호 수정
	int updateMember(MemberVO member);

	// 아이디 찾기
	String findMemberId(
			@Param("member_name") String member_name, 
			@Param("member_phone") String member_phone);

	// 비밀번호 찾기 
	String findMemberPass(
			@Param("member_id") String member_id, 
			@Param("member_phone") String member_phone);

	// 비밀번호 수정
	int updatePassword(
			@Param("member_id") String member_id, 
			@Param("memberNewPasswd") String memberNewPasswd);
	
	




	


	
}
