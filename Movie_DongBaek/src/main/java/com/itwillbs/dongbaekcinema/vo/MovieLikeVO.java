package com.itwillbs.dongbaekcinema.vo;

import lombok.*;

@Data
public class MovieLikeVO {
	
	private int like_num;
	private String member_id;
	private int movie_num;
	private String movie_name_kr;	// --- 밑으로는 찜 영화 목록 시 보여주기 위해 변수 지정
	private String movie_poster;
	private String movie_release_date;
	private String movie_status;
	private String like_view;
	
	
}
