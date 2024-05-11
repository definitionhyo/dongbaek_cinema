package com.itwillbs.dongbaekcinema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import com.itwillbs.dongbaekcinema.voNew.ChartVO;

@Mapper
public interface ChartMapper {

	List<ChartVO> selectSixUp();
	
	
}
