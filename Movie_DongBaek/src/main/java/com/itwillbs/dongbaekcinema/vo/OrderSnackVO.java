package com.itwillbs.dongbaekcinema.vo;

import lombok.Data;

@Data
public class OrderSnackVO {
	private int order_snack_num;
	private int snack_quantity;
	private String order_num;
	private String member_id;
	private int snack_num;	
	private String snack_payment_status;
}
