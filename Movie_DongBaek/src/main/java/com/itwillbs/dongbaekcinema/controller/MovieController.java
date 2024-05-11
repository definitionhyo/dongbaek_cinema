package com.itwillbs.dongbaekcinema.controller;

import java.util.*;
import java.util.List;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.itwillbs.dongbaekcinema.service.*;
import com.itwillbs.dongbaekcinema.vo.*;
import com.itwillbs.dongbaekcinema.voNew.PageInfoVO;

import antlr.collections.*;

@Controller
public class MovieController {
	
	@Autowired
	private MovieService service;
	
	//영화목록-현재상영작탭 클릭시(예매율순.기본)
	@GetMapping("movie_list_present")
	public String movie_list_present(
			Model model, 
			@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="") String movieSearchKeyword ) {
		
		//페이징처리 변수선언
		int listLimit = 8; //한페이지 표시 목록갯수
		int startRow = (pageNum - 1) * listLimit; //조회시작 행번호
		
		//페이징 계산작업
		//1.전체게시물 수 조회 작업 요청-검색X
		int listCount = service.getMovieListCounting(movieSearchKeyword);
		int pageListLimit = 2; //2.페이지번호개수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //3. 전체 페이지 목록갯수
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //4. 시작 페이지 번호
		int endPage = startPage + pageListLimit - 1; //5. 끝페이지 번호
		// 최대페이지번호 처리 
		if(endPage>maxPage) {
			endPage = maxPage;
		}
		//페이징 처리 정보 저장할 PageInfo객체에 계산데이터 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		
		//영화 목록 조회 ( 페이징 정보 전달 )
		List<MovieVO> movieList = service.getMovieList_present_bookrate(startRow, listLimit, movieSearchKeyword);
		
		//jsp페이지에 전달 ( 영화목록, 페이징 정보)
		model.addAttribute("movieList", movieList);
		model.addAttribute("pageInfo", pageInfo);
//		System.out.println(movieList);
		return "movie/movie_list_present";
	}
	
	
	//영화목록-현재상영작 평점순셀렉트박스 선택시
	@ResponseBody
	@GetMapping("movie_list_present2")
	public List<MovieVO> movie_list_present2(Model model,
			@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="") String movieSearchKeyword) {
		System.out.println("movie_list_present2");
		
		//페이징처리 변수선언
		int listLimit = 8; //한페이지 표시 목록갯수
		int startRow = (pageNum - 1) * listLimit; //조회시작 행번호
		
		//페이징 계산작업
		//1.전체게시물 수 조회 작업 요청-검색X
		int listCount = service.getMovieListCounting(movieSearchKeyword);
		int pageListLimit = 2; //2.페이지번호개수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //3. 전체 페이지 목록갯수
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //4. 시작 페이지 번호
		int endPage = startPage + pageListLimit - 1; //5. 끝페이지 번호
		// 최대페이지번호 처리 
		if(endPage>maxPage) {
			endPage = maxPage;
		}
		//페이징 처리 정보 저장할 PageInfo객체에 계산데이터 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+listLimit + startRow);
		
		List<MovieVO> movieList = service.getMovieList_present_reviewrate(startRow,listLimit);
		model.addAttribute("movieList", movieList);
		model.addAttribute("pageInfo",pageInfo);
		return movieList;
	}
	
	
	//영화목록-현재상영작 다시 예매 선택시
		@ResponseBody
		@GetMapping("movie_list_return")
		public List<MovieVO> movie_list_return(Model model, 
				@RequestParam(defaultValue="1") int pageNum,
				@RequestParam(defaultValue="") String movieSearchKeyword) {
			System.out.println("}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}movie_list_return");
			//페이징처리 변수선언
			int listLimit = 8; //한페이지 표시 목록갯수
			int startRow = (pageNum - 1) * listLimit; //조회시작 행번호
			
			//페이징 계산작업
			//1.전체게시물 수 조회 작업 요청-검색X
			int listCount = service.getMovieListCounting(movieSearchKeyword);
			int pageListLimit = 2; //2.페이지번호개수
			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //3. 전체 페이지 목록갯수
			int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //4. 시작 페이지 번호
			int endPage = startPage + pageListLimit - 1; //5. 끝페이지 번호
			// 최대페이지번호 처리 
			if(endPage>maxPage) {
				endPage = maxPage;
			}
			//페이징 처리 정보 저장할 PageInfo객체에 계산데이터 저장
			PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+listLimit + startRow);
			//영화 목록 조회 ( 페이징 정보 전달 )
			List<MovieVO> movieList = service.getMovieList_present_bookrate(startRow, listLimit, movieSearchKeyword);
			
			//jsp페이지에 전달 ( 영화목록, 페이징 정보)
			model.addAttribute("movieList", movieList);
			model.addAttribute("pageInfo", pageInfo);
//			System.out.println(movieList);
			return movieList ;
		}
	
		//-----------------------------------------------------------------------------------------

		//영화목록-상영예정작탭 클릭시
		@GetMapping("movie_list_prepare")
		public String movie_list_prepare(Model model, 
				@RequestParam(defaultValue="1") int pageNum) {
//			System.out.println("Moviecontroller-movie_list_prepare");
			
			int listLimit = 8; //한페이지 표시 목록갯수
			int startRow = (pageNum - 1) * listLimit; //조회시작 행번호
			
			//페이징 계산작업
			//1.전체게시물 수 조회 작업 요청-검색X
			int listCount = service.getMovieListCount_prepare();
			int pageListLimit = 2; //2.페이지번호개수
			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //3. 전체 페이지 목록갯수
			int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //4. 시작 페이지 번호
			int endPage = startPage + pageListLimit - 1; //5. 끝페이지 번호
			// 최대페이지번호 처리 
			if(endPage>maxPage) {
				endPage = maxPage;
			}
			//페이징 처리 정보 저장할 PageInfo객체에 계산데이터 저장
			PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
			
			List<MovieVO> movieList = service.getMovieList_prepare(startRow, listLimit);
			model.addAttribute("movieList", movieList);
			model.addAttribute("pageInfo", pageInfo);
			
			return "movie/movie_list_prepare";
		}
		
		
		//상영예정작 
		//영화목록-상영예정작 가나다순 셀렉트박스 선택시
		@ResponseBody
		@GetMapping("movie_list_prepareNameDESC")
		public List<MovieVO> movie_list_prepareNameDESC(Model model,
										@RequestParam(defaultValue="1") int pageNum
										) {
			System.out.println("movie_list_prepareNameDESC");
			
			
			int listLimit = 8; //한페이지 표시 목록갯수
			int startRow = (pageNum - 1) * listLimit; //조회시작 행번호
			
			//페이징 계산작업
			//1.전체게시물 수 조회 작업 요청-검색X
			int listCount = service.getMovieListCount_prepare();
			int pageListLimit = 2; //2.페이지번호개수
			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //3. 전체 페이지 목록갯수
			int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //4. 시작 페이지 번호
			int endPage = startPage + pageListLimit - 1; //5. 끝페이지 번호
			// 최대페이지번호 처리 
			if(endPage>maxPage) {
				endPage = maxPage;
			}
			//페이징 처리 정보 저장할 PageInfo객체에 계산데이터 저장
			PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
			List<MovieVO> movieList = service.getMovieList_prepareNameDESC(startRow, listLimit);
			
			
			model.addAttribute("pageInfo", pageInfo);		
			model.addAttribute("movieList", movieList);
			return movieList;
		}
		
		
		
		
		
		//상영예정작 - 다시 예매순 셀렉트박스 선택시
		@ResponseBody
		@GetMapping("movie_list_prepareReturn")
		public List<MovieVO> movie_list_prepareReturn(Model model,@RequestParam(defaultValue="1") int pageNum) {
			System.out.println("movie_list_prepareReturn");
			
			//페이징처리 변수선언
			int listLimit = 8; //한페이지 표시 목록갯수
			int startRow = (pageNum - 1) * listLimit; //조회시작 행번호
			
			//페이징 계산작업
			//1.전체게시물 수 조회 작업 요청-검색X
			int listCount = service.getMovieListCount_prepare();
			int pageListLimit = 2; //2.페이지번호개수
			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //3. 전체 페이지 목록갯수
			int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //4. 시작 페이지 번호
			int endPage = startPage + pageListLimit - 1; //5. 끝페이지 번호
			// 최대페이지번호 처리 
			if(endPage>maxPage) {
				endPage = maxPage;
			}
			//페이징 처리 정보 저장할 PageInfo객체에 계산데이터 저장
			PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
			
			List<MovieVO> movieList = service.getMovieList_prepare(startRow, listLimit);
			model.addAttribute("movieList", movieList);
			model.addAttribute("pageInfo", pageInfo);
			return movieList;
		}
	
	//---------------------------------------------------------------------
	
	//영화상세정보-메인
	@GetMapping("movie_detail_info")
	public String movie_detail_info(int movie_num, Model model) {
//		System.out.println("Moviecontroller-movie_detail_info");
//		System.out.println(movie_num);
		
		// 각 영화의 상세정보 출력 getMovie()메서드
		// 파라미터: 리턴타입:MemberVO
		MovieVO movie = service.getMovieADDReview(movie_num);
//		System.out.println(movie);
		model.addAttribute("movie", movie);
		
		// 각 영화의 리뷰정보 출력 getReviewRating
		ReviewVO review = service.getReview(movie_num);
//		System.out.println(review);
		model.addAttribute("review", review);

		return "movie/movie_detail_info";
	}
	

	//영화상세정보-포토탭
	@GetMapping("movie_detail_photo")
	public String movie_detail_photo(int movie_num, Model model) {
		
		// 각 영화의 상세정보 출력 getMovie()메서드
		// 파라미터: 리턴타입:MemberVO
		MovieVO movie = service.getMovieADDReview(movie_num);
//		System.out.println(movie);
		model.addAttribute("movie", movie);
		
		// 각 영화의 리뷰정보 출력 getReview
		ReviewVO review = service.getReview(movie_num);
//		System.out.println(review);
		model.addAttribute("review", review);
		
		return "movie/movie_detail_photo";
	}
	
	//영화상세정보-리뷰탭
	@GetMapping("movie_detail_review")
	public String movie_detail_review(
							int movie_num,
							Model model,
							@RequestParam(defaultValue="1") int pageNum) {
		
		// 각 영화의 상세정보 출력 getMovie()메서드
		// 파라미터: 리턴타입:MemberVO
		MovieVO movie = service.getMovieADDReview(movie_num);
		model.addAttribute("movie", movie);
		
		
		//페이징처리 변수선언
		int listLimit = 5; //한페이지 표시 목록갯수
		int startRow = (pageNum - 1) * listLimit; //조회시작 행번호
		
		
		
		
		// 각 영화의 리뷰정보 출력
		ReviewVO review = service.getReview(movie_num);
		model.addAttribute("review", review);
		
		// 리뷰목록출력(리뷰탭 컨텐츠영역)
		List<ReviewVO> reviewList = service.getReviewList(movie_num, startRow, listLimit);
		
		// 각 영화의 리뷰개수 출력 getReviewCounting === 영화당 리뷰개수 출력용(ReviewVO)
		ReviewVO reviewCount = service.getReviewCounting(movie_num);
		model.addAttribute("reviewCount", reviewCount);
		
		
		//페이징 계산작업
		//1.전체게시물 수 조회 작업 요청-검색X ==== 페이징처리용 (int)
		int listCount = service.getReviewListCount_forPaging(movie_num);
		
		int pageListLimit = 2; //2.페이지번호개수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //3. 전체 페이지 목록갯수
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //4. 시작 페이지 번호
		int endPage = startPage + pageListLimit - 1; //5. 끝페이지 번호
		// 최대페이지번호 처리 
		if(endPage>maxPage) {
			endPage = maxPage;
		}
		
		
		//페이징 처리 정보 저장할 PageInfo객체에 계산데이터 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pageInfo", pageInfo);
		return "movie/movie_detail_review";
	}
	
	
	// "찜하기" 기능 - 찜버튼 클릭 시
//	@GetMapping("likeMovie")
	
	
	
	
}
