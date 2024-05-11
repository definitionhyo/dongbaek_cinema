package com.itwillbs.dongbaekcinema.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dongbaekcinema.mapper.MovieMapper;
import com.itwillbs.dongbaekcinema.vo.MovieVO;
import com.itwillbs.dongbaekcinema.vo.ReviewVO;
import com.itwillbs.dongbaekcinema.voNew.*;

@Service
public class MovieService {

	@Autowired
	private MovieMapper mapper;
	
	// 영화 등록 요청 작업을 위한 registMovie() 메서드 정의
	public int registMovie(MovieVO movie) {
		return mapper.insertMovie(movie);
	}
	

	// 영화 정보 조회 요청을 위한 getMovieList() 메서드 정의 -(0613+정의효 
	public MovieVO getMovie(int movie_num) {
		System.out.println(movie_num);
		return mapper.selectMovie(movie_num);
	}
	
	
	

	
	// 현재상영작 예매율순 영화목록 조회 요청 - 기본
	public List<MovieVO> getMovieList_present_bookrate(int startRow, int listLimit, String movieSearchKeyword){
		//		System.out.println("getMovieList_present_bookrate()");
		return mapper.select_presentMovie_bookingRateDESC(startRow, listLimit, movieSearchKeyword);
	}
	//수정용
	
	// 현재상영작 평점순 영화목록 조회 요청
	public List<MovieVO> getMovieList_present_reviewrate(int startRow, int listLimit){
//			System.out.println("getMovieList_present_reviewrate()");
		return mapper.select_presentMovie_reviewRate(startRow, listLimit);
	}
		
	// 현재상영작 전체 글 목록 갯수 조회 요청 - 검색X
	public int getMovieListCounting(String movieSearchKeyword) {
		return mapper.selectMovieListCounting(movieSearchKeyword);
	}
	
	
	
	//---------------------------------------------------------------------------------	
	
	// 상영예정작 목록 조회 요청을 위한 getMovieList_prepare() 메서드 정의 -
	public List<MovieVO> getMovieList_prepare(int startRow, int listLimit) {
//		System.out.println("getMovieList_prepare()");
		return mapper.select_prepareMovie(startRow, listLimit);
	}
	
	//상영예정작 목록페이지 - 셀렉트박스변경(가나다순정렬)
	public List<MovieVO> getMovieList_prepareNameDESC(int startRow, int listLimit) {
		System.out.println("Service - getReviewList()");
			
		return mapper.select_movieList_prepareNameDESC(startRow, listLimit);
	}
	
	// 상영예정작 개수 카운팅
	public int getMovieListCount_prepare() {
		System.out.println("Service - getMovieListCount_prepare");
		return mapper.selectMovieListCount_prepare();
	}
	
	// 메인페이지 탑4 영화목록 조회 요청
	public List<MovieVO> getMovieList_top4() {
//		System.out.println("getMovieList_top4");
		return mapper.select_movieListTop4();
	}

	
	//------------------------------------------------------------------------------
	// 영화 정보 조회 - 각영화당 평점평균정보 포함하는 뷰(MOVIES_ADD_REVIEWRATING) 조회

	public MovieVO getMovieADDReview(int movie_num) {
		return mapper.selectMovieADDReview(movie_num);
	}
	
	//------------------------------------------------------------------------------
	// 리뷰 정보 조회 요청을 위한 getReviewRating()메서드 정의
	// 파라미터:movie_num 리턴타입:ReviewVO 
	public ReviewVO getReview(int movie_num) {
//		System.out.println("Service - getReview()");
		return mapper.selectReview(movie_num);
	}

	// 영화당 리뷰 개수정보 조회요청을 위한 getReviewCounting()메서드 정의
	// 파라미터 : movie_num, 리턴타입 : ReviewVO
	public ReviewVO getReviewCounting(int movie_num) {
//		System.out.println("service-getReviewCounting");
		return mapper.selectReviewCounting(movie_num);
	}
	
	//리뷰 목록 조회요청 - getReviewList ++ 페이징
	public List<ReviewVO> getReviewList(int movie_num, int startRow, int listLimit) {
//		System.out.println("Service - getReviewList()");
		return mapper.selectReviewList(movie_num, startRow, listLimit);
	}
	
	//영화당 리뷰총개수 조회(페이징)
	public int getReviewListCount_forPaging(int movie_num) {
		return mapper.selectReviewCounting_forPaging(movie_num);
	}
	
	//리뷰컨텐츠 하나만 출력
//	public ReviewVO getReviewRecent(int movie_num) {
//		return mapper.selectReviewLecent(movie_num);
//	}
	
	//-------------------------------------------------------------------------

	
	
	// 영화 목록 전부 조회 페이징처리로 필요없음 - 0616정의효
//	public List<MovieVO> getMovieList() {
//		return mapper.selectMovieList();
//	}

//	//페이징처리 - 0616 정의효 -  0622페이징처리후 완료되면 지우기 
//	public List<MovieVO> getMovieList(int pageNo, int pageListLimit) {
//		int start = (pageNo - 1) * pageListLimit;
//		return mapper.getMovieList(start, pageListLimit);
//	}


	//페이징처리 - 0616 정의효 -  0622페이징처리후 완료되면 지우기 
//	public int getTotalPageCount(int pageListLimit) {
//		int totalCount = mapper.getCount();
//		return (int) Math.ceil((double) totalCount / pageListLimit);
//	}

	//영화삭제 - 0620정의효
	public void movieDelete(String movie_num) {
		mapper.movieDelete(movie_num);
	}

	//영화수정 - 0620정의효 작성중
	public void movieModify(MovieVO movie) {
		 mapper.movieModify(movie);
	}

	// 영화 목록 조회 요청 위한 메서드 / 페이징처리중 - 0622 정의효 
	public List<MovieVO> getmovieList(String movierSearchKeyword, int startRow, int listLimit) {
		return mapper.selectMovieList(movierSearchKeyword, startRow, listLimit);
	}

	// 전체 영화 목록 개수 조회 요청 / 페이징처리중 - 0622 정의효 
	public int getMovieListCount(String movieSearchKeyword) {
		return mapper.selectMovieListCount(movieSearchKeyword);
	}

	//영화 중복검사
	public boolean isMovieAlreadyRegistered(String movie_name_kr) {
		return mapper.isMovieAlreadyRegistered(movie_name_kr);
	}












}
