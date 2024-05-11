package com.itwillbs.dongbaekcinema.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.dongbaekcinema.handler.MyPasswordEncoder;
import com.itwillbs.dongbaekcinema.service.*;
import com.itwillbs.dongbaekcinema.vo.*;

@Controller
public class MemberController {
	
	// Service와 연결하기
	@Autowired
	private MemberService service;
	
	
	// 회원가입 폼에서 아이디 중복확인
	@PostMapping("/idCheck")
	@ResponseBody // json 값을 가져오기 위한 어노테이션 @ResponseBody
	public int idCheck(@RequestParam("id") String id) { // id 값을 받아오기 위한 @RequestParam
		int cnt = service.idCheck(id);
		return cnt;
	}
	
	// "/member_join_pro" 요청에 대해 MemberService 객체 비즈니스 로직 수행 
	// => 폼 파라미터로 전달되는 가입 정보를 파라미터로 전달받기 
	// => 가입 완료 후 이동할 페이지 : member/member_join_step4.jsp 
	// => 가입 실패 시 오류 페이지(fail_back) 을 통해 "회원 가입이 실패하였습니다." 출력 후 이전 페이지( )로 돌아가기!
	// => 패스워드 암호화 기능(BCryptPasswordEncoder 활용)
	@PostMapping("member_join_pro")
	public String joinPro(MemberVO member, HttpSession session,  Model model) {
		System.out.println(member);
		
		// 패스워드 암호화(해싱)--------------
		// => MyPasswordEncoder  클래스에 덮어쓰기
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		
		// 2. getCtyptoPassword() 메서드에 평문 전달하며 암호문 얻어오기
		String securePasswd = passwordEncoder.getCryptoPasswd(member.getMember_pass());
		
		// 3. 리턴받은 암호문을 MemberVO 객체에 덮어쓰기
		member.setMember_pass(securePasswd);
		// --------------------------------------
		
		// MemberService(registMember()) - MemberMapper(insertMember())
		int insertCount = service.registMember(member);
		
		// 회원 가입 성공/실패에 따른 페이지 포워딩
		// => 성공 시 MemberJoinSuccess 로 리다이렉트
		// => 실패 시 fail_back.jsp 로 포워딩(model 객체의 "msg" 속성으로 "회원 가입 실패!" 저장)
		if(insertCount > 0) {
			// (카카오)회원 이메일, 이름 session에서 제거
			session.removeAttribute("member_email");
			session.removeAttribute("member_name");
			return "redirect:/MemberJoinSuccess";
		} else {
			model.addAttribute("msg", "회원 가입이 실패하였습니다!");
			return "fail_back";
		}
	}
	
	// "/MemberJoinSuccess" 요청에 대해 "member/member_join_step4.jsp" 페이지 포워딩
	// => GET 방식 요청, Dispatch 방식 포워딩 
	@GetMapping("MemberJoinSuccess")
	public String joinSuccess() {
		return "member/member_join_step4";
	}
	
	@GetMapping("member_join_step4")
	public String member_join_step4(HttpSession session, Model model) {
		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
					
			return "fail_location";
		}
		return "member_join_step4";
	}
	
	
	
	// 메인화면에서 회원 로그인 화면으로 이동
	@RequestMapping(value="member_login_form", method = {RequestMethod.GET, RequestMethod.POST })
	public String member_login_form(Model model, HttpSession session,
						@RequestParam(required = false) String play_num) {
		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", " 잘못된 접근!");
			
			return "fail_back";
		}
		
		if(play_num != null) {
			session.setAttribute("play_num", play_num);
//			System.out.println("url하고 play_num : " + url + play_num );
		}
		
		
		return "member/member_login_form";
	}

	
	// 로그인 폼에서 로그인 버튼, 네이버/카카오 로그인 버튼 클릭 시 처리
	@PostMapping("member_login_pro")
	public String member_login_pro(
				MemberVO member, boolean remember_me,
				HttpSession session, HttpServletResponse response, Model model) {
		
		// 1. 일반 로그인 시도
		// MemberService - getPasswd()
		// member 테이블에서 id가 일치하는 레코드의 패스워드(passwd) 조회
		// 파라미터 : MemberVO member	리턴타입 : MemberVO getMember
//		String passwd = service.getPasswd(member);
		
		// BcryptPasswordEncoder 객체를 활요한 로그인(해싱된 암호 필요)-----------------
//		String passwd = getMember.getMember_pass();
//		System.out.println(passwd);
		// 1. MemberService - getPasswd() 메서드를 호출하여 
		// member 테이블에서 id 가 일치하는 레코드 패스워드 조회 요청
		// => 파라미터 : memberVO 객체		리턴타입 : String securePasswd
		String securePasswd = service.getPasswd(member);
			System.out.println(securePasswd);
			System.out.println(member.getMember_pass());
		
		// 2. BcryptPasswordEncoder 객체 생성
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		// 3. BcryptPasswordEncoder 객체의 matches() 메서드 호출해서 암호 비교
		// => 파라미터 : 평문, 암호화 된 암호 		리턴타입 : boolean
		// 로그인 성공/ 실패 여부 판별하여 포워딩
		// => 성공 : MemberVO 객체에 데이터가 저장되어 있고 입력받은 패스워드가 같음
		// => 실패 : MemberVO 객체가 null 이거나 입력받은 패스워드와 다름
		
		System.out.println("securePasswd : " + securePasswd);

		if(member.getMember_id() == null) {		
			// 아이디로 조회 시 없는 아이디일 때
			model.addAttribute("msg", "없는 아이디 입니다. "
					+ "입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		} else if (member.getMember_pass() ==  null || !passwordEncoder.matches(member.getMember_pass(), securePasswd)) {
			// 패스워드가 member.getPasswd와 다를 때(비밀번호가 틀림)
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. "
					+ "입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		} else {
			// 로그인 성공 시
			
			// 아이디로 조회한 회원 정보를 들고와서 세션에 아이디와 회원타입(회원, 비회원, 직원) 들고오기
			MemberVO getMember = service.getMember(member.getMember_id());
			
			// 탈퇴한 회원인 경우(member_status가 "탈퇴") 탈퇴한 회원입니다 하고 돌려보내기
			if(getMember.getMember_status().equals("탈퇴")) {
				model.addAttribute("msg", "탈퇴한 회원입니다. 로그인이 불가능합니다.");
				return "fail_back";
			}
			session.setAttribute("member_id", getMember.getMember_id());
			session.setAttribute("member_type", getMember.getMember_type());
			
			// 만약, "아이디 저장" 체크박스 버튼이 눌려진 경우 cookie에 member_id 저장
			Cookie cookie = new Cookie("member_id", getMember.getMember_id());
			
			if(remember_me) {
				// Cookie에 로그인 성공한 member_id 저장 (name : "member_id")
				// cookie 유지 시간 지정 (초 단위)
				cookie.setMaxAge(60 * 60 * 24 * 15); // 15일 유지 (초 * 분 * 시 * 일)
			} else if (!remember_me) {
				// "아이디 저장" 체크박스 버튼이 눌려져 있지 않을 때 => cookie에 member_id 제거
				// cookie 유지 시간 지정 (초 단위)
				cookie.setMaxAge(0); // 삭제
			}
			response.addCookie(cookie);
			
//			System.out.println("play_num 없어? " + session.getAttribute("play_num"));
			
			// 나중에 작업하던 곳으로 돌아가게 설정하기(예매-좌석)
			if(session.getAttribute("play_num") != null) {
				return "redirect:/reservation_seat?play_num=" + session.getAttribute("play_num");
			}
			
			return "redirect:/";	// 메인페이지(루트)로 리다이렉트 (href="./" 와 같음)
		}
			
	}
		
	// 네이버/카카오 로그인 클릭 시 (네이버/카카오 로그인 성공)
	// 넘어온 이메일 정보가 DB에 있는지 확인
	
	// 2. 카카오 로그인 클릭
	@PostMapping("/checkKakao")
	@ResponseBody	// Json 형태의 응답을 반환하도록 지정
	public String checkKakao(@RequestParam String email, @RequestParam String nickname, HttpSession session) {
		// 카카오에서 받아온 데이터 출력
		System.out.println("email : " + email + "name : " + nickname);
		
		// DB에서 리턴받아 판별
		// MemberService - idCheck()
		// 파라미터 : String(email -> member_id)		리턴타입 : int(idCheck)
		int idCheck = service.idCheck(email);
		
		// 카카오에서 전달받은 이메일 값으로 회원가입 여부 판별
		if (idCheck > 0) {
			// DB에 카카오에서 전달받은 이메일이 아이디로 존재할 때
			System.out.println("존재하는 회원");
			
			// 이미 가입된 회원이므로 세션에 유저의 아이디 저장
			session.setAttribute("member_id", email);
			return "existing";
		} else {
			// DB에 아이디가 존재하지 않는 경우 -> 회원가입으로 넘어가기
			return "new";
		}
		
	}
	
	// 3. 네이버 로그인 클릭
	@PostMapping("/checkUserNaver")
	@ResponseBody	// Json 형태의 응답을 반환하도록 지정
	public String checkUser(@RequestParam("email") String email, HttpSession session) {
		  System.out.println("email : "+ email);
		  int idCheck = service.idCheck(email);
		  System.out.println(idCheck);
		  
		// 네이버에서 전달받은 이메일 값으로 회원가입 여부 판별
		if (idCheck > 0) {
			// DB에 네이버에서 전달받은 이메일이 아이디로 존재할 때
			System.out.println("존재하는 회원");
				
			// 이미 가입된 회원이므로 세션에 유저의 아이디 저장
			session.setAttribute("member_id", email);
			return "existing";
		 
		} else {
			// DB에 아이디가 존재하지 않는 경우 -> 회원가입으로 넘어가기
			return "new";
		}
		
	}
//	
	//----------------------------------------------------
		
	// 이메일 정보가 있을 때 (회원임)
	
	// 이메일이 회원정보에 없을 때(회원 아님)
	// "아직 동백씨네마의 회원이 아닙니다. 회원가입 하시겠습니까?" => 회원가입 페이지로 넘어가기
//		return "member/member_join_step3";	// => 회원가입(3단계) 정보입력창으로 가기
		
	
	// 로그아웃 작업 후 메인으로 돌아가기
	@GetMapping("member_logout")
	public String member_logout(HttpSession session) {
		// 세션에 저장한 member_id(저장한 정보들) 초기화
		session.invalidate();
		
		// 세션 초기화 후 main 화면으로 돌아가기
		return "redirect:/";
	}
	
	// 메인화면에서 회원가입 화면 1페이지로 이동
	@GetMapping("member_join_step1")
	public String member_join_step1(HttpSession session, Model model) {
		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			
			return "fail_location";
		}
		
		return "member/member_join_step1";
	}
	
	// 회원가입 화면 1페이지에서 휴대폰 인증 클릭 시 이동
//	@GetMapping("member_join_certify")
//	public String member_join_certify() {
//		return "member/member_join_certify";
//	}
	
	// 회원가입 화면 1 인증 성공, 네이버/카카오 인증 성공하면 회원가입 화면 2페이지로 이동
	@RequestMapping(value = "/member_join_step2", method = {RequestMethod.GET, RequestMethod.POST})
	public String member_join_step2(MemberVO member, Model model, HttpSession session) {
//		System.out.println(member);
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
							
			return "fail_location";
		}
		
		
		// 약관 동의 하는 페이지로 이동
		model.addAttribute("member", member);
		
		return "member/member_join_step2";
	}
	
	
	// 회원정보(member_phone, member_email, member_birth 등)을 가지고 정보입력(step3)로 이동
	@RequestMapping(value = "/member_join_step3", method = {RequestMethod.GET, RequestMethod.POST})
	public String member_join_step3(MemberVO member, Model model, HttpSession session) {
		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
							
			return "fail_location";
		}
		
		System.out.println(member);
		
		model.addAttribute("member", member);
		
		return "member/member_join_step3";
	}
	
	
	// 회원 로그인 화면에서 상단 탭(header)의 비회원 로그인 탭 클릭 시 비회원 로그인 페이지로 이동
	@GetMapping("no_member_login_form")
	public String no_member_login_form(HttpSession session, Model model) {
		
		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", " 잘못된 접근!");
			
			return "fail_back";
		}
		
		return "member/no_member_login_form";
	}
	
	// 비회원 로그인(가입) 작업
	@PostMapping("no_member_login_pro")
	public String no_member_login_pro(MemberVO noMember, Model model, HttpSession session) {
		
		// 중복되면 안되는 정보 (member_phone)이 중복되는 경우 돌려보내기
		String member_phone = noMember.getMember_phone();
		boolean isExistPhone = service.isExistPhone(member_phone);
		if(isExistPhone) { // 이미 DB상에 존재하는 phone번호인 경우
			model.addAttribute("msg", "이미 등록되어있는 전화번호입니다. 회원로그인 및 다른 전화번호를 사용해주세요.");
			return "fail_back";
		}
		
		// 패스워드 암호화(해싱)--------------
		// => MyPasswordEncoder  클래스에 덮어쓰기
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		
		// 2. getCtyptoPassword() 메서드에 평문 전달하며 암호문 얻어오기
		String securePasswd = passwordEncoder.getCryptoPasswd(noMember.getMember_pass());
		
		// 3. 리턴받은 암호문을 MemberVO 객체에 덮어쓰기
		noMember.setMember_pass(securePasswd);
		
		// 비회원 로그인 작업 
		// MemberService - noMemberLogin()
		// 파라미터 : MemberVO(noMember)	리턴타입 : int(insertCount)
		int insertCount = service.noMemberLogin(noMember);
		System.out.println(insertCount);
		// 비회원 로그인(가입) 성공 시 success_back으로 이동
		if(insertCount > 0) {
			session.setAttribute("member_id", noMember.getMember_phone());
			session.setAttribute("member_type", "비회원");
			
			System.out.println(session.getAttribute("member_id"));
			
			// 나중에 작업하던 곳으로 돌아가게 설정하기(예매-좌석)
			if(session.getAttribute("play_num") != null) {
				return "redirect:/reservation_seat?play_num=" + session.getAttribute("play_num");
			}
			
			
			return "redirect:/./";
		} else {
			// 로그인 실패 시 "로그인에 실패했습니다." 띄우고 이전 페이지로 돌아가기
			model.addAttribute("msg", "로그인에 실패했습니다.");
			
			return "fail_back";
		}
		
	}

	// 회원 로그인 화면에서 상단 탭(header)의  비회훤 예매 확인 탭 클릭 시 비회원 예매 확인 페이지로 이동
	@GetMapping("no_member_reservation_check_form")
	public String no_member_reservation_check_form(HttpSession session, Model model) {
		
		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", " 잘못된 접근!");
		
			return "fail_back";
		}
		
		return "member/no_member_reservation_check_form";
	}
	
	// 비회원 예매 확인을 위한 로그인
	@PostMapping("noMemberCheckPro")
	public String no_member_reservation_check_pro(MemberVO noMember,
					Model model, HttpSession session) {
		
		// 비밀번호 암호화
//		String securePasswd = service.getPasswd(noMember);
//		System.out.println(securePasswd);
//		System.out.println(noMember.getMember_pass());
		
		
		
		// 이름, 휴대폰번호, 비밀번호를 받아 맞는 레코드 조회
		// MemberService - getNoMemberPasswd()
		// 파라미터 : String 파라미터 두 개(member_name, member_phone)	리턴타입 : String(passwd)
		String securePasswd = service.getNoMemberPasswd(noMember.getMember_name(), noMember.getMember_phone());
		System.out.println(securePasswd);
		
		// 2. BcryptPasswordEncoder 객체 생성
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		// 3. BcryptPasswordEncoder 객체의 matches() 메서드 호출해서 암호 비교
		// => 파라미터 : 평문, 암호화 된 암호 		리턴타입 : boolean
		// 로그인 성공/ 실패 여부 판별하여 포워딩
		// => 성공 : MemberVO 객체에 데이터가 저장되어 있고 입력받은 패스워드가 같음
		// => 실패 : MemberVO 객체가 null 이거나 입력받은 패스워드와 다름
		
		System.out.println("securePasswd : " + securePasswd);
	
		if(noMember.getMember_pass() ==  null || !passwordEncoder.matches(noMember.getMember_pass(), securePasswd)) {		
			// 아이디로 조회 시 없는 아이디일 때
			model.addAttribute("msg", "입력하신 정보와 일치하는 예매내역이 없습니다. "
					+ "입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		}  else  {	// 비밀번호 일치 -> 로그인 성공
			session.setAttribute("member_id", noMember.getMember_phone());
			// 세션에 "member_type"로 저장해서 비회원의 경우 권한 제한
			session.setAttribute("member_type", "비회원");
			// 마이페이지 홈으로 이동
			return "redirect:/myPage_reservation_history";
		}
		
	}
	
	// 아이디 찾기 페이지로 이동
	@GetMapping("MemberModifyFormId")
	public String modifyForm(Model model, HttpSession session) {
		
		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", " 잘못된 접근!");
			
			return "fail_back";
		}
		
		return "member/member_id_find";
	}
	
	// 아이디 찾기 로직 수행
	@PostMapping("MemberIdFind")
	public String idFind(@RequestParam String member_name, String member_phone , MemberVO member, Model model, HttpSession session) {
		String find_id = service.findId(member_name, member_phone);
		System.out.println("find_id : " + find_id);
		

		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", " 잘못된 접근!");
			
			return "fail_back";
		}

		// 아이디로 조회한 회원 정보를 들고와서 세션에 아이디와 회원타입(회원, 비회원, 직원) 들고오기
//		MemberVO getMember = service.getMember(member.getMember_id());
//		
//		// 탈퇴한 회원인 경우(member_status가 "탈퇴") 탈퇴한 회원입니다 하고 돌려보내기
//		if(getMember.getMember_status().equals("탈퇴")) {
//			model.addAttribute("msg", "탈퇴한 회원입니다. 로그인이 불가능합니다.");
//			return "fail_back";
//		}
		
//		model.addAttribute("find_id", find_id);
		if(find_id == null) {
			model.addAttribute("msg", "일치하는 회원이 없습니다.");
			return "fail_back"; // 다시 전화번호를 입력할 수 있도록 페이지 reset 필요
		} else { 
			
		session.setAttribute("find_id", find_id);
		session.setAttribute("member_name", member_name);
		return "member/member_id_find_result";
		}
	}
	
	// 비밀번호 찾기 페이지로 이동
	@GetMapping("MemberFindPasswd")
	public String modifyFormPass(HttpSession session, Model model, MemberVO member) {
		
		
		// 세션 아이디가 있을 경우" 접근 막기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id != null) {
			model.addAttribute("msg", " 잘못된 접근!");
			
			return "fail_back";
		}

//		// 아이디로 조회한 회원 정보를 들고와서 세션에 아이디와 회원타입(회원, 비회원, 직원) 들고오기
//		MemberVO getMember = service.getMember(member.getMember_id());
//		
//		// 탈퇴한 회원인 경우(member_status가 "탈퇴") 탈퇴한 회원입니다 하고 돌려보내기
//		if(getMember.getMember_status().equals("탈퇴")) {
//			model.addAttribute("msg", "탈퇴한 회원입니다. 로그인이 불가능합니다.");
//			return "fail_back";
//		}
		
		
		return "member/member_passwd_find";
	}
	
	// 비밀번호 변경할 회원의 아이디와 전화번호 일치 여부 로직
	@PostMapping("MemberPasswdFind")
	public String passFind(@RequestParam String member_id, String member_phone, MemberVO member, Model model, HttpSession session) {
		String matchMember = service.matchMember(member_id, member_phone);
		System.out.println("matchMember : " + matchMember);
			
		if(matchMember == null) {
			model.addAttribute("msg", "일치하는 회원이 없습니다.");
			return "fail_back"; 
		} else {
//			session.setAttribute("member_id", member_id); // 세션에 저장하면 로그인 상태가 된다
			model.addAttribute("member_id", member_id);
			session.setAttribute("matchMember", matchMember);
			
			return "member/member_passwd_find_result";
		}
	}
		
		// 비밀번호수정
		// 여기서는 모댈로 가져올 필요가 없음 -> sessionScope.member_id 로 처리하는 것이 좋다!
		// 세션으로 처리할 경우 로그인 상태로 헤더가 변경되게 된다. 
		@RequestMapping(value = "MemberPasswdModify", method= {RequestMethod.GET, RequestMethod.POST})
//		@PostMapping("MemberPasswdModify")
		public String modifyPro(HttpServletRequest request, Model model, MemberVO member ,@RequestParam String memberNewPasswd, @RequestParam String member_id) {
//			String sId = (String)session.getAttribute("member_id");
//			if(sId != null) {
//				model.addAttribute("msg", " 잘못된 접근입니다!");
//				model.addAttribute("url", "./");
//						
//				return "fail_location";
//			}
			System.out.println("memberNewPasswd : " + memberNewPasswd);
//			model.addAttribute("member_id", member.getMember_id());
			System.out.println("member_id : " + member_id);
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			int updatePasswd = service.updatePassword(member_id, passwordEncoder.encode(memberNewPasswd));
//			
//			
			if (updatePasswd > 0) {
				model.addAttribute("msg", "비밀번호 수정 성공!");
				model.addAttribute("targetURL", "member_login_form");
				
				return "success_forward";
			} else {
				model.addAttribute("msg", "회원 정보 수정 실패!");
				model.addAttribute("targetURL", "member_passwd_fird");
				
				return "fail_location";
			}
//				
		}
	
		
	}
	
	









