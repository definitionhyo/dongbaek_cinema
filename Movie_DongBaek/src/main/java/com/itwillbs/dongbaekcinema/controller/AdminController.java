package com.itwillbs.dongbaekcinema.controller;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.dongbaekcinema.service.AdminService;
import com.itwillbs.dongbaekcinema.service.MemberService;
import com.itwillbs.dongbaekcinema.service.MovieService;
import com.itwillbs.dongbaekcinema.service.PaymentService;
import com.itwillbs.dongbaekcinema.vo.MemberVO;
import com.itwillbs.dongbaekcinema.vo.MovieVO;
import com.itwillbs.dongbaekcinema.vo.PaymentVO;
import com.itwillbs.dongbaekcinema.voNew.AdminLateVO;
import com.itwillbs.dongbaekcinema.voNew.CsInfoVO;
import com.itwillbs.dongbaekcinema.voNew.PageInfoVO;
import com.itwillbs.dongbaekcinema.voNew.PlayScheduleVO;




@Controller
public class AdminController {
	
	// 0608 정의효 - 데이터랑 없는상태에서는 오류떠서 주석처리 다해놓음
	@Autowired
	private MemberService member_service;
	
	@Autowired
	private AdminService admin_service;

	// 0609 정의효
	@Autowired
	private PaymentService payment_service;
	
	@Autowired
	private MovieService movie_service;
	
	// 관리자페이지 메인
	@GetMapping("admin_main")
	public String adminMain(HttpSession session, Model model) {
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		


		
		
		
		return "admin/admin_main";
	}
	
	// 관리자페이지 회원관리
//	@GetMapping("admin_")
//	public String adminMemeberListHttpSession session, Model model() {
	
//	// 직원 세션이 아닐 경우 잘못된 접근 처리
//	String member_type = (String)session.getAttribute("member_type");
//	System.out.println(member_type);
//	if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
//
//        model.addAttribute("msg", "잘못된 접근입니다!");
//        return "fail_back";
//    }
	
	
//		return "admin/admin_";
//	}
	
	// 관리자페이지 상영스케줄 관리
	@GetMapping("admin_schedule_list")
	public String adminScheduleList(HttpSession session, Model model) {
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
	
	        model.addAttribute("msg", "잘못된 접근입니다!");
	        return "fail_back";
	    }
		
		
		// 상영스케줄 관리 사이드 버튼 클릭시 영화관 목록 조회 후 셀렉트박스 생성 
		List<HashMap<String, String>> theaterInfo = admin_service.getTheater();
//		System.out.println(theaterInfo);		
				
		model.addAttribute("theaterInfo",theaterInfo);
		
		
		return "admin/admin_schedule_list";
	}
	
	
	// 상단 생성 버튼 클릭 시 해당 영화관의 스케줄 목록 가져옴
	@ResponseBody
    @GetMapping(value = "showSchedual", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getSchedule(HttpSession session, Model model
    		, @RequestParam String theater_num, @RequestParam String play_date
    		, @RequestParam(defaultValue = "1") int pageNo) throws Exception {
		
		
        // 상영 스케줄 정보 가져오기
        List<PlayScheduleVO> scheduleList = admin_service.showSchedual(theater_num, play_date, pageNo);
        
        // 영화관 번호로 해당 상영관 번호와 이름 가져오기
        List<PlayScheduleVO> roomList = admin_service.getRoomInfo(theater_num);
        
        System.out.println("1차 스케줄 생성 : " + scheduleList);

        JSONArray jsonArray = null;
        
        try {
			jsonArray = new JSONArray(); // JSONArray 객체 생성
				
			JSONObject jsonObject = new JSONObject(); // JSONObject 객체 생성
			jsonObject.put("scheduleList", scheduleList);
			jsonObject.put("roomList", roomList);
			
			jsonArray.put(jsonObject);
		} catch (JSONException e) {

			e.printStackTrace();
		}
        
        
        return jsonArray.toString();
    }
	

	
	
	
	// 관리자페이지 상영스케줄 상단 확인 버튼 클릭시 현재 상영중인 영화 목록 조회- json 
	@ResponseBody
	@RequestMapping(value = "findMovieList", method = {RequestMethod.POST, RequestMethod.GET}, produces = "application/json;charset=utf-8")
	public List<MovieVO> findMovieList(HttpSession session, Model model
			, @RequestParam String play_date
			, @RequestParam(defaultValue = "1") int pageNo) throws Exception {
		
//		System.out.println("findMovieList : " + play_date);
		
		// 테이블 셀렉트박스에서 상영날짜별 선택가능한 영화 목록 조회
		List<MovieVO> movieList = admin_service.findMovieList(play_date);
		
		
//		System.out.println(movieList);
		
		model.addAttribute("movieList",movieList);
		
		return movieList;
	}
	
	// 상영스케줄 영화 선택 변경시 보여줄 상영스케줄
	@ResponseBody
	@RequestMapping(value = "testSchedule", method = {RequestMethod.POST, RequestMethod.GET})
	public String testSchedule(HttpSession session, Model model,
	                           @RequestParam int theater_num, @RequestParam int room_num
	                           , @RequestParam int movie_num, @RequestParam String play_date
	                           , @RequestParam int breakTime) {

//		System.out.println("testSchedule 전송정보 확인 theater_num:" + theater_num);
//	    System.out.println("testSchedule 전송정보 확인 room_num:" + room_num);
//	    System.out.println("testSchedule 전송정보 확인 movie_num:" + movie_num);

	    JSONArray jsonArray = new JSONArray(); // JSON 배열 변수 선언
	    

	    try {
	    	// 해당 영화 이름 가져오기
	    	String movie_name_kr = admin_service.findMovieName(movie_num);
	    	
	        // 해당 영화 러닝타임 정보 가져오기
	        int movie_running_time = admin_service.findMovieRunningTime(movie_num);

			// 영화관 별 상영관 번호 계산(ex) theater_num = 2 일때 동백관은 room_num=4
			room_num = (theater_num - 1) * 3 + room_num; 

	        // 상영관 시작시간 종료시간 정보 가져오기
	        PlayScheduleVO playSchedule = admin_service.getRoomStartTime(theater_num, room_num);

	        // 회차별 시간 계산
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

	        // 새로운 배열 생성
	        LocalTime startDateTime1 = LocalTime.parse(playSchedule.getRoom_start_time(), formatter);
	        LocalTime endDateTime1 = startDateTime1.plusMinutes(movie_running_time);

	        String[] new_start_turn = new String[5];
	        String[] new_end_turn = new String[5];
	        String[] play_time_type = new String[5];

	        for (int i = 0; i < 5; i++) {
	            if (i == 0) {
	                // 첫 번째 회차
	                new_start_turn[i] = startDateTime1.format(formatter);
	                new_end_turn[i] = endDateTime1.format(formatter);
	            } else {
	                // 나머지 회차
                    LocalTime previousEndDateTime = LocalTime.parse(new_end_turn[i - 1], formatter);
                    LocalTime breakStartDateTime = previousEndDateTime.plusMinutes(breakTime);
                    LocalTime startDateTime = breakStartDateTime.plusMinutes(0);
                    LocalTime endDateTime = startDateTime.plusMinutes(movie_running_time);

	                new_start_turn[i] = startDateTime.format(formatter);
	                new_end_turn[i] = endDateTime.format(formatter);
	            }

	            // play_time_type 설정
	            LocalTime startTime = LocalTime.parse(new_start_turn[i], formatter);

	            if (startTime.isBefore(LocalTime.parse("09:00:00", formatter))) {
	                play_time_type[i] = "조조";
	            } else if (startTime.isAfter(LocalTime.parse("22:00:00", formatter))) {
	                play_time_type[i] = "심야";
	            } else {
	                play_time_type[i] = "일반";
	            }
	        }

	        // 출력(1~5회차 등록)
	        for (int i = 0; i < new_start_turn.length; i++) {
//	            System.out.println("새로운 시작 시간 [" + i + "]: " + new_start_turn[i]);
//	            System.out.println("새로운 종료 시간 [" + i + "]: " + new_end_turn[i]);
//	            System.out.println("회차 유형 [" + i + "]: " + play_time_type[i]);

	            LocalTime endTime = LocalTime.parse(new_end_turn[i], formatter);
	            LocalTime roomEndTime = LocalTime.parse(playSchedule.getRoom_end_time(), formatter);

	            if (endTime.isAfter(roomEndTime)) {
//	            	System.out.println("endTime:" + endTime + "roomEndTime:" + roomEndTime);
//	                System.out.println( i + 1 + "회차 종료 시간이 상영관 종료 시간보다 늦습니다.");
	            } else if (endTime.isAfter(LocalTime.parse("00:00:00", formatter)) 
	            		&& endTime.isBefore(LocalTime.parse(new_start_turn[0], formatter))){
//	            	System.out.println( i + 1 + "회차 종료 시간 00:00:00이후이고 " +new_start_turn[0] + " 사이입니다");
	            
	            } else {
	            	System.out.println("endTime:" + endTime + "roomEndTime:" + roomEndTime);
//	                System.out.println( i + 1 + "회차 종료 시간이 상영관 종료 시간보다 빠릅니다.");
	                

	            	JSONObject jsonObject = new JSONObject();
	                jsonObject.put("play_turn", i + 1);
	                jsonObject.put("new_start_turn", new_start_turn[i]);
	                jsonObject.put("new_end_turn", new_end_turn[i]);
	                jsonObject.put("movie_running_time", movie_running_time);
	                jsonObject.put("movie_name_kr", movie_name_kr);
//	                System.out.println("회차:"+ i);
//	                System.out.println("new_start_turn:"+ new_start_turn);
//	                System.out.println("new_end_turn:"+ new_end_turn);
//	                System.out.println("movie_running_time:"+ movie_running_time);
//	                System.out.println("movie_name_kr:"+ movie_name_kr);
	                
	                // 이미 등록된 상영스케줄이 있는지 여부 확인(없을 경우 scheduelCount == 0)
	                int scheduelCount = admin_service.checkSchedule(play_date, theater_num, room_num);
	                System.out.println("scheduelCount:" + scheduelCount);
	                System.out.println("play_date:" + play_date);
	                System.out.println("theater_num:" + theater_num);
	                System.out.println("room_num:" + room_num);
	                
	                if(scheduelCount == 0) { // 등록된 상영스케줄이 없을 경우
	                	jsonObject.put("isRegist", "미등록");
	                	jsonArray.put(jsonObject);
	                } else { // 등록된 상영스케줄이 있을 경우	        	
	                	jsonObject.put("isRegist", "변경");
	                	jsonArray.put(jsonObject);
	                }
	            }
	        }
	        
	        

	        return jsonArray.toString();	

	    } catch (Exception e) {
	        return "";
	    }
	}
	
	
	
	
	// 상영스케줄 우측 등록 버튼 클릭시 상영스케줄 등록 창 이동
	@ResponseBody
	@RequestMapping(value = "createSchedule", method = {RequestMethod.POST, RequestMethod.GET})
	public String createSchedule(HttpSession session, Model model
			, @RequestParam String play_date, @RequestParam int theater_num
			, @RequestParam int row_num, @RequestParam int movie_num
			, @RequestParam int breakTime) {
		
//		System.out.println("createUpdateSchedule 전송정보 확인 play_date:" + play_date);
//		System.out.println("theater_num:" + theater_num + ", row_num:" + row_num +", movie_num:" + movie_num);
		
		// 영화관 별 상영관 번호 계산(ex) theater_num = 2 일때 동백관은 room_num=4
		int room_num = (theater_num - 1) * 3 + row_num;		
		
		JSONObject jsonObject = new JSONObject(); // JSON 배열 변수 선언
		
		// 상영날짜가 이전일 경우 등록 불가
		LocalDate playDate = LocalDate.parse(play_date);
		if(!playDate.isAfter(LocalDate.now()) ) {
			jsonObject.put("result", "상영일자는 현재 날짜 보다 미래인 경우에만 등록가능합니다");
			return jsonObject.toString();
		}

	    try {
	    	
	    	// 기존 상영스케줄 존재여부 확인
	    	int scheduelCount = admin_service.checkSchedule(play_date, theater_num, room_num);
//	    	System.out.println("scheduelCount:" + scheduelCount);
	    	
	    	if( scheduelCount > 0) { //기존 상영 스케줄이 존재할 경우
	    		
	    		jsonObject.put("result", "이미 등록된 스케줄이 있습니다 수정 버튼을 클릭해 주세요");
	    		return jsonObject.toString();
	    	}
	    	
	    	
	    	
	        // 해당 영화 러닝타임 정보 가져오기
	        int movie_running_time = admin_service.findMovieRunningTime(movie_num); 

	        // 상영관 시작시간 종료시간 정보 가져오기
	        PlayScheduleVO playSchedule = admin_service.getRoomStartTime(theater_num, room_num);

	        // 회차별 시간 계산


	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

	        // 새로운 배열 생성
	        LocalTime startDateTime1 = LocalTime.parse(playSchedule.getRoom_start_time(), formatter);
	        LocalTime endDateTime1 = startDateTime1.plusMinutes(movie_running_time);

	        String[] new_start_turn = new String[5];
	        String[] new_end_turn = new String[5];
	        String[] play_time_type = new String[5];

	        for (int i = 0; i < 5; i++) {
	            if (i == 0) {
	                // 첫 번째 회차
	                new_start_turn[i] = startDateTime1.format(formatter);
	                new_end_turn[i] = endDateTime1.format(formatter);
	            } else {
	                // 나머지 회차
                    LocalTime previousEndDateTime = LocalTime.parse(new_end_turn[i - 1], formatter);
                    LocalTime breakStartDateTime = previousEndDateTime.plusMinutes(breakTime);
                    LocalTime startDateTime = breakStartDateTime.plusMinutes(0);
                    LocalTime endDateTime = startDateTime.plusMinutes(movie_running_time);

	                new_start_turn[i] = startDateTime.format(formatter);
	                new_end_turn[i] = endDateTime.format(formatter);
	            }

	            // play_time_type 설정
	            LocalTime startTime = LocalTime.parse(new_start_turn[i], formatter);

	            if (startTime.isBefore(LocalTime.parse("09:00:00", formatter))) {
	                play_time_type[i] = "조조";
	            } else if (startTime.isAfter(LocalTime.parse("22:00:00", formatter))) {
	                play_time_type[i] = "심야";
	            } else {
	                play_time_type[i] = "일반";
	            }
	        }

	        // 출력(1~5회차 등록)
	        for (int i = 0; i < new_start_turn.length; i++) {
//	            System.out.println("새로운 시작 시간 [" + i + "]: " + new_start_turn[i]);
//	            System.out.println("새로운 종료 시간 [" + i + "]: " + new_end_turn[i]);
//	            System.out.println("회차 유형 [" + i + "]: " + play_time_type[i]);

	            LocalTime endTime = LocalTime.parse(new_end_turn[i], formatter);
	            LocalTime roomEndTime = LocalTime.parse(playSchedule.getRoom_end_time(), formatter);
	            int play_turn = i + 1;
	            
	            if (endTime.isAfter(roomEndTime)) {
//	                System.out.println( i + 1 + "회차 종료 시간이 상영관 종료 시간보다 늦습니다.");
	            } else if (endTime.isAfter(LocalTime.parse("00:00:00", formatter)) 
	            		&& endTime.isBefore(LocalTime.parse(new_start_turn[0], formatter))){
//	            	System.out.println();
//	            	System.out.println( i + 1 + "회차 종료 시간 00:00:00이후이고 " +new_start_turn[0] + " 사이입니다");
	            
	            } else {
//	                System.out.println( i + 1 + "회차 종료 시간이 상영관 종료 시간보다 빠릅니다.");
	                int insertCount = admin_service.insertSchedule(play_date, theater_num, room_num, movie_num, new_start_turn[i], new_end_turn[i], play_turn, play_time_type[i]);
	                
	                if(insertCount > 0) {
//	                	System.out.println("상영회차 등록:" + insertCount + "개");
	                	jsonObject.put("result", "상영 회차가 등록되었습니다 조회버튼을 눌러주세요");	                	
	                } else {
	                	jsonObject.put("result", "회차 등록이 실패했습니다");	                		                	
	                }
	            }
	        }

	        return jsonObject.toString();

	    } catch (Exception e) {
	        jsonObject.put("result", "회차 등록 실패");
	        return jsonObject.toString();
	    }
		
		
	}
	
	
	// 상영스케줄 우측 수정 버튼 클릭시 상영스케줄 업데이트
	@ResponseBody
	@RequestMapping(value = "updateSchedule", method = {RequestMethod.POST, RequestMethod.GET})
	public String updateSchedule(HttpSession session, Model model
			, @RequestParam String play_date, @RequestParam int theater_num
			, @RequestParam int row_num, @RequestParam int movie_num
			, @RequestParam int breakTime) {
		
//		System.out.println("updateSchedule 전송정보 확인 play_date:" + play_date);
//		System.out.println("theater_num:" + theater_num + ", row_num:" + row_num +", movie_num:" + movie_num);
		
		// 영화관 별 상영관 번호 계산(ex) theater_num = 2 일때 동백관은 room_num=4
		int room_num = (theater_num - 1) * 3 + row_num;		
		
		JSONObject jsonObject = new JSONObject(); // JSON 배열 변수 선언

		// 상영날짜가 오늘보다 이전일 경우 변경 불가
		LocalDate playDate = LocalDate.parse(play_date);
		if(!playDate.isAfter(LocalDate.now()) ) {
			jsonObject.put("result", "상영일자는 현재 날짜 보다 미래인 경우에만 변경가능합니다");
			return jsonObject.toString();
		}

		
	    try {
	    	
	    	// 기존 상영스케줄 존재여부 확인
	    	int scheduelCount = admin_service.checkSchedule(play_date, theater_num, room_num);
//	    	System.out.println("scheduelCount:" + scheduelCount);
	    	
	    	if( scheduelCount == 0) { // 기존 상영 스케줄이 존재하지 않는 경우
	    		
	    		jsonObject.put("result", "등록된 스케줄이 없습니다 등록 버튼을 클릭해 주세요");
	    		return jsonObject.toString();
	    	
	    	} else { //기존 상영 스케줄이 존재할 경우
	    		
		        // 해당 영화 러닝타임 정보 가져오기
		        int movie_running_time = admin_service.findMovieRunningTime(movie_num); 

		        // 상영관 시작시간 종료시간 정보 가져오기
		        PlayScheduleVO playSchedule = admin_service.getRoomStartTime(theater_num, room_num);

		        // 회차별 시간 계산


		        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

		        // 새로운 배열 생성
		        LocalTime startDateTime1 = LocalTime.parse(playSchedule.getRoom_start_time(), formatter);
		        LocalTime endDateTime1 = startDateTime1.plusMinutes(movie_running_time);

		        String[] new_start_turn = new String[5]; // 회차별 시작시간 저장할 배열
		        String[] new_end_turn = new String[5]; // 회차별 종료시간 저장할 배열
		        String[] play_time_type = new String[5]; // 회차별 상영분류(조조,일반,심야) 저장할 배열

		        for (int i = 0; i < 5; i++) {
		            if (i == 0) {
		                // 첫 번째 회차
		                new_start_turn[i] = startDateTime1.format(formatter);
		                new_end_turn[i] = endDateTime1.format(formatter);
		            } else {
		                // 나머지 회차
	                    LocalTime previousEndDateTime = LocalTime.parse(new_end_turn[i - 1], formatter);
	                    LocalTime breakStartDateTime = previousEndDateTime.plusMinutes(breakTime);
	                    LocalTime startDateTime = breakStartDateTime.plusMinutes(0);
	                    LocalTime endDateTime = startDateTime.plusMinutes(movie_running_time);

		                new_start_turn[i] = startDateTime.format(formatter);
		                new_end_turn[i] = endDateTime.format(formatter);
		            }

		            // play_time_type 설정
		            LocalTime startTime = LocalTime.parse(new_start_turn[i], formatter);

		            if (startTime.isBefore(LocalTime.parse("09:00:00", formatter))) {
		                play_time_type[i] = "조조";
		            } else if (startTime.isAfter(LocalTime.parse("22:00:00", formatter))) {
		                play_time_type[i] = "심야";
		            } else {
		                play_time_type[i] = "일반";
		            }
		        }

		        // 출력(1~5회차 등록)
		        for (int i = 0; i < new_start_turn.length; i++) {
//		            System.out.println("새로운 시작 시간 [" + i + "]: " + new_start_turn[i]);
//		            System.out.println("새로운 종료 시간 [" + i + "]: " + new_end_turn[i]);
//		            System.out.println("회차 유형 [" + i + "]: " + play_time_type[i]);

		            LocalTime endTime = LocalTime.parse(new_end_turn[i], formatter);
		            LocalTime roomEndTime = LocalTime.parse(playSchedule.getRoom_end_time(), formatter);
		            int play_turn = i + 1;
		            
		            if (endTime.isAfter(roomEndTime)) { // 회차 종료 시간이 상영관 종료시간보다 늦은 경우
//		                System.out.println( i + 1 + "회차 종료 시간이 상영관 종료 시간보다 늦습니다.");
		                int deleteCount = admin_service.deleteLateSchedule(play_date, theater_num, room_num, play_turn);
//		                System.out.println(i+1 + "회차 삭제수행:" + deleteCount );
		            
		            } else if (endTime.isAfter(LocalTime.parse("00:00:00", formatter)) 
		            		&& endTime.isBefore(LocalTime.parse(new_start_turn[0], formatter))){ // 회차 종료 시간이 오전 00:00:00 ~ 상영관 시작시간인 경우
//		            	System.out.println( i + 1 + "회차 종료 시간 00:00:00이후이고 " +new_start_turn[0] + " 사이입니다");
		            	int deleteCount = admin_service.deleteLateSchedule(play_date, theater_num, room_num, play_turn);
//		            	System.out.println(i+1 + "회차 삭제수행:" + deleteCount );
		            	
		            } else { // 회차 종료 시간이 상영관 종료시간보다 빠른 경우(update 수행)
//		                System.out.println( i + 1 + "회차 종료 시간이 상영관 종료 시간보다 빠릅니다.");
		                int updateCount = admin_service.updateSchedule(play_date, theater_num, room_num, movie_num, new_start_turn[i], new_end_turn[i], play_turn, play_time_type[i]);
		                
		                if(updateCount > 0) {
//		                	System.out.println("상영회차 변경:" + updateCount + "개");
		                	jsonObject.put("result", "상영 회차가 변경되었습니다 조회 버튼을 눌러주세요");	                	
		                } else { // 기존 회차가 존재하지 않을 경우(ex.4회차까지만 등록되어있는 경우 5회차)
		                	admin_service.insertSchedule(play_date, theater_num, room_num, movie_num, new_start_turn[i], new_end_turn[i], play_turn, play_time_type[i]);
		                	jsonObject.put("result", "상영 회차가 변경되었습니다! 조회 버튼을 눌러주세요");	                		                	
		                }
		            }
		            
		        }
		     }

		        return jsonObject.toString();

		    } catch (Exception e) {
		        jsonObject.put("result", "회차 등록 실패");
		        return jsonObject.toString();
		    }
		
		
	}	
	
	
	// 상영스케줄 우측 삭제 버튼 클릭시 상영스케줄 등록 창 이동
	@ResponseBody
	@RequestMapping(value = "deleteSchedule", method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteSchedule1(HttpSession session, Model model
			, @RequestParam String play_date, @RequestParam int theater_num
			, @RequestParam int row_num) {
		
//		System.out.println("deleteSchedule 전송정보 확인 play_date:" + play_date);
//		System.out.println("theater_num:" + theater_num + ", row_num:" + row_num +", movie_num:" + movie_num);
		
		// 영화관 별 상영관 번호 계산(ex) theater_num = 2 일때 동백관은 room_num=4
		int room_num = (theater_num - 1) * 3 + row_num;		
		
		JSONObject jsonObject = new JSONObject(); // JSON 배열 변수 선언

		// 상영날짜가 오늘보다 이전일 경우 삭제 불가
		LocalDate playDate = LocalDate.parse(play_date);
		if(!playDate.isAfter(LocalDate.now()) ) {
			jsonObject.put("result", "상영일자는 현재날짜보다 미래일 경우에만 삭제가능합니다");
			return jsonObject.toString();
		}
		
	    try {
	    	
	    	// 기존 상영스케줄 존재여부 확인
	    	int scheduelCount = admin_service.checkSchedule(play_date, theater_num, room_num);
//	    	System.out.println("scheduelCount:" + scheduelCount);
	    	
	    	if( scheduelCount > 0) { //기존 상영 스케줄이 존재할 경우
	    		
	    		// 기존 상영 스케줄 삭제
	    		int deleteCount = admin_service.deleteSchedule(play_date, theater_num, room_num);
//	    		System.out.println("기존 스케줄 삭제 :" + deleteCount);
	    		jsonObject.put("result", "상영정보가 삭제되었습니다 조회 버튼을 눌러주세요");
	    		return jsonObject.toString();

	    	} else { // 기존 상영 스케줄인 없는 경우
	    		jsonObject.put("result", "삭제할 상영정보가 없습니다 먼저 등록해주세요");
	    		return jsonObject.toString();  		
	    	}
	    	
	    }catch (Exception e) {
	    	jsonObject.put("result", "스케줄 삭제 불가");
	    	return jsonObject.toString();

		}	
	    	
		
	}
	
	
	// 관리자 메인 차트 출력부분
	@ResponseBody
	@RequestMapping(value = "adminLate", method = {RequestMethod.POST, RequestMethod.GET}, produces = "application/json;charset=utf-8")
	public List<AdminLateVO> adminLate(HttpSession session, Model model) {
		
		
    	List<AdminLateVO> adminLateList = new ArrayList<AdminLateVO>();
		    	
    	
    	for(int i = 0; i < 4; i++) {
    		// vo객체 생성
    		AdminLateVO adminLate = new AdminLateVO();

    		adminLate.setDayCount(i); // 인덱스
    		
    		// 날짜 변수 저장(0-오늘 1-1일전 2-2일전 3-3일전)
    		LocalDate today = LocalDate.now();
            LocalDate daysBefore = today.minusDays(i);
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String date = daysBefore.format(dtf);
            adminLate.setDateNow(date);
            System.out.println("1:" + adminLate);
    		
    		// 일일 회원 가입 수(joinLate)
            adminLate.setJoinLate(admin_service.getMemberJoinCount(adminLate.getDayCount()));
    		
            System.out.println("2:" + adminLate);
    		// 일일 예매 수(orderLate)
            adminLate.setOrderLate(admin_service.getOrderLate(adminLate.getDayCount()));
			
            System.out.println("3:" + adminLate);
			// 일주일간 영화 예매 수 top4 movieLate
            adminLate.setMovieLate(admin_service.getMovieLateCount(adminLate.getDayCount()));

    		System.out.println("4:" + adminLate);
			// 일주일간 영화 예매 수 top4 movieName
            adminLate.setMovie_name_kr(admin_service.getMovieLateName(adminLate.getDayCount()));
    	
    		// 통계 정보 저장
    		adminLateList.add(adminLate);
    		
    	}
    	
    	//데이터 전송
		return adminLateList;
	}
	
	
	
	
	// 관리자페이지 결제관리
//	@GetMapping("")
//	public String adminPayment(HttpSession session, Model model) {

	
//	// 직원 세션이 아닐 경우 잘못된 접근 처리
//	String member_type = (String)session.getAttribute("member_type");
//	System.out.println(member_type);
//	if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
//
//        model.addAttribute("msg", "잘못된 접근입니다!");
//        return "fail_back";
//    }	
	
	//		return "admin/admin_";
//	}	

	// 관리자페이지 목록 출력
	// csTypeNo = 1 공지, 2 1:1게시판, 3 자주묻는 질문 
	@GetMapping("admin_cs_notice")
	public String adminCsNotice(HttpSession session, Model model
			, @RequestParam(defaultValue = "1") int pageNo
			, @RequestParam(defaultValue = "1") int csTypeNo) {
//		System.out.println("pageNO : " + pageNo);
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		
		
		// --------------------------페이징 작업 ----------------------------------


		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNo - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		
		int startPage = ((pageNo - 1) / listLimit) * listLimit + 1; // 시작할 페이지
//		System.out.println("startPage: " + startPage);
		int endPage = startPage + listLimit -1; // 끝페이지
		int listCount = admin_service.getCsTotalPageCount(listLimit, csTypeNo);
		
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		
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

		return "admin/admin_cs_notice_list";

		
	}
	
	// 관리자페이지 공지사항 글쓰기 폼 이동
	@GetMapping("admin_cs_notice_form")
	public String adminCsNoticeForm(HttpSession session, Model model
			, @RequestParam(defaultValue = "1") int pageNo) {
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
      }
		
		model.addAttribute("pageNo", pageNo);
		
		return "admin/admin_cs_notice_form";
	}
	
	// 관리자페이지 공지사항 글쓰기 등록 후 게시판 이동
	// fileUploadPost
	@PostMapping("admin_cs_notice_pro")
	public String adminCsNoticePro(HttpSession session, Model model
			, @RequestParam( defaultValue = "1", name = "pageNo") int pageNo
			, @ModelAttribute("noticeInfo") CsInfoVO csInfo
			, @RequestParam int csTypeNo) {
		
//		System.out.println("notice_form pageNo: " + pageNo + ", csInfo: " + csInfo);
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }

		

//		System.out.println(request.getRealPath("/resources/upload")); // Deprecated 처리된 메서드
		String uploadDir = "/resources/upload"; 
//		String saveDir = request.getServletContext().getRealPath(uploadDir); // 사용 가능
		String saveDir = session.getServletContext().getRealPath(uploadDir);
//		System.out.println("실제 업로드 경로 : "+ saveDir);
		// 실제 업로드 경로 : D:\Shared\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload
		
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			// ------------------------------------------------------------------------------

			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
//		System.out.println(date);

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			// 기존 업로드 경로에 날짜 경로 결합하여 저장
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			// --------------------------------------------------------------

			// => 파라미터 : 실제 업로드 경로
			Path path = Paths.get(saveDir);
			
			// Files 클래스의 createDirectories() 메서드를 호출하여
			// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// BoardVO 객체에 전달된 MultipartFile 객체 꺼내기
		MultipartFile mFile1 = csInfo.getFile1();
//		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
		

		// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
		String uuid = UUID.randomUUID().toString();
//		System.out.println("uuid : " + uuid);
		
		// 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
		csInfo.setCs_file("");
		
		// 파일명을 저장할 변수 선언
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			csInfo.setCs_file(subDir + "/" + fileName1);
		}
		

		
//		System.out.println("실제 업로드 파일명1 : " + csInfo.getCs_file());
		
		// -----------------------------------------------------------------------------------
		// BoardService - registBoard() 메서드를 호출하여 게시물 등록 작업 요청
		// => 파라미터 : BoardVO 객체    리턴타입 : int(insertCount)
		int insertCount = admin_service.registCs(csTypeNo, csInfo);
		
		
		// 게시물 등록 작업 요청 결과 판별
		if(insertCount > 0) { // 성공
			try {
				// 업로드 된 파일은 MultipartFile 객체에 의해 임시 디렉토리에 저장
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 글목록(BoardList)으로 리다이렉트
			return "redirect:/admin_cs_notice";
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "fail_back";
		}


	}
	
	
	
	// 관리자페이지 공지사항 글수정 폼
	// csTypeNo = 1 공지, 2 1:1게시판, 3 자주묻는 질문 
	// 이전 등록된 정보 가져오기
	@GetMapping("admin_cs_notice_modify_form")
	public String adminCsNoticeModifyForm(HttpSession session, Model model
			, @RequestParam(defaultValue = "1") int pageNo
			, @RequestParam int cs_type_list_num
			, @RequestParam(defaultValue = "1") int csTypeNo) {

		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		
		
		// 질문 정보 가져오기
		// 파라미터값 : cs_type_list_num
		CsInfoVO csInfo = admin_service.getCsInfo(csTypeNo, cs_type_list_num);
//		System.out.println("어드민컨트롤러 csQna" + csQna );
		
		// 페이지번호와 
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("csInfo", csInfo);
		
		
		
		return "admin/admin_cs_notice_modify_form";
	}
	
	// 관리자페이지 글쓰기 수정 작업 후 게시판 이동
	@PostMapping("admin_cs_notice_modify_pro")
	public String adminCsNoticeModifyPro(HttpSession session, Model model
			, @RequestParam(defaultValue = "1")int pageNo
			, @ModelAttribute("csInfo") CsInfoVO csInfo
			, @RequestParam int csTypeNo) {
		
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		

		
		// 이클립스 프로젝트 상에 업로드 폴더(upload) 생성 필요 
		String uploadDir = "/resources/upload"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
//		System.out.println("실제 업로드 경로 : "+ saveDir);
		
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			// ------------------------------------------------------------------------------
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
//		System.out.println(date);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			// 기존 업로드 경로에 날짜 경로 결합하여 저장
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			// --------------------------------------------------------------
			// => 파라미터 : 실제 업로드 경로
			Path path = Paths.get(saveDir);
			
			// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// BoardVO 객체에 전달된 MultipartFile 객체 꺼내기
		MultipartFile mFile1 = csInfo.getFile1();
//		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
		
		// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
		String uuid = UUID.randomUUID().toString();
//		System.out.println("uuid : " + uuid);
		
		// 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
		csInfo.setCs_file("");
		
		// 파일명을 저장할 변수 선언
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			csInfo.setCs_file(subDir + "/" + fileName1);
		}
		

		
//		System.out.println("실제 업로드 파일명1 : " + csInfo.getCs_file());
		System.out.println("글쓰기 변경시 전달될 정보 : " + csInfo);
		
		// -----------------------------------------------------------------------------------
		// BoardService - registBoard() 메서드를 호출하여 게시물 등록 작업 요청
		// => 파라미터 : csTypeNo,csInfo 객체    리턴타입 : int(updateCount)
		int updateCount = admin_service.updateCs(csTypeNo, csInfo);
		
		
		// 게시물 등록 작업 요청 결과 판별
		if(updateCount > 0) { // 성공
			try {
				// 이동할 위치의 파일명도 UUID 가 결합된 파일명을 지정해야한다!
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 자주묻는 질문 게시판(admin_cs_faq)으로 리다이렉트
			return "redirect:/admin_cs_notice";
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "fail_back";
		}
		
		
	}
	
	
	// 관리자 페이지 글 삭제(파라미터 csType=1일때 공지사항 삭제, csType=3일때 1:1질문 삭제)
	@GetMapping("delete_cs")
	public String deleteCs(HttpSession session, Model model
			, @RequestParam(defaultValue = "1")int pageNo
			, @RequestParam("csTypeNo") int csTypeNo
			, @RequestParam("cs_type_list_num")int cs_type_list_num) {
		
//		System.out.println("delete_cs, csTypeNo:" + csTypeNo + ", cs_type_list_num:" + cs_type_list_num);
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		
		
		int deleteCount = admin_service.deleteCs(csTypeNo, cs_type_list_num);
		
		// 글삭제 작업 후 리턴할 페이지
		if(deleteCount != 0 && csTypeNo == 1) { // 삭제 성공 시 공지사항 목록으로 리턴
			
			return "redirect:/admin_cs_notice";
		} else if(deleteCount != 0 && csTypeNo == 3) { // 삭제 성공 시 자주묻는 질문 목록으로 리턴
			
			return "redirect:/admin_cs_faq";
		} else {
			
			model.addAttribute("msg", "글 삭제 실패!");
			return "fail_back";
		}
		
	}
	
	// 관리자페이지 1:1 질문관리 게시판 목록
	@GetMapping("admin_cs_qna")
	public String adminCsQna(HttpSession session, Model model
			, @RequestParam(defaultValue = "1", name = "pageNo") int pageNo
			, @RequestParam(defaultValue = "2") int csTypeNo) {

		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		
		
		
		// --------------------------페이징 작업 ----------------------------------


		int listLimit = 10;// 한 페이지에 보여줄 목록 수
		
		// 조회 시작 행(레코드) 번호 계산
		int startRow = (pageNo - 1) * listLimit;
		
		int startPage = ((pageNo - 1) / listLimit) * listLimit + 1; // 시작할 페이지
//		System.out.println("startPage: " + startPage);
		int endPage = startPage + listLimit -1; // 끝페이지
		int listCount = admin_service.getCsTotalPageCount(listLimit, csTypeNo);
		
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
			endPage = maxPage;
		}
//		System.out.println("어드민 컨트롤러 공지사항 스타트페이지" + startPage +", 엔드 페이지:"+ endPage);
		// --------------------------------------------------------------------------
		
		// 1:1 게시판 목록 조회
		List<CsInfoVO> csInfoList = admin_service.getCsList(pageNo, listLimit, startRow, csTypeNo);
		
		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listLimit, listLimit, maxPage, startPage, endPage);
		
//		System.out.println("CsQnaList : " + CsQnaList);
//		System.out.println("pageInfo : " + pageInfo);
		
		// 글목록, 페이징 정보 저장
		model.addAttribute("csInfoList", csInfoList);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageInfo", pageInfo);
		
		
		
		return "admin/admin_cs_qna_list";
	}
	
	// 관리자페이지 1:1 질문 답글 폼 이동
	@GetMapping("admin_cs_qna_reply")
	public String adminCsQnaReply(HttpSession session, Model model
			, @RequestParam(defaultValue = "1") int pageNo
			, @RequestParam int cs_type_list_num
			, @RequestParam(defaultValue = "2") int csTypeNo ) {
		
		System.out.println("adminCsQnaReply pageNo:" + pageNo + ",cs_type_list_num:" + cs_type_list_num );
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }	
		
		
		
		// 1:1 질문 정보 가져오기
		// 파라미터값 : cs_type_list_num
		CsInfoVO csInfo = admin_service.getCsInfo(csTypeNo, cs_type_list_num);
//		System.out.println("어드민컨트롤러 csQna" + csQna );
		
		// 페이지번호와 
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("csInfo", csInfo);
		
		
		return "admin/admin_cs_qna_form";
	}	
	
	// 관리자페이지 1:1 질문 답글 등록 후 게시판 이동
	@RequestMapping(value="admin_cs_qna_pro" , method = {RequestMethod.GET, RequestMethod.POST})
	public String adminCsQnaPro(HttpSession session, Model model
			, @RequestParam(defaultValue = "1", name = "pageNo") int pageNo
			, @RequestParam(defaultValue = "2") int csTypeNo
			, @ModelAttribute("qnaInfo") CsInfoVO qnaInfo) {
		
//		System.out.println("pageNo : " + pageNo + ", qnaInfo : " + qnaInfo);
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		

		
		// 답변 등록을 위한 update 서비스
		int updateCount = admin_service.quaReply(csTypeNo, qnaInfo);
		
		if(updateCount > 0 ) { // 답변 등록 성공 시
			model.addAttribute("pageNo", pageNo);
			// 1:1 질문 관리 게시판으로 이동
			return "redirect:/admin_cs_qna";
		} else {
//			System.out.println("quaReply - update 실패!");
			model.addAttribute("msg", "답변 등록이 실패하였습니다!");
			return "fail_back";
		}
		
		

	}	
	
	// 관리자페이지 자주묻는 질문 관리 게시판 목록
	@GetMapping("admin_cs_faq")
	public String adminCsFaq(HttpSession session, Model model
			, @RequestParam(defaultValue = "3") int csTypeNo
			, @RequestParam(defaultValue = "전체") String cs_type_keyword
			, @RequestParam(defaultValue = "1") int pageNo) {

		System.out.println(cs_type_keyword);
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		
		// --------------------------페이징 작업 ----------------------------------



		int listLimit = 10;// 한 페이지에 보여줄 목록 수
		
		// 조회 시작 행(레코드) 번호 계산
		int startRow = (pageNo - 1) * listLimit;
		
		int startPage = ((pageNo - 1) / listLimit) * listLimit + 1; // 시작할 페이지
//		System.out.println("startPage: " + startPage);
		int endPage = startPage + listLimit -1; // 끝페이지
		int listCount = admin_service.getCsTotalPageCountKeyword(listLimit, csTypeNo, cs_type_keyword);
		
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
			endPage = maxPage;
		}
//		System.out.println("어드민 컨트롤러 공지사항 스타트페이지" + startPage +", 엔드 페이지:"+ endPage);
		// --------------------------------------------------------------------------
		
		// 공지사항 목록 조회
		List<CsInfoVO> csInfoList = admin_service.getCsListKeyword(pageNo, listLimit, startRow, csTypeNo, cs_type_keyword);
		
		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, listLimit, maxPage, startPage, endPage);
		
//		System.out.println("CsFaqList : " + CsFaqList);
//		System.out.println("pageInfo : " + pageInfo);
		
		// 글목록, 페이징 정보 저장
		model.addAttribute("csInfoList", csInfoList);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageInfo", pageInfo);
		
		
		
		
		return "admin/admin_cs_faq_list";
	}
	
	// 관리자페이지 자주묻는 질문 글쓰기 폼 이동
	@GetMapping("admin_cs_faq_form")
	public String adminCsFaqForm(HttpSession session, Model model, @RequestParam(name="pageNo", defaultValue = "1") int pageNo) {

		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		
		// 페이지 정보 저장
		model.addAttribute("pageNo", pageNo);
		
		return "admin/admin_cs_faq_form";
	}
	
	// 관리자페이지 자주묻는 질문 글쓰기 등록 후 게시판 이동
	@PostMapping("admin_cs_faq_pro")
	public String adminCsFaqPro(HttpSession session, Model model
			, @RequestParam( defaultValue = "1", name = "pageNo") int pageNo
			, @ModelAttribute("faqInfo") CsInfoVO faqInfo
			, @RequestParam int csTypeNo) {
		
//		System.out.println("faqInfo: " + faqInfo);
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		
		
		// 자주 묻는 질문 게시판 변수명 설정(1=공지사항, 2=1:1게시판, 3=자주묻는질문)
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
		
		
		
		// 이클립스 프로젝트 상에 업로드 폴더(upload) 생성 필요 
		// => 주의! 외부에서 접근하도록 하려면 resources 폴더 내에 upload 폴더 생성
		// 이클립스가 관리하는 프로젝스 상의 가상 업로드 경로에 대한 실제 업로드 경로 알아내기
		// => request.getRealPath() 대신 request.getServletContext.getRealPath() 메서드 또는
		//    세션 객체를 활용한 session.getServletContext().getRealPath() 메서드 사용
//		System.out.println(request.getRealPath("/resources/upload")); // Deprecated 처리된 메서드
		String uploadDir = "/resources/upload"; 
//		String saveDir = request.getServletContext().getRealPath(uploadDir); // 사용 가능
		String saveDir = session.getServletContext().getRealPath(uploadDir);
//		System.out.println("실제 업로드 경로 : "+ saveDir);
		// 실제 업로드 경로 : D:\Shared\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload
		
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			// ------------------------------------------------------------------------------
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
//		System.out.println(date);
			// => 디렉토리 구조로 바로 활용하기 위해 날짜 구분 기호를 슬래시(/)로 지정
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			// 3. 기존 업로드 경로에 날짜 경로 결합하여 저장
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			// --------------------------------------------------------------
			// java.nio.file.Paths 클래스의 get() 메서드를 호출하여
			// => 파라미터 : 실제 업로드 경로
			Path path = Paths.get(saveDir);
			
			// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// BoardVO 객체에 전달된 MultipartFile 객체 꺼내기
		MultipartFile mFile1 = faqInfo.getFile1();
//		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
		
		// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
		String uuid = UUID.randomUUID().toString();
//		System.out.println("uuid : " + uuid);
		
		//  파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
		faqInfo.setCs_file("");
		
		// 파일명을 저장할 변수 선언
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			faqInfo.setCs_file(subDir + "/" + fileName1);
		}
		

		
//		System.out.println("실제 업로드 파일명1 : " + faqInfo.getCs_file());
		
		// -----------------------------------------------------------------------------------
		// BoardService - registBoard() 메서드를 호출하여 게시물 등록 작업 요청
		// => 파라미터 : BoardVO 객체    리턴타입 : int(insertCount)
		int insertCount = admin_service.registCs(csTypeNo, faqInfo);
		
		
		// 게시물 등록 작업 요청 결과 판별
		if(insertCount > 0) { // 성공
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 자주묻는 질문 게시판(admin_cs_faq)으로 리다이렉트
			return "redirect:/admin_cs_faq";
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "fail_back";
		}

	}

	
	
	// 관리자페이지 자주묻는 질문 글수정 폼 이동
	// csTypeNo = 1 공지, 2 1:1게시판, 3 자주묻는 질문 
	// 이전 등록된 정보 가져오기
	@GetMapping("admin_cs_faq_modify_form")
	public String adminCsFaqModifyForm(HttpSession session, Model model
			, @RequestParam(defaultValue = "1") int pageNo
			, @RequestParam int cs_type_list_num
			, @RequestParam(defaultValue = "3") int csTypeNo) {

		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		
	
		// 1:1 질문 정보 가져오기
		// 파라미터값 : cs_type_list_num
		CsInfoVO csInfo = admin_service.getCsInfo(csTypeNo, cs_type_list_num);
//		System.out.println("어드민컨트롤러 csQna" + csQna );
		
		// 페이지번호와 
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("csInfo", csInfo);
		
		return "admin/admin_cs_faq_modify_form";
	}
	
	// 관리자페이지 자주묻는 질문 글수정 등록 후 게시판 이동
	// csTypeNo = 1 공지, 2 1:1게시판, 3 자주묻는 질문 
	@PostMapping("admin_cs_faq_modify_pro")
	public String adminCsFaqModifyPro(HttpSession session, Model model
			, @RequestParam( defaultValue = "1", name = "pageNo") int pageNo
			, @ModelAttribute("noticeInfo") CsInfoVO faqInfo
			, @RequestParam int csTypeNo) {

		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		
		

		
//		System.out.println(request.getRealPath("/resources/upload")); // Deprecated 처리된 메서드
		String uploadDir = "/resources/upload"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
//		System.out.println("실제 업로드 경로 : "+ saveDir);
		
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			// ------------------------------------------------------------------------------
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
//		System.out.println(date);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			// 3. 기존 업로드 경로에 날짜 경로 결합하여 저장
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			// --------------------------------------------------------------
			// => 파라미터 : 실제 업로드 경로
			Path path = Paths.get(saveDir);
			
			// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mFile1 = faqInfo.getFile1();
//		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
		
		// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
		String uuid = UUID.randomUUID().toString();
//		System.out.println("uuid : " + uuid);
		
		faqInfo.setCs_file("");
		
		// 파일명을 저장할 변수 선언
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			faqInfo.setCs_file(subDir + "/" + fileName1);
		}
		

		
//		System.out.println("실제 업로드 파일명1 : " + faqInfo.getCs_file());
		
		// -----------------------------------------------------------------------------------
		// => 파라미터 : csTypeNo, faqInfo 객체    리턴타입 : int(updateCount)
		int updateCount = admin_service.updateCs(csTypeNo, faqInfo);
		
		
		// 게시물 등록 작업 요청 결과 판별
		if(updateCount > 0) { // 성공
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 자주묻는 질문 게시판(admin_cs_faq)으로 리다이렉트
			return "redirect:/admin_cs_faq";
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "fail_back";
		}
		
		
		
		

	}	
	
	
	
	
//	관리자 - 회원관리 - 정의효 
	@GetMapping("admin_member_list")
	public String adminMemberList(
			HttpSession session,
			@RequestParam(defaultValue = "") String memberSearchType,
			@RequestParam(defaultValue = "") String memberSearchKeyword,
			@RequestParam(defaultValue = "1") int pageNo, 
			Model model) {
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
	
            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		
		int listLimit = 10; // 한 페이지에 보여줄 게시물 수
		
		// 조회 시작 행(레코드) 번호 계산
		int startRow = (pageNo - 1) * listLimit;
		
		// 회원 목록 조회
		List<MemberVO> memberList = member_service.getMemberList(memberSearchType, memberSearchKeyword, startRow, listLimit);
		
		int listCount = member_service.getMemberListCount(memberSearchType, memberSearchKeyword);
		
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
		
		// oneperson 뒤로가기 - 기존페이지 및 검색정보 저장을 위한 값들 세션에 저장		
		// pageNo 값을 세션에 저장
	    session.setAttribute("pageNo", pageNo);
		// memberSearchType 값을 세션에 저장		
	    session.setAttribute("memberSearchType", memberSearchType);
	    // memberSearchKeyword 값을 세션에 저장		
	    session.setAttribute("memberSearchKeyword", memberSearchKeyword);
	    
	    
	    
		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageInfo", pageInfo);
//		System.out.println(memberList);
		
		return "admin/admin_member_list";
	}
	
	// 관리자 - 회원상세 - 정의효
		@GetMapping("admin_member_oneperson")
		public String adminMemberOneperson(
		        HttpSession session,
		        @RequestParam String member_id,
		        Model model,
		        HttpServletRequest request) {

		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
	
            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }	
			
			
			MemberVO member = member_service.getMemberWithGradeName(member_id);
			model.addAttribute("member", member);
			
			return "admin/admin_member_oneperson";
		}
	
	
//	관리자 - 영화관리 - 정의효
	@GetMapping("admin_movie_management")
	public String adminMovieManagement(
						HttpSession session,
						@RequestParam(defaultValue = "") String movieSearchKeyword,
						@RequestParam(defaultValue = "1") int pageNo, 
						Model model) {
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		
		
		
		int listLimit = 10; // 한 페이지에 보여줄 게시물 수
		
		// 조회 시작 행(레코드) 번호 계산
		int startRow = (pageNo - 1) * listLimit;
		
		// 회원 목록 조회
		List<MovieVO> movieList = movie_service.getmovieList(movieSearchKeyword, startRow, listLimit);
		
		int listCount = movie_service.getMovieListCount(movieSearchKeyword);
		
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
		
		model.addAttribute("movieList", movieList);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageInfo", pageInfo);
		System.out.println(movieList);
		
		
		return "admin/admin_movie_management";
	}
	
//	관리자 - 영화상세 - 정의효
	@GetMapping("admin_movie_detail")
	public String adminMemberOneperson(HttpSession session, @RequestParam int movie_num, Model model) {

		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		
		
		
		MovieVO movie = movie_service.getMovie(movie_num);
		model.addAttribute("movie", movie);
		
		return "admin/admin_movie_detail";
	}
	
	// 관리자 - 영화관리 - 등록페이지 - 정의효
	@GetMapping("admin_movie_regist")
	public String adminMovieRegist(HttpSession session, Model model) {

		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		
		
		
		return "admin/admin_movie_regist";
	}
	
	// 관리자 영화관리 - 등록페이지 - 등록하기 - 정의효
	@PostMapping("admin_movie_regist_Pro")
	public String adminMovieRegistPro(HttpSession session, @DateTimeFormat(pattern = "yyyy-MM-dd") MovieVO movie, Model model) {
		System.out.println(movie);
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		
		
		
		int insertCount = movie_service.registMovie(movie);
		
		
		
		return "redirect:/admin_movie_management";
	}
	
	// 관리자 - 결제관리 - 정의효
	@GetMapping("admin_payment_list")
	public String adminPaymentList(
						HttpSession session,
						@RequestParam(defaultValue = "") String paymentSearchKeyword,
						@RequestParam(defaultValue = "1") int pageNo, 
						Model model) {
		
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우

            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }		
		
		int listLimit = 10; // 한 페이지에 보여줄 게시물 수
		
		// 조회 시작 행(레코드) 번호 계산
		int startRow = (pageNo - 1) * listLimit;
		
		// 회원 목록 조회
		List<PaymentVO> paymentList = payment_service.getPaymentList(paymentSearchKeyword, startRow, listLimit);
		
		int listCount = payment_service.getPaymentListCount(paymentSearchKeyword);
		
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
		
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageInfo", pageInfo);
		
		System.out.println(paymentList);
		return "admin/admin_payment_list";
	}
	

	
	
	// 관리자 - 결제상세 - 정의효
	@PostMapping("admin_payment_list_detail")
	public String adminPaymentListDetail(HttpSession session, @RequestParam String order_num, @RequestParam String payment_num, Model model) {
		
		// 직원 세션이 아닐 경우 잘못된 접근 처리
			String member_type = (String)session.getAttribute("member_type");
			System.out.println(member_type);
			if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
		
	            model.addAttribute("msg", "잘못된 접근입니다!");
	            return "fail_back";
	        }
		
		List<PaymentVO> paymentDetail = payment_service.getPaymentDetail(order_num, payment_num);
		model.addAttribute("paymentDetail", paymentDetail);
		
		
		return "admin/admin_payment_list_detail";
	}
	
	// 관리자 - 회원등급변경 - 정의효
	@PostMapping("admin_changeMemberGrade")
	public String adminChangeMemberGrade(HttpSession session, @RequestParam String grade_name, @RequestParam String member_id, Model model) {
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
	
            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		System.out.println(grade_name);
	    member_service.changeMemberGrade(grade_name, member_id);
	    model.addAttribute("member_id", member_id); // 변경후 리다이렉트를 위해 전달하는 member_id model객체에 저장
	    return "redirect:/admin_member_oneperson";
	}

	// 관리자 - 회원상태변경 - 정의효
	@PostMapping("admin_changeMemberStatus")
	public String adminChangeMemberStatus(HttpSession session, @RequestParam String member_status, @RequestParam String member_id, Model model) {
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
	
            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		System.out.println(member_status);
		member_service.changeMemberStatus(member_status, member_id);
		model.addAttribute("member_id", member_id);
		return "redirect:/admin_member_oneperson";
	}
    
	// 관리자 - 회원삭제 - 정의효
	@PostMapping("admin_memberDelete")
	public String adminMemberDelete(HttpSession session, @RequestParam String member_id, Model model) {
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
	
            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		member_service.memberDelete(member_id);
		return "redirect:/admin_member_list";
	}
		
	// 관리자 - 영화삭제 - 정의효
	@PostMapping("admin_movieDelete")
	public String adminMovierDelete(HttpSession session, @RequestParam String movie_num, Model model) {
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
	
            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		movie_service.movieDelete(movie_num);
		return "redirect:/admin_movie_management";
	}
		
	// 관리자 - 영화수정 - 정의효
	@PostMapping("admin_movie_modify")
	public String adminMovieModify(HttpSession session, @ModelAttribute MovieVO movie, Model model) {
		// 직원 세션이 아닐 경우 잘못된 접근 처리
		String member_type = (String)session.getAttribute("member_type");
		System.out.println(member_type);
		if(member_type == null || !member_type.equals("직원")) { // 미로그인 또는 "직원"이 아닐 경우
	
            model.addAttribute("msg", "잘못된 접근입니다!");
            return "fail_back";
        }
		movie_service.movieModify(movie);
		
		System.out.println(movie);
		return "redirect:/admin_movie_management";
	}
	
	// 관리자 - 영화등록 - 중복검사 - 정의효
	@GetMapping("checkMovie")
	public void checkMovie(
				@RequestParam String movie_name_kr,
				HttpServletResponse response,
				HttpSession session)throws IOException {
	    // 직원 세션 확인
	    String member_type = (String) session.getAttribute("member_type");
	    if (member_type == null || !member_type.equals("직원")) {
	        return;
	    }

	    boolean isMovieAlreadyRegistered = movie_service.isMovieAlreadyRegistered(movie_name_kr);
	    response.setContentType("text/plain");
	    response.getWriter().write(isMovieAlreadyRegistered ? "true" : "false");
	    System.out.println(isMovieAlreadyRegistered);
	}
    
	
}

























