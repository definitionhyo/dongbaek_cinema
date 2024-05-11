package com.itwillbs.dongbaekcinema.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.ChartMapper;
import com.itwillbs.dongbaekcinema.voNew.ChartVO;

@Service
public class ChartService {
	
	@Autowired
	private ChartMapper mapper;

	public List<ChartVO> getSixUpGenre() {
		
		return mapper.selectSixUp();
	}
}
