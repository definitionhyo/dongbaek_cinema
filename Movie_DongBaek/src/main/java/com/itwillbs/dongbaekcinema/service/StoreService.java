package com.itwillbs.dongbaekcinema.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.StoreMapper;
import com.itwillbs.dongbaekcinema.vo.SnackVO;

@Service
public class StoreService {
	@Autowired StoreMapper mapper;
	public List<SnackVO> getSnackList() {
		// TODO Auto-generated method stub
		return mapper.selectSnackList();
	}
	public SnackVO getSnackListByNum(int snackNum) {
		// TODO Auto-generated method stub
		return mapper.selectSnackListByNum(snackNum);
	}


}
