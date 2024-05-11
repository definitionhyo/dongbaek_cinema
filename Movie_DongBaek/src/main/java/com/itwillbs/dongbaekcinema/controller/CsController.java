package com.itwillbs.dongbaekcinema.controller;

import java.io.*;
import java.nio.file.*;
import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

import com.itwillbs.dongbaekcinema.service.*;
import com.itwillbs.dongbaekcinema.vo.*;
import com.itwillbs.dongbaekcinema.voNew.CsInfoVO;
import com.itwillbs.dongbaekcinema.voNew.PageInfoVO;

@Controller
public class CsController {
	
	// Service와 연결하기
	@Autowired
	private CsService service;
	
	@Autowired
	private AdminService admin_service;
	
	// cs 부분 main으로 가는 매핑
	@GetMapping("cs_main")
	public String cs_main(Model model) {
		
		// 공지사항 최근 3개(제목만 들고올거지만?)
//		CsVO board_csNotice = service.getCsNotice();
		
		// 모델에 저장해 이동하기
//		model.addAttribute("board_csNotice", board_csNotice);
		
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = listLimit; // 조회 시작 행(레코드) 번호 (다섯개만 보여줄거임)
		
		int startPage = listLimit + 1; // 시작할 페이지
//		System.out.println("startPage: " + startPage);
		int endPage = startPage + listLimit -1; // 끝페이지
		// CS 게시판 구분용 contiodion 변수(csType=1일경우 공지사항)
		int listCount = admin_service.getCsTotalPageCount(listLimit, 1);
		
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
			endPage = maxPage;
		}
//		System.out.println("어드민 컨트롤러 공지사항 스타트페이지" + startPage +", 엔드 페이지:"+ endPage);
		// --------------------------------------------------------------------------
		
		// 공지사항 목록 조회
		List<CsInfoVO> csInfoList = admin_service.getCsList(1, listLimit, startRow, 1);
		
		model.addAttribute("csInfoList", csInfoList);

		return "cs/cs_main";
	}
	
	// cs 부분 1:1질문(cs_qna_form.jsp)으로 가는 매핑
	@GetMapping("cs_qna_form")
	public String cs_qna_form(HttpSession session, Model model) {
		
		// 미 로그인 시 (세션 아이디가 없는 경우) 접근 불가
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", "회원만 가능한 작업입니다. 로그인 후 이용해주세요.");
			model.addAttribute("targetURL", "member_login_form");
			return "fail_location";
		}
		
		// 비회원의 경우도 사용하지 못하게 접근 불가시키기
		String member_type = (String) session.getAttribute("member_type");
		if(member_type.equals("비회원")) {
			model.addAttribute("msg", "가입한 회원만 가능한 작업입니다. 로그인 후 이용해주세요.");
			return "fail_back";
		}
		
		return "cs/cs_qna_form";
	}
	
	// cs 부분 1:1질문 DB 에 INSERT 하는 메서드
	@PostMapping("csQnaPro")
	public String qnaPro(CsVO board, Model model, HttpSession session, HttpServletRequest request) {
		// 값 받아오기
//		System.out.println(board);
		
		// ======================================== 파일 처리 ========================================
		// 이클립스 프로젝트 상 업로드 폴더의 실제 경로 알아내기(request나 session 객체필요)
		String uploadDir = "/resources/upload";	// 현재 폴더상 경로
		String saveDir = request.getServletContext().getRealPath(uploadDir);  // 실제 경로
//		System.out.println(saveDir);
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
//		System.out.println("원본파일명1 : " + mFile.getOriginalFilename());
		
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
//		System.out.println("실제 업로드 파일명1 : " + board.getCs_file_real());
		
		// ======================================== 파일 처리 끝 ========================================
		
		// CsService - insertBoard()
		// 파라미터 : CsVO board		리턴타입 : int(insertCount)
		int insertCount = service.insertBoard(board);
		
		if(insertCount == 0) {	// DB에 등록 실패 시
			model.addAttribute("msg", "1:1 문의 등록 실패!");
			return "fail_back";
		} else { // 성공 시
			
			try {
				// 업로드 된 파일은 MultipartFile 객체에 의해 임시 디렉토리에 저장되어 있으며
				// 글쓰기 작업 성공 시 임시 디렉토리 -> 실제 디렉토리로 이동 작업 필요
				// MultipartFile 객체의 transferTo() 메서드를 호출하여 실제 위치로 이동(업로드)
				// => 비어있는 파일은 이동할 수 없으므로(= 예외 발생) 제외
				// => File 객체 생성 시 지정한 디렉토리에 지정한 이름으로 파일이 이동(생성)함
				//		따라서, 이동할 위치의 파일명도 UUID가 결합된 파일명을 지정해야한다!
				if(!mFile.getOriginalFilename().equals("")) {
					// 원래 파일이름은 mFile인데 saveDir 디렉토리에 fileName을 넣어라
					mFile.transferTo(new File(saveDir, fileName));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		// cs main으로 이동
		return "redirect:/myPage_inquiry";
	}
	
	// cs 부분 자주묻는질문(cs_faq.jsp)으로 가는 매핑
	@GetMapping("cs_faq")
	public String cs_faq() {
		return "cs/cs_faq";
	}
	
	// cs 부분 자주묻는질문 DB 조회하는 메서드
	@GetMapping("/faq_data")
	@ResponseBody	// CsVO -> json으로 리턴
	public List<CsVO> fag_data(@RequestParam("cs_type") String cs_type
//			, @RequestParam("pageNum") int pageNum
			) {
		
//		int startNum = pageNum * 5 - 4;
		// 받아온 값으로(cs_type) 레코드 조회
		// CsService - getFaq()
		// 파라미터 : String(cs_type), int (startNum, pageNum)		리턴타입 : CsVO(faq)
		List<CsVO> faq = service.getCsFaq(cs_type);
//		List<CsVO> faq = service.getCsFaq(cs_type, startNum, pageNum);
//		System.out.println(faq);
		
		return faq;
	}
	
	// cs 부분 공지사항(cs_cs_notice.jsp)으로 가는 매핑
	@GetMapping("cs_notice")
	public String adminCsNotice(HttpSession session, Model model
			, @RequestParam(defaultValue = "1") int pageNo
			, @RequestParam(defaultValue = "1") int csTypeNo) {
//		System.out.println("pageNO : " + pageNo);
		

		
		
		// --------------------------페이징 작업 ----------------------------------


		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNo - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		
		int startPage = ((pageNo - 1) / listLimit) * listLimit + 1; // 시작할 페이지
//		System.out.println("startPage: " + startPage);
		int endPage = startPage + listLimit -1; // 끝페이지
		int listCount = admin_service.getCsTotalPageCount(listLimit, csTypeNo);
		
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
			endPage = maxPage;
		}
//		System.out.println("어드민 컨트롤러 공지사항 스타트페이지" + startPage +", 엔드 페이지:"+ endPage);
		// --------------------------------------------------------------------------
		
		// 공지사항 목록 조회
		List<CsInfoVO> csInfoList = admin_service.getCsList(pageNo, listLimit, startRow, csTypeNo);
		
		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, listLimit, maxPage, startPage, endPage);
		
//		System.out.println("CsNoticeList : " + CsNoticeList);
//		System.out.println("pageInfo : " + pageInfo);
		model.addAttribute("csInfoList", csInfoList);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageInfo", pageInfo);

		return "cs/cs_notice";

		
	}
	
	@GetMapping("cs_notice_view")
	public String cs_notice_view(HttpSession session, Model model
								,@RequestParam int cstypeNo
								,@RequestParam int cs_type_list_num) {

		System.out.println("cs_notice_view");
		// admin_service - getCsInfo() 메서드 호출하여 글 상세정보 조회 요청
		// => 파라미터 : cs_type_list_num   리턴타입 : CsInfoVO 객체(csInfo)
		CsInfoVO csInfo = admin_service.getCsInfo(cstypeNo, cs_type_list_num);
		
		// 상세정보 조회 결과 저장
		model.addAttribute("csInfo", csInfo);
		
		return "cs/cs_notice_view";

	}
	
}