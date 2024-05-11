package com.itwillbs.dongbaekcinema.vo;

import java.sql.*;

import org.springframework.web.multipart.*;

import lombok.*;

@Data	// lombok -> Getter/Setter, 기본생성자, toString() 오버라이딩
public class CsVO {
	private int cs_num;
	private String cs_subject;
	private String cs_content;
	private Timestamp cs_date;
	private String cs_type;
	private MultipartFile cs_file;
	private String cs_file_real;	// 저장되는 파일명(uuid+파일명.확장자)
	private String cs_reply;
	private String cs_phone;
	private int cs_type_list_num;
	private String member_id;
	
}
