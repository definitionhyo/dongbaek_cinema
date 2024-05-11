//package com.itwillbs.dongbaekcinema.controller;
//
//
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.List;
//
//import javax.servlet.http.HttpSession;
//
//import org.json.JSONArray;
//import org.json.JSONException;
//import org.json.JSONObject;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.propertyeditors.CustomDateEditor;
//import org.springframework.format.annotation.DateTimeFormat;
//import org.springframework.http.MediaType;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.WebDataBinder;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.InitBinder;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.itwillbs.dongbaekcinema.service.AdminService;
//import com.itwillbs.dongbaekcinema.service.MemberService;
//import com.itwillbs.dongbaekcinema.service.MovieService;
//import com.itwillbs.dongbaekcinema.service.PaymentService;
//import com.itwillbs.dongbaekcinema.vo.MemberVO;
//import com.itwillbs.dongbaekcinema.vo.MovieVO;
//import com.itwillbs.dongbaekcinema.vo.PaymentVO;
//import com.itwillbs.dongbaekcinema.voNew.CsInfoVO;
//import com.itwillbs.dongbaekcinema.voNew.PageInfoVO;
//import com.itwillbs.dongbaekcinema.voNew.PlayScheduleVO;
//
//
//
//
//@Controller
//public class AdminController_backup {
//	
//	// 0608 정의효 - 데이터랑 없는상태에서는 오류떠서 주석처리 다해놓음
//	// 멤버 관련 회원가입, 조회를 위한 MemberService @Autowired 
//	@Autowired
//	private MemberService member_service;
//	
//	@Autowired
//	private AdminService admin_service;
//
//
//	
//
//
//	// 0609 정의효
//	// 결제 관련 조회를 위한 PaymentService @Autowired
//	@Autowired
//	private PaymentService payment_service;
//	
//	@Autowired
//	private MovieService movie_service;
//	
//	// 관리자페이지 메인
//	@GetMapping("admin_main")
//	public String adminMain(HttpSession session, Model model) {
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }
//		
//		
//		return "admin/admin_main";
//	}
//	
//	// 관리자페이지 회원관리
////	@GetMapping("admin_")
////	public String adminMemeberListHttpSession session, Model model() {
//	
////	// 직원 세션이 아닐 경우 잘못된 접근 처리
////	String member_type = (String)session.getAttribute("member_type");
////	System.out.println(member_type);
////	if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////        model.addAttribute("msg", "잘못된 접근입니다!");
////        return "fail_back";
////    }
//	
//	
////		return "admin/admin_";
////	}
//	
//	// 관리자페이지 상영스케줄 관리
//	@GetMapping("admin_schedule_list")
//	public String adminScheduleList(HttpSession session, @RequestParam(defaultValue = "1") int pageNo, Model model) {
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////	
////	        model.addAttribute("msg", "잘못된 접근입니다!");
////	        return "fail_back";
////	    }
//		
//		
//		// 상영스케줄 관리 사이드 버튼 클릭시 영화관 목록 조회 후 셀렉트박스 생성 
//		List<HashMap<String, String>> theaterInfo = admin_service.getTheater();
////		System.out.println(theaterInfo);		
//				
//		model.addAttribute("theaterInfo",theaterInfo);
//		
//		
//		return "admin/admin_schedule_list";
//	}
//	
////    // 관리자페이지 상영스케줄 상단 확인 버튼 클릭시 상영스케줄 목록 조회- json
////	@ResponseBody
////	@RequestMapping(value = "showSchedual", method = {RequestMethod.POST, RequestMethod.GET}, produces = "application/json;charset=utf-8")
////	public List<PlayScheduleVO> findSchedule(HttpSession session, @RequestParam String theater_num, @RequestParam String play_date, @RequestParam(defaultValue = "1") int pageNo, Model model) throws Exception {
//////		System.out.println(theater_num + ", " + play_date + ", " + pageNo);
////
////		
//////		// 직원 세션이 아닐 경우 잘못된 접근 처리
//////		String member_type = (String)session.getAttribute("member_type");
//////		System.out.println(member_type);
//////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
//////
//////            model.addAttribute("msg", "잘못된 접근입니다!");
//////            return "fail_back";
//////        }
////		
////
////		
////		// 상단 셀렉트박스에서 영화관, 상영날짜 선택 후 버튼 클릭시 스케줄 목록 조회
////
////		List<PlayScheduleVO> playList = admin_service.showSchedual(theater_num, play_date, pageNo);
////
//////		System.out.println(playList);
////		
////		model.addAttribute("playList", playList);
////		
////		return playList;
////	}
//
//	
//	// 상단 생성 버튼 클릭 시 해당 영화관의 스케줄 목록 가져옴
//	@ResponseBody
//    @GetMapping(value = "showSchedual", produces = MediaType.APPLICATION_JSON_VALUE)
//    public String getSchedule(HttpSession session, @RequestParam String theater_num, @RequestParam String play_date, @RequestParam(defaultValue = "1") int pageNo, Model model) throws Exception {
//        // 상영 스케줄 정보 가져오기
//        List<PlayScheduleVO> scheduleList = admin_service.showSchedual(theater_num, play_date, pageNo);
//        
//        // 영화관 번호로 해당 상영관 번호와 이름 가져오기
//        List<PlayScheduleVO> roomList = admin_service.getRoomInfo(theater_num);
//        
//        System.out.println("1차 스케줄 생성 : " + scheduleList);
//
//        JSONArray jsonArray = null;
//        
//        try {
//			jsonArray = new JSONArray(); // JSONArray 객체 생성
//				
//			JSONObject jsonObject = new JSONObject(); // JSONObject 객체 생성
//			jsonObject.put("scheduleList", scheduleList);
//			jsonObject.put("roomList", roomList);
//			
//			jsonArray.put(jsonObject);
//		} catch (JSONException e) {
//
//			e.printStackTrace();
//		}
//        
//        
//        return jsonArray.toString();
//    }
//	
//
//	
//	
//	
//	// 관리자페이지 상영스케줄 상단 확인 버튼 클릭시 현재 상영중인 영화 목록 조회- json 
//	@ResponseBody
//	@RequestMapping(value = "findMovieList", method = {RequestMethod.POST, RequestMethod.GET}, produces = "application/json;charset=utf-8")
//	public List<MovieVO> findMovieList(HttpSession session, @RequestParam String play_date, @RequestParam(defaultValue = "1") int pageNo, Model model) throws Exception {
////		System.out.println("findMovieList : " + play_date);
//		
//		// 테이블 셀렉트박스에서 상영날짜별 선택가능한 영화 목록 조회
//		List<MovieVO> movieList = admin_service.findMovieList(play_date);
//		
//		
////		System.out.println(movieList);
//		
//		model.addAttribute("movieList",movieList);
//		
//		return movieList;
//	}
//	
//	
//	
//	// 상영스케줄 우측 생성 버튼 클릭시 상영스케줄 등록 창 이동
//	@ResponseBody
//	@RequestMapping(value = "createUpdateSchedule", method = {RequestMethod.POST, RequestMethod.GET})
//	public String createSchedule1(HttpSession session, @RequestParam String play_date, @RequestParam int theater_num, @RequestParam int row_num, @RequestParam int movie_num, Model model) {
//		System.out.println("createUpdateSchedule 전송정보 확인 play_date:" + play_date + ", theater_num:" + theater_num + ", row_num:" + row_num +", movie_num:" + movie_num);
//		JSONArray jsonArray = null; // JSON 배열변수 선언
//		
//		// 특정 상영날짜 영화관의 상영관에 상영스케줄 정보가 등록되어있는지 확인
//		int turnCount = admin_service.checkSchedule(play_date, theater_num, row_num);
////		System.out.println("상영정보 존재(건):" + turnCount);
//
//	        
//        try {
//			jsonArray = new JSONArray(); // JSONArray 객체 생성
//			JSONObject jsonObject = new JSONObject(); // JSONObject 객체 생성
//			
//			
//			if(turnCount > 0 ) { // 상영스케줄이 이미 생성되어 있는 경우(기존 정보 삭제 후 재생성)
//				System.out.println("상영스케줄 이미 존재함");
//			
////				// 상영스케줄 정보 삭제 수행
//				int deleteTurnCount = admin_service.deleteSchedule(play_date, theater_num, row_num);
////				
////				
//				if(deleteTurnCount == 0) { // 상영스케줄이 다른 테이블에서 참조하는경우 삭제 실패(ex.예매가 진행되고있는 경우)
//					jsonObject.put("result", "상영 정보가 이미 예매되었으므로 삭제가 불가능합니다");
//					
//				} else { // 상영 스케줄 등록
//					
//					int insertTurnCount  = admin_service.insertSchedule(play_date,theater_num,row_num, movie_num);
//					
//					
//					if(insertTurnCount == 0) {
//						System.out.println("상영 스케줄 등록을 시도했으나 실패");
//						jsonObject.put("result", "등록을 시도했으나 실패하였습니다");
//					} else {
//						System.out.println("상영등록 성공");
//						jsonObject.put("result", "상영정보가 등록되었습니다 확인 버튼을 다시 눌러주세요");
//					}
//				}
////				
//			} else { // 상영 스케줄이 없는 경우(insert 실행)
//				System.out.println("상영스케줄 없음");
//				
////				// 상영 스케줄 등록 날짜가 오늘보다 미래여야함!
//				int insertTurnCount  = admin_service.insertSchedule(play_date,theater_num,row_num, movie_num);
//			
//				if(insertTurnCount == 0) {
//					System.out.println("상영등록 날짜가 오늘과 같거나 과거이므로 등록실패");
//					jsonObject.put("result", "등록을 시도했으나 실패하였습니다");
//				} else {
//					System.out.println("상영등록 성공");
//					jsonObject.put("result", "상영정보가 등록되었습니다 확인 버튼을 다시 눌러주세요");
//				}
//			}
//			
//	
//			
////				jsonObject.put("roomList", roomList);
//			
//			jsonArray.put(jsonObject);
//		} catch (JSONException e) {
//
//			e.printStackTrace();
//		}
//			
//
//
//
//		return jsonArray.toString();
//	}
//	
//	
//	
//	
//	
//	// 관리자페이지 결제관리
////	@GetMapping("")
////	public String adminPayment(HttpSession session, Model model) {
//
//	
////	// 직원 세션이 아닐 경우 잘못된 접근 처리
////	String member_type = (String)session.getAttribute("member_type");
////	System.out.println(member_type);
////	if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////        model.addAttribute("msg", "잘못된 접근입니다!");
////        return "fail_back";
////    }	
//	
//	//		return "admin/admin_";
////	}	
//
//	// 관리자페이지 공지사항관리 목록 출력
//	@GetMapping("admin_cs_notice")
//	public String adminCsNotice(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNo) {
////		System.out.println("pageNO : " + pageNo);
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }
//		
//		
//		// --------------------------페이징 작업 ----------------------------------
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 1;
//
//		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
//		int startRow = (pageNo - 1) * listLimit; // 조회 시작 행(레코드) 번호
//		
//		
//		int startPage = ((pageNo - 1) / listLimit) * listLimit + 1; // 시작할 페이지
////		System.out.println("startPage: " + startPage);
//		int endPage = startPage + listLimit -1; // 끝페이지
//		int listCount = admin_service.getCsTotalPageCount(listLimit, csTypeNo);
//		
//		// 3. 전체 페이지 목록 갯수 계산
//		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
//		
//		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
//		if(endPage > maxPage) { 
//			endPage = maxPage;
//		}
////		System.out.println("어드민 컨트롤러 공지사항 스타트페이지" + startPage +", 엔드 페이지:"+ endPage);
//		// --------------------------------------------------------------------------
//		
//		// 공지사항 목록 조회
//		List<CsInfoVO> CsNoticeList = admin_service.getCsList(pageNo, listLimit, startRow, csTypeNo);
//		
//		// 페이징 정보 저장
//		PageInfoVO pageInfo = new PageInfoVO(listCount, listLimit, maxPage, startPage, endPage);
//		
////		System.out.println("CsNoticeList : " + CsNoticeList);
////		System.out.println("pageInfo : " + pageInfo);
//			model.addAttribute("CsNoticeList", CsNoticeList);
//			model.addAttribute("pageNo", pageNo);
//			model.addAttribute("pageInfo", pageInfo);
//			
//	
//		return "admin/admin_cs_notice_list";
//	}
//	
//	// 관리자페이지 공지사항 글쓰기 폼 이동
//	@GetMapping("admin_cs_notice_form")
//	public String adminCsNoticeForm(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNo) {
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////      }
//		
//		model.addAttribute("pageNo", pageNo);
//		
//		return "admin/admin_cs_notice_form";
//	}
//	
//	// 관리자페이지 공지사항 글쓰기 등록 후 게시판 이동
//	// fileUploadPost
//	@PostMapping("admin_cs_notice_pro")
//	public String adminCsNoticePro(HttpSession session, Model model, @RequestParam( defaultValue = "1", name = "pageNo") int pageNo, @ModelAttribute("noticeInfo") CsInfoVO noticeInfo,  @RequestParam(required = false, value = "cs_multi_file" ) MultipartFile files) {
//		System.out.println("notice_form pageNo: " + pageNo + ", noticeInfo: " + noticeInfo + ", files: " + files);
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }
//
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 1;
//		
//		
//		
//	
//		// 공지사항 글쓰기 등록을 위한 함수 호출
//		int insertCount = admin_service.registCs(csTypeNo, noticeInfo, files);
//
//		if(insertCount > 0) { //글쓰기 성공
//			
//			return "redirect:/admin_cs_notice"; // 공지사항으로 리다이렉트
//		} else { // 글쓰기 실패
//			model.addAttribute("msg", "등록이 실패했습니다!");
//			
//			return "fail_back"; // 실패 창 띄우기
//		}
//
//		
//
//	}
//	
//	
//	
//	// 관리자페이지 공지사항 글수정 폼
//	// 이전 등록된 정보 가져오기
//	@GetMapping("admin_cs_notice_modify_form")
//	public String adminCsNoticeModifyForm(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNo, @RequestParam int cs_type_list_num) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }
//		
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 1;
//		
//		
//		// 1:1 질문 정보 가져오기
//		// 파라미터값 : cs_type_list_num
//		CsInfoVO notice = admin_service.getCsInfo(csTypeNo, cs_type_list_num);
////		System.out.println("어드민컨트롤러 csQna" + csQna );
//		
//		// 페이지번호와 
//		model.addAttribute("pageNo", pageNo);
//		model.addAttribute("notice", notice);
//		
//		
//		
//		return "admin/admin_cs_notice_modify_form";
//	}
//	
//	// 관리자페이지 글쓰기 수정 작업 후 게시판 이동
//	@PostMapping("admin_cs_notice_modify_pro")
//	public String adminCsNoticeModifyPro(HttpSession session, Model model, @RequestParam(defaultValue = "1")int pageNo, @ModelAttribute("noticeInfo") CsInfoVO noticeInfo,  @RequestParam(required = false, value = "cs_multi_file" ) MultipartFile files) {
//		
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }
//		
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 1;
//		
//		// 공지사항 글정보 변경
//		int updateCount = admin_service.updateCs(csTypeNo, noticeInfo, files);
//		
//		
//		if(updateCount > 0 ) { // 답변 등록 성공 시
//			// 페이지 정보 저장
//			model.addAttribute("pageNo", pageNo);
//			// 공지사항 게시판으로 이동
//			return "redirect:/admin_cs_notice_list";
//		} else {
//			System.out.println("notice - update 실패!");
//			model.addAttribute("msg", "답변 등록이 실패하였습니다!");
//			return "fail_back"; // 실패 시 이동할 페이지
//		}
//		
//		
//	}
//	
//	
//	// 관리자 페이지 글 삭제(파라미터 csType=1일때 공지사항 삭제, csType=3일때 1:1질문 삭제)
//	@GetMapping("delete_cs")
//	public String deleteCs(HttpSession session, Model model, @RequestParam(defaultValue = "1")int pageNo, @RequestParam("csType") int csType, @RequestParam("cs_type_list_num") int cs_type_list_num) {
//		System.out.println("delete_cs, csType:" + csType + ", cs_type_list_num:" + cs_type_list_num);
//		
//		int deleteCount = admin_service.deleteCs(csType, cs_type_list_num);
//		
//		// 글삭제 작업 후 리턴할 페이지
//		if(deleteCount != 0 && csType == 1) { // 삭제 성공 시 공지사항 목록으로 리턴
//			
//			return "redirect:/admin_cs_notice";
//		} else if(deleteCount != 0 && csType == 3) { // 삭제 성공 시 자주묻는 질문 목록으로 리턴
//			
//			return "redirect:/admin_cs_faq";
//		} else {
//			
//			model.addAttribute("msg", "글 삭제 실패!");
//			return "fail_back";
//		}
//		
//	}
//	
//	// 관리자페이지 1:1 질문관리 게시판 목록
//	@GetMapping("admin_cs_qna")
//	public String adminCsQna(HttpSession session, Model model, @RequestParam(defaultValue = "1", name = "pageNo") int pageNo) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		
//		
//		// --------------------------페이징 작업 ----------------------------------
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 2;
//
//		int listLimit = 5;// 한 페이지에 보여줄 목록 수
//		
//		// 조회 시작 행(레코드) 번호 계산
//		int startRow = (pageNo - 1) * listLimit;
//		
//		int startPage = ((pageNo - 1) / listLimit) * listLimit + 1; // 시작할 페이지
////		System.out.println("startPage: " + startPage);
//		int endPage = startPage + listLimit -1; // 끝페이지
//		int listCount = admin_service.getCsTotalPageCount(listLimit, csTypeNo);
//		
//		// 3. 전체 페이지 목록 갯수 계산
//		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		
//		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
//		if(endPage > maxPage) { 
//			endPage = maxPage;
//		}
////		System.out.println("어드민 컨트롤러 공지사항 스타트페이지" + startPage +", 엔드 페이지:"+ endPage);
//		// --------------------------------------------------------------------------
//		
//		// 1:1 게시판 목록 조회
//		List<CsInfoVO> CsQnaList = admin_service.getCsList(pageNo, listLimit, startRow, csTypeNo);
//		
//		// 페이징 정보 저장
//		PageInfoVO pageInfo = new PageInfoVO(listLimit, listLimit, maxPage, startPage, endPage);
//		
////		System.out.println("CsQnaList : " + CsQnaList);
////		System.out.println("pageInfo : " + pageInfo);
//		
//		// 글목록, 페이징 정보 저장
//		model.addAttribute("CsQnaList", CsQnaList);
//		model.addAttribute("pageNo", pageNo);
//		model.addAttribute("pageInfo", pageInfo);
//		
//		
//		
//		return "admin/admin_cs_qna_list";
//	}
//	
//	// 관리자페이지 1:1 질문 답글 폼 이동
//	@GetMapping("admin_cs_qna_reply")
//	public String adminCsQnaReply(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNo ,@RequestParam int cs_type_list_num) {
////		System.out.println("adminCsQnaReply pageNo:" + pageNo + ",cs_type_list_num:" + cs_type_list_num );
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }	
//		
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 2;
//		
//		
//		// 1:1 질문 정보 가져오기
//		// 파라미터값 : cs_type_list_num
//		CsInfoVO csQna = admin_service.getCsInfo(csTypeNo, cs_type_list_num);
////		System.out.println("어드민컨트롤러 csQna" + csQna );
//		
//		// 페이지번호와 
//		model.addAttribute("pageNo", pageNo);
//		model.addAttribute("csQna", csQna);
//		
//		
//		return "admin/admin_cs_qna_form";
//	}	
//	
//	// 관리자페이지 1:1 질문 답글 등록 후 게시판 이동
//	@RequestMapping(value="admin_cs_qna_pro" , method = {RequestMethod.GET, RequestMethod.POST})
//	public String adminCsQnaPro(HttpSession session, Model model, @RequestParam(defaultValue = "1", name = "pageNo") int pageNo, @ModelAttribute("qnaInfo") CsInfoVO qnaInfo) {
//		System.out.println("pageNo : " + pageNo + ", qnaInfo : " + qnaInfo);
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 2;
//		
//		// 답변 등록을 위한 update 서비스
//		int updateCount = admin_service.quaReply(csTypeNo, qnaInfo);
//		
//		if(updateCount > 0 ) { // 답변 등록 성공 시
//			model.addAttribute("pageNo", pageNo);
//			// 1:1 질문 관리 게시판으로 이동
//			return "redirect:/admin_cs_qna";
//		} else {
//			System.out.println("quaReply - update 실패!");
//			model.addAttribute("msg", "답변 등록이 실패하였습니다!");
//			return "fail_back";
//		}
//		
//		
//
//	}	
//	
//	// 관리자페이지 자주묻는 질문 관리 게시판 목록
//	@GetMapping("admin_cs_faq")
//	public String adminCsFaq(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNo) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }
//		
//		// --------------------------페이징 작업 ----------------------------------
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 3;
//
//
//		int listLimit = 5;// 한 페이지에 보여줄 목록 수
//		
//		// 조회 시작 행(레코드) 번호 계산
//		int startRow = (pageNo - 1) * listLimit;
//		
//		int startPage = ((pageNo - 1) / listLimit) * listLimit + 1; // 시작할 페이지
////		System.out.println("startPage: " + startPage);
//		int endPage = startPage + listLimit -1; // 끝페이지
//		int listCount = admin_service.getCsTotalPageCount(listLimit, csTypeNo);
//		
//		// 3. 전체 페이지 목록 갯수 계산
//		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		
//		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
//		if(endPage > maxPage) { 
//			endPage = maxPage;
//		}
////		System.out.println("어드민 컨트롤러 공지사항 스타트페이지" + startPage +", 엔드 페이지:"+ endPage);
//		// --------------------------------------------------------------------------
//		
//		// 공지사항 목록 조회
//		List<CsInfoVO> CsFaqList = admin_service.getCsList(pageNo, listLimit, startRow, csTypeNo);
//		
//		// 페이징 정보 저장
//		PageInfoVO pageInfo = new PageInfoVO(listCount, listLimit, maxPage, startPage, endPage);
//		
////		System.out.println("CsFaqList : " + CsFaqList);
////		System.out.println("pageInfo : " + pageInfo);
//		
//		// 글목록, 페이징 정보 저장
//		model.addAttribute("CsFaqList", CsFaqList);
//		model.addAttribute("pageNo", pageNo);
//		model.addAttribute("pageInfo", pageInfo);
//		
//		
//		
//		
//		return "admin/admin_cs_faq_list";
//	}
//	
//	// 관리자페이지 자주묻는 질문 글쓰기 폼 이동
//	@GetMapping("admin_cs_faq_form")
//	public String adminCsFaqForm(HttpSession session, Model model, @RequestParam(name="pageNo", defaultValue = "1") int pageNo) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }
//		
//		// 페이지 정보 저장
//		model.addAttribute("pageNo", pageNo);
//		
//		return "admin/admin_cs_faq_form";
//	}
//	
//	// 관리자페이지 자주묻는 질문 글쓰기 등록 후 게시판 이동
//	@PostMapping("admin_cs_faq_pro")
//	public String adminCsFaqPro(HttpSession session, Model model, @RequestParam( defaultValue = "1", name = "pageNo") int pageNo, @ModelAttribute("faqInfo") CsInfoVO faqInfo,  @RequestParam(required = false, value = "cs_multi_file" ) MultipartFile files) {
//		System.out.println("faqInfo: " + faqInfo + ", files" + files);
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		
//		// 자주 묻는 질문 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 3;
//		
//
//		// 자주묻는 질문 글쓰기 등록을 위한 함수 호출
//		int insertCount = admin_service.registCs(csTypeNo, faqInfo, files);
//
//		if(insertCount > 0) { //글쓰기 성공
//			
//			return "redirect:/admin_cs_faq"; // 자주 묻는 질문으로 리다이렉트
//		} else { // 글쓰기 실패
//			model.addAttribute("msg", "등록이 실패했습니다!");
//			
//			return "fail_back"; // 실패 창 띄우기
//		}
//		
//
//	}
//
//	
//	
//	// 관리자페이지 자주묻는 질문 글수정 폼 이동
//	// 이전 등록된 정보 가져오기
//	@GetMapping("admin_cs_faq_modify_form")
//	public String adminCsFaqModifyForm(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNo, @RequestParam int cs_type_list_num) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }
//		
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 3;
//		
//		// 1:1 질문 정보 가져오기
//		// 파라미터값 : cs_type_list_num
//		CsInfoVO csFaq = admin_service.getCsInfo(csTypeNo, cs_type_list_num);
////		System.out.println("어드민컨트롤러 csQna" + csQna );
//		
//		// 페이지번호와 
//		model.addAttribute("pageNo", pageNo);
//		model.addAttribute("csFaq", csFaq);
//		
//		return "admin/admin_cs_faq_modify_form";
//	}
//	
//	// 관리자페이지 자주묻는 질문 글수정 등록 후 게시판 이동
//	@PostMapping("admin_cs_faq_modify_pro")
//	public String adminCsFaqModifyPro(HttpSession session, Model model, @RequestParam( defaultValue = "1", name = "pageNo") int pageNo, @ModelAttribute("noticeInfo") CsInfoVO faqInfo, @RequestParam(required = false, value = "cs_multi_file" ) MultipartFile files) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		
//		// 공지사항 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
//		int csTypeNo = 3;
//
//		System.out.println("faq_modify_pro csTypeNo :" + csTypeNo + ", faqInfo" + faqInfo + ", files" + files);
//		// 공지사항 글정보 변경
//		int updateCount = admin_service.updateCs(csTypeNo, faqInfo, files);
//		
//		
//		if(updateCount > 0 ) { // 답변 등록 성공 시
//			// 페이지 정보 저장
//			model.addAttribute("pageNo", pageNo);
//			// 자주묻는 질문 게시판으로 이동
//			return "redirect:/admin_cs_faq";
//		} else {
//			System.out.println("Faq - update 실패!");
//			model.addAttribute("msg", "답변 등록이 실패하였습니다!");
//			return "fail_back"; // 실패 시 이동할 페이지
//		}
//		
//
//	}	
//	
//	
//	
//	
//	// 관리자페이지 회원관리 메인(리스트) 회원목록 다 가져와서 뿌리기
//	// 데이터넣고 주석풀고 확인하기 0608 - 정의효
//
////	---------------------원본 -------------------------------------------------
////	@GetMapping("admin_member_list")
////	public String adminMemberList(HttpSession session, Model model) {
////		
////		// --------------------원본---------------
////		List<MemberVO> memberList = member_service.getMemberList();
////		model.addAttribute("memberList", memberList);
////		System.out.println(memberList);
////		// --------------------원본---------------
////		
////		
////		return "admin/admin_member_list";
////	}
////	---------------------원본 -------------------------------------------------
//	
////	admin_member_list 페이징처리 테스트 - 0616 정의효
////	검색기능 추가중 - 0621 정의효 
//	@GetMapping("admin_member_list")
//	public String adminMemberList(
//			HttpSession session,
//			@RequestParam(defaultValue = "") String memberSearchType,
//			@RequestParam(defaultValue = "") String memberSearchKeyword,
//			@RequestParam(defaultValue = "1") int pageNo, 
//			Model model) {
//		
//		int listLimit = 5; // 한 페이지에 보여줄 게시물 수
//		
//		// 조회 시작 행(레코드) 번호 계산
//		int startRow = (pageNo - 1) * listLimit;
//		
//		// 회원 목록 조회
//		List<MemberVO> memberList = member_service.getMemberList(memberSearchType, memberSearchKeyword, startRow, listLimit);
//		
//		int listCount = member_service.getMemberListCount(memberSearchType, memberSearchKeyword);
//		
//		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
//		int pageListLimit = 2;
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
//				if(endPage > maxPage) { 
//					endPage = maxPage;
//				}
//		
//		// 페이징 정보 저장
//		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
//		
//		model.addAttribute("memberList", memberList);
//		model.addAttribute("pageInfo", pageInfo);
//		System.out.println(memberList);
//		
//		
//		return "admin/admin_member_list";
//	}
//	
//	
//	
//	// 관리자페이지 영화관리 메인
//	// 영화 가져와서 뿌리기
//	// admin_movie_management 원본---------------------------------------
////	@GetMapping("admin_movie_management")
////	public String adminMovieManagement(HttpSession session, Model model) {
////
////		
//////		// 직원 세션이 아닐 경우 잘못된 접근 처리
//////		String member_type = (String)session.getAttribute("member_type");
//////		System.out.println(member_type);
//////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
//////
//////            model.addAttribute("msg", "잘못된 접근입니다!");
//////            return "fail_back";
//////        }		
////		
////		
////		List<MovieVO> movieList = movie_service.getMovieList();
////		model.addAttribute("movieList", movieList);
////		return "admin/admin_movie_management";
////	}
//	// admin_movie_management 원본---------------------------------------
//	
////	 admin_movie_management 페이징 처리 테스트 0616 정의효-----------------------------
//	@GetMapping("admin_movie_management")
//	public String adminMovieManagement(HttpSession session, @RequestParam(defaultValue = "1") int pageNo, Model model) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		int pageListLimit = 5; // 한 페이지에 보여줄 게시물 수
//		
//		List<MovieVO> movieList = movie_service.getMovieList(pageNo, pageListLimit);
//		int totalPageCount = movie_service.getTotalPageCount(pageListLimit);
////		int startIndex = payment_service.getStartIndex(pageNo, pageListLimit);  찾아서 1~10뜨고 11~20뜨고 해보기
////		int endIndex = payment_service.getEndIndex(pageNo, pageListLimit);	찾아서 1~10뜨고 11~20뜨고 해보기
//		
//		model.addAttribute("movieList", movieList);
//		model.addAttribute("currentPage", pageNo);
//		model.addAttribute("totalPageCount", totalPageCount);
//		
//		return "admin/admin_movie_management";
//	}
//	
////	---------------------------------------------------------------------------
//	
//	
//	// 영화 상세정보 조회
//	//  ?=movie_num
//	// 포워딩 페이지 : admin/admin_movie_detail
//	// 데이터넣고 주석풀고 확인하기 0608 - 정의효
//	@GetMapping("admin_movie_detail")
//	public String adminMemberOneperson(HttpSession session, @RequestParam int movie_num, Model model) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		
//		
//		MovieVO movie = movie_service.getMovie(movie_num);
//		model.addAttribute("movie", movie);
//		
//		return "admin/admin_movie_detail";
//	}
//	
//	// 관리자페이지 영화관리 등록페이지로 이동 - 0609 정의효
//	@GetMapping("admin_movie_regist")
//	public String adminMovieRegist(HttpSession session, Model model) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		
//		
//		return "admin/admin_movie_regist";
//	}
//	
//	// 영화등록페이지 에서 등록하기 클릭시(insert 구문) - 영화관리 메인으로 이동 - 0610 정의효
//	// POST => 폼 파라미터 데이터를 전송받아 저장할 MovieVO 타입 파라미터 설정
//	
//	@InitBinder //0620정의효 - 문자열을 DATE타임으로바꾸는거 안되면 삭제하기
//    public void initBinder(WebDataBinder binder) {
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
//        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
//    }
//	
//	
//	@PostMapping("admin_movie_regist_Pro")
//	public String adminMovieRegistPro(HttpSession session, @DateTimeFormat(pattern = "yyyy-MM-dd") MovieVO movie, Model model) {
//		System.out.println(movie);
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		
//		
//		int insertCount = movie_service.registMovie(movie);
//		
//		
//		
//		return "redirect:/admin_movie_management";
//	}
//	
//	// 관리자페이지 결제관리 메인(리스트) 결제목록 다 가져와서 뿌리기
//	// 데이터넣고 주석풀고 확인하기 0608 - 정의효
//	// 0609 완
//	// 페이징관리 시작 0615-13:41-정의효
//	// 처음 페이지 요청 = 1페이지
//	
//	//--------------------------------------------------원본
////	@GetMapping("admin_payment_list")
////	public String adminPaymentList(HttpSession session, Model model) {
////		
////		
//////		// 직원 세션이 아닐 경우 잘못된 접근 처리
//////		String member_type = (String)session.getAttribute("member_type");
//////		System.out.println(member_type);
//////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
//////
//////            model.addAttribute("msg", "잘못된 접근입니다!");
//////            return "fail_back";
//////        }		
////		
////		
////		List<PaymentVO> paymentList = payment_service.getPaymentList();
////		
////		model.addAttribute("paymentList", paymentList);
////		
////		return "admin/admin_payment_list";
////	}
//	//--------------------------------------------------원본
//	// -- 페이징처리 테스트 - 일단 초안완 0616 정의효
//	@GetMapping("admin_payment_list")
//	public String adminPaymentList(HttpSession session, @RequestParam(defaultValue = "1") int pageNo, Model model) {
//		
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		
//		int pageListLimit = 5; // 한 페이지에 보여줄 게시물 수
//		
//		List<PaymentVO> paymentList = payment_service.getPaymentList(pageNo, pageListLimit);
//		int totalPageCount = payment_service.getTotalPageCount(pageListLimit);
////		int startIndex = payment_service.getStartIndex(pageNo, pageListLimit);  찾아서 1~10뜨고 11~20뜨고 해보기
////		int endIndex = payment_service.getEndIndex(pageNo, pageListLimit);	찾아서 1~10뜨고 11~20뜨고 해보기
//		
//		model.addAttribute("paymentList", paymentList);
//		model.addAttribute("currentPage", pageNo);
//		model.addAttribute("totalPageCount", totalPageCount);
////		model.addAttribute("startIndex", startIndex);	찾아서 1~10뜨고 11~20뜨고 해보기
////		model.addAttribute("endIndex", endIndex);	찾아서 1~10뜨고 11~20뜨고 해보기
//		System.out.println(paymentList);
//		return "admin/admin_payment_list";
//	}
//	
//
//	// 관리자페이지 회원(1명) 정보 조회
//	//  ?=member_id(이름은 중복될수있으니까 X)
//	// 포워딩 페이지 : admin/admin_member_oneperson
//	// 데이터넣고 주석풀고 확인하기 0608 - 정의효
//	@GetMapping("admin_member_oneperson")
//	public String adminMemberOneperson(HttpSession session, @RequestParam String member_id, Model model) {
//
//		
////		// 직원 세션이 아닐 경우 잘못된 접근 처리
////		String member_type = (String)session.getAttribute("member_type");
////		System.out.println(member_type);
////		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
////
////            model.addAttribute("msg", "잘못된 접근입니다!");
////            return "fail_back";
////        }		
//		
//		MemberVO member = member_service.getMember(member_id);
//		model.addAttribute("member", member);
//		
//		return "admin/admin_member_oneperson";
//	}
//	
//	// 관리자페이지 결제관리메인 -> 상세보기 클릭시 주문내역상세
//	// 파라미터 id
//	// 포워딩페이지 : admin/admin_payment_list_detai
//	// 데이터넣고 주석풀고 확인하기 **완료X 0608 - 정의효
//	// 0609 완
////	--원본-----------------------------
////	@GetMapping("admin_payment_list_detail")
////	public String adminPaymentListDetail(@RequestParam int order_num, Model model) {
////		
////		PaymentVO payment = payment_service.getPayment(order_num); 
////		model.addAttribute("payment", payment);
////		System.out.println(payment);
////		return "admin/admin_payment_list_detail";
////	}
////	--원본-----------------------------
//	//List로 수정중 0616정의효
//	//수정중 0621정의효 14:00
//	@GetMapping("admin_payment_list_detail")
//	public String adminPaymentListDetail(@RequestParam int order_num, Model model) {
//		
//		List<PaymentVO> paymentDetail = payment_service.getPaymentDetail(order_num);
//		model.addAttribute("paymentDetail", paymentDetail);
//		
//		
//		return "admin/admin_payment_list_detail";
//	}
//	
//	//0619정의효 관리자페이지 - 회원 등급 변경
//	@PostMapping("admin_changeMemberGrade")
//	public String adminChangeMemberGrade(HttpSession session, @RequestParam String grade_name, @RequestParam String member_id) {
//		System.out.println(grade_name);
//	    member_service.changeMemberGrade(grade_name, member_id);
//	    return "redirect:/admin_member_list";
//	}
//
//	//0619정의효 관리자페이지 - 회원 상태 변경
//	@PostMapping("admin_changeMemberStatus")
//	public String adminChangeMemberStatus(HttpSession session, @RequestParam String member_status, @RequestParam String member_id) {
//		System.out.println(member_status);
//		member_service.changeMemberStatus(member_status, member_id);
//		return "redirect:/admin_member_list";
//	}
//    
//	//0619정의효 관리자페이지 - 회원삭제
//	@PostMapping("admin_memberDelete")
//	public String adminMemberDelete(HttpSession session, @RequestParam String member_id) {
//		member_service.memberDelete(member_id);
//		return "redirect:/admin_member_list";
//	}
//		
//	//0620정의효 관리자페이지 - 영화삭제
//		@PostMapping("admin_movieDelete")
//		public String adminMovierDelete(HttpSession session, @RequestParam String movie_num) {
//			movie_service.movieDelete(movie_num);
//			return "redirect:/admin_movie_management";
//		}
//		
//	//0620정의효 영화수정 완
//	@PostMapping("admin_movie_modify")
//	public String adminMovieModify(HttpSession session, @ModelAttribute MovieVO movie) {
//		movie_service.movieModify(movie);
//		
//		System.out.println(movie);
//		return "redirect:/admin_movie_management";
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
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
