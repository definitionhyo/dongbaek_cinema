package com.itwillbs.dongbaekcinema.service;

import java.util.*;

import org.json.simple.*;
import org.springframework.stereotype.*;

import net.nurigo.java_sdk.api.*;
import net.nurigo.java_sdk.exceptions.*;

@Service
public class testService {

	public void certifiedPhoneNumber(String member_phone, int randomNumber) {
		
		String api_key = "#";	// coolsms 본인 API키 입력 - 실제 테스트 시에는 바꿔주기
	    String api_secret = "#";	// coolsms 본인 API_secret키 입력
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", member_phone);    // 수신전화번호
	    params.put("from", "#");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");
	    params.put("text", "동백씨네마 본인인증 : 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	        JSONObject obj = (JSONObject) coolsms.send(params);
	        System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	        System.out.println(e.getMessage());
	        System.out.println(e.getCode());
	      }
	}
	
}
