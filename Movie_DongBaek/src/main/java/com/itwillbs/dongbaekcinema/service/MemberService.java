package com.itwillbs.dongbaekcinema.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.MemberMapper;
import com.itwillbs.dongbaekcinema.vo.MemberVO;
import com.itwillbs.dongbaekcinema.vo.PaymentVO;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	// 회원가입 폼 - 아이디 중복확인 메서드 
	public int idCheck(String member_id) {
		int cnt = mapper.idCheck(member_id);
		System.out.println("cnt : " + cnt);
		return cnt;
	}
	
	// 회원 가입 
	public int registMember(MemberVO member) {
		return mapper.insertMember(member);
	}
	
	// 로그인 작업
	public String getPasswd(MemberVO member_id) {
		// 받아온 member_id로 회원 정보 조회 후 그 회원의 member_pass 리턴
		return mapper.selectPasswd(member_id);
	}
	
	// 회원 정보 조회 요청을 위한 메서드
	public MemberVO getMember(String member_id) {
		return mapper.selectMember(member_id);
	}
	
	// 회원정보 멤버십 위해 추가 0626 정의효
	public MemberVO getMemberWithGradeName(String member_id) {
		return mapper.selectMemberWithGradeName(member_id);
	}
	
	// 비회원 로그인(가입) 작업을 위한 메서드
	public int noMemberLogin(MemberVO noMember) {
		return mapper.insertNoMember(noMember);
	}
	
	// 비회원 중복되면 안되는 정보 (member_phone)이 중복 확인 메서드
	public boolean isExistPhone(String member_phone) {
		MemberVO existMember = mapper.selectMemberByPhone(member_phone);
		
		if(existMember != null) {	// 회원이 존재하면
			return true;
		}
		
		return false;
	}
	
	// 비회원 로그인(정보조회) 작업을 위한 메서드
	public String getNoMemberPasswd(String member_name, String member_phone) {
		return mapper.selectNoMemberPasswd(member_name, member_phone);
	}
	

	// 0619정의효 멤버 등급 변경
	public void changeMemberGrade(String grade_name, String member_id) {
		mapper.changeMemberGrade(grade_name, member_id);
	}

	// 0619정의효 멤버 상태 변경
	public void changeMemberStatus(String member_status, String member_id) {
		mapper.changeMemberStatus(member_status, member_id);
	}

	// 0619정의효 멤버 삭제
	public void memberDelete(String member_id) {
		mapper.memberDelete(member_id);
		
	}
	
	// 회원정보 비밀번호 수정
	public int modifyMember(MemberVO member) {
		
		return mapper.updateMember(member);
	}

	// 아이디 찾기
	public String findId(String member_name, String member_phone) {
		return mapper.findMemberId(member_name, member_phone);
	}
	
	// 비밀번호 찾기 위해 이름과 핸드폰 번호 일치하는 회원 찾기
	public String matchMember(String member_id, String member_phone) {
		return mapper.findMemberPass(member_id, member_phone);
	}

	// 비밀번호 변경하기
	public int updatePassword(String member_id, String memberNewPasswd) {
		// TODO Auto-generated method stub
		return mapper.updatePassword(member_id, memberNewPasswd);
	}


	// 회원 목록 조회 요청을 위한 메서드(페이징처리,검색하는중) 0621-정의효
	public List<MemberVO> getMemberList(String memberSearchType, String memberSearchKeyword, int startRow,
			int listLimit) {
		return mapper.selectMemberList(memberSearchType, memberSearchKeyword, startRow, listLimit);
	}
	
	//전체 글 목록 갯수 조회 요청 - 페이징처리중 0621 17:05 없어도되는지 확인 없어도되면 삭제하기
	public int getMemberListCount(String memberSearchType, String memberSearchKeyword) {
		return mapper.selectMemberListCount(memberSearchType, memberSearchKeyword);
	}




	


	

	









}
