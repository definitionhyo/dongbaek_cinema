package com.itwillbs.dongbaekcinema.voNew;

import java.sql.Date;

import lombok.Data;

@Data
public class ReservationVO {
	private int play_num;
	private int movie_num;
	private String movie_name_kr;
	private String movie_poster;
	private int theater_num;
	private String theater_name;
	private String play_date;
	private String play_start_time;
	private String play_end_time;
	private String play_time_type;
	private int room_num;
	private String room_name;
	private int ticket_type_num;
	private int seat_num;
	private String seat_name;
	private String snack_name;
	private int snack_quantity;	
	
}
