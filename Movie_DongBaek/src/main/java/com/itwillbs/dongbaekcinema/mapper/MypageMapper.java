package com.itwillbs.dongbaekcinema.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.dongbaekcinema.vo.*;
import com.itwillbs.dongbaekcinema.voNew.*;

@Mapper
public interface MypageMapper {
	
	
	// 나의 예매내역 조회 - 회원 아이디로 레코드 조회(페이징처리)
	List<MyTicketVO> selectMyTicket(
								@Param("member_id") String member_id
								, @Param("startRow") int startRow
								, @Param("listLimit") int listLimit);

	// 나의 멤버십 등급 조회 - 회원 아이디로 레코드 조회
	GradeNextVO selectMyGrade(String member_id);
	
	// 나의 개인정보 조회  - 회원 아이디로 레코드 조회
	List<MemberVO> getMyInfoList(String member_id);

	// 나의 개인정보 수정 - 회원 아이디로 조회하여 업데이트
	int updateMyInfo(MemberVO member
					, @Param("member_pass") String member_pass
					, @Param("member_email") String member_email
					, @Param("member_id") String member_id
					, @Param("member_like_genre") String member_like_genre);
	
	// 나의 개인정보 수정 - 비밀번호 찾기
	String selectMyPasswd(String member_id);

	// 개인정보 수정 - 탈퇴하기
	int memberwithdrawal(String member_id);
	
	// 나의 리뷰 조회 - 회원 아이디로 레코드 조회
	List<MyReviewVO> selectMyReviewList(
									@Param("member_id") String member_id
									, @Param("startRow") int startRow 
									, @Param("listLimit") int listLimit);
	// 
	List<MyReviewVO> selectMyReview(@Param("member_id") String member_id, 
									@Param("movie_num") int movie_num);

	// 나의 문의 내역 조회 - 회원 아이디로 레코드 조회
	List<CsVO> selectMyInq(String member_id);
	
	// 나의 문의 조회 - 회원 아이디로 레코드 조회
	List<CsInfoVO> selectMyInqList(
								@Param("member_id") String member_id 
								, @Param("startRow") int startRow
								, @Param("listLimit") int listLimit);

	// 나의 문의 상세 조회 - cs_num으로 레코드 조회
	List<CsInfoVO> selectMyInquiryDetail(String cs_num);

	// 나의 문의 내역 - 수정
//	int updateMyInqList(@Param("cs_num") String cs_num, CsInfoVO csInfo);
	int updateMyInqList(CsVO cs);
	
	// 나의 문의 내역 삭제 - cs_num 으로 레코드 조회 후 삭제
	int deleteMyInq(String cs_num);

	MyReviewVO selectMovieName(String movie_num);

	int insertMyReview(MyReviewVO myReview);


}
