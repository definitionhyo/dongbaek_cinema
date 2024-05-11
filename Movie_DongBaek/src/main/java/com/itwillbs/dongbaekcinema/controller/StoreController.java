package com.itwillbs.dongbaekcinema.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.dongbaekcinema.service.StoreService;
import com.itwillbs.dongbaekcinema.vo.SnackVO;



@Controller
public class StoreController {
	
	@Autowired
	private StoreService service;

	@GetMapping("snack_main")
	public String snackList(Model model) {
		List<SnackVO> snackList = service.getSnackList();
		System.out.println(snackList);
		
		// student_list.jsp 페이지로 포워딩 시 전달할 List 객체 저장
		model.addAttribute("snackList", snackList);
		System.out.println(snackList);
		return "store/snack_main";
	}
}
