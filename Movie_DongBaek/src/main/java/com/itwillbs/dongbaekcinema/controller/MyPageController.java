package com.itwillbs.dongbaekcinema.controller;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.dongbaekcinema.handler.MyPasswordEncoder;
import com.itwillbs.dongbaekcinema.service.*;
import com.itwillbs.dongbaekcinema.vo.*;
import com.itwillbs.dongbaekcinema.voNew.*;

import retrofit2.http.*;

@Controller
public class MyPageController {
	
	@Autowired
	private MypageService service;
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private PayService payService;
	
//	@Autowired
//	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MovieLikeService likeService;
	
	//  마이페이지 메인화면
	@GetMapping("myPage")
	public String myPage(HttpSession session, Model model) {
		
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
		
		// 세션 아이디로 현재등급과 다음 등급 조회(현등급,다음등급 정보)
		// myPageService - getGrade()
		// 파라미터 : String(member_id)		리턴타입 : GradeNextVO(myGrade)
		GradeNextVO myGrade = service.getMyGrade(member_id);
//		System.out.println(myGrade);
		
		// 세션 아이디로 예매내역 받아오기(최근 세개만)
		List<MyTicketVO> myTicketList = service.getMyTicket(member_id, 0, 2);
		
		// 세션 아이디로 회원 이름 받아오기
		MemberVO member = memberService.getMember(member_id);
		
		// 세션 아이디로 나의 문의 내역 받아오기
		List<CsVO> myInq = service.getMyInq(member_id);
		
		// 받아온 등급 정보와 예매내역 정보 저장
		model.addAttribute("myGrade", myGrade);				                         
		model.addAttribute("myTicketList", myTicketList);
		model.addAttribute("member", member);
		model.addAttribute("myInq", myInq);
		
		return "myPage/myPage";
	}
	
	// 마이페이지 -  예매내역 페이지로 이동
	@GetMapping("myPage_reservation_history")
	public String myPage_reservation_history(HttpSession session, Model model,
			// 페이징 처리
			@RequestParam(defaultValue = "1") int pageNo ) {
		// 세션아이디로 나의 예매/구매 내역 보여주기
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
		
		int listLimit = 5; // 한 페이지에 보여줄 게시물 수
		
		// 조회 시작 행(레코드) 번호 계산
		int startRow = (pageNo - 1) * listLimit;
		
		// 나의 예매내역 조회
		// MypageService - getMyTicket()
		// 파라미터 : member_id		리턴타입 : List<MyTicketVO>(myTicketList)
		List<MyTicketVO> myTicketList = service.getMyTicket(member_id, startRow, listLimit);
		
		List<MyTicketVO> myTicketListAll = service.getMyTicket(member_id, 0, 0);
		int listCount = myTicketListAll.size();
		
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 5;
		
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
		
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + listLimit -1; // 끝페이지
		
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
			endPage = maxPage;
		}
		
		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("pageInfo", pageInfo);
		
		// 받아온 예매내역 전달
		model.addAttribute("myTicketList", myTicketList);
		
		return "myPage/myPage_reservation_history";
	}
	
	// 마이페이지 -  구매내역 페이지로 이동
	@GetMapping("myPage_buy_history")
	public String myPage_buy_history(HttpSession session, Model model,
			// 페이징 처리
			@RequestParam(defaultValue = "1") int pageNo) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
		
		// 세션아이디로 나의 예매/구매 내역 보여주기
		// 구매내역 페이징 생각하기
		int pageNum = 3;
		
		// 한 페이지에 보여줄 게시물 수
		int listLimit = 5; 
		
		// 조회 시작 행(레코드) 번호 계산
		int startRow = (pageNo - 1) * listLimit;
		System.out.println("listLimit : " + listLimit + ", startRow : " + startRow);
		// 나의 구매내역 조회
		// MypageService - getMyPayment()
		// 파라미터 : member_id		리턴타입 : List<PaymentVO>(myPaymentList)
		List<BuyDetailVO> myPaymentList = paymentService.getMyPaymentList(member_id, startRow, listLimit);
		
		// 나의 예매내역 조회
		// MypageService - getMyTicket()
		// 파라미터 : member_id		리턴타입 : List<MyTicketVO>(myTicketList)
		
		List<BuyDetailVO> myPaymentListAll = paymentService.getMyPaymentList(member_id, 0, 0);
		int listCount = myPaymentListAll.size();
		
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 5;
		
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
		
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + listLimit -1; // 끝페이지
		
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
			endPage = maxPage;
		}
		
		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("pageInfo", pageInfo);
		
		//받아온 구매내역 전달
		model.addAttribute("myPaymentList", myPaymentList);
		
		return "myPage/myPage_buy_history";
	}
	
	// 마이페이지 - 구매내역 - 상세내역 조회
	@PostMapping("myPayment_detail")
	public String myPayment_detail(String payment_num, @RequestParam(required = false) String play_change, 
												HttpSession session, Model model) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
		
		// 상세내역 클릭 시 payment_num 을 받아와 조회해 보여주기
		// 파라미터 : int(payment_num)		리턴타입 : List<BuyDetailVO>(myPaymentDetailList)
//		System.out.println(payment_num);
		List<BuyDetailVO> myPaymentDetailList = paymentService.getMyPaymentDetail(payment_num);
//		System.out.println(myPaymentDetail);
		
		// 상세내역 클릭 시 payment_num으로 스낵, 영화 정보(갯수) 가져오기
		// 파라미터 : int(payment_num)		리턴타입 : BuyDetailVO(tickets)
		// 파라미터 : int(payment_num)		리턴타입 : BuyDetailVO(snacks)
		List<BuyDetailVO> myTicket = paymentService.getMyTickets(payment_num);
		List<BuyDetailSnackVO> mySnack = paymentService.getMySnacks(payment_num);
		
		//받아온 구매 상세내역 전달
		model.addAttribute("myPaymentDetailList", myPaymentDetailList);
		model.addAttribute("myTicket", myTicket);
		model.addAttribute("mySnack", mySnack);
		model.addAttribute("play_change", play_change);
		
		return "myPage/myPage_buy_history_detail";
	}
	
	
	// ============= 결제 취소 ================
	@PostMapping("payCancel")
	public ResponseEntity<String> orderCancle(BuyDetailVO buyDetail) throws Exception {
//		System.out.println(buyDetail);
		
		// ----------- api 작업 -----------------
		// 주문번호가 있으면 실행
		// payService - getToken() : 토큰 받아오기
		// payService - paymentInfo() : 결제번호와 토큰으로 결제된 금액 받아오기
		// payService - payMentCancle() : 결제 취소 기능 메서드 호출
	    if(!"".equals(buyDetail.getPayment_num())) {
	        String token = payService.getToken();
	        int amount = Integer.parseInt(payService.paymentInfo(buyDetail.getPayment_num(), token));
	        payService.payMentCancle(token, buyDetail.getPayment_num(), amount, buyDetail.getReason());
	    }
		
	    // ------------ DB 작업 -----------------
	    // PayService - orderCancle() 호출
	    // 결제 상태변경(PAYMENTS.payment_status), 티켓예약 상태변경, 스낵결제 상태변경
		payService.orderCancle(buyDetail);

		return ResponseEntity.ok().body("주문취소완료"); // <200 OK OK,주문취소완료,[]>
	}
	
	// 마이페이지 - 찜한 영화 목록으로 이동
	@GetMapping("myPage_like")
	public String myPageLike(HttpSession session, Model model,
			// 페이징 처리
			@RequestParam(defaultValue = "1") int pageNo) {
		
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		// 세션 아이디로 찜한 영화 목록 들고오기
		// 찜한 영화 있을 경우 찜하기 표시하기(비회원이 아닐 때)
		String member_type = (String) session.getAttribute("member_type");
		String member_id = (String) session.getAttribute("member_id");
		System.out.println(member_type);
		System.out.println(member_id);
		if (member_id == null || (member_type != null && member_type.equals("비회원"))) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
			return "fail_location";
		}
		
		// 세션아이디로 나의 예매/구매 내역 보여주기
		// 구매내역 페이징 생각하기
		int pageNum = 5;
		// 한 페이지에 보여줄 게시물 수
		int listLimit = 6; 
		// 조회 시작 행(레코드) 번호 계산
		int startRow = (pageNo - 1) * listLimit;

		// 찜한 영화 목록 - 페이징
		// LikeService - getLikeMovie()
		// 파라미터 : member_id		리턴타입 : List<LikeVO>(likeList)
		List<MovieLikeVO> likeList = likeService.getLikeMovieList(member_id, startRow, listLimit); 
//		System.out.println(likeList);
		
		// 나의 예매
		List<MyTicketVO> myTicketList = service.getMyTicket(member_id, startRow, listLimit);
		// 페이징처리, 찜한 영화 총 갯수
		int likeListCount = likeService.getLikeMovieCount(member_id); 


		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 5;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = likeListCount / listLimit + (likeListCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + listLimit -1; // 끝페이지
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
			endPage = maxPage;
		}

		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(likeListCount, pageListLimit, maxPage, startPage, endPage);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("likeList", likeList);
//			if(likeList != null) {
//	//		 모델에 저장 (-> 메인, 영화목록, 영화디테일)
//	//		 세션x : 찜하기 목록이 업데이트 될때마다 달라지므로 페이지마다 조회해서 파라미터로 받을 예정
//			}
//		
		model.addAttribute("likeListCount", likeListCount);
		
		
		return "myPage/myPage_like";
	}
	
	// 마이페이지 - 나의 리뷰 페이지로 이동
	@GetMapping("myPage_myReview")
    public String myPage_myReview(
    		HttpSession session,
    		Model model,
    		@RequestParam(defaultValue = "1") int pageNo) {
        // 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
        String member_id = (String) session.getAttribute("member_id");
        if(member_id == null) {
            model.addAttribute("msg", " 로그인이 필요합니다!");
            model.addAttribute("targetURL", "member_login_form");

            return "fail_location";
        }

        // 세션 아이디로 리뷰 보여주기
        // 페이징
        int pageNum = 5;
        
        // 한 페이지 게시물 수
        int listLimit = 5;
        
        // 조회 시작 레코드 번호 계산
        int startRow = (pageNo - 1) * listLimit;
        
        // 나의 리뷰 조회
        // MypageService - getMyReview()
        // 파라미터 : member_id(세션저장)    리턴타입 : List<ReviewVO> myReviewList
        List<MyReviewVO> myReviewList = service.getMyReviewList(member_id,startRow, listLimit);
        System.out.println(myReviewList);
        System.out.println(); 
        
        // 나의 예매 내역 가져오기
//        List<MyTicketVO> myTicketList = service.getMyTicket(member_id, startRow, listLimit);
        
        // 나의 리뷰 전체
        List<MyReviewVO> myReviewListAll = service.getMyReviewList(member_id, 0, 0);
        int listCount = myReviewListAll.size();
        
        // 2. 한 페이지에서 표시할 목록 개수 설정(페이지 번호의 개수)
        int pageListLimit = 5;
        
        // 3. 전체 페이지 목록 개수 계산
        int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
        
        // 4. 시작 페이지 번호 계산
        int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
        
        // 5.끝 페이지 번호 계산
        int endPage = startPage + listLimit -1; 
        
        // 끝페이지 번호가 전체 페이지보다 클 경우 끝 페이지 번호를 최대 페이지로 설정
        if(endPage > maxPage) {
        	endPage = maxPage;
        }
        
        // 페이징 정보 저장
        PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
        model.addAttribute("pageInfo", pageInfo);
        
        // 받아온 리뷰내역 전달
        model.addAttribute("myReviewList", myReviewList);

        return "myPage/myPage_myReview";
    }
	
	// 각각의 영화에 대해 회원이 작성한 리뷰 가져오기
	@ResponseBody
	@PostMapping("GetReivew")
	public List<MyReviewVO> getReview(@RequestParam String member_id, @RequestParam int movie_num) {
		System.out.println(movie_num);
		
		List<MyReviewVO> myReview = service.getMyReview(member_id, movie_num);
		System.out.println("각각의 리뷰 가져오기" + myReview);
		return myReview;
	}

    // 마이페이지 - 나의 리뷰 글쓰기 페이지로 이동
//    @GetMapping("review_write")
	@RequestMapping(value = "review_write", method = {RequestMethod.GET, RequestMethod.POST})
    public String myPage_reviewWrite(HttpSession session, Model model 
						    		,@RequestParam String movie_num) {
		 // 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
        String member_id = (String) session.getAttribute("member_id");
        if(member_id == null) {
            model.addAttribute("msg", " 로그인이 필요합니다!");
            model.addAttribute("targetURL", "member_login_form");

        }
        
       System.out.println(movie_num);

       MyReviewVO myReview = service.getMovieName(movie_num);
        
        model.addAttribute("myReview", myReview);
        model.addAttribute("movie_num", movie_num);
        
        return "myPage/myPage_myReview_form";
    }
	
	
	// 나의 리뷰 글쓰기
	@PostMapping("review_write_pro")
	public String review_write_pro(MyReviewVO myReview
							, HttpSession session
							, Model model
							) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
				model.addAttribute("msg", " 로그인이 필요합니다!");
				model.addAttribute("targetURL", "member_login_form");
						
			return "fail_location";
		}
		
		System.out.println(myReview);
		
//		int insertReviewCount = service.registReview(myReview, member_id);
		myReview.setMember_id(member_id);
		int insertReviewCount = service.registReview(myReview);
		
		
		if(insertReviewCount > 0) {
			return "redirect:/myPage_myReview";
		} else {
			model.addAttribute("msg", "글쓰기 실패!");
			return "fail_back";
		}
	}
	
	
	// 마이페이지 - 영화 네컷 페이지로 이동
//	@GetMapping("myPage_moviefourcut")
//	public String myPage_moviefourcut() {
//		return "myPage/myPage_moviefourcut";
//	}
	
	// 마이페이지 - 문의 내역 페이지로 이동
	@GetMapping("myPage_inquiry")
	public String myPage_inquiry(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNo) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
				
			return "fail_location";
		}
			
		// 페이징
		int pageNum = 5;
			
		// 한 페이지에 보여줄 게시물 수
		int listLimit = 5;
			
		int startRow = (pageNo - 1) * listLimit;
			
			
		// 세션에 저장된 아이디로 문의내역 조회
		// myPageService - getMyInq(member_id)
		// 파라미터(member_id)		리턴타입(CsVO)
		List<CsInfoVO> myInqList = service.getMyInqList(member_id, startRow, listLimit);
		System.out.println(myInqList);
			
		List<CsInfoVO> myInqListAll = service.getMyInqList(member_id, 0, 0);
		int listCount = myInqListAll.size();
			
		// 한 페이지에서 표시할 목록 개수 설정(페이지 번호의 개수)
		int pageListLimit = 5;
			
		// 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
					
		// 시작 페이지 번호 계산
		int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
					
		// 끝 페이지 번호 계산
		int endPage = startPage + listLimit -1; // 끝페이지
					
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
				endPage = maxPage;
		}
			
		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
			
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("myInqList", myInqList);
		
		return "myPage/myPage_inquiry";
	}
		

	// 마이페이지 - 문의 내역 - 상세 조회
	@PostMapping("inquiry_detail")
	public String inquiry_detail(String cs_num, @RequestParam(required= false) String cs_reply,
						HttpSession session, Model model) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
					
			return "fail_location";
		}
		
		// cs_num 받아와 조회해서 보여주기
		List<CsInfoVO> myInquiryDetailList = service.getMyInquiryDetail(cs_num);
//		List<CsInfoVO> myInquiryDetailList = service.getMyInquiryDetail(cs_num);
		
		// 문의 내역 저장
		model.addAttribute("myInquiryDetailList", myInquiryDetailList);
		model.addAttribute("cs_reply", cs_reply);
		
		return "myPage/myPage_inquiry_detail";
	}
	
	// 마이페이지 - 문의 내역 - 수정
	@PostMapping("myPage_inquiry_detailModify")
	public String myPage_inquiry_detailModify(
					@ModelAttribute("CsVO") CsVO board
					, @RequestParam("cs_num") String cs_num
					, HttpSession session
					, Model model
					, HttpServletRequest request) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
							
			return "fail_location";
		}
		
		// ======================================== 파일 처리 ========================================
				// 이클립스 프로젝트 상 업로드 폴더의 실제 경로 알아내기(request나 session 객체필요)
				String uploadDir = "/resources/upload";	// 현재 폴더상 경로
				String saveDir = request.getServletContext().getRealPath(uploadDir);  // 실제 경로
//				System.out.println(saveDir);
				// (지영) - 서버상 경로 알아두기
				
				String subDir = ""; // 서브디렉토리(업로드 날짜에 따라 디렉토리 구분하기)
				
				try {
					Date date = new Date();	// 1. Date 객체 생성
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");	// 날짜 형식 포맷 지정(/로 디렉토리 구분)
					// 실제 업로드 경로에 날짜 경로 결합
					subDir = sdf.format(date);	// 날짜 디렉토리
					saveDir += "/" + subDir;					// 실제 경로 + 날짜 경로
					
					// 실제 경로를 관리하는 객체 리턴받기(파라미터 : 
					Path path = Paths.get(saveDir);
					
					// path 객체로 관리하는 경로 생성
					Files.createDirectories(path);	// try-catch 필수
				} catch (IOException e) {
					System.out.println("e 이거 오류 : ");
					e.printStackTrace();
				}
				
				// 파라미터로 받은 CsVO board 에서 전달된 MultipartFile 객체 꺼내기
				MultipartFile mFile = board.getCs_file();
//				System.out.println("원본파일명1 : " + mFile.getOriginalFilename());
				
				// 파일명 중복 방지 처리 - 랜덤ID(8글자) 붙이기 (ex.랜덤ID_파일명.확장자)
				String uuid = UUID.randomUUID().toString().substring(0, 8);
				
				// 파일명이 없을 때를 대비하여 기본 파일명 "" 처리
				board.setCs_file_real(""); 	
				
				// 파일명을 저장할 변수 선언
				String fileName = uuid + "_" + mFile.getOriginalFilename();
				
				if(!mFile.getOriginalFilename().equals("")) {	// 파일이 있을 경우
					// 실제 이름을 (날짜디렉토리/uuid_실제받은파일명.확장자) 로 저장
					board.setCs_file_real(subDir + "/" + fileName);
				}
//				System.out.println("실제 업로드 파일명1 : " + board.getCs_file_real());
				
				// ======================================== 파일 처리 끝 ========================================
		
		// Service - updateMyInqList() 메서드를 호출하여 게시물 등록 작업 요청
		// => 파라미터 : cs_num, CsInfoVO    리턴타입 : int(insertCount)
//		int updateCount = service.updateMyInqList(cs_num, csInfo);
		int updateCount = service.updateMyInqList(board);
		
//		System.out.println(cs_num);
		
		// 게시물 등록 작업 요청 결과 판별
		if(updateCount > 0) { // 성공
			try {
				// 이동할 위치의 파일명도 UUID 가 결합된 파일명을 지정해야한다!
				if(!mFile.getOriginalFilename().equals("")) {
					mFile.transferTo(new File(saveDir, fileName));
				}

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return "redirect:/myPage_inquiry";
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "fail_back";
		}
		
	}
	
	// 마이 페이지 - 문의 내역 - 삭제
	@GetMapping("delete_myInquiry")
	public String deleteMyInquiry(HttpSession session
								, Model model
								, @RequestParam("cs_num") String cs_num) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
					
			return "fail_location";
		}
		
		int deleteCount = service.deleteMyInquiry(cs_num);
		
		if(deleteCount > 0) { // 삭제 성공
			return "redirect:/myPage_inquiry";
		} else {
			model.addAttribute("msg", "글 삭제 실패!");
			return "fail_back";
		}
		
	}
	
	// 마이페이지 - 나의 등급 페이지로 이동
	@GetMapping("myPage_grade")
	public String myPage_grade(HttpSession session, Model model) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
		
		// 세션 아이디로 현재등급과 다음 등급 조회(현등급,다음등급 정보)
		// myPageService - getGrade()
		// 파라미터 : String(member_id)		리턴타입 : GradeNextVO(myGrade)
		GradeNextVO myGrade = service.getMyGrade(member_id);
//		System.out.println(myGrade);
		
		// 다음 등급까지 얼마 남았는지 비교하기 위한 결제금액 조회
		// paymentService - getYearPayment()
		// 파라미터 : String(member_id)		리턴타입 : int(payment_total_price)
		int payment_total_price = paymentService.getYearPayment(member_id);
//		System.out.println(payment_total_price);
		
		model.addAttribute("myGrade", myGrade);
		model.addAttribute("payment_total_price", payment_total_price);
		
		return "myPage/myPage_grade";
	}
	
	// 마이페이지 - 개인정보 수정 비밀번호 확인 페이지로 이동 -> pro 생성 해서 처리하
	// 로그인 한 상태와 로그인하지 않은 상태를 구분해서 페이지이동
	// => 로그인 한 상태 : modify_check.jsp 화면으로 이동
	// => 비로그인 상태 : 로그인해야한다는 메세지를 띄우고, 로그인 화면으로 이동
	@GetMapping("myPage_modify_check")
	public String myPage_modify_check(HttpSession session, Model model) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
					
			return "fail_location";
		}		
		return "myPage/myPage_modify_check";
	}
	
	@PostMapping("myPage_modify_check_pro")
	public String myPage_modify_check_pro(@RequestParam String member_pass_check, MemberVO member, Model model, HttpSession session) {
		String member_id = (String)session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("url", "member_login_form");
					
			return "fail_location";
		}
		
		System.out.println("member_pass_check : " + member_pass_check);
//		
		String securePasswd = service.getPasswd(member_id);
	
		// 2. BcryptPasswordEncoder 객체 생성
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		System.out.println("securePasswd : " + securePasswd);

//		 if (member.getMember_pass() ==  null || !passwordEncoder.matches(member.getMember_pass(), securePasswd)) {
		 if (!passwordEncoder.matches(member_pass_check, securePasswd)) {
				// 패스워드가 member.getPasswd와 다를 때(비밀번호가 틀림)
				model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. "
						+ "입력하신 내용을 다시 확인해주세요.");
				return "fail_back";
		 } 
		 return "redirect:/myPage_modify_member";
	}
	

	// 마이페이지 - 개인정보 수정 폼페이지로 이동
	@GetMapping("myPage_modify_member")
	public String myPage_modify_member(MemberVO member, Model model, HttpSession session) {
		// 세션아이디로 개인정보 내역 보여주기
		String member_id = (String) session.getAttribute("member_id");
		
		// 나의 개인정보 조회
		// MypageService - getMyInfo()
		// 파라미터 : member_id		리턴타입 : List<MemberVO>(myInfoList)
		List<MemberVO> myInfoList = service.getMyInfo(member_id);
		System.out.println(myInfoList);

		//받아온 개인정보 전달
		model.addAttribute("myInfoList", myInfoList);
		
		return "myPage/myPage_modify_member";
	}
	
	// 마이페이지 - 개인정보 수정 
	@PostMapping("myPage_modify_member_pro")
//	@RequestMapping(value = "myPage_modify_member_pro", method= {RequestMethod.GET, RequestMethod.POST})
	public String myPage_modify_member_pro(MemberVO member,
										   Model model,
										   HttpSession session,
										   @RequestParam String member_pass,
										   @RequestParam String member_email,
										   @RequestParam String member_like_genre) {
		// 세션 아이디로 개인정보 내역 보여주기
		System.out.println("member_pass : " + member_pass);
		System.out.println("member_email : " + member_email);
		String member_id = (String)session.getAttribute("member_id");
		
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		
		// 나의 개인정보 업데이트 
		// MypageService - updateMyInfo()
		// 파라미터 : member_id	리턴타입 : int 
		int updateCount = service.updateMyInfo(
								member, 
								passwordEncoder.encode(member_pass),
								member_email,
								member_id,
								member_like_genre
								);
		
		System.out.println(updateCount);
		
		if(updateCount > 0 ) {
			model.addAttribute("msg", "개인정보 수정이 성공했습니다.");
//			model.addAttribute("url", "myPage/myPage_modify_member");
			
//			return "success_back";		
			
			return "redirect:/myPage_modify_member";
			
		} else {
		
		model.addAttribute("msg", "개인정보 수정이 실패했습니다.");
//		model.addAttribute("url", "member_login_form");
		
		return "fail_back";
		}
		
	}
	
	// 회원 탈퇴 확인
	// DB 에 저장된 비밀번호와 일치 여부 확인 시
	// 일치한다면 회원상태 '탈퇴'로 변경 
	// 회원 상태 가 탈퇴라면 로그인 불가능 하다록 로그인 페이지 수정 필요
	@GetMapping("MemberWithdrawalForm")
	public String member_withdrawal_form(HttpSession session, Model model, MemberVO member) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "./");
							
			return "fail_location";
		}
		return "myPage/myPage_withdrawal_check";
	}
	
	// 회원 탈퇴 로직
	@PostMapping("MemberWithdrawal")
	public String member_withdrawal_pro(HttpSession session, Model model, MemberVO member, String withdrawalPasswd) {
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login_form");
							
			return "fail_location";
		}
		
		String securePasswd = memberService.getPasswd(member);
		System.out.println(securePasswd);
		System.out.println(withdrawalPasswd);
	
		// 2. BcryptPasswordEncoder 객체 생성
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
		System.out.println("securePasswd : " + securePasswd);
	
		if (passwordEncoder.matches(withdrawalPasswd, securePasswd)) {
			// 회원상태 = 탈퇴로 변경
			int withdrawalCount = service.memberwithdrawal(member_id);
			
			if(withdrawalCount > 0 ) {
				// 세션무효화 필요
				session.invalidate();

				model.addAttribute("msg", "동백시네마를 이용해주셔서 감사합니다. 탈퇴처리 되었습니다.");
				model.addAttribute("targetURL", "member_login_form");
				
				
				return "success_forward";		
			} 
		}
		// 패스워드가 member.getPasswd와 다를 때(비밀번호가 틀림)
		model.addAttribute("msg", "비밀번호를 잘못 입력했습니다."
				+ "입력하신 내용을 다시 확인해주세요." );
		return "fail_back";
		
	}
	

	
}












