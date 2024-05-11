package com.itwillbs.dongbaekcinema.vo;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class GradeVO {
	private String grade_name;
	private BigDecimal grade_discount;
	private int grade_min;
	private int grade_max;
//	데이터넣고 주석풀고 확인하기 0608 - 정의효
}
