package com.itwillbs.dongbaekcinema.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.dongbaekcinema.vo.PlayVO;
import com.itwillbs.dongbaekcinema.vo.SnackVO;
import com.itwillbs.dongbaekcinema.vo.RoomVO;
import com.itwillbs.dongbaekcinema.vo.OrderTicketVO;
import com.itwillbs.dongbaekcinema.vo.OrderVO;
import com.itwillbs.dongbaekcinema.vo.PaymentVO;
import com.itwillbs.dongbaekcinema.voNew.GradeNextVO;
import com.itwillbs.dongbaekcinema.voNew.ReservationVO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import com.itwillbs.dongbaekcinema.service.MemberService;
import com.itwillbs.dongbaekcinema.service.MypageService;
import com.itwillbs.dongbaekcinema.service.PayService;
import com.itwillbs.dongbaekcinema.service.ReservationService;
import com.itwillbs.dongbaekcinema.service.StoreService;
import com.itwillbs.dongbaekcinema.vo.MemberVO;
import com.itwillbs.dongbaekcinema.vo.MovieVO;
import com.itwillbs.dongbaekcinema.vo.OrderSnackVO;
import com.itwillbs.dongbaekcinema.vo.TheaterVO;
import com.itwillbs.dongbaekcinema.vo.TicketTypeVO;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService service;
	
	@Autowired
	private StoreService service2;
	
	@Autowired
	private MypageService service3;
	@Autowired
	private MemberService service4;
	@Autowired
	private PayService payservice;
	
	// 네비바의 [예매] 클릭 시 
	// reservation_main 요청에 의해 "reservation_main/reservation_main.jsp" 페이지로 포워딩
	// 포워딩 시 reservation_main.jsp의 [영화선택] 영역에 
	// 접속일 기준 10일이내에 상영하는 영화목록을 예매율순으로 출력
	@GetMapping("reservation_main")
	public String reservation_main(Model model) {
		System.out.println("ReservationController - reservation_main");
		
		// ReservationService - getMovieListDescBookingRate() 메서드를 호출하여
		// MOVIES 테이블에서 접속일 기준 10일이내에 상영하는 영화목록을 예매율순으로 조회
		// => 파라미터 : 없음   리턴타입 : List<MovieVO>(movieList)
		List<MovieVO> movieList = service.getMovieListDescBookingRate();
//		System.out.println(movieList);
		model.addAttribute("movieList", movieList);
				
		return "reservation/reservation_main";
	}

	// reservation_main.jsp의 [예매율순] 클릭 시
	// descBookingRate 요청에 의해 reservation_main.jsp의 [영화선택] 영역에 
	// 접속일에 상영중인 영화목록을 예매율순으로 출력
	@ResponseBody
	@GetMapping(value = "DescBookingRate", produces = "application/json;charset=utf-8")
	public List<MovieVO> DescBookingRate(Model model) {
		System.out.println("ReservationController - DescBookingRate");
		
		// ReservationService - getMovieListDescBookingRate() 메서드를 호출하여
		// MOVIES 테이블에서 접속일 기준 10일이내에 상영하는 영화목록을 예매율순으로 조회
		// => 파라미터 : 없음   리턴타입 : List<MovieVO>(movieList)
		List<MovieVO> movieList = service.getMovieListDescBookingRate();
//		System.out.println(movieList);
		model.addAttribute("movieList", movieList);
		
		return movieList;
	}
	
	// reservation_main.jsp의 [가나다순] 클릭 시
	// ascMovieName 요청에 의해 reservation_main.jsp의 [영화선택] 영역에 
	// 접속일에 상영중인 영화목록을 가나다순으로 출력
	@ResponseBody
	@GetMapping(value = "AscMovieName", produces = "application/json;charset=utf-8")
	public List<MovieVO> AscMovieName(Model model) {
		System.out.println("ReservationController - AscMovieName");
		
		// ReservationService - getMovieListAscMovieName() 메서드를 호출하여
		// MOVIES 테이블에서 접속일에 상영중인 영화목록을 가나다순으로 조회
		// => 파라미터 : 없음   리턴타입 : List<MovieVO>(movieList)
		List<MovieVO> movieList = service.getMovieListAscMovieName();
//		System.out.println(movieList);

		model.addAttribute("movieList", movieList);
		
		return movieList;
	}
	
	// reservation_main.jsp의 [영화명] 클릭 시 극장명 출력되도록
	// TheaterList 요청에 의해 reservation_main.jsp의 [극장선택] 영역에 
	// 선택한 영화를 접속일 기준 10일이내에 상영하는 극장 목록 출력
	@ResponseBody
	@RequestMapping(value = "TheaterList", method= {RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=utf-8")
	public List<TheaterVO> TheaterList(int movie_num, Model model) {
		System.out.println("ReservationController - TheaterList");
		
		// ReservationService - getTheaterList() 메서드를 호출하여
		// THEATERS 테이블에서 선택한 영화를 접속일 기준 10일이내에 상영하는 극장 조회
		// => 파라미터 : movie_num   리턴타입 : List<TheaterVO>(theaterList)
		List<TheaterVO> theaterList = service.getTheaterList(movie_num);
		model.addAttribute("theaterList", theaterList);		
		System.out.println(theaterList);		
		
		return theaterList;
	}
	
	// reservation_main.jsp의 [날짜] 클릭 시 시간 정보 출력
	// PlayList 요청에 의해 reservation_main.jsp의 [시간선택] 영역에 
	// 선택한 영화를 선택한 극장에서 선택한 날짜에 상영하는 시간과 상영관 목록 출력
	@ResponseBody
	@RequestMapping(value = "PlayList", method= {RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=utf-8")
	public String PlayList(@RequestParam int movie_num, @RequestParam int theater_num, @RequestParam String play_date, Model model) {
		System.out.println("ReservationController - PlayList");
		
//			TheaterVO theater = service.getTheater(theater_num);
//			model.addAttribute("theater", theater);
		
		// ReservationService - getTheaterList() 메서드를 호출하여
		// PLAYS 테이블에서 선택한 영화를 선택한 극장에서 선택한 날짜에 상영하는 시간과 상영관 조회
		// => 파라미터 : movie_num, theater_num, play_date  리턴타입 : List<PlayVO>(playList)
		List<Map<String, Object>> playList = service.getPlayList(movie_num, theater_num, play_date);
		model.addAttribute("playList", playList);		
		System.out.println(playList);		

		JSONArray ja = new JSONArray(playList);
		System.out.println(ja);
		return ja.toString();
	}
	

	// reservation_seat 요청에 의해 "reservation_seat.jsp" 페이지로 포워딩
	// 포워딩 시 상영번호에 해당하는 상영정보를 [선택정보] 영역에 출력
	@RequestMapping(value = "reservation_seat", method= {RequestMethod.GET, RequestMethod.POST})
	public String reservation_seat(@RequestParam(defaultValue = "0") int play_num, Model model, HttpSession session) {
		System.out.println("ReservationController - Play()");
		System.out.println(play_num);
		
		// 세션 아이디가 존재하지 않으면(미로그인) "잘못된 접근입니다!"출력 후 이전 페이지로 돌아가기 처리
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null || play_num == 0) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("targetURL", "./");
//			model.addAttribute("msg", " 로그인이 필요합니다!");
//			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
		session.setAttribute("play_num", play_num);
		
		// ReservationService - getPlay() 메서드를 호출하여
		// PLAYS 테이블에서 선택한 상영번호에 해당하는 상영정보 조회
		// => 파라미터 : play_num  리턴타입 : PlayVO(play)
		ReservationVO reservation = service.getPlay(play_num);
		model.addAttribute("reservation", reservation);
		System.out.println(reservation);
		
		return "reservation/reservation_seat";
	}

	@ResponseBody
	@RequestMapping(value = "SelectPeople", method= {RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=utf-8")
	public String SelectPeople(@RequestParam String play_num, Model model) {
		System.out.println("ReservationController - SelectPeople()");
		System.out.println(play_num);
		
		// ReservationService - getOrderTicket() 메서드를 호출하여
		// PLAYS 테이블에서 선택한 상영번호에 해당하는 상영정보 조회
		// => 파라미터 : play_num  리턴타입 : List<OrderTicketVO>(orderticketList)
		int playNum = Integer.parseInt(play_num);
		List<OrderTicketVO> orderTicketList = service.getOrderTicket(playNum);
		model.addAttribute("orderTicketList", orderTicketList);
		System.out.println(orderTicketList);
		
		JSONArray ja = new JSONArray(orderTicketList);
		System.out.println(ja);
		return ja.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "GetTicketPrice", method= {RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=utf-8")
	public String GetTicketPrice(@RequestParam String play_time_type, Model model, HttpSession session) {
		System.out.println("ReservationController - GetTicketPrice()");
		System.out.println(play_time_type);
		
		// ReservationService - getTicketPriceList() 메서드를 호출하여
		// PLAYS 테이블에서 선택한 상영번호에 해당하는 상영정보 조회
		// => 파라미터 : play_time_type  리턴타입 : List<OrderTicketVO>(ticketPriceList)
		List<TicketTypeVO> ticketPriceList = service.getTicketPriceList(play_time_type);
//		model.addAttribute("ticketPriceList", ticketPriceList);
		session.setAttribute("ticketPriceList", ticketPriceList);
		System.out.println(ticketPriceList);

		JSONArray ja = new JSONArray(ticketPriceList);
		System.out.println(ja);
		return ja.toString();
	}
	
	
	@GetMapping("reservation_ing")
    public String reservation_ing(int play_num,String seat_name,String ticket_type_num,String snack_num,String snack_quantity,HttpSession session,HttpServletRequest request,Model model) {
        //잘못된 접근처리
        String beforePage =(String)request.getHeader("REFERER");
        if(beforePage==null) {
            model.addAttribute("msg", "잘못된 접근");
            model.addAttribute("targetURL", "./");

            return "fail_location";
        }
        //세션 끊겼을때 처리
        String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 세션이 만료되었습니다");
			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
        
       
        List<TicketTypeVO> ticketPriceList = new ArrayList<TicketTypeVO>();
		String ticketlist[] =ticket_type_num.split(","); // ticket_type_num ,로 나눠 배열 저장
		
			int ticketTotalPrice=0;
			int i=0;
		   for(String ticket : ticketlist) {
			   int ticket_num=Integer.parseInt(ticket);
			   TicketTypeVO ticketType = service.getTicketPriceListByNum(ticket_num);
			   ticketPriceList.add(ticketType);
			   ticketTotalPrice+=ticketPriceList.get(i).getTicket_type_price();
			   i++;
	        }
		  
		   System.out.println(ticketTotalPrice);
		   
		   model.addAttribute("ticketPriceList", ticketPriceList);
       
		   List<SnackVO> snackNumlist = new ArrayList<SnackVO>();
		   int snackTotalPrice=0;
		   if(!snack_num.equals("")) {
			   String snacklist[]=snack_num.split(",");
			   int i2=0;
			   int snackquantitylist [] = Stream.of(snack_quantity.split(",")).mapToInt(Integer::parseInt).toArray();//문자열 ,단위로 나눠 int 타입 배열로 저장 
			   for(String snack : snacklist) {
				   int snackNum=Integer.parseInt(snack);
				   SnackVO snacks=service2.getSnackListByNum(snackNum);
				   snackNumlist.add(snacks);
				   snackTotalPrice+=snackNumlist.get(i2).getSnack_price()*snackquantitylist[i2];
				   i2++;
			   };
			  
			  
			   model.addAttribute("snackNumlist", snackNumlist);
			   model.addAttribute("snackquantitylist", snackquantitylist);
		   }
		   
		   List<Integer> seatNumList=new ArrayList<Integer>();
	       String seatlist[] =seat_name.split(",");
	        for(String seat : seatlist) {
	        	int seatnum=service.getSeatNumListByName(seat);
	        	seatNumList.add(seatnum);
	        }
	        model.addAttribute("seatNumList", seatNumList); 
			   
		int beforeTotalprice=ticketTotalPrice+snackTotalPrice;
		model.addAttribute("beforeTotalprice", beforeTotalprice);  
        
        
		
		MemberVO member=service.getMember(member_id);
		GradeNextVO member_grade=service3.getMyGrade(member_id);
		int discount=(int) (ticketTotalPrice*member_grade.getGrade_discount());
		
		ReservationVO reservation = service.getPlay(play_num);
		model.addAttribute("reservation", reservation);
		model.addAttribute("member", member);
		model.addAttribute("member_grade", member_grade);
		int totalprice=ticketTotalPrice-discount+snackTotalPrice;
		model.addAttribute("totalprice", totalprice);
//		System.out.println(member);
//		System.out.println(member_grade);
		return "reservation/reservation_ing";
	}
	
	@GetMapping("reservation_check")
	public String reservation_check(int play_num,String snack_num,String snack_quantity,HttpSession session,HttpServletRequest request,Model model) {
		//잘못된 접근처리
		String beforePage =(String)request.getHeader("REFERER");
		if(beforePage==null) {
			model.addAttribute("msg", "잘못된 접근");
			model.addAttribute("targetURL", "./");
							
			return "fail_location";
		}
		//세션 끊겼을때 처리
        String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 세션이 만료되었습니다");
			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
		ReservationVO reservation = service.getPlay(play_num);
		model.addAttribute("reservation", reservation);
		
		MemberVO member=service4.getMember(member_id);
		model.addAttribute("member", member);
		
		 List<SnackVO> snackNumlist = new ArrayList<SnackVO>();
		  
		 if(!snack_num.equals("")) {
			 String snacklist[]=snack_num.split(",");
			  
			   for(String snack : snacklist) {
				   int snackNum=Integer.parseInt(snack);
				   SnackVO snacks=service2.getSnackListByNum(snackNum);
				   snackNumlist.add(snacks);
			   };  
			model.addAttribute("snackNumlist", snackNumlist);
			int snackquantitylist [] = Stream.of(snack_quantity.split(",")).mapToInt(Integer::parseInt).toArray();//문자열 ,단위로 나눠 int 타입 배열로 저장 
			model.addAttribute("snackquantitylist", snackquantitylist);
		   }
		
		return "reservation/reservation_check";
	}
	
	@GetMapping("reservation_snack")
	public String reservation_snack(int play_num,String ticket_type_num,HttpSession session, HttpServletRequest request, Model model) {
		//잘못된 접근처리
		String beforePage =(String)request.getHeader("REFERER");
		if(beforePage==null) {
			model.addAttribute("msg", "잘못된 접근");
			model.addAttribute("targetURL", "./");
			
			return "fail_location";
		}
		//세션 끊겼을때 처리
        String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 세션이 만료되었습니다");
			model.addAttribute("targetURL", "member_login_form");
			
			return "fail_location";
		}
		List<TicketTypeVO> ticketPriceList = new ArrayList<TicketTypeVO>();
		String ticketlist[] =ticket_type_num.split(","); // ticket_type_num ,로 나눠 배열 저장
		   for(String ticket : ticketlist) {
			   int ticket_num=Integer.parseInt(ticket);
			   TicketTypeVO ticketType = service.getTicketPriceListByNum(ticket_num);
			   ticketPriceList.add(ticketType);
	        }
		   
		   model.addAttribute("ticketPriceList", ticketPriceList);

		List<SnackVO> snackList = service2.getSnackList();

		model.addAttribute("snackList", snackList);
		
		ReservationVO reservation = service.getPlay(play_num);
		model.addAttribute("reservation", reservation);
		

		
		return "reservation/reservation_snack";
	}
	@RequestMapping(value ="complete", method = RequestMethod.POST)
	@ResponseBody
	public int paymentComplete(String seat_name,String snack_num_param,String snack_quantity_param,String ticket_type_num_param,OrderSnackVO snack,OrderVO order,OrderTicketVO ticket,PaymentVO payment,HttpSession session
			) throws Exception {
		
			
			int res = 1;
			String token = payservice.getToken();
			String seatlist[] =seat_name.split(",");
			List<Integer> seatNumList=new ArrayList<Integer>();
	        int ticket_num [] = Stream.of(ticket_type_num_param.split(",")).mapToInt(Integer::parseInt).toArray();
	        for(String seat : seatlist) {
	        	int seatnum=service.getSeatNumListByName(seat);
	        	seatNumList.add(seatnum);
	        }
	       
	        List<OrderTicketVO> orderTicketList = service.getOrderTicket(ticket.getPlay_num());
	        
	        for(OrderTicketVO seat:orderTicketList) {//이미 예약된 좌석인지 검증
	        	for(int seat2: seatNumList) {
    				if(seat2==seat.getSeat_num()) {
    					res = 0;
    					payservice.payMentCancle(token, payment.getPayment_num(), Integer.parseInt(payment.getPayment_total_price()),"결제실패");//결제취소
    					return res;
    				}
    	}
	        	
	        }
	        
	        
		    
		    List<TicketTypeVO> ticketPriceList = new ArrayList<TicketTypeVO>();
			String ticketlist[] =ticket_type_num_param.split(","); // ticket_type_num ,로 나눠 배열 저장
			
				int ticketTotalPrice=0;
				int i=0;
			   for(String ticketpPrice : ticketlist) {
				   int ticketNum=Integer.parseInt(ticketpPrice);
				   TicketTypeVO ticketType = service.getTicketPriceListByNum(ticketNum);
				   ticketPriceList.add(ticketType);
				   ticketTotalPrice+=ticketPriceList.get(i).getTicket_type_price();
				   i++;
		        };


		    List<SnackVO> snackNumlist = new ArrayList<SnackVO>();
			   int snackTotalPrice=0;
			   if(!snack_num_param.equals("")) {
				   String snacklist[]=snack_num_param.split(",");
				   int i2=0;
				   int snackquantitylist [] = Stream.of(snack_quantity_param.split(",")).mapToInt(Integer::parseInt).toArray();//문자열 ,단위로 나눠 int 타입 배열로 저장 
				   for(String snackprice : snacklist) {
					   int snackNum=Integer.parseInt(snackprice);
					   SnackVO snacks=service2.getSnackListByNum(snackNum);
					   snackNumlist.add(snacks);
					   snackTotalPrice+=snackNumlist.get(i2).getSnack_price()*snackquantitylist[i2];
					   i2++;
				   };
			   }

			GradeNextVO member_grade=service3.getMyGrade((String) session.getAttribute("member_id"));
			int discount=(int)(ticketTotalPrice*member_grade.getGrade_discount());


			int totalprice=ticketTotalPrice-discount+snackTotalPrice;
		    
			String amount = payservice.paymentInfo(payment.getPayment_num(), token);
			if(totalprice!=Integer.parseInt(amount) ) {//결제금액 실제 총가격과 비교검증
				res = 0;
				payservice.payMentCancle(token, payment.getPayment_num(), Integer.parseInt(payment.getPayment_total_price()),"결제실패");//결제취소
				return res;
			}
		    

		    service.registOrder(order); //주문정보 저장
		    service.registPayment(payment);//결제정보 저장
		    
		    int i3=0;
		    for(int seat:seatNumList) {
	        	ticket.setSeat_num(seat);
	        	ticket.setTicket_type_num(ticket_num[i3]);
	        	service.registTicket(ticket);//티켓정보 저장
	        	i3++;
	        }
		    
		    if(!snack_num_param.equals("")) {//스낵구매시에만
				int snackNum[]=Stream.of(snack_num_param.split(",")).mapToInt(Integer::parseInt).toArray();
				int snackQuantity[]=Stream.of(snack_quantity_param.split(",")).mapToInt(Integer::parseInt).toArray();
				for(int i4=0; i4<snackNum.length; i4++) {
					snack.setSnack_num(snackNum[i4]);
					snack.setSnack_quantity(snackQuantity[i4]);
					service.registSnack(snack);//스낵정보 저장
				}
				
			}
		    
		   
		   
			return res;
		 
	}
	
	@ResponseBody
	@RequestMapping(value = "verify_iamport/{imp_uid}", method = RequestMethod.POST)
	public IamportResponse<Payment> verifyIamportPOST(@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
			
		IamportClient client = payservice.getClient();
			return client.paymentByImpUid(imp_uid);
		}
}

