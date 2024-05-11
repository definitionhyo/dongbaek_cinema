package com.itwillbs.dongbaekcinema.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.dongbaekcinema.mapper.*;
import com.itwillbs.dongbaekcinema.vo.*;

@Service
public class CsService {

	@Autowired
	private CsMapper mapper;
	
	public CsVO getCsNotice() {
		// 
		return null;
	}
	
	// cs게시판 중 Faq 레코드 조회(지영)
	public List<CsVO> getCsFaq(String cs_type) {
		return mapper.selectCsFaq(cs_type);
	}
//	public List<CsVO> getCsFaq(String cs_type, int startNum, int pageNum) {
//		return mapper.selectCsFaq(cs_type, startNum, pageNum);
//	}
	
	// cs 부분 1:1질문 DB 에 저장(지영)
	public int insertBoard(CsVO board) {
		return mapper.insertBoard(board);
	}
	
	
	
}
