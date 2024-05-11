package com.itwillbs.dongbaekcinema.vo;

import java.math.BigDecimal;
import java.sql.Date;

import lombok.Data;

@Data
public class MovieVO {

	private int movie_num;
	private String movie_name_kr;
	private String movie_name_en;
	private String movie_director;
	private String movie_cast;
	private String movie_genre;
	private Date movie_release_date; //Date : java.sql.Date 임포트함 XX-YY-MM
	private Date movie_close_date;
	private int movie_running_time;
	private int movie_audience_num;
	private String movie_content;
	private String movie_grade;
	private String movie_poster;
	private String movie_preview;
	private String movie_photo1;
	private String movie_photo2;
	private String movie_photo3;
	private BigDecimal movie_booking_rate;
	
	//영화 당 평점평균출력 위한 앨리어스
	private BigDecimal movie_review_rating;
	
	
}
























