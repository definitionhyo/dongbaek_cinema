package com.itwillbs.dongbaekcinema.mapper;

import org.apache.ibatis.annotations.*;

@Mapper
public interface PayMapper {
	
	// 결제 취소 (payment_num)으로 일치하는 레코드 결제 상태(payment_status) 변경
	public int updatePayment(String payment_num);
	
	// 티켓예약 상태변경, 스낵결제 상태변경
	public int updateTicket(long order_num);
	public int updateSnack(long order_num);
	
}
