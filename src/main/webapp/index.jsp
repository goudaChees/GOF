<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>앞날의 지침</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
	integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
	integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
	crossorigin="anonymous"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
      	// SDK를 초기화. 사용할 앱의 JavaScript 키
      	Kakao.init('b956cab5ef7dbe5bc1f861614a4b2061');
      	console.log(Kakao.isInitialized());
</script>
<style>
* {
	box-sizing: border-box;
}

div {
	border: 1px solid black;
	text-align: center;
}
</style>

</head>
<body>
	<c:choose>
		<c:when test="${loginID =='admin'}">
			<!-- 세션에 관리자 아이디로 로그인시 -->
			<div class="container w-100"
				style="max-width: 100%; padding: 0; margin: 0; position: relative;">
				<nav class="navbar navbar-expand-lg navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="index.jsp">앞날의 지침</a>
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
									aria-current="page" href="#">지출의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="csmain.cscenter">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">관리자페이지</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</c:when>

		<c:when test="${loginID !=null}">
			<!-- 세션에 아이디가 존재할때 -->
			<div class="container w-100"
				style="max-width: 100%; padding: 0; margin: 0; position: relative;">
				<nav class="navbar navbar-expand-lg navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="index.jsp">앞날의 지침</a>
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
									aria-current="page" href="#">지출의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="csmain.cscenter">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">마이페이지</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</c:when>
		<c:otherwise>
			<!-- 세션에 아이디가 없을 때 -->
			<div class="container w-100"
				style="max-width: 100%; padding: 0; margin: 0; position: relative;">
				<nav class="navbar navbar-expand-lg navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="index.jsp">앞날의 지침</a>
						<button class="navbar-toggler" type="button"
							data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
							aria-controls="navbarNavDropdown" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse justify-content-end"
							id="navbarNavDropdown">
							<ul class="navbar-nav">
								<li class="nav-item"><a class="nav-link active nonMember"
									aria-current="page" href="#">지출의 참견</a></li>
								<li class="nav-item"><a class="nav-link active nonMember"
									aria-current="page" href="#">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="joinform.member">회원가입</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
			<form action="login.member" method="post">
				<div class="container">
					<div class="row">
						<div class="col-12">Login</div>
					</div>
					<div class="row">
						<div class="col-4 p-0">아이디 :</div>
						<div class="col-8 p-0">
							<input type="text" id="id" name="id" placeholder="input your id">
						</div>
					</div>
					<div class="row">
						<div class="col-4 p-0">패스워드 :</div>
						<div class="col-8 p-0">
							<input type="password" id="pw" name="pw"
								placeholder="input your pw">
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<input type="submit" id="login" value="로그인"
								style="background-color: #dfe7fd; border: 1px solid #cddafd;">
							<input type="button" id="kakao-login-btn" value="카카오로 로그인"
								style="background-color: #dfe7fd; border: 1px solid #cddafd;">
							<input type="button" id="kakao-logout" value="카카오로 로그아웃"
								style="background-color: #dfe7fd; border: 1px solid #cddafd;">
						</div>
					</div>
				</div>
			</form>
		</c:otherwise>
	</c:choose>

	<div class="row w-100 m-0" id="footer">
		<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
	</div>

	<script>
    	$(".nonMember").on("click",function(){ // 로그인 하지 않고 게시판 1,2 클릭 시 팝업
    		Swal.fire({
    			  title: '회원가입 후 이용 가능합니다.',
    			  text: "회원가입 페이지로 이동합니다.",
    			  icon: 'warning',
    			  showCancelButton: true,
    			  confirmButtonColor: '#3085d6',
    			  cancelButtonColor: '#d33',
    			  confirmButtonText: '확인',
    			  cancelButtonText: '취소',
    			}).then((result) => {
    			  if (result.isConfirmed) {
    			    location.href="/join.member"
    			  }
    			})
    	})

    	$("#login").on("click",function(){ // 일반회원 로그인시
    		$.ajax({
    			url:"/login.member",
    			data:{id:$("#id").val(),
    				pw:$("#pw").val()},
    			type="POST"
    		}).done(function(resp){
    			let result = JSON.parse(resp)
    			if(!result){
    				Swal.fire({
    					  icon: 'error',
    					  title: 'Oops...',
    					  text: '입력하신 회원정보가 존재하지 않습니다.'
    					})
    			}
    		})
    	})

	    $("#kakao-login-btn").on("click", function(){
	    //1. 로그인 시도
	    Kakao.Auth.login({
	        success: function(authObj) {
	         
	          //2. 로그인 성공시, API 호출
	          Kakao.API.request({
	            url: '/v2/user/me',
	            success: function(res) {
	              console.log(res);
	              let id = res.id;
				  scope : 'profile_nickname, account_email';
				alert('로그인성공');
	              //location.href="loginok.jsp";
	        	}
	          })
	          console.log(authObj); //access 토큰 값
			  Kakao.Auth.setAccessToken(authObj.access_token); //access 토큰 값 저장
			  var token = authObj.access_token;
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	    })
	    
	    $("#kakao-logout").on("click", function(){
			
			if (!Kakao.Auth.getAccessToken()) {
	      			alert('Not logged in.')
	      			return
	    		}
	    		Kakao.Auth.logout(function() {
	      			alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken());
	   		 	})
	  		
		  })
    </script>
</body>
</html>