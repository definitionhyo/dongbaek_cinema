package com.itwillbs.dongbaekcinema.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.dongbaekcinema.vo.ReviewLikeVO;

@Mapper
public interface ReviewLikeMapper {

	// 리뷰에 대해 리뷰좋아요를 누른 적이 있는지 확인
	int selectFindReviewLike(@Param("review_num") int review_num, @Param("member_id") String member_id);

	// 리뷰별 리뷰좋아요 등록
	int insertReviewLike(@Param("review_num") int review_num, @Param("member_id") String member_id);

	// 리뷰별 리뷰좋아요 갯수 가져오기
	int selectReviewLikeCount(int review_num);

	// 리뷰별 리뷰좋아요 취소(삭제)
	int deleteReviewLike(@Param("review_num") int review_num, @Param("member_id") String member_id);

	// 세션아이디가 존재하는 경우 회원인지 비회원인지 확인
	int selectMember(String member_id);



}
