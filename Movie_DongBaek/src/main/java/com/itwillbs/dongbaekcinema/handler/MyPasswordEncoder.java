package com.itwillbs.dongbaekcinema.handler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.itwillbs.dongbaekcinema.vo.MemberVO;

// 비밀번호 암호화 & 매칭 작업
public class MyPasswordEncoder {

		// 1. 어노테이션으로 BCryptPasswordEncoder객체 생성
		@Autowired
		private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		private MemberVO member;
		
		// 2. 암호화 수행하는 getCryptoPasswd() 메서드 정의
		// => 파라미터 : 평문(String rawPassword) 	리턴타입 : String
		public String getCryptoPasswd(String rawPassword) {
			String securePassword = passwordEncoder.encode(rawPassword);
			
//			System.out.println("평문 : " + member.getMember_pass());
//			System.out.println("암호문 : " + securePassword ); // 매번 동일한 함호라도 결과가 다르다
			
		// 3. 암호문 리턴
			return securePassword;
		}

		
		// 두 문자열 비교를 수행할 isSameCryptoPassword() 메서드 정의
		// => 파라미터 : 평문(String rawPassword), 암호문(String EncryptedPasword)
		public boolean isSameCryptoPassword(String rawPassword, String EncryptedPassword) {
			// => 리턴타입 : boolean
			// => 입력 받은 평문은 그대로 두고, DB에 저장된 패스워드를 가져와서 비교
			// BCryptPasswordEncoder 객체의 matches() 메서드를 호출하여 두 암호 비교
			// 파라미터 : 평문, 암호화된 암호 를 순서대로 입력
			// 리턴타입 : boolean
			return passwordEncoder.matches(rawPassword, EncryptedPassword);
		}
		
}
