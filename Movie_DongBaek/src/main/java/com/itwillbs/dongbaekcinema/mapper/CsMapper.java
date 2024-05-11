package com.itwillbs.dongbaekcinema.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.dongbaekcinema.vo.*;

@Mapper
public interface CsMapper {
	
	// cs게시판 중 Faq 레코드 조회(지영)
	List<CsVO> selectCsFaq(@Param("cs_type") String cs_type);
//	List<CsVO> selectCsFaq(@Param("cs_type") String cs_type, @Param("startNum") int startNum, @Param("pageNum") int pageNum);

	// cs 부분 1:1질문 DB 에 저장(지영)
	int insertBoard(CsVO board);
	
}
