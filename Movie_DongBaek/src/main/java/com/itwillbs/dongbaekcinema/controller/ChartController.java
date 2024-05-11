package com.itwillbs.dongbaekcinema.controller;

import java.util.List;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.dongbaekcinema.service.ChartService;
import com.itwillbs.dongbaekcinema.voNew.ChartVO;

@Controller
public class ChartController {
	
	@Autowired
	private ChartService service;
	
	@ResponseBody
	@RequestMapping(value = "ChartSixUp", method= {RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=utf-8")
	public String sixUp(){
		
		List<ChartVO> chartSixUp = service.getSixUpGenre();
		JSONArray ja = new JSONArray(chartSixUp);
		System.out.println(ja);
		return ja.toString();
	}
}
