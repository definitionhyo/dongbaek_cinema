package com.itwillbs.dongbaekcinema.voNew;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class MyReviewVO {
	// 영화 상영 완료 목록 가져오기
	private int movie_num;
	private long order_num;
	private int play_num;
	private String member_id;
	private String movie_name_kr;
	private String play_date;
	private String play_status;
	
	// 리뷰 작성 및 수정
	private int review_num;
	private String review_rating;
//	private BigDecimal review_rating;
	private String review_content;
	private String  review_date;
}
