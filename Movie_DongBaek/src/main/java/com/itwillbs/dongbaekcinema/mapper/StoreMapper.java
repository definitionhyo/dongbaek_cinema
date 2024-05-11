package com.itwillbs.dongbaekcinema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.dongbaekcinema.vo.SnackVO;

@Mapper
public interface StoreMapper {

	List<SnackVO> selectSnackList();

	SnackVO selectSnackListByNum(int snackNum);

	

}
