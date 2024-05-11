package com.itwillbs.dongbaekcinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GradeController {
	
	// 메인화면에서 멤버십 화면으로 이동
	@GetMapping("grade")
	public String grade() {
		return "grade/grade";
	}

}


























