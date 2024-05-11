package com.itwillbs.dongbaekcinema.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.dongbaekcinema.mapper.*;
import com.itwillbs.dongbaekcinema.vo.*;

@Service
public class MovieLikeService {
	
	@Autowired
	private MovieLikeMapper mapper;
	
	// 찜한 영화 찾기(지영)
	public List<MovieLikeVO> getLikeMovie(String member_id) {
		
		return mapper.selectLikeMovie(member_id);
	}
	
	// 찜 기능(지영)
	public int checkLikeMovie(MovieLikeVO movieLike) {
		return mapper.insertLikeMovie(movieLike);
	}
	
	// 찜 취소(지영)
	public int unCheckLikeMovie(MovieLikeVO movieLike) {
		return mapper.deleteLikeMovie(movieLike);
	}
	
	// 찜 영화 갯수 세기  -> 페이징
	public int getLikeMovieCount(String member_id) {
		return mapper.countLikeMovie(member_id);
	}
	
	// 찜한 영화 목록 - 페이징
	public List<MovieLikeVO> getLikeMovieList(String member_id, int startRow, int listLimit) {
		return mapper.selectLikeMovieList(member_id, startRow, listLimit);
	}
	
	
	
}
