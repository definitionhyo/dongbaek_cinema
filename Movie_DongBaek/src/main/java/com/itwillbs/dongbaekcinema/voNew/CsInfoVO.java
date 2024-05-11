package com.itwillbs.dongbaekcinema.voNew;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 프로퍼티를 변수로 갖는 생성자
@NoArgsConstructor // 기본생성자
@Data
public class CsInfoVO {

	private int cs_num;
	private String cs_subject;
	private String cs_content;
	private Timestamp cs_date;
	private String cs_type;
	private String cs_file; // 첨부파일 등록을 위해 데이터타입 변경
	private String cs_file_real;
	private String cs_reply;
	private String cs_phone;
	private int cs_type_list_num;
	private String member_id;
	private String member_name;
	private String member_email;
	private String member_phone;
	private MultipartFile file1;
//	private MultipartFile cs_multi_file; // 첨부파일 등록을 위해 데이터타입 변경
	
	
}
