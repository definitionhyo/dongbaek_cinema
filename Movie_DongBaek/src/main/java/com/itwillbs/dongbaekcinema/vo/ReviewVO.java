package com.itwillbs.dongbaekcinema.vo;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class ReviewVO {
	private int review_num;
	private BigDecimal review_rating;
	private String review_content;
	private String  review_date;
	private int movie_num;
	private String member_id;
	
	//평균평점
	private BigDecimal movie_review_rating;
	//영화당 리뷰개수카운팅
	private int review_count;
	//영화당 평균평점순 정렬을 위한 앨리어스
	

}
