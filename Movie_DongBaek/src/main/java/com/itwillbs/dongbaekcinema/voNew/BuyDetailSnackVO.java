package com.itwillbs.dongbaekcinema.voNew;

import java.util.Date;

import lombok.*;

/*
CREATE OR REPLACE VIEW BUY_DETAIL_SNACK AS
(
    SELECT O.member_id, P.payment_num, P.payment_name, P.payment_card_name, P.payment_card_num
        , P.payment_datetime, P.payment_total_price, P.payment_status
        , S.snack_name
        FROM PAYMENTS P
        JOIN ORDERS O ON P.order_num = O.order_num
        JOIN ORDER_SNACKS OS ON P.order_num = OS.order_num
        JOIN SNACKS S ON OS.snack_num = S.snack_num
);
 */


@Data
public class BuyDetailSnackVO {
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
//	private String movie_name_kr;
//	private String ticket_type;
	private String snack_name;
//	private int ticket_quantity;	// 구매내역 중 영화, 티켓타입별 갯수
	private int snack_quantity;		// 구매내역 중 스낵별 갯수
	private String reason;
}
