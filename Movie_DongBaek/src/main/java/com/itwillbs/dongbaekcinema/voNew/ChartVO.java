package com.itwillbs.dongbaekcinema.voNew;

import lombok.Data;

@Data
public class ChartVO {
	private int movie_num;
	private String movie_name_kr;
	private String movie_genre;
	private String member_id; 
	private String member_birth;  
	private int play_num;
	private int genreCnt;
	private double rate;
	
}
