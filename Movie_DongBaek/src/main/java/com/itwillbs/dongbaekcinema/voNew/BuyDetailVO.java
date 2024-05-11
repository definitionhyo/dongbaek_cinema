package com.itwillbs.dongbaekcinema.voNew;

import java.util.Date;

import lombok.*;

/*
CREATE OR REPLACE VIEW BUY_DETAIL AS
(
    SELECT O.member_id, P.payment_num, P.payment_name, P.payment_card_name, P.payment_card_num, O.order_num
        , P.payment_datetime, P.payment_total_price, P.payment_status, M.movie_name_kr
        , CONCAT(TT.ticket_user_type, '/', TT.ticket_time_type) AS 'ticket_type'
        FROM PAYMENTS P
        JOIN ORDERS O ON P.order_num = O.order_num
        JOIN ORDER_TICKETS OT ON P.order_num = OT.order_num -- 갯수만큼 나오는 거 play_num 으로 묶어 카운팅
        JOIN PLAYS ON OT.play_num = PLAYS.play_num
        JOIN MOVIES M ON PLAYS.movie_num = M.movie_num
        JOIN TICKET_TYPES TT ON OT.ticket_type_num = TT.ticket_type_num
);
 */


@Data
public class BuyDetailVO {
	// 마이페이지 - 나의 구매내역 중 
	private long order_num;
	private String member_id;
	private String payment_num;
	private String payment_name;
	private String payment_card_name;
	private String payment_card_num;
	private Date payment_datetime;
	private int payment_total_price;
	private String payment_status;
	private String movie_name_kr;
	private String ticket_type;
//	private String snack_name;
	private int ticket_quantity;	// 구매내역 중 영화, 티켓타입별 갯수
//	private int snack_quantity;		// 구매내역 중 스낵별 갯수
	private String reason;
}
