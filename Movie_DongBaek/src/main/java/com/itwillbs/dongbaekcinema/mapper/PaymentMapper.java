package com.itwillbs.dongbaekcinema.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.dongbaekcinema.vo.PaymentVO;
import com.itwillbs.dongbaekcinema.voNew.*;

@Mapper
public interface PaymentMapper {

	// 결제 내역 상세 조회 id로 구별
	//0616 수정중 
//	--------------------원본--------------------------
//	PaymentVO selectPayment(int order_num);
	List<PaymentVO> selectPayment(int order_num);
	
//	// 결제 내역 조회 - 0615정의효 페이징처리로 이거없어도됨
//	List<PaymentVO> selectPaymentList();
	
	// 마이페이지 - 회원의 나의 구매내역 조회(지영)
	List<BuyDetailVO> selectMyPaymentList(@Param("member_id") String member_id, @Param("startRow") int startRow, @Param("listLimit") int listLimit);

	// 마이페이지 - 회원의 나의 구매내역 상세 조회(지영)
	List<BuyDetailVO> selectMyPaymentDetail(String payment_num);
	
	// 마이페이지 - 회원의 나의 구매내역 상세 조회 - 티켓 (지영)
	List<BuyDetailVO> selectMyTickets(String payment_num);
	
	// 마이페이지 - 회원의 나의 구매내역 상세 조회 - 스낵 (지영)
	List<BuyDetailSnackVO> selectMySnacks(String payment_num);
	
	// 마이페이지 - 나의 멤버십. 올해 누적 실적 조회 (지영)
	int selectYearPayment(String member_id);
	
	//페이징처리중 - 0615 정의 - 페이징처리 새로 완료후삭제예정 0622 정의효
//	List<PaymentVO> getPaymentList(@Param("start") int start, @Param("perPage") int pageListLimit);
	
	//페이징처리중 - 0615 정의  - 페이징처리 새로 완료후삭제예정 0622 정의효
//	int getCount();

	//0621 정의효 - 결제상세 list작성중
	List<PaymentVO> getPaymentDetail(@Param("order_num") String order_num, @Param("payment_num") String payment_num);
	
	//전체 결제 목록 조회 0622정의효
	List<PaymentVO> selectPaymentList(@Param("paymentSearchKeyword") String paymentSearchKeyword, 
									  @Param("startRow") int startRow, 
									  @Param("listLimit") int listLimit);

	// 전체 결제 목록 개수 0622 정의효
	int selectPaymentListCount(String paymentSearchKeyword);
	



}
