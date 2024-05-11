package com.itwillbs.dongbaekcinema.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.dongbaekcinema.service.AdminService;
import com.itwillbs.dongbaekcinema.service.ReservationService;
import com.itwillbs.dongbaekcinema.service.TheaterService;
import com.itwillbs.dongbaekcinema.vo.ScheduleVO;
import com.itwillbs.dongbaekcinema.vo.SnackVO;
import com.itwillbs.dongbaekcinema.vo.TheaterVO;
import com.itwillbs.dongbaekcinema.vo.TicketTypeVO;
import com.itwillbs.dongbaekcinema.voNew.CsInfoVO;

@Controller
public class TheaterController {
	
	@Autowired
	private TheaterService service;
	
	@Autowired
	private AdminService admin_service;
	
	
	//영화관 메인
	@GetMapping("theater_main")
	public String theater_main(Model model) {
		//영화관 목록  조회
		List<TheaterVO> theaterList = service.getTheaterList();
		
		model.addAttribute("theaterList", theaterList);

		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = listLimit; // 조회 시작 행(레코드) 번호 (다섯개만 보여줄거임)
		
		// 공지사항 목록 조회
		List<CsInfoVO> csInfoList = admin_service.getCsList(1, listLimit, startRow, 1);
		
		model.addAttribute("csInfoList", csInfoList);
		
		
		
		return "theater/theater_main";
	}

	//영화관 정보 
	@ResponseBody
	@GetMapping("getTheater")
	public Object getTheater(int theater_num, Model model) {
//		System.out.println(theater_num);
		TheaterVO theater=service.getTheater(theater_num);
			
//		System.out.println(theater);
		return theater;
	}
	
	//관별 상영 시간표
	@PostMapping("getSchedule")
	public String getSchedule(int theater_num, String play_date, Model model) {
		System.out.println("getSchedule");
		System.out.println(theater_num);
		System.out.println(play_date);
		List<ScheduleVO> scheduleList = service.getSchedule(theater_num,play_date);
		model.addAttribute("scheduleList",scheduleList);
		System.out.println(scheduleList);

		return "theater/runningtime_tap_ajax";
	}
	@GetMapping("theater-price_tap")
	public String theater_price_tap(Model model) {
		List<TicketTypeVO> ticketList = service.getTicketList();
		System.out.println(ticketList);
		model.addAttribute("ticketList", ticketList);
		return "theater/theater-price_tap";
	}
	@GetMapping("theater-runningtime_tap")
	public String theater_runningtime_tap(Model model) {
		List<TheaterVO> theaterList = service.getTheaterList();
		System.out.println(theaterList);
		
		LocalDate currentdate = LocalDate.now();
		LocalDate maxdate=currentdate.plusDays(10);

		
		
		model.addAttribute("theaterList", theaterList);
		model.addAttribute("currentdate", currentdate);
		model.addAttribute("maxdate", maxdate);
		
		return "theater/theater-runningtime_tap";
	}
	

}
