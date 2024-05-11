package com.itwillbs.dongbaekcinema.voNew;

import java.sql.*;
import java.util.*;

import lombok.*;
/*
CREATE OR REPLACE VIEW ORDER_MY_TICKET
AS
SELECT member_id, movie_poster, movie_name_kr, play_date, ticket_type, order_num, movie_num, ticket_payment_status, play_start_time,
        CASE 
	        WHEN (play_date > now() OR (play_date = now() AND play_start_time > CURTIME()) ) THEN '상영 전'
	        ELSE '상영완료'
        END AS 'play_status',
        CASE
	        WHEN (play_date > now() OR (play_date = now() AND play_start_time >= ADDTIME(CURTIME(), '0:30:00')) ) AND ticket_payment_status = '결제완료' THEN '취소가능'
            ELSE '취소불가'
        END AS 'play_change'
FROM (SELECT movie_name_kr, movie_poster, play_date, play_start_time, member_id, MOVIES.movie_num, ticket_payment_status
		, CONCAT(TICKET_TYPES.ticket_user_type, '/', TICKET_TYPES.ticket_time_type) AS 'ticket_type', order_num
        FROM PLAYS 
	        JOIN MOVIES ON PLAYS.movie_num = MOVIES.movie_num
	        JOIN ORDER_TICKETS ON PLAYS.play_num = ORDER_TICKETS.play_num
	        JOIN TICKET_TYPES ON TICKET_TYPES.ticket_type_num = ORDER_TICKETS.ticket_type_num
      ) AS MYPAGE_ORDER
      ;
 */


@Data
public class MyTicketVO {
	// 나의 예매내역에서 사용되는 VO
	// 회원 id, 영화 포스터, 영화명(한글), 상영일자, 상영상태(상영 전, 상영완료), 상영취소여부(취소가능, 취소불가)
	private String member_id;
	private String movie_poster;
	private String movie_name_kr;
	private String play_date;
	private String ticket_type;
	private String play_status;
	private String play_change;
	private long order_num;	// 파라미터 전달 시 사용하기 위해 order_num 추가
	private String movie_num;
	private String payment_num;
	private String ticket_payment_status;
//	private String payment_name;
//	private String payment_datetime;
//	private String payment_card_name;
//	private String payment_total_price;
//	private String payment_status;
	private Time play_start_time;
	private Time play_end_time;
	
}
