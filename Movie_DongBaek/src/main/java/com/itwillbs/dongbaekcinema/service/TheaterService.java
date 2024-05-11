package com.itwillbs.dongbaekcinema.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.TheaterMapper;
import com.itwillbs.dongbaekcinema.vo.ScheduleVO;
import com.itwillbs.dongbaekcinema.vo.TheaterVO;
import com.itwillbs.dongbaekcinema.vo.TicketTypeVO;

@Service
public class TheaterService {
	@Autowired 
	TheaterMapper mapper;
	public List<TheaterVO> getTheaterList() {
		// TODO Auto-generated method stub
		return mapper.selectTheaterList();
	}
	public TheaterVO getTheater(int theater_num) {
		// TODO Auto-generated method stub
		return mapper.selectTheater(theater_num);
	}
	public List<ScheduleVO> getSchedule(int theater_num, String play_date) {
		// TODO Auto-generated method stub
		return mapper.selectSchedule(theater_num,play_date);
	}
	public List<TicketTypeVO> getTicketList() {
		// TODO Auto-generated method stub
		return mapper.selectTicketTypeList();
	}


}
