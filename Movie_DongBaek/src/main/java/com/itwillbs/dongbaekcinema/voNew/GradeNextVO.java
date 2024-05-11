package com.itwillbs.dongbaekcinema.voNew;

import lombok.*;

@Data
public class GradeNextVO {
	// 현재 등급과 다음 등급 정보
	private String grade_name;
	private String next_grade_name;
	private double grade_discount;
	private double next_grade_discount;
	private int grade_max;
	
}
