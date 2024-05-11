package com.itwillbs.dongbaekcinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.PaymentMapper;
import com.itwillbs.dongbaekcinema.vo.PaymentVO;
import com.itwillbs.dongbaekcinema.voNew.*;

@Service
public class PaymentService {

	@Autowired
	private PaymentMapper mapper;
	
	// 결제 상세 조회를 위한 메서드(id로 구분)
	// 0616 페이먼트 상세 여러개 테스트중 0616정의효
//	-----------------원본------------------ 0618 원본이 주석풀려있음
//	public PaymentVO getPayment(int order_num) {
//		return mapper.selectPayment(order_num);
//	}

	

	
	//0618정의효 - 밑에꺼 수정하거나 삭제해서 List값 다시확인
//	public List<PaymentVO> getPayment(int order_num) {
//		return mapper.selectPayment(order_num);
//	}
	
//	// (모든) 결제 내역을 조회후 리스트게 아겨조기위한 메서드 - 페이징처리메서드로인해 없어도됨 0615정의효
//	public List<PaymentVO> getPaymentList() {
//		return mapper.selectPaymentList();
//	}
	
	// 마이페이지 - 회원의 나의 구매내역 조회(지영)
	public List<BuyDetailVO> getMyPaymentList(String member_id, int startRow, int listLimit) {
		return mapper.selectMyPaymentList(member_id, startRow, listLimit);
	}
	
	// 마이페이지 - 회원의 나의 구매내역 상세 조회 (지영)
	public List<BuyDetailVO> getMyPaymentDetail(String payment_num) {
		return mapper.selectMyPaymentDetail(payment_num);
	}
	
	// 마이페이지 - 회원의 나의 구매내역 상세 조회 - 티켓 (지영)
	public List<BuyDetailVO> getMyTickets(String payment_num) {
		return mapper.selectMyTickets(payment_num);
	}
	
	// 마이페이지 - 회원의 나의 구매내역 상세 조회 - 스낵 (지영)
	public List<BuyDetailSnackVO> getMySnacks(String payment_num) {
		return mapper.selectMySnacks(payment_num);
	}
	
	// 마이페이지 - 나의 멤버십. 올해 누적 실적 조회 (지영)
	public int getYearPayment(String member_id) {
		return mapper.selectYearPayment(member_id);
	}
	
	// 페이징처리 테스트 - 현재페이지? 0615정의효 - 페이징처리 새로 완료후삭제예정 0622 정의효
//	public List<PaymentVO> getPaymentList(int pageNo, int pageListLimit) {
//		int start = (pageNo - 1) * pageListLimit;
//		return mapper.getPaymentList(start, pageListLimit);
//	}
	
	// 페이징처리 테스트 - 총 몇페이진지 0615정의효  - 페이징처리 새로 완료후삭제예정 0622 정의효
//	public int getTotalPageCount(int pageListLimit) {
//		int totalCount = mapper.getCount();
//		return (int) Math.ceil((double) totalCount / pageListLimit);
//	}

	// 0621 정의효 관리자-결제상세정보
	public List<PaymentVO> getPaymentDetail(String order_num, String payment_num) {
		return mapper.getPaymentDetail(order_num, payment_num);
	}
	
//	결제 목록 조회 0622 정의효
	public List<PaymentVO> getPaymentList(String paymentSearchKeyword, int startRow, int listLimit) {
		return mapper.selectPaymentList(paymentSearchKeyword, startRow, listLimit);
	}

//	전체 결제목록 개수 조회 0622정의효
	public int getPaymentListCount(String paymentSearchKeyword) {
		return mapper.selectPaymentListCount(paymentSearchKeyword);
	}


	



	//페이징처리테스트 -10페이지 까지나오게 0615 정의효 -찾아서 1~10뜨고 11~20뜨고 해보기
//	public int getStartIndex(int pageNo, int pageListLimit) {
//		return (pageNo - 1) * pageListLimit + 1;
//	}
		
	//페이징처리테스트 -10페이지 까지나오게 0615 정의효  - 찾아서 1~10뜨고 11~20뜨고 해보기
//	public int getEndIndex(int pageNo, int pageListLimit) {
//		return pageNo * pageListLimit;  
//	}
}









