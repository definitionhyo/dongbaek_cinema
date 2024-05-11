package com.itwillbs.dongbaekcinema.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.AdminMapper_2;
import com.itwillbs.dongbaekcinema.vo.PlayVO;

@Service
public class AdminService_2 {

    @Autowired
    private AdminMapper_2 mapper;

    // 상단 버튼 클릭 시 상영 목록 검색
    public List<PlayVO> showSchedual(int theater_num, String play_date) {
    	System.out.println("AdminService - showSchedual()");
    	System.out.println(theater_num + ", " + play_date);
        return mapper.selectScheduleList(theater_num, play_date);
    }
    
    // 극장명으로 극장번호 조회
	public int findTheaterNum(String theater_name) {
		
		return mapper.findTheaterNum(theater_name);
	}

}
