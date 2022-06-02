<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>myPage</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/member/myWriting.css">
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/letter/letter_list.css">
<link rel="stylesheet" href="/css/letter/letter_Write.css">
</head>
<body>
	<div class="container w-100">
		<div class="row w-100 m-0" id="header">
			<div class="col-12 p-0">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="/index.jsp" style="color: #664E55"><img
							src="/img/logo.png" id="logo"></a>
						<button class="navbar-toggler" type="button"
							data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
							aria-controls="navbarNavDropdown" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse justify-content-end"
							id="navbarNavDropdown">
							<ul class="navbar-nav">
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/list.brd1?cpage=1"
									style="color: #664E55">살까말까</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/list.brd2" style="color: #664E55">최저가경매</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/csnotice.cscenter"
									style="color: #664E55">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/mypage.member"
									style="color: #664E55">마이페이지</a></li>
								<li class="nav-item"><a class="nav-link active" aria-current="page" href="/list.letter?type=r&page=1">
											<i class="bi bi-envelope" style="color: #664E55"></i></a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#"><i
										class="bi bi-box-arrow-right" style="color: #664E55"></i></a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>

		<div class="row w-100 m-0" id="content">
			<div class="d-none d-lg-block col-3"></div>
			<div class="col-12 col-lg-6">
				<div class="row w-100 m-0" id="MyPageOutline">
					<div class="col-12">
						<div class="row w-100 m-0" id="MyPageHeader">
							<div class="col-12">
								<a href="/mypage.member"><img src="/img/nametagmypage.png" id="nametag"></a><br>
								<ul class="nav nav-tabs">
									<li class="nav-item"><a class="nav-link"
										href="/mypage.member">내 정보 보기</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/myWriting.member?board=1&page=1">내 글 보기</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/myReply.member?board=1&page=1">내 댓글 보기</a></li>
									<li class="nav-item"><a class="nav-link active"
										aria-current="page" href="/list.letter?type=r&page=1">메세지함</a></li>
								</ul>
							</div>
						</div>
						<div class="row w-100 m-0" id="mywriting">
							<div class="col-12">
								<form action="/send.letter" id="letterForm" method="post">
									<span id="headTitle">메세지 보내기</span>
									<div id="msg_Box">
										<div class="row w-80 m-0">
											<div class="col-12 infoWrapper">
												<div class="info-m">보내는 사람 <span style="font-weight:normal"> ${nickname }</span></div>
											</div>
											<div class="col-12 infoWrapper">
												<div class="info-m">받는 사람</div>
												<c:choose>
													<c:when test='${receiver!=null }'>
														<input type="text" class="inputBox-m" id="receiver" name="receiver"
															value="${receiver }" readonly>
													</c:when>
													<c:otherwise>
														<input type="text" class="inputBox-m" id="receiver"
															name="receiver" placeholder="닉네임 검색" readonly>
														<input type="button" value="검색" id="searchBtn"
															class="searchBtn">
													</c:otherwise>
												</c:choose>
											</div>
											<div class="col-12 infoWrapper">
												<div class="info-m">제목</div>
												<input type="text" id="title" class="inputBox-m" name="title"
													placeholder="제목을 입력해주세요" maxlength="30">
											</div>
											<div class="col-12 infoWrapper" id="contents_Box">
												<div class="info-m" id="contents_Info" style="width: 100%">내용</div>
												<textarea id="contents" class="inputBox-m" name="contents"
													placeholder="내용을 입력해주세요" style="margin-left: 2px" maxlength="300"></textarea>
											</div>
											<div class="col-12" id="mbtns">
												<input type="button" id="msg_Submit" class="msg_btn" value="보내기"> 
												<input type="button" id="msg_Cancel" class="msg_btn" value="취소">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row w-100 m-0" id="footer"
			style="background-color: #A2BAAC; font-weight: bold;">
			<div class="col-12 p-0 d-lg-none">
				<div
					style="padding-top: 20px; padding-bottom: 10px; text-align: center; font-size: min(14px, 3.5vw);">
					<a href="/csnotice.cscenter" class="footerLink">
						<span>공지사항</span></a>
					<span style="margin-left: 20px" class="footerBar">|</span>
					<a href="/csmain.cscenter" class="footerLink">
						<span style="margin-left: 20px">자주 묻는 질문</span></a>
					<span style="margin-left: 20px" class="footerBar">|</span> 
					<a href="/csemail.cscenter" class="footerLink">
						<span style="margin-left: 20px">1 : 1 문의</span></a>
					<span style="margin-left: 20px" class="footerBar">|</span> 
					<a href="/csmap.cscenter" class="footerLink">
						<span style="margin-left: 20px;">찾아오시는 길</span></a><br>
					<div style="margin-top: 15px; text-align: center">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩
							2층, 3층</span><br> <span class="footerLetter">대 표 전 화 : 4989
							- 4284</span> <span style="margin-left: 10px; margin-right: 10px"
							class="footerLetter">|</span> <span class="footerLetter">E-MAIL
							: ttaengerang@gmail.com </span><br> <span
							style="color: #FFF2CC; font-size: min(15px, 4vw); line-height: 40px;">COPYRIGHT
							BY PHOENIX </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-9">
				<div style="margin-left: 40px; margin-top: 20px; text-align: left">
					<a href="/csnotice.cscenter" class="footerLink"><span>공지사항</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csmain.cscenter" class="footerLink"><span style="margin-left:20px">자주 묻는 질문</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csemail.cscenter" class="footerLink"><span style="margin-left:20px">1 : 1 문의</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csmap.cscenter" class="footerLink"><span style="margin-left:20px">찾아오시는 길</span></a><br>
					<div
						style="margin-top: 30px; text-align: left; margin-bottom: 15px">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩
							2층, 3층</span><br> <span class="footerLetter">대 표 전 화 : 4989
							- 4284</span><span style="margin-left: 20px" class="footerLetter">|</span><span
							style="margin-left: 20px" class="footerLetter">E-MAIL :
							ttaengerang@gmail.com </span><br> <span style="color: #FFF2CC">COPYRIGHT
							BY YUNJI AYEONG WOOHYENG JEONGYOEN HEESEUNG IN PHOENIX </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-3" style="text-align: right">
				<img src="/img/footerLogo.png"
					style="width: 70%; margin-right: 10px; margin-top: 10%">
			</div>
		</div>
	</div>
	<script>
         
         function openSearchNN(){
            window.name = "parentForm";
            
            searchPop = window.open("/letter/letter_Search.jsp", "",
                  "top=200,left=400,width=550,height=350");
         }
      
         $("#searchBtn").on("click",function(){
            openSearchNN();
         })
         
         $("#msg_Submit").on("click",function(){
        	 if($("#receiver").val().length==0){
        		 Swal.fire({
        			icon:'warning',
   				  title: '작성자를 입력해주세요.',
   				  confirmButtonText: '확인'
   				});
        		return false;
        	 }
        	 
        	 if($("#title").val().length==0){
        		 Swal.fire({
        			icon:'warning',
   				  title: '제목을 입력해주세요.',
   				  confirmButtonText: '확인'
   				});
        		return false;
        	 }
        	 
        	 if($("#contents").val().length==0){
        		 Swal.fire({
        			icon:'warning',
   				  title: '내용을 입력해주세요.',
   				  confirmButtonText: '확인'
   				});
        		return false;
        	 }
        	 
        	 
				Swal.fire({
				  title: '작성하신 쪽지를 보내시겠습니까?',
				  showCancelButton: true,
				  confirmButtonText: '보내기',
				  cancelButtonText: '취소'
				}).then((result) => {
					if (result.isConfirmed) {
						Swal.fire({
							icon: 'success',
							title: '메세지 전송 완료'
						}).then((result2) => {
							if (result2.isConfirmed) {
							$("#letterForm").submit();
							}
						})
					}
				})
			})
         
         $("#msg_Cancel").on("click",function(){
            location.href="/list.letter?type=r&page=1";
         })
      
      
         //로그아웃 관련 공통기능
         // SDK를 초기화. 사용할 앱의 JavaScript 키
         Kakao.init('b956cab5ef7dbe5bc1f861614a4b2061');
       //console.log(Kakao.isInitialized());
       
       //item을 localStorage에 저장하는 메소드
       function saveToDos(token) { 
          typeof(Storage) !== 'undefined' && sessionStorage.setItem('AccessKEY', JSON.stringify(token)); 
      };
        $(".bi-box-arrow-right").on("click",function(){
           if (!Kakao.Auth.getAccessToken()) {
           Swal.fire({
              text: '로그아웃 하시겠습니까?',
              showCancelButton: true,
              confirmButtonText: '로그아웃',
              cancelButtonText: '취소',
            }).then((result) => {
              if (result.isConfirmed) {            
                location.href="/logout.member";              
              } 
            })
            return
           }
         // -- 로그아웃 버튼 클릭시 카카오톡으로 로그인한 사용자의 토큰을 반납.
         let result = confirm("로그아웃 하시겠습니까?");
         if(!result){
            return false;
         } else {
           Kakao.Auth.logout(function() {
                  alert("로그아웃 되었습니다.");
                  location.href="/logout.member";
                })
         }
        })
        
   </script>
</body>
</html>