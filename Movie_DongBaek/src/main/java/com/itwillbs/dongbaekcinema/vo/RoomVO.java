package com.itwillbs.dongbaekcinema.vo;

import java.sql.Time;

import lombok.Data;

@Data
public class RoomVO {
	private int room_num;
	private String room_name;
	private int theater_num;
	private Time room_start_time;
	private Time room_end_time;
}
