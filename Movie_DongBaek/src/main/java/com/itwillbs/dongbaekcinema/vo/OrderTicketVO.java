package com.itwillbs.dongbaekcinema.vo;

import lombok.Data;

@Data
public class OrderTicketVO {
	private int order_ticket_num;
	private String order_num;
	private String member_id;
	private int play_num;
	private int seat_num;	
	private int ticket_type_num;	
}
