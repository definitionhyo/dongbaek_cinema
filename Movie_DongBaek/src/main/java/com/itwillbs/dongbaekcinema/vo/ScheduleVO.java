package com.itwillbs.dongbaekcinema.vo;

import java.sql.Date;
import java.sql.Time;

import lombok.Data;

@Data
public class ScheduleVO {
	private String movie_name_kr;
	private String room_name;
	private Time play_start_time ;
	private Time end_time; 
	private String play_time_type;
	private String movie_name_en;
	private int room_num;
	private String movie_grade;
	private String movie_genre;
	private int movie_running_time;
	private Date movie_release_date;
	private int play_num;
	

}
