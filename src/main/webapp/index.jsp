<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>땡그랑</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/index.css">
<link rel="stylesheet" href="/css/common.css">

</head>
<body>

	<div class="container w-100 p-0">
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
								<c:choose>
									<c:when test="${loginID =='admin'}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd1?cpage=1"
											style="color: #664E55">살까말까</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color: #664E55">최저가경매</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csnotice.cscenter"
											style="color: #664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/adminmain.admin"
											style="color: #664E55">관리자페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#"><i
												class="bi bi-box-arrow-right" style="color: #664E55"></i></a></li>
									</c:when>
									<c:when test="${loginID !=null}">
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
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#"><i
												class="bi bi-box-arrow-right" style="color: #664E55"></i></a></li>
									</c:when>
									<c:otherwise>
										<li class="nav-item nonMember"><a class="nav-link active"
											aria-current="page" href="#" style="color: #664E55">살까말까</a></li>
										<li class="nav-item nonMember"><a class="nav-link active"
											aria-current="page" href="#" style="color: #664E55">최저가경매</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csnotice.cscenter"
											style="color: #664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/joinform.member"
											style="color: #664E55">회원가입</a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>

		<c:choose>
			<c:when test="${loginID !=null}">
				<div class="row w-100 m-0" id="main">
					<div class="col-12 p-0">
						<img src="/img/after_main.png" id="bgImg">
					</div>
					<div class="col-12">
					<div class="row w-100 m-0">
						<div class="col-12 col-sm-8" align=left>
							<div class="row">
								<div class="col-12" style="text-align: left">
									<img src="/img/logoname.png" style="width: 250px;">
									<h3 style="padding-left: 30px;">당신이 부자가 될 때 까지</h3>
									<h5 style="padding-left: 30px;" id="hello">
										<img src='/img/pinkpig_front.png' style='width: 8%'>
										${loginID }님 환영합니다!
										<img src='/img/pinkpig_paw.png' style='width: 8%'>
									</h5>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<img src="/img/flyingPig_small.png" id=flyingpig style="width: 200px">
						</div>
					</div>
					<div class="row w-100 m-0 my-5 px-3" >
						<div class="col-12 col-md-8" id=imgbox>
							<div class="row">
								<div class="col-6 col-md-3">
									<a href="/list.brd1?cpage=1">
									<div class="card">
										<img src="/img/card_basket.png" class="cardimg px-3">
										<p>살까말까</p>
									</div>
									</a>
								</div>
								<div class="col-6 col-md-3">
									<a href="/list.brd2">
									<div class="card">
										<img src="/img/card_shoppingbag.png" class="cardimg px-3">
										<p>최저가경매</p>
									</div>
									</a>
								</div>
								<div class="col-6 col-md-3">
									<a href="/csmain.cscenter">
									<div class="card">
										<img src="/img/card_clipboard.png" class="cardimg px-3">
										<p>고객센터</p>
									</div>
									</a>
								</div>
								<div class="col-6 col-md-3">
									<a href="/mypage.member">
									<div class="card">
										<img src="/img/card_mypage.png" class="cardimg px-3">
										<p>마이페이지</p>
									</div>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row w-100 m-0" id="content">
					<div class="col-12">
						<img src="/img/Main.png" id="bgImg">
					</div>
					<div class="col-12" id="loginArea">
						<img src="/img/loginBg_center.png" class="d-none d-lg-block"
							id="loginBg"> <img src="/img/mloginBg_center.png"
							class="d-block d-lg-none" id="mloginBg">

						<form action="login.member" method="post">
							<div class="row" id="loginInput">
								<div class="col-12 p-0">
									<input type="text" id="id" name="id" placeholder="아이디 입력">
								</div>
								<div class="col-12 p-0">
									<input type="password" id="pw" name="pw" placeholder="비밀번호 입력">
								</div>
								<div class="col-12">
									<input type="button" id="login" value="로그인"><br> <img
										src="/img/kakao_login.png" id="kakao-login-btn"><br>
								</div>
								<div class="col-4"></div>
								<div class="col-4 loginlastline">
									<a href="#" id="findId">아이디</a> / <a href="#" id="findPW">비밀번호
										찾기</a>	 / <a href="/joinform.member" id="joinbtn">회원가입</a>
								</div>
								<div class="col-4"></div>
							</div>
						</form>
					</div>
				</div>
			</c:otherwise>
		</c:choose>

		<div class="row w-100 m-0" id="footer" style="background-color: #A2BAAC; font-weight: bold;">
			<div class="col-12 p-0 d-lg-none">
				<div style="padding-top: 20px; padding-bottom:10px; text-align: center; font-size:min(14px,3.5vw);">
					<a href="/csmain.cscenter" class="footerLink">
						<span>자주 묻는 질문</span></a>
					<span style="margin-left: 20px" class="footerBar">|</span> 
					<a href="/csemail.cscenter" class="footerLink">
						<span style="margin-left: 20px">1 : 1 문의</span></a>
					<span style="margin-left: 20px" class="footerBar">|</span> 
					<a href="/csmap.cscenter" class="footerLink">
						<span style="margin-left: 20px;">찾아오시는 길</span></a><br>
					<div style="margin-top: 15px; text-align: center">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩 2층, 3층</span><br> 
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span>
						<span style="margin-left: 10px; margin-right:10px" class="footerLetter">|</span>
						<span class="footerLetter">E-MAIL : ttaengerang@gmail.com </span><br> 
						<span style="color: #FFF2CC;font-size:min(15px,4vw);line-height:40px;">COPYRIGHT BY PHOENIX </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-9">
				<div style="margin-left:40px ; margin-top:20px;text-align:left">
					<a href="/csmain.cscenter" class="footerLink"><span>자주 묻는 질문</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csemail.cscenter" class="footerLink"><span style="margin-left:20px">1 : 1 문의</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csmap.cscenter" class="footerLink"><span style="margin-left:20px">찾아오시는 길</span></a><br>
					<div style="margin-top:30px ; text-align:left; margin-bottom:15px">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩 2층, 3층</span><br>
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span><span style="margin-left:20px" class="footerLetter">|</span><span style="margin-left:20px" class="footerLetter">E-MAIL : ttaengerang@gmail.com </span><br>
						<span style="color:#FFF2CC">COPYRIGHT BY YUNJI AYEONG WOOHYENG JEONGYOEN HEESEUNG IN  PHOENIX  </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-3" style="text-align:right">
				<img src="/img/footerLogo.png" style="width:70%;margin-right:10px;margin-top:10%">
			</div>
		</div>
	</div>

	<script>
		$("#findId").on("click",function(){
			window.open("/member/findid.jsp", "",
			"top=100,left=200,width=550,height=350");
		})
		$("#findPW").on("click",function(){
			window.open("/member/findpw.jsp", "",
			"top=100,left=200,width=550,height=500");
		})
    	$(".nonMember").on("click",function(){ // 로그인 하지 않고 게시판 1,2 클릭 시 팝업
    		Swal.fire({
			  icon: 'info',
			  text: '로그인 후 사용 가능합니다.'
			})
    	})
    	$("#login").on("click",function(){ // 일반회원 로그인시
    		$.ajax({
    			url:"/login.member",
    			data:{id:$("#id").val(),
    				pw:$("#pw").val()},
    			type:"POST"
    		}).done(function(resp){
    			if(resp=='false'){
    				Swal.fire({
    					  icon: 'error',
    					  title: 'Oops...',
    					  text: '아이디와 비밀번호가 존재하지 않습니다.'
   					})
    				$("#id").val("");
    				$("#pw").val("");
    			}else{
    				location.reload();
    			}
    		})
    	})
    	
      	// SDK를 초기화. 사용할 앱의 JavaScript 키
      	Kakao.init('b956cab5ef7dbe5bc1f861614a4b2061');
	    //console.log(Kakao.isInitialized());
	    
	    //item을 localStorage에 저장하는 메소드
	    function saveToDos(token) { 
    		typeof(Storage) !== 'undefined' && sessionStorage.setItem('AccessKEY', JSON.stringify(token)); 
		};
	    $("#kakao-login-btn").on("click", function(){
	    //1. 로그인 시도
	    Kakao.Auth.login({
	        success: function(authObj) {
	         
	          //2. 로그인 성공시, API 호출
	          Kakao.API.request({
	            url: '/v2/user/me',
	            success: function(res) {
// 	              console.log(res);
	              let id = res.id;
				  scope : 'profile_nickname, account_email';
				
	              $.ajax({
	            	    url:"/kakaoCheck.member",
	            	    data:{id:res.id,
	            	    	email:res.kakao_account.email,
	            	    	nickname:res.properties.nickname,
	            	    	token:authObj.access_token},
	            	    type:"POST"
	            	}).done(function(resp){
	            		location.reload();
	            		
	            	})
	        	}
	          })
// 	          console.log(authObj); //access 토큰 값
			  Kakao.Auth.setAccessToken(authObj.access_token); //access 토큰 값 저장
			  var token = authObj.access_token;
			  saveToDos(token);
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	    })
		  
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