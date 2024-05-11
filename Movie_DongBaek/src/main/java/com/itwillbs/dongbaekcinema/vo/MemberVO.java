package com.itwillbs.dongbaekcinema.vo;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

 
@Data
public class MemberVO {
	private String member_id; 
	private String member_pass;
	private String member_name;
	private String member_email; // NULL
	// Date : java.sqlDate 임포트함 -> DB 상에는 DATE 타입이지만 입력 폼에서 text로 취급되어 String으로 바꿈
	// 스프링에서 String 으로 저장해도 DB 에서는 날짜 형식이 기 때문에 DATE 형식으로 입출력이 이루어진다
	private String member_birth;  
	private Date member_date;	//Date : java.sqlDate 임포트함
	private String member_phone;
	private String member_status; // ENUM 타입 -> String 타입으로 바꿈
	private boolean member_agree_marketing;
	private Date member_withdrawl;	//Date : java.sql.Date 임포트함 XX-YY-MM // NULL
	private String member_type;
	private String member_like_genre; // NULL
	private int theater_num;
	private String grade_name;
	private String payment_total_price;
	private String grade_max;
	private String total_payment;
	
}
