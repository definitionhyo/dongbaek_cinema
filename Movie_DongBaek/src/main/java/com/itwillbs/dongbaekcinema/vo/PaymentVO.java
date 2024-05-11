package com.itwillbs.dongbaekcinema.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PaymentVO {
	private String payment_num;
	private String payment_name;
	private String payment_datetime;	// java.util.Date 로 임포트함 시분초 필요하니까
	private String payment_card_name;
	private int payment_card_num;
	private String payment_total_price;
	private String order_num;
	private String payment_status;	// 추가함
	private String member_id; // 관리자페이지-전체결제내역에서 아이디를 출력하기위해 DB에서 가져와서 저장하기위한 member_id 0615-정의효
	private String movie_name_kr;
	private String theater_name;
	private int seat_num;
	private String headcount;
	private String payment_member_name;
	private String snack_name;
	private String member_name;
//	데이터넣고 주석풀고 확인하기 0608 - 정의효
	private String seat_names;
	private int dong_baek_combo_count;
	private int chul_juk_combo_count;
	
}

