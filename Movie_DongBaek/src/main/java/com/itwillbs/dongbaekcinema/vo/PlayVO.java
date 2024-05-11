package com.itwillbs.dongbaekcinema.vo;

import java.sql.Time;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 프로퍼티를 변수로 갖는 생성자
@NoArgsConstructor // 기본생성자
@Data
public class PlayVO {

    private int play_num;
    private String play_date;
    private int play_turn;
    private Time play_start_time;
    private Time play_end_time;
    private String play_time_type;
    private int movie_num;
    private int theater_num;
    private int room_num;
    private String movie_name_kr; // MOVIES 테이블로부터 조인으로 가져오는 컬럼
    private String theater_name; // THEATERS 테이블로부터 조인으로 가져오는 컬럼
    private String room_name; // ROOMS 테이블로부터 조인으로 가져오는 컬럼
    private String movie_release_date;
    private String movie_close_date;
    
    
//    private int playNum;
//    private LocalDate playDate;
//    private int playTurn;
//    private LocalTime playStartTime;
//    private LocalTime playEndTime;
//    private String playTimeType;
//    private int movieNum;
//    private int theaterNum;
//    private int roomNum;

}

//enum play_time_type {
//    "조조", "일반", "심야";
//}


