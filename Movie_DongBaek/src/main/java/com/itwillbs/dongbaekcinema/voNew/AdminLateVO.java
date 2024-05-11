package com.itwillbs.dongbaekcinema.voNew;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 프로퍼티를 변수로 갖는 생성자
@NoArgsConstructor // 기본생성자
@Data
public class AdminLateVO {

		private int dayCount; // 배열 인덱스(0~3)
		private String dateNow; //
		private int joinLate; // 해당일 회원가입수 당일
		private int orderLate; // 예매 수
		private int movie_num; // 영화 번호
		private String movie_name_kr; // 영화 이름
		private int movieLate; // 오늘자 기준 영화 예매 수
//		private int movieOrderCount; // 영화 예매수
//		private int totalOrderCount; // 총 예매수
		private double movieOrderLate; // 영화별 예매율( 영화 예매수/총 예매수)
		
}
