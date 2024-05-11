package com.itwillbs.dongbaekcinema.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.dongbaekcinema.vo.ScheduleVO;
import com.itwillbs.dongbaekcinema.vo.TheaterVO;
import com.itwillbs.dongbaekcinema.vo.TicketTypeVO;

@Mapper
public interface TheaterMapper {

	List<TheaterVO> selectTheaterList();

	TheaterVO selectTheater(int theater_num);
	
	List<ScheduleVO> selectSchedule(@Param("theater_num") int theater_num,@Param("play_date") String play_date);

	List<TicketTypeVO> selectTicketTypeList();

}
