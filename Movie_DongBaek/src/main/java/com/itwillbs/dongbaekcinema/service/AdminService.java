package com.itwillbs.dongbaekcinema.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.AdminMapper;
import com.itwillbs.dongbaekcinema.vo.MovieVO;
import com.itwillbs.dongbaekcinema.voNew.*;

@Service
public class AdminService {

    @Autowired
    private AdminMapper mapper;
    
    @Autowired
    private PayService payService;



    // 영화관 정보 불러오기
	public List<HashMap<String, String>> getTheater() {
		System.out.println("AdminService - getTheater()");
		
		return mapper.getTeater();
	}
    
    
    // 상단 확인 버튼 클릭 시 상영 목록 검색
    public List<PlayScheduleVO> showSchedual(String theater_num, String play_date, int pageNo) {
    	System.out.println("AdminService - showSchedual()");
    	System.out.println(theater_num + ", " + play_date);
        return mapper.selectScheduleList(theater_num, play_date, pageNo);
    }

    // 상단 확인 버튼 클릭 시 셀렉트박스에서 선택가능한 영화 목록 조회
	public List<MovieVO> findMovieList(String play_date) {
		
		return mapper.findMovieList(play_date);
	}

	// 영화목록 셀렉트 박스 클릭 시 DB에서 회차 생성 관련 정보 가져오기
	public List<PlayScheduleVO> createTurn(int theater_num, int movie_num, int pageNo) {
		
		List<PlayScheduleVO> playScheduleList =  mapper.getTurnInfo(theater_num, movie_num, pageNo);
		
		int index = 1;
		// 리턴받은 상영스케줄 회차 정보가 없을 경우 회차 번호 생성
		for(PlayScheduleVO playSchedule : playScheduleList) {
			System.out.println("playSchedule" + index + " : "+ playSchedule);	
//			if(playSchedule.getPlay_turn() == ""){ // 회차 정보가 없는 경우
//				playSchedule.setPlay_turn(index);
//			}
			
			// 새로운 회차 정보 넣기
			
			index++; // 인덱스값 +1
		}
		
		
		
		return playScheduleList;
	}

	// 영화관 번호로 상영관 번호와 이름 가져오기
	public List<PlayScheduleVO> getRoomInfo(String theater_num) {
		
		return mapper.getRoom(theater_num);
	}
	
    // 해당 영화 러닝타임 가져오기
	public int findMovieRunningTime(int movie_num) {
        // 상영회차 정보 생성을 위해 영화 상영정보 가져오기(movie_running_time)
        return mapper.findMovieRunningTime(movie_num);
	}
	
    // 영화번호로 영화명 가져오기
	public String findMovieName(int movie_num) {
		return mapper.findMovieName(movie_num);
	} 

    // 상영관 시작시간 종료시간 가져오기
	public PlayScheduleVO getRoomStartTime(int theater_num, int room_num) {
		return mapper.getRoomStartTime(theater_num, room_num);
	}


	// 특정 날짜에 상영관 스케줄이 등록되어있는지 확인
	public int checkSchedule(String play_date, int theater_num, int room_num) {
		
		return mapper.checkSchedule(play_date, theater_num, room_num);
	}
	
	// 특정 날짜의 영화관의 상영관별 상영 스케줄 삭제
	public int deleteSchedule(String play_date, int theater_num, int room_num) {
		
		return mapper.deleteSchedule(play_date, theater_num, room_num);
	}

	// 특정 날짜의 상영관 스케줄 등록
	public int insertSchedule(String play_date, int theater_num
			, int room_num, int movie_num, String new_start_turn 
			, String new_end_turn, int play_turn, String play_time_type) {
            
        return mapper.insertSchedule(play_date, theater_num, room_num, movie_num, new_start_turn, new_end_turn, play_turn, play_time_type);
	}
	
    // 특정 날짜 영화관 상영관 정보 변경
	public int updateSchedule(String play_date, int theater_num, int room_num, int movie_num, String new_start_turn,
			String new_end_turn, int play_turn, String play_time_type) {
		
		return mapper.updateSchedule(play_date, theater_num, room_num, movie_num, new_start_turn, new_end_turn, play_turn, play_time_type);
	}
	
    // 상영관 종료시간보다 늦은 회차 업데이트 시 삭제
	public int deleteLateSchedule(String play_date, int theater_num, int room_num, int play_turn) {
		// TODO Auto-generated method stub
		return mapper.deleteLateSchedule(play_date, theater_num, room_num, play_turn);
	}	

	
    // CS 게시판 목록 가져오기
	public List<CsInfoVO> getCsList(int pageNo, int ListLimit, int startRow, int csTypeNo) {
	
		// CS 게시판 구분용 contiodion 변수
		String condition = distinctType(csTypeNo);
		

		return mapper.getCsWithPaging(startRow, ListLimit, condition);
	}
	
    // 키워드에 따라 1:1 자주묻는 질문 목록 출력하기
	public List<CsInfoVO> getCsListKeyword(int pageNo, int listLimit, int startRow, int csTypeNo,
			String cs_type_keyword) {
		
		// CS 게시판 구분용 contiodion 변수
		String condition = distinctType(csTypeNo);
		
		return mapper.getCsWithKeywordPaging(startRow, listLimit, condition, cs_type_keyword);
	}
	
	// CS게시판 총 목록 갯수 가져오기
    public int getCsTotalPageCount(int pageListLimit, int csTypeNo) {

		// CS 게시판 구분용 contiodion 변수(csType=1일경우 공지사항, cstype=2일경우 1:1질문 게시판, cstype=3경우 자주묻는 질문)
		String condition = distinctType(csTypeNo);
		System.out.println("getCsTotalPageCount- condition:" + condition);
        
//        System.out.println("getCsTotalPageCount pageListLimit:" + pageListLimit + "csType:" + csType + "condition" + condition + "totalCount" + totalCount);
        return mapper.getCsCount(condition);
    }
    
	// CS게시판 키워드에 맞는 목록 갯수 가져오기
    public int getCsTotalPageCountKeyword(int pageListLimit, int csTypeNo, String cs_type_keyword) {

		// CS 게시판 구분용 contiodion 변수(csType=1일경우 공지사항, cstype=2일경우 1:1질문 게시판, cstype=3경우 자주묻는 질문)
		String condition = distinctType(csTypeNo);
		System.out.println("getCsTotalPageCount- condition:" + condition);
        
//        System.out.println("getCsTotalPageCount pageListLimit:" + pageListLimit + "csType:" + csType + "condition" + condition + "totalCount" + totalCount);
        return mapper.getCsCountKeyword(condition, cs_type_keyword);
    }
    
	// 관리자 공지사항, 자주묻는 질문 글쓰기 등록
	public int registCs(int csTypeNo, CsInfoVO csInfo) {
		
		// CS 게시판 구분용 contiodion 변수
		String condition = distinctType(csTypeNo);
		System.out.println("registCs - condition:" + condition);
		System.out.println("registCs - csInfo:" + csInfo);
		
		return mapper.registCs(condition, csInfo);
				
	}
    
	
	// CS 공지, 자주묻는 질문 게시판 글수정
	public int updateCs(int csTypeNo, CsInfoVO csInfo) {
		
		// CS 게시판 구분용 contiodion 변수(1: 공지사항, 2: 자주묻는 질문 게시판)
		String condition = distinctType(csTypeNo);
		System.out.println("updateCs - condition:" + condition);
		System.out.println("updateCs - csInfo:" + csInfo);
		
		return mapper.updateCs(condition, csInfo);
				
		
	}
    
	// CS게시판 공지사항, 자주묻는 질문 삭제
	public int deleteCs(int csTypeNo, int cs_type_list_num) {

		// CS 게시판 구분용 contiodion 변수
		String condition = distinctType(csTypeNo);
		
		System.out.println("deleteCs condition:" + condition);
		System.out.println("deleteCs cs_type_list_num:" + cs_type_list_num);

		return mapper.deleteCs(condition, cs_type_list_num);
	}


    // CS게시판 1:1 질문 관리 답변 화면 정보 가져오기
	public CsInfoVO getCsInfo(int csTypeNo, int cs_type_list_num) {
		
		// CS 게시판 구분용 contiodion 변수
		String condition = distinctType(csTypeNo);
		
		
		return mapper.getCsInfo(condition, cs_type_list_num);
	}

	// CS게시판 1:1 질문 관리 답변 등록
	public int quaReply(int csTypeNo, CsInfoVO qnaInfo) {
		
		// CS 게시판 구분용 contiodion 변수
		String condition = distinctType(csTypeNo);
		System.out.println("quaReply - condition:" + condition);
		System.out.println("quaReply - qnaInfo:" + qnaInfo);
		
		return mapper.updateReply(condition, qnaInfo);
	}
	

    // CS 게시판 구분용 메서드 모듈
    public String distinctType(int csTypeNo) {
    	
    	String condition = ""; // 조건절 변수명
    	// csType 변수명에 따라 Cs게시판 목록 가져오기
    	if(csTypeNo == 1) {
    		condition = "'공지'"; 
    	} else if(csTypeNo == 2) {
    		condition = "'영화정보문의', '회원 문의', '예매 결제 관련 문의', '일반 문의'";
    	} else if(csTypeNo == 3) {
    		condition = "'예매','멤버십','결제수단','극장','할인혜택'";
    	}
    	
    	return condition;
    }

    // 통계 late 회원가입 수
	public int getMemberJoinCount(int dayCount) {
		
		return mapper.getMemberJoinCount(dayCount);
	}


	// 예매 수 조회
	public int getOrderLate(int dayCount) {
		
		return mapper.getOrderLate(dayCount);
	}


	// 해당 날짜 영화별 예매 수 조회
	public int getMovieLateCount(int dayCount) {

		return mapper.getMovieLateCount(dayCount);
	}

	// 해당 날짜 영화별 예매 수 영화명
	public String getMovieLateName(int dayCount) {
		
		return mapper.getMovieLateName(dayCount);
	}











    
    
    












}
