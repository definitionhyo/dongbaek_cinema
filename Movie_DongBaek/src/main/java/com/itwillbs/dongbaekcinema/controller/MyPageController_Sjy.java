//package com.itwillbs.dongbaekcinema.controller;
//
//import java.io.*;
//import java.util.*;
//
//import javax.servlet.http.*;
//
//import org.springframework.beans.factory.annotation.*;
//import org.springframework.http.*;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.*;
//import org.springframework.web.bind.annotation.*;
//
//import com.itwillbs.dongbaekcinema.handler.MyPasswordEncoder;
//import com.itwillbs.dongbaekcinema.service.*;
//import com.itwillbs.dongbaekcinema.vo.*;
//import com.itwillbs.dongbaekcinema.voNew.*;
//
//import retrofit2.http.*;
//
//@Controller
//public class MyPageController {
//	
//	@Autowired
//	private MypageService service;
//	
//	@Autowired
//	private PaymentService paymentService;
//	
//	@Autowired
//	private PayService payService;
//	
////	@Autowired
////	private AdminService adminService;
//	
//	@Autowired
//	private MemberService memberService;
//	
//	@Autowired
//	private MovieLikeService likeService;
//	
//	//  마이페이지 메인화면
//	@GetMapping("myPage")
//	public String myPage(HttpSession session, Model model) {
//		
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//			
//			return "fail_location";
//		}
//		
//		// 세션 아이디로 현재등급과 다음 등급 조회(현등급,다음등급 정보)
//		// myPageService - getGrade()
//		// 파라미터 : String(member_id)		리턴타입 : GradeNextVO(myGrade)
//		GradeNextVO myGrade = service.getMyGrade(member_id);
////		System.out.println(myGrade);
//		
//		// 세션 아이디로 예매내역 받아오기(최근 세개만)
//		List<MyTicketVO> myTicketList = service.getMyTicket(member_id, 0, 2);
//		
//		// 세션 아이디로 회원 이름 받아오기
//		MemberVO member = memberService.getMember(member_id);
//		
//		// 세션 아이디로 나의 문의 내역 받아오기
//		List<CsVO> myInq = service.getMyInq(member_id);
//		
//		// 받아온 등급 정보와 예매내역 정보 저장
//		model.addAttribute("myGrade", myGrade);				                         
//		model.addAttribute("myTicketList", myTicketList);
//		model.addAttribute("member", member);
//		model.addAttribute("myInq", myInq);
//		
//		return "myPage/myPage";
//	}
//	
//	// 마이페이지 -  예매내역 페이지로 이동
//	@GetMapping("myPage_reservation_history")
//	public String myPage_reservation_history(HttpSession session, Model model,
//			// 페이징 처리
//			@RequestParam(defaultValue = "1") int pageNo ) {
//		// 세션아이디로 나의 예매/구매 내역 보여주기
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//			
//			return "fail_location";
//		}
//		
//		int listLimit = 5; // 한 페이지에 보여줄 게시물 수
//		
//		// 조회 시작 행(레코드) 번호 계산
//		int startRow = (pageNo - 1) * listLimit;
//		
//		// 나의 예매내역 조회
//		// MypageService - getMyTicket()
//		// 파라미터 : member_id		리턴타입 : List<MyTicketVO>(myTicketList)
//		List<MyTicketVO> myTicketList = service.getMyTicket(member_id, startRow, listLimit);
//		
//		List<MyTicketVO> myTicketListAll = service.getMyTicket(member_id, 0, 0);
//		int listCount = myTicketListAll.size();
//		
//		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
//		int pageListLimit = 5;
//		
//		// 3. 전체 페이지 목록 갯수 계산
//		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		
//		// 4. 시작 페이지 번호 계산
//		int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
//		
//		// 5. 끝 페이지 번호 계산
//		int endPage = startPage + listLimit -1; // 끝페이지
//		
//		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
//		if(endPage > maxPage) { 
//			endPage = maxPage;
//		}
//		
//		// 페이징 정보 저장
//		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
//		
//		model.addAttribute("pageInfo", pageInfo);
//		
//		// 받아온 예매내역 전달
//		model.addAttribute("myTicketList", myTicketList);
//		
//		return "myPage/myPage_reservation_history";
//	}
//	
//	// 마이페이지 -  구매내역 페이지로 이동
//	@GetMapping("myPage_buy_history")
//	public String myPage_buy_history(HttpSession session, Model model,
//			// 페이징 처리
//			@RequestParam(defaultValue = "1") int pageNo) {
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//			
//			return "fail_location";
//		}
//		
//		// 세션아이디로 나의 예매/구매 내역 보여주기
//		// 구매내역 페이징 생각하기
//		int pageNum = 3;
//		
//		// 한 페이지에 보여줄 게시물 수
//		int listLimit = 5; 
//		
//		// 조회 시작 행(레코드) 번호 계산
//		int startRow = (pageNo - 1) * listLimit;
//		
//		// 나의 구매내역 조회
//		// MypageService - getMyPayment()
//		// 파라미터 : member_id		리턴타입 : List<PaymentVO>(myPaymentList)
//		List<BuyDetailVO> myPaymentList = paymentService.getMyPaymentList(member_id, startRow, listLimit);
//		
//		// 나의 예매내역 조회
//		// MypageService - getMyTicket()
//		// 파라미터 : member_id		리턴타입 : List<MyTicketVO>(myTicketList)
//		
//		List<BuyDetailVO> myPaymentListAll = paymentService.getMyPaymentList(member_id, 0, 0);
//		int listCount = myPaymentListAll.size();
//		
//		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
//		int pageListLimit = 5;
//		
//		// 3. 전체 페이지 목록 갯수 계산
//		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		
//		// 4. 시작 페이지 번호 계산
//		int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
//		
//		// 5. 끝 페이지 번호 계산
//		int endPage = startPage + listLimit -1; // 끝페이지
//		
//		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
//		if(endPage > maxPage) { 
//			endPage = maxPage;
//		}
//		
//		// 페이징 정보 저장
//		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
//		
//		model.addAttribute("pageInfo", pageInfo);
//		
//		//받아온 구매내역 전달
//		model.addAttribute("myPaymentList", myPaymentList);
//		
//		return "myPage/myPage_buy_history";
//	}
//	
//	// 마이페이지 - 구매내역 - 상세내역 조회
//	@PostMapping("myPayment_detail")
//	public String myPayment_detail(String payment_num, @RequestParam(required = false) String play_change, 
//												HttpSession session, Model model) {
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//			
//			return "fail_location";
//		}
//		
//		// 상세내역 클릭 시 payment_num 을 받아와 조회해 보여주기
//		// 파라미터 : int(payment_num)		리턴타입 : List<BuyDetailVO>(myPaymentDetailList)
////		System.out.println(payment_num);
//		List<BuyDetailVO> myPaymentDetailList = paymentService.getMyPaymentDetail(payment_num);
////		System.out.println(myPaymentDetail);
//		
//		// 상세내역 클릭 시 payment_num으로 스낵, 영화 정보(갯수) 가져오기
//		// 파라미터 : int(payment_num)		리턴타입 : BuyDetailVO(tickets)
//		// 파라미터 : int(payment_num)		리턴타입 : BuyDetailVO(snacks)
//		List<BuyDetailVO> myTicket = paymentService.getMyTickets(payment_num);
//		List<BuyDetailSnackVO> mySnack = paymentService.getMySnacks(payment_num);
//		
//		//받아온 구매 상세내역 전달
//		model.addAttribute("myPaymentDetailList", myPaymentDetailList);
//		model.addAttribute("myTicket", myTicket);
//		model.addAttribute("mySnack", mySnack);
//		model.addAttribute("play_change", play_change);
//		
//		return "myPage/myPage_buy_history_detail";
//	}
//	
//	
//	// ============= 결제 취소 ================
//	@PostMapping("payCancel")
//	public ResponseEntity<String> orderCancle(BuyDetailVO buyDetail) throws Exception {
////		System.out.println(buyDetail);
//		
//		// ----------- api 작업 -----------------
//		// 주문번호가 있으면 실행
//		// payService - getToken() : 토큰 받아오기
//		// payService - paymentInfo() : 결제번호와 토큰으로 결제된 금액 받아오기
//		// payService - payMentCancle() : 결제 취소 기능 메서드 호출
//	    if(!"".equals(buyDetail.getPayment_num())) {
//	        String token = payService.getToken();
//	        int amount = Integer.parseInt(payService.paymentInfo(buyDetail.getPayment_num(), token));
//	        payService.payMentCancle(token, buyDetail.getPayment_num(), amount, buyDetail.getReason());
//	    }
//		
//	    // ------------ DB 작업 -----------------
//	    // PayService - orderCancle() 호출
//	    // 결제 상태변경(PAYMENTS.payment_status), 티켓예약 상태변경, 스낵결제 상태변경
//		payService.orderCancle(buyDetail);
//
//		return ResponseEntity.ok().body("주문취소완료"); // <200 OK OK,주문취소완료,[]>
//	}
//	
//	
//	// 마이페이지 - 나의 리뷰 페이지로 이동
////	@GetMapping("myPage_myReview")
////	public String myPage_myReview() {
////		return "myPage/myPage_myReview";
////	}
////	
////	// 마이페이지 - 나의 리뷰 글쓰기 페이지로 이동
////	@GetMapping("myPage_reviewWrite")
////	public String myPage_reviewWrite() {
////		return "myPage/myPage_reviewWrite";
////	}
//	
//	// 마이페이지 - 찜한 영화 목록으로 이동
//	@GetMapping("myPage_like")
//	public String myPageLike(HttpSession session, Model model,
//			// 페이징 처리
//			@RequestParam(defaultValue = "1") int pageNo) {
//		
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		// 세션 아이디로 찜한 영화 목록 들고오기
//		// 찜한 영화 있을 경우 찜하기 표시하기(비회원이 아닐 때)
//		String member_type = (String) session.getAttribute("member_type");
//		String member_id = (String) session.getAttribute("member_id");
//
//		if (member_id == null || member_type.equals("비회원")) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//			return "fail_location";
//		}
//		
//		// 세션아이디로 나의 예매/구매 내역 보여주기
//		// 구매내역 페이징 생각하기
//		int pageNum = 5;
//		// 한 페이지에 보여줄 게시물 수
//		int listLimit = 6; 
//		// 조회 시작 행(레코드) 번호 계산
//		int startRow = (pageNo - 1) * listLimit;
//
//		// 찜한 영화 목록 - 페이징
//		// LikeService - getLikeMovie()
//		// 파라미터 : member_id		리턴타입 : List<LikeVO>(likeList)
//		List<MovieLikeVO> likeList = likeService.getLikeMovieList(member_id, startRow, listLimit); 
////		System.out.println(likeList);
//		
//		// 페이징처리, 찜한 영화 총 갯수
//		int likeListCount = likeService.getLikeMovieCount(member_id); 
//
//
//		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
//		int pageListLimit = 5;
//		// 3. 전체 페이지 목록 갯수 계산
//		int maxPage = likeListCount / listLimit + (likeListCount % listLimit > 0 ? 1 : 0);
//		// 4. 시작 페이지 번호 계산
//		int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
//		// 5. 끝 페이지 번호 계산
//		int endPage = startPage + listLimit -1; // 끝페이지
//		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
//		if(endPage > maxPage) { 
//			endPage = maxPage;
//		}
//
//		// 페이징 정보 저장
//		PageInfoVO pageInfo = new PageInfoVO(likeListCount, pageListLimit, maxPage, startPage, endPage);
//
//		model.addAttribute("pageInfo", pageInfo);
//		model.addAttribute("likeList", likeList);
////			if(likeList != null) {
////	//		 모델에 저장 (-> 메인, 영화목록, 영화디테일)
////	//		 세션x : 찜하기 목록이 업데이트 될때마다 달라지므로 페이지마다 조회해서 파라미터로 받을 예정
////			}
////		
//		model.addAttribute("likeListCount", likeListCount);
//		
//		
//		return "myPage/myPage_like";
//	}
//	
//	// 마이페이지 - 나의 리뷰 페이지로 이동
//    @GetMapping("myPage_myReview")
//    public String myPage_myReview(HttpSession session, Model model) {
//        // 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//        String member_id = (String) session.getAttribute("member_id");
//        if(member_id == null) {
//            model.addAttribute("msg", " 로그인이 필요합니다!");
//            model.addAttribute("targetURL", "member_login_form");
//
//            return "fail_location";
//        }
//
//        // 세션 아이디로 리뷰 보여주기
//        // 페이징
//        int pageNum = 5;
//
//        // 나의 리뷰 조회
//        // MypageService - getMyReview()
//        // 파라미터 : member_id(세션저장)    리턴타입 : List<ReviewVO> myReviewList
//        List<ReviewVO> myReviewList = service.getMyReview(member_id, pageNum);
////        List<MyReviewVO> myReviewList = service.getMyReview(member_id, pageNum);
//        System.out.println(myReviewList);
//        System.out.println(); 
//        
//        // 받아온 리뷰내역 전달
//        model.addAttribute("myReviewList", myReviewList);
//
//        return "myPage/myPage_myReview";
//    }
//
//    // 마이페이지 - 나의 리뷰 글쓰기 페이지로 이동
//    @GetMapping("myPage_reviewWrite")
//    public String myPage_reviewWrite(HttpSession session, Model model) {
//        // 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//        String member_id = (String) session.getAttribute("member_id");
//        if(member_id == null) {
//            model.addAttribute("msg", " 로그인이 필요합니다!");
//            model.addAttribute("targetURL", "member_login_form");
//
//            return "fail_location";
//        }
//
//
//        return "myPage/myPage_reviewWrite";
//    }
//
//	// 마이페이지 - 영화 네컷 페이지로 이동
//	@GetMapping("myPage_moviefourcut")
//	public String myPage_moviefourcut() {
//		return "myPage/myPage_moviefourcut";
//	}
//	
//	// 마이페이지 - 문의 내역 페이지로 이동
//	@GetMapping("myPage_inquiry")
//	public String myPage_inquiry(HttpSession session, Model model) {
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//			
//			return "fail_location";
//		}
//		
//		// 세션에 저장된 아이디로 문의내역 조회
//		// myPageService - getMyInq(member_id)
//		// 파라미터(member_id)		리턴타입(CsVO)
//		List<CsVO> myInq = service.getMyInq(member_id);
//		System.out.println(myInq);
//		model.addAttribute("myInq", myInq);
//		
//		return "myPage/myPage_inquiry";
//	}
//	
//	// 마이페이지 - 나의 등급 페이지로 이동
//	@GetMapping("myPage_grade")
//	public String myPage_grade(HttpSession session, Model model) {
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//			
//			return "fail_location";
//		}
//		
//		// 세션 아이디로 현재등급과 다음 등급 조회(현등급,다음등급 정보)
//		// myPageService - getGrade()
//		// 파라미터 : String(member_id)		리턴타입 : GradeNextVO(myGrade)
//		GradeNextVO myGrade = service.getMyGrade(member_id);
////		System.out.println(myGrade);
//		
//		// 다음 등급까지 얼마 남았는지 비교하기 위한 결제금액 조회
//		// paymentService - getYearPayment()
//		// 파라미터 : String(member_id)		리턴타입 : int(payment_total_price)
//		int payment_total_price = paymentService.getYearPayment(member_id);
////		System.out.println(payment_total_price);
//		
//		model.addAttribute("myGrade", myGrade);
//		model.addAttribute("payment_total_price", payment_total_price);
//		
//		return "myPage/myPage_grade";
//	}
//	
//	// 마이페이지 - 개인정보 수정 비밀번호 확인 페이지로 이동 -> pro 생성 해서 처리하
//	// 로그인 한 상태와 로그인하지 않은 상태를 구분해서 페이지이동
//	// => 로그인 한 상태 : modify_check.jsp 화면으로 이동
//	// => 비로그인 상태 : 로그인해야한다는 메세지를 띄우고, 로그인 화면으로 이동
//	@GetMapping("myPage_modify_check")
//	public String myPage_modify_check(HttpSession session, Model model) {
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//					
//			return "fail_location";
//		}		
//		return "myPage/myPage_modify_check";
//	}
//	
//	@PostMapping("myPage_modify_check_pro")
//	public String myPage_modify_check_pro(@RequestParam String member_pass_check, MemberVO member, Model model, HttpSession session) {
//		String member_id = (String)session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("url", "member_login_form");
//					
//			return "fail_location";
//		}
//		
//		System.out.println("member_pass_check : " + member_pass_check);
////		
//		String securePasswd = service.getPasswd(member_id);
//	
//		// 2. BcryptPasswordEncoder 객체 생성
//		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//		System.out.println("securePasswd : " + securePasswd);
//
////		 if (member.getMember_pass() ==  null || !passwordEncoder.matches(member.getMember_pass(), securePasswd)) {
//		 if (!passwordEncoder.matches(member_pass_check, securePasswd)) {
//				// 패스워드가 member.getPasswd와 다를 때(비밀번호가 틀림)
//				model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. "
//						+ "입력하신 내용을 다시 확인해주세요.");
//				return "fail_back";
//		 } 
//		 return "redirect:/myPage_modify_member";
//	}
//	
//
//	// 마이페이지 - 개인정보 수정 폼페이지로 이동
//	@GetMapping("myPage_modify_member")
//	public String myPage_modify_member(MemberVO member, Model model, HttpSession session) {
//		// 세션아이디로 개인정보 내역 보여주기
//		String member_id = (String) session.getAttribute("member_id");
//		
//		// 나의 개인정보 조회
//		// MypageService - getMyInfo()
//		// 파라미터 : member_id		리턴타입 : List<MemberVO>(myInfoList)
//		List<MemberVO> myInfoList = service.getMyInfo(member_id);
//		System.out.println(myInfoList);
//
//		//받아온 개인정보 전달
//		model.addAttribute("myInfoList", myInfoList);
//		
//		return "myPage/myPage_modify_member";
//	}
//	
//	// 마이페이지 - 개인정보 수정 
//	@PostMapping("myPage_modify_member_pro")
////	@RequestMapping(value = "myPage_modify_member_pro", method= {RequestMethod.GET, RequestMethod.POST})
//	public String myPage_modify_member_pro(MemberVO member,
//										   Model model,
//										   HttpSession session,
//										   @RequestParam String member_pass,
//										   @RequestParam String member_email,
//										   @RequestParam String member_like_genre) {
//		// 세션 아이디로 개인정보 내역 보여주기
//		System.out.println("member_pass : " + member_pass);
//		System.out.println("member_email : " + member_email);
//		String member_id = (String)session.getAttribute("member_id");
//		
//		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//		
//		
//		// 나의 개인정보 업데이트 
//		// MypageService - updateMyInfo()
//		// 파라미터 : member_id	리턴타입 : int 
//		int updateCount = service.updateMyInfo(
//								member, 
//								passwordEncoder.encode(member_pass),
//								member_email,
//								member_id,
//								member_like_genre
//								);
//		
//		System.out.println(updateCount);
//		
//		if(updateCount > 0 ) {
//			model.addAttribute("msg", "개인정보 수정이 성공했습니다.");
////			model.addAttribute("url", "myPage/myPage_modify_member");
//			
////			return "success_back";		
//			
//			return "redirect:/myPage_modify_member";
//			
//		} else {
//		
//		model.addAttribute("msg", "개인정보 수정이 실패했습니다.");
////		model.addAttribute("url", "member_login_form");
//		
//		return "fail_back";
//		}
//		
//	}
//	
//	// 회원 탈퇴 확인
//	// DB 에 저장된 비밀번호와 일치 여부 확인 시
//	// 일치한다면 회원상태 '탈퇴'로 변경 
//	// 회원 상태 가 탈퇴라면 로그인 불가능 하다록 로그인 페이지 수정 필요
//	@GetMapping("MemberWithdrawalForm")
//	public String member_withdrawal_form(HttpSession session, Model model, MemberVO member) {
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "./");
//							
//			return "fail_location";
//		}
//		return "myPage/myPage_withdrawal_check";
//	}
//	
//	// 회원 탈퇴 로직
//	@PostMapping("MemberWithdrawal")
//	public String member_withdrawal_pro(HttpSession session, Model model, MemberVO member, String withdrawalPasswd) {
//		String member_id = (String) session.getAttribute("member_id");
//		if(member_id == null) {
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
//							
//			return "fail_location";
//		}
//		
//		String securePasswd = memberService.getPasswd(member);
//		System.out.println(securePasswd);
//		System.out.println(withdrawalPasswd);
//	
//		// 2. BcryptPasswordEncoder 객체 생성
//		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//	
//		System.out.println("securePasswd : " + securePasswd);
//	
//		if (passwordEncoder.matches(withdrawalPasswd, securePasswd)) {
//			// 회원상태 = 탈퇴로 변경
//			int withdrawalCount = service.memberwithdrawal(member_id);
//			
//			if(withdrawalCount > 0 ) {
//				// 세션무효화 필요
//				session.invalidate();
//
//				model.addAttribute("msg", "동백시네마를 이용해주셔서 감사합니다. 탈퇴처리 되었습니다.");
//				model.addAttribute("targetURL", "member_login_form");
//				
//				
//				return "success_forward";		
//			} 
//		}
//		// 패스워드가 member.getPasswd와 다를 때(비밀번호가 틀림)
//		model.addAttribute("msg", "비밀번호를 잘못 입력했습니다."
//				+ "입력하신 내용을 다시 확인해주세요." );
//		return "fail_back";
//		
//	}
//	
//
//	
//}
//
//
//
//
//
//
//
//
