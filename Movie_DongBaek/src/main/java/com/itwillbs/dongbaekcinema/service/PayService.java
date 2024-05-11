package com.itwillbs.dongbaekcinema.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.itwillbs.dongbaekcinema.mapper.*;
import com.itwillbs.dongbaekcinema.voNew.*;
import com.siot.IamportRestClient.IamportClient;

import lombok.Getter;


@Service
public class PayService {

	@Autowired
	private PayMapper mapper;
	
	private String impKey="2836321062537518";
	
	private String impSecret="gDtR42HoIUGMBdqwjWpjtZsXqwv1CQYBV04n7CRKxEXzx5vkdBH4J9OYKqsdtSdjMXHEfHM7hJVe8Luo";
	@Getter
	private IamportClient client=new IamportClient(impKey,impSecret);
	
	public String getToken() throws Exception {

		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/users/getToken");

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		JsonObject json = new JsonObject();

		json.addProperty("imp_key", impKey);
		json.addProperty("imp_secret", impSecret);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		
		bw.write(json.toString());
		bw.flush();
		bw.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();


		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
	}

	
    //결제 정보 불러오기
	public String paymentInfo(String imp_uid, String access_token) throws IOException, ParseException {
		HttpsURLConnection conn = null;

		URL url = new URL("https://api.iamport.kr/payments/" + imp_uid);

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("GET");
		conn.setRequestProperty("Authorization", access_token);
		conn.setDoOutput(true);

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		JSONParser parser = new JSONParser();

		JSONObject p = (JSONObject) parser.parse(br.readLine());
		
		String response = p.get("response").toString();
		
		p = (JSONObject) parser.parse(response);
		
		String amount = p.get("amount").toString();
		return amount;
	}
	
	// 결제 취소
	public void payMentCancle(String access_token, String imp_uid, int amount, String reason) throws IOException, ParseException {
		System.out.println("imp_uid = " + imp_uid);
		
		// 확인
		System.out.println("결제취소!");
		System.out.println(access_token);
		System.out.println(imp_uid);
		
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/payments/cancel");
 
		conn = (HttpsURLConnection) url.openConnection();
 
		conn.setRequestMethod("POST");
 
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", access_token);
 
		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();
 
		json.addProperty("reason", reason);
		json.addProperty("imp_uid", imp_uid);
		json.addProperty("amount", amount);
		json.addProperty("checksum", amount);
 
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 
		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
 
//		br.close();
//		conn.disconnect();
		
	}
	
	// 결제 취소
    public int orderCancle(BuyDetailVO buyDetail) throws Exception {
		if(!buyDetail.getPayment_num().equals("")) {
//			String token = payService.getToken(); 
			String token = getToken(); 
			int price = buyDetail.getPayment_total_price();
//			payService.payMentCancle(token, buyDetail.getPayment_num(), price, buyDetail.getReason());
			payMentCancle(token, buyDetail.getPayment_num(), price, buyDetail.getReason());
		}
		
		// payment_num 으로 조회 후 결제 상태(payment_status) 변경
		int updatePaymentCount = mapper.updatePayment(buyDetail.getPayment_num());
		// 티켓예약 상태변경, 스낵결제 상태변경
		int updateTicketCount = mapper.updateTicket(buyDetail.getOrder_num());
		int updateSnackCount = mapper.updateSnack(buyDetail.getOrder_num());
		System.out.println("updatePaymentCount: " + updatePaymentCount + ", updateTicketCount : " + updateTicketCount + ", updateSnackCount : " + updateSnackCount);
		
		return updatePaymentCount;
    }
	
}

