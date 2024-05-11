package com.itwillbs.dongbaekcinema.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.dongbaekcinema.vo.PlayVO;

@Mapper
public interface AdminMapper_2 {

	// 극장 이름과 상영 일자로 스케줄 목록 조회
	public List<PlayVO> selectScheduleList(int theater_num, @Param("play_date") String play_date);

	// 극장 이름으로 극장 번호 조회
	public int findTheaterNum(@Param("theater_name") String theater_name);

	
}
