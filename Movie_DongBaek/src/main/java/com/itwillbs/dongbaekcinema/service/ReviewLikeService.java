package com.itwillbs.dongbaekcinema.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.ReviewLikeMapper;
import com.itwillbs.dongbaekcinema.vo.ReviewLikeVO;

@Service
public class ReviewLikeService {
	
	@Autowired
	private ReviewLikeMapper mapper;

	// 리뷰에 대해 리뷰좋아요를 누른 적이 있는지 확인
	public int findReviewLike(int review_num, String member_id) {
		System.out.println("ReviewLikeService - getReviewLikeInfo()");

		return mapper.selectFindReviewLike(review_num, member_id);
	}

	// 리뷰별 리뷰좋아요 등록
	public int registReviewLike(int review_num, String member_id) {
		System.out.println("ReviewLikeService - registReviewLike()");
		return mapper.insertReviewLike(review_num, member_id);
	}

	// 1) 리뷰별 리뷰좋아요 갯수 가져오기
	// 2) '회원이 좋아요를 누른 리뷰'의 전체 리뷰좋아요 수 구하기
	// 3) '회원이 좋아요를 취소한 리뷰'의 전체 리뷰좋아요 수 구하기
	public int getReviewLikeCount(int review_num) {
		System.out.println("ReviewLikeService - getReviewLikeCount()");
		
		return mapper.selectReviewLikeCount(review_num);
	}

	// 리뷰별 리뷰좋아요 취소(삭제)
	public int removeReviewLike(int review_num, String member_id) {
		System.out.println("ReviewLikeService - removeReviewLike()");

		return mapper.deleteReviewLike(review_num, member_id);
	}

	// 세션아이디가 존재하는 경우 회원인지 비회원인지 확인
	public int getMember(String member_id) {
		System.out.println("ReviewLikeService - getMember()");
		
		return mapper.selectMember(member_id);
	}



}
