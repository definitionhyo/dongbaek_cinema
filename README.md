# 동백씨네마 (Dongbaek Cinema) – 영화 예매 웹앱

> 사용자는 영화를 예매하고, 관리자는 영화 등록 및 관리를 할 수 있는 웹 애플리케이션입니다.

---

### 📌 자료
- **PPT 보기:** [동백씨네마_PPT.pdf](docs/동백씨네마.pdf)

---

## 관리자 페이지 회원관리

### 화면 예시
<img src="screenshots/dongbaek_admin_movielist.png" width="450" />
<img src="screenshots/dongbaek_memberInformation.png" width="450" />
<img src="screenshots/dongbaek_memberDelete.png" width="450" />

- **기능:**
  - **CRUD**: 회원 관리 기능 (생성, 읽기, 수정, 삭제)
  - **비회원 버튼 클릭 시 삭제 모달 출력**
  - **검색**: 이름, 아이디, 멤버십으로 검색
  - **수정, 삭제 시**: 모달창으로 확인

---

## 관리자 페이지 영화관리

### 화면 예시
<img src="screenshots/dongbaek_admin_movielist.png" width="450" />
<img src="screenshots/dongbaek_movieRegistration.png" width="450" />
<img src="screenshots/dongbaek_movieChangeModal.png" width="450" />

- **기능:**
  - **CRUD**: 영화 관리 기능 (생성, 읽기, 수정, 삭제)
  - **영화정보 API**: KOBIS API 연동
  - **등록하기 버튼 클릭 시**: 필수 입력값, 중복 검사 후 등록
  - **검색**: 영화 제목으로 검색
  - **수정, 삭제 시**: 모달창으로 확인

---

## 관리자 페이지 결제관리

### 화면 예시
<img src="screenshots/dongbaek_payment.png" width="450" />
<img src="screenshots/dongbaek_accountCancel.png" width="450" />

- **기능:**
  - **CRUD**: 결제 관리 기능 (생성, 읽기, 수정, 삭제)
  - **결제취소 API**: I’mport 결제 취소 연동
  - **검색**: 아이디로 결제 내역 검색
  - **결제 취소 시**: 모달창으로 확인

---

### 🛠 프로젝트 개요
- **기간:** 2023‑05‑17 ~ 2023‑06‑30  
- **팀 구성:** 7명 (부산 ITWILL 교육센터 팀 프로젝트)

### 🔧 기술 스택
- **언어**: Java, JSP, HTML, CSS, JavaScript  
- **프레임워크/라이브러리**: Spring, MyBatis, jQuery, AJAX, Bootstrap  
- **서버/DB**: Apache Tomcat, MySQL  
- **도구**: GitHub, Notion, Discord, Google Drive

---

### 🎯 담당 역할
- **관리자 페이지 CRUD 구현**  
- **KOBIS API** 연동  
- **I’mport API** 결제 연동  

---

### ✨ 회고 & 성과
> 처음으로 진행한 개발 프로젝트였기 때문에 시간이 부족하다고 느꼈지만, 팀원들과 역할을 분담하고 협력하여 프로젝트를 마무리할 수 있었습니다.  
> 개발 절차를 따르며 전반적인 개발 흐름을 이해하는 데 큰 도움이 되었고, API 연동 과정에서 발생한 오류를 분석하고 해결하며 문제 해결 능력을 강화할 수 있었습니다.  
> 또한, 문제 해결 과정에서 팀워크와 주석의 중요성을 재확인했으며, 다음 프로젝트에서는 공동 코드 작성 및 협업 방식을 개선할 계획입니다.
