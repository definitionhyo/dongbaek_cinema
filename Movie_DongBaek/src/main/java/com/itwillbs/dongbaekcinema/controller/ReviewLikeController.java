package com.itwillbs.dongbaekcinema.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.dongbaekcinema.service.ReviewLikeService;

@Controller
public class ReviewLikeController {
	
	@Autowired
	private ReviewLikeService service;
	
	// IsReviewLikeExist 요청에 의해 
	// 세션 아이디가 있는 경우 특정 리뷰에 대해 좋아요를 누른 적이 있는지 확인
	@ResponseBody
	@PostMapping("IsReviewLikeExist")
	public boolean isReviewLikeExist(@RequestParam int review_num, @RequestParam String member_id) {
//	public boolean isReviewLikeExist(@RequestParam int review_num, @RequestParam String member_id, Model model) {
		System.out.println("ReviewLikeController - isReviewLikeExist()");
		boolean isReviewLikeExist = false;
		
		// ReviewLikeService의 findReviewLike() 메서드를 호출하여 
		// 리뷰에 대해 리뷰좋아요를 누른 적이 있는지 확인
		// => 파라미터 : review_num, member_id,   리턴타입 : int(reviewLikeCount)
		int findreviewLikeCount = service.findReviewLike(review_num, member_id);
		System.out.println(findreviewLikeCount);
		
		// reviewLikeCount > 0 일 경우 isReviewLikeExist = true
		if(findreviewLikeCount > 0) {
			isReviewLikeExist = true;
		}
		
		System.out.println(isReviewLikeExist);
		
		return isReviewLikeExist;
	}
	
	
	// ReviewLikeCount 요청에 의해 
	// 리뷰별 리뷰좋아요 갯수 가져오기
	@ResponseBody
	@PostMapping("ReviewLikeCount")
	public int reviewLikeCount(@RequestParam int review_num) {
		System.out.println("MovieController - reviewLikeCount()");
		
		// ReviewLikeService의 getReviewLikeCount() 메서드를 호출하여 
		// 리뷰별 리뷰좋아요 갯수 가져오기
		// => 파라미터 : review_num   리턴타입 : int(reviewLikeCount)
		int reviewLikeCount = service.getReviewLikeCount(review_num);
		
		return reviewLikeCount;
	}
	
	// ReviewLike 요청에 의해 
	// 리뷰별 리뷰좋아요 등록
	@ResponseBody
	@PostMapping("ReviewLike")
	public int reviewLike(@RequestParam int review_num, @RequestParam String member_id) {
		System.out.println("ReviewLikeController - reviewLike()");
		
		// ReviewLikeService의 registReviewLike() 메서드를 호출하여 
		// 리뷰 좋아요 등록
		// => 파라미터 : review_num, member_id   리턴타입 : int(insertCount)
		int insertCount = service.registReviewLike(review_num, member_id);
		
		int reviewLikeCount = 0;
		
		if(insertCount > 0) {
			// ReviewLikeService의 getReviewLikeCount() 메서드를 호출하여 
			// '회원이 좋아요를 누른 리뷰'의 전체 리뷰좋아요 수 구하기
			// => 파라미터 : review_num  리턴타입 : int(reviewLikeCount)
			reviewLikeCount = service.getReviewLikeCount(review_num);
		}
		
		return reviewLikeCount;
	}
	
	
	// ReviewLike 요청에 의해 
	// 리뷰별 리뷰좋아요 취소(삭제)
	@ResponseBody
	@PostMapping("RemoveReviewLike")
	public int removeReviewLike(@RequestParam int review_num, @RequestParam String member_id) {
		System.out.println("ReviewLikeController - removeReviewLike()");
		
		// ReviewLikeService의 removeReviewLike() 메서드를 호출하여 
		// 리뷰 좋아요 취소(삭제)
		// => 파라미터 : review_num, member_id   리턴타입 : int(deleteCount)
		int deleteCount = service.removeReviewLike(review_num, member_id);
		
		int reviewLikeCount = 0;
		
		if(deleteCount > 0) {
			// ReviewLikeService의 getReviewLikeCount() 메서드를 호출하여 
			// '회원이 좋아요를 취소한 리뷰'의 전체 리뷰좋아요 수 구하기
			// => 파라미터 : review_num  리턴타입 : int(reviewLikeCount)
			reviewLikeCount = service.getReviewLikeCount(review_num);
		}
		
		return reviewLikeCount;
	}
	
	
	// 세션아이디가 존재하는 경우
	// IsMember 요청에 의해 
	// 회원인지 비회원인지 확인
	@ResponseBody
	@PostMapping("IsMember")
	public boolean isMember(@RequestParam String member_id) {
		System.out.println("ReviewLikeController - isMember()");
		boolean isMember = false;
		
		// ReviewLikeService의 getMember() 메서드를 호출하여 
		// 현재 세션아이디가 회원인지 아닌지 확인
		/// => 파라미터 : member_id  리턴타입 : int(getMember)
		int getMember = service.getMember(member_id);
		
		if(getMember > 0) {
			isMember = true;
		}
		
		return isMember;
	}

}
