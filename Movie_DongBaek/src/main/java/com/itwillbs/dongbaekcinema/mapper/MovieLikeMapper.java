package com.itwillbs.dongbaekcinema.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.dongbaekcinema.vo.*;

@Mapper
public interface MovieLikeMapper {

	// 찜한 영화 찾기(지영)
	List<MovieLikeVO> selectLikeMovie(String member_id);
	
	// 찜 기능(지영)
	int insertLikeMovie(MovieLikeVO movieLike);

	// 찜 취소(지영)
	int deleteLikeMovie(MovieLikeVO movieLike);
	
	// 찜 영화 갯수 세기 -> 페이징
	int countLikeMovie(String member_id);
	
	// 찜한 영화 목록 - 페이징
	List<MovieLikeVO> selectLikeMovieList(@Param("member_id") String member_id
										, @Param("startRow") int startRow
										, @Param("listLimit") int listLimit);
	
	
}
