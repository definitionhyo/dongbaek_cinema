package com.itwillbs.dongbaekcinema;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.dongbaekcinema.service.*;
import com.itwillbs.dongbaekcinema.vo.*;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MovieService service;
	
	@Autowired
	private MovieLikeService likeService;
	
	//메인페이지에 영화리스트 전달
	@RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
	public String mainPage(Model model, HttpSession session) {

		//영화 목록 조회(현재상영작.예매율순)
		List<MovieVO> movieList = service.getMovieList_top4();
		model.addAttribute("movieList", movieList);
//		System.out.println(movieList);
		
		return "home";
	}
	
	// 페이지 - 영화 찜 보여주기(지영)
	@RequestMapping(value = "likeMovieShow", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<MovieLikeVO> likeMovieShow(HttpSession session) {
		// 찜한 영화 있을 경우 찜하기 표시하기(비회원이 아닐 때)
		String member_id = (String) session.getAttribute("member_id");
		String member_type = (String) session.getAttribute("member_type");

		if (member_id != null && !"비회원".equals(member_type)) {
//			System.out.println("어디서 문제니 : member_id " + member_id);
//			System.out.println("어디서 문제니 : member_type " + session.getAttribute("member_type"));
			
			// 찜한 영화 찾기
			// LikeService - getLikeMovie()
			// 파라미터 : member_id		리턴타입 : List<LikeVO>(likeList)
			List<MovieLikeVO> likeList = likeService.getLikeMovie(member_id); 
			System.out.println(likeList);
//					
//			if(likeList != null) {
				// 모델에 저장 (-> 메인, 영화목록, 영화디테일)
				// 세션x : 찜하기 목록이 업데이트 될때마다 달라지므로 페이지마다 조회해서 파라미터로 받을 예정
//			} else {
//				
//			}
			return likeList;
		}
		return null;
	}
	
	// 영화 찜 버튼 기능 구현(지영)
	@RequestMapping(value = "likeMovie", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public Integer likeMovie(
			// 찜 구현 시 필요한 파라미터
			String member_id, int movie_num, boolean isLike,
			MovieLikeVO movieLike
			) {
		
		// 넘어온 파라미터 확인
		System.out.println("member_id : " + member_id + ", movie_num : " + movie_num + ", isLike : " + isLike);
		
		// isLike의 값에 따라
		// FALSE (찜 안된 영화 -> 찜) : INSERT
		// 	 LikeService - checkLikeMovie()		파라미터 : MovieLikeVO(movieLike)		리턴타입 : int(insertCount)
		// TRUE (찜 된 영화 -> 찜 취소) : DELETE
		//	 LikeService - unCheckLikeMovie()		파라미터 : MovieLikeVO(movieLike)		리턴타입 : int(deleteCount)
		if(!isLike) {
			// 찜 기능
			int insertCount = likeService.checkLikeMovie(movieLike);
			System.out.println("찜 된 영화 갯수 : " + insertCount);
			
			return insertCount;
		} else {
			// 찜 취소
			int deleteCount = likeService.unCheckLikeMovie(movieLike);
			System.out.println("취소된 영화 갯수 : " + deleteCount);
			
			return deleteCount;
		}
		
	}
	
}
