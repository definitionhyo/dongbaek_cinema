package com.itwillbs.dongbaekcinema.vo;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class OrderVO {
//	private int order_num;
//	private BigDecimal order_total_price;
	private String order_num;	// 아임포트 결제번호
	private int order_total_price;
	private String member_id;
}
