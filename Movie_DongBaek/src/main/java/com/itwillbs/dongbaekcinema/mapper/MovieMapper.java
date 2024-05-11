package com.itwillbs.dongbaekcinema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.itwillbs.dongbaekcinema.vo.MovieVO;
import com.itwillbs.dongbaekcinema.vo.ReviewVO;

@Mapper
public interface MovieMapper {

	// 영화 등록 0620정의효
	int insertMovie(MovieVO movie);

	// 영화 정보 조회
	MovieVO selectMovie(int movie_num);
	
	
	// 영화 목록 조회 - 현재상영작
	List<MovieVO> select_presentMovie();

	// 영화 목록 조회 - 현재상영작 예매율 순 정렬 - 검색X
	List<MovieVO> select_presentMovie_bookingRateDESC(
								@Param("startRow") int startRow, 
								@Param("listLimit") int listLimit,
								@Param("movieSearchKeyword") String movieSearchKeyword);
	//수정


	// 전체 글 목록 갯수 조회 - 검색O
	int selectMovieListCounting(String movieSearchKeyword);
	
	
	
	// 영화 정보 조회 - 각영화당 평점평균정보 포함하는 뷰(MOVIES_ADD_REVIEWRATING) 조회
	MovieVO selectMovieADDReview(int movie_num);
	
	
	//영화 목록 조회 - 현재상영작 평점 순 정렬
	List<MovieVO> select_presentMovie_reviewRate(@Param("startRow") int startRow, 
						@Param("listLimit") int listLimit);
	
	// 영화 목록 조회 - 상영예정작
	List<MovieVO> select_prepareMovie(
						@Param("startRow") int startRow, 
						@Param("listLimit") int listLimit);
	
	// 상영예정작 개수 조회 - 검색X
	int selectMovieListCount_prepare();
	
	// 영화 목록 조회 - 탑4(메인)
	List<MovieVO> select_movieListTop4();

	// 영화 목록 조회 - 가나다순
	List<MovieVO> select_movieList_prepareNameDESC(
							@Param("startRow") int startRow, 
							@Param("listLimit") int listLimit);
	
	
	//-------------------------------------------
	// 리뷰 정보 조회
	ReviewVO selectReview(int movie_num);
	
	// 각 영화당 리뷰 개수 정보 조회
	ReviewVO selectReviewCounting(int movie_num);

	// 리뷰 목록 조회
	List<ReviewVO> selectReviewList(
			@Param("movie_num") int movie_num,
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);


	// 리뷰 총개수 조회(페이징용)
	int selectReviewCounting_forPaging(int movie_num);

//	// 리뷰컨텐츠 하나만 출력
//	ReviewVO selectReviewLecent(int movie_num);
	
	//---------------------------------------------
	// 영화 정보 모두 조회 페이징처리로 필요없음 - 0616 정의효
	//	List<MovieVO> selectMovieList();

	// 페이징처리 0616 정의효 - 0622페이징처리후 완료되면 지우기 
//	List<MovieVO> getMovieList(@Param("start") int start, @Param("perPage") int pageListLimit);

	// 페이징처리 0616 정의효 - 0622페이징처리후 완료되면 지우기 
//	int getCount();
	
	//영화삭제 0620-정의효
	void movieDelete(String movie_num);

	// 영화수정 0620-정의효
	void movieModify(MovieVO movie);

	// 영화 목록 조회 / 페이징- 0622정의효
	List<MovieVO> selectMovieList(@Param("movieSearchKeyword") String movieSearchKeyword, 
								  @Param("startRow") int startRow, 
								  @Param("listLimit") int listLimit);
	
	// 전체 영화 목록 개수 조회 / 페이징 - 0622정의효
	int selectMovieListCount(String movieSearchKeyword);

	// 영화 중복검사
	boolean isMovieAlreadyRegistered(String movie_name_kr);

	










	
}
