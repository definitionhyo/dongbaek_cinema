package com.itwillbs.dongbaekcinema.voNew;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 프로퍼티를 변수로 갖는 생성자
@NoArgsConstructor // 기본생성자
@Data
public class PlayScheduleVO {
    
	private int movie_num;
	private String movie_name_kr; 
	private String movie_release_date;
	private String movie_close_date;
	private int movie_running_time;
    private int theater_num;
    private String theater_name; 
    private int room_num;
    private String room_name; 
    private String room_start_time; 
    private String room_end_time;    
    private String play_date;
    private int play_num;
    private int play_turn;
    private String play_start_time;
    private String play_end_time;
    private String play_time_type;
	
}
