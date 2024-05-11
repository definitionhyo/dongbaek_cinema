package com.itwillbs.dongbaekcinema.controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.dongbaekcinema.service.*;

@Controller
public class MessageCertifyController {
	
	@Autowired
	private testService service;
	
	@RequestMapping(value = "/phoneCheck", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String sendSMS(@RequestParam("member_phone") String member_phone) { // 휴대폰 문자보내기
		System.out.println(member_phone);
		
		int randomNumber = 
				1111;	// 임의로 1111 누르면 되는걸로
//				(int)((Math.random()* (9999 - 1000 + 1)) + 1000);//난수 생성
		service.certifiedPhoneNumber(member_phone, randomNumber);
		
		return Integer.toString(randomNumber);
	}
	
}
