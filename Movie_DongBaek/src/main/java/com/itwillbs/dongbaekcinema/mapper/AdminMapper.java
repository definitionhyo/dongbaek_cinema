package com.itwillbs.dongbaekcinema.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.dongbaekcinema.vo.CsVO;
import com.itwillbs.dongbaekcinema.vo.MovieVO;
import com.itwillbs.dongbaekcinema.vo.PlayVO;
import com.itwillbs.dongbaekcinema.voNew.AdminLateVO;
import com.itwillbs.dongbaekcinema.voNew.CsInfoVO;
import com.itwillbs.dongbaekcinema.voNew.PlayScheduleVO;

@Mapper
public interface AdminMapper {
	
	// 셀렉트박스 영화관 정보 가져오기
	public List<HashMap<String, String>> getTeater();

	// 확인 버튼 클릭 시 스케줄 목록 가져오기
	public List<PlayScheduleVO> selectScheduleList(@Param("theater_num") String theater_num, @Param("play_date") String play_date,@Param("pageNo") int pageNo);

	// 확인 버튼 클릭 시 선택가능한 영화 정보 가져오기
	public List<MovieVO> findMovieList(@Param("play_date") String play_date);

	// 영화 목록 셀렉트 박스 클릭시 선택 가능한 영화 정보 가져오기
	public List<PlayScheduleVO> getTurnInfo(@Param("theater_num") int theater_num, @Param("movie_num") int movie_num, @Param("pageNo") int pageNo);

	// 영화관 번호로 해당 상영관 정보 가져오기
	public List<PlayScheduleVO> getRoom(@Param("theater_num") String theater_num);
	
	// 특정 날짜 상영 스케줄 등록여부 확인
	public int checkSchedule(@Param("play_date")String play_date, @Param("theater_num")int theater_num, @Param("room_num")int room_num);

	// 특정 날짜 상영관별 스케줄 삭제 수행
	public int deleteSchedule(@Param("play_date")String play_date, @Param("theater_num")int theater_num, @Param("room_num")int room_num);
	
	// 상영 스케줄 등록
	public int insertSchedule(@Param("play_date")String play_date, @Param("theater_num")int theater_num, 
						@Param("room_num")int room_num, @Param("movie_num")int movie_num, @Param("new_start_turn")String new_start_turn, 
								@Param("new_end_turn")String new_end_turn, @Param("play_turn")int play_turn, @Param("play_time_type")String play_time_type);

	// movie_num으로 해당 영화 러닝타임 가져오기
	public int findMovieRunningTime(@Param("movie_num")int movie_num);

	// movie_num으로 해당 영화 러닝타임 가져오기
	public String findMovieName(@Param("movie_num")int movie_num);
	
	// 상영관별 시작시간 정보 가져오기
	public PlayScheduleVO getRoomStartTime(@Param("theater_num")int theater_num, @Param("room_num")int room_num);	
	
	// 종영시간이 상영관 종료시간보다 늦는 회차 업데이트시 삭제
	public int deleteLateSchedule(@Param("play_date")String play_date, @Param("theater_num")int theater_num, @Param("room_num")int room_num, @Param("play_turn")int play_turn);

	// 특정 날짜 영화관 상영관 스케줄 변경(업데이트)
	public int updateSchedule(@Param("play_date")String play_date, @Param("theater_num")int theater_num
			, @Param("room_num")int room_num, @Param("movie_num")int movie_num, 
			@Param("new_start_turn")String new_start_turn, @Param("new_end_turn")String new_end_turn
			, @Param("play_turn")int play_turn, @Param("play_time_type")String play_time_type);
	
	
    // CS 게시판 목록 가져오기
    List<CsInfoVO> getCsWithPaging(@Param("start") int start, @Param("pageListLimit") int pageListLimit, @Param("condition") String condition);

    // CS 게시판 총 목록 수 가져오기
	public int getCsCount(@Param("condition") String condition);

	// CS 게시판 글수정& 답글 달기시 정보 가져오기
	public CsInfoVO getCsInfo(@Param("condition")String condition, @Param("cs_type_list_num") int cs_type_list_num);
	
	// CS 게시판 cs_type_list_num(타입별 글번호) 카운트
//	public int countCsTypeListNum(@Param("condition")String condition);

	// CS 게시판 공지사항, 자주묻는 질문 글쓰기
	public int registCs(@Param("condition")String condition, @Param("csInfo")CsInfoVO csInfo);

	// CS 게시판 공지사항, 자주묻는 질문 게시판 글 수정
	public int updateCs(@Param("condition")String condition, @Param("csInfo")CsInfoVO csInfo);

	// CS 게시판 공지사항, 자주묻는 질문 게시판 글 삭제
	public int deleteCs(@Param("condition")String condition,  @Param("cs_type_list_num")int cs_type_list_num);

	// CS 게시판 1:1 게시판 답변 추가
	public int updateReply(@Param("condition")String condition, @Param("qnaInfo")CsInfoVO qnaInfo);

	// CS 게시판 자주묻는 질문 키워드 목록 가져오기
	public List<CsInfoVO> getCsWithKeywordPaging(@Param("start")int start, @Param("pageListLimit")int pageListLimit, @Param("condition")String condition, @Param("cs_type_keyword")String cs_type_keyword);

	// CS 게시판 키워드로 총 목록 개수 조회하기
	public int getCsCountKeyword(@Param("condition")String condition, @Param("cs_type_keyword")String cs_type_keyword);

	// 통계 일일 회원 가입수
	public int getMemberJoinCount(int dayCount);

	// 일일 예매 수 조회
	public int getOrderLate(int dayCount);

	// 해당 날짜 예매율 탑4 영화 예매 수
	public int getMovieLateCount(int dayCount);
	
	// 해당 날짜 예매율 탑4 영화명
	public String getMovieLateName(int dayCount);


	
	
	
	


}
