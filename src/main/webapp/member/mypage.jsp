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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/member/mypage.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

</head>
<body>
	<div class="container">
		<div class="row w-100 m-0" id="header">
			<div class="col-12 p-0">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="/index.jsp" style="color: #664E55">앞날의
							지침</a>
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
									aria-current="page" href="#" style="color: #664E55">지출의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/list.brd2" style="color: #664E55">선택의
										참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/csmain.cscenter"
									style="color: #664E55">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/mypage.member"
									style="color: #664E55">마이페이지</a></li>
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
								<p>My Page</p>
								<ul class="nav nav-tabs">
									<li class="nav-item selected"><a class="nav-link active"
										aria-current="page" href="/mypage.member">내 정보 보기</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/myWriting.member?board=1&page=1">내 글 보기</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/myReply.member?board=1&page=1">내 댓글 보기</a></li>
								</ul>
							</div>
						</div>
						<div class="row" id="MyPage">
							<div class="col-12">
								<form action="update.member" method="post">
									<div class="row" id="MyPageArea">
										<div class="col-12" >
											<div class="row">
												<div class="col-12" id="MyPageAreaHeader">MyPage</div>
											</div>
											<div class="row" align=center>
												<div class="col-4">ID</div>
												<div class="col-8">${dto.id }</div>
											</div>
											<div class="row">
												<div class="col-4">NAME</div>
												<div class="col-8">${dto.name }</div>
											</div>
											<div class="row">
												<div class="col-4">PHONE</div>
												<div class="col-8">
													<input type=text value="${dto.phone }" class="editable" name=phone id="phoneTD" disabled>
												</div>
												<div class="col-4"></div>
												<div class="col-8" id="phoneCheckResult"></div>
											</div>
											<div class="row">
												<div class="col-4">EMAIL</div>
												<div class="col-8">
													<input type=text value="${dto.email }" class="editable" name=email id="emailTD" disabled>
												</div>
												<div class="col-4"></div>
												<div class="col-5" id="emailCheckResult"></div>
											</div>
											<div class="row">
												<div class="col-4">NICKNAME</div>
												<div class="col-8">
													<input type=text value="${dto.nickname }" class="editable" name=nickname id="nicknameTD" disabled>
												</div>
												<div class="col-4"></div>
												<div class="col-8" id="nicknameCheckResult"></div>
											</div>
											<div class="row">
												<div class="col-4">JOINDATE</div>
												<div class="col-8">${dto.joindate }</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-12">
											<br>
										</div>
									</div>
									<div class="row w-100 m-0" align=center>
										<div class="col-12" id="btns">
											<button id="modify" type="button">수정하기</button>
											<button id="pw_modify" type="button">비밀번호 수정</button>
											<button id="member_out" type="button">탈퇴하기</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row w-100 m-0" id="footer">
			<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
		</div>
	</div>
	<script>
	
	// 카카오 초기화 및 토큰 받아오기
	Kakao.init('b956cab5ef7dbe5bc1f861614a4b2061');
	//sessionStorage에 저장된 사용자 엑세스 토큰 받아온다.
	window.Kakao.Auth.setAccessToken(JSON.parse(sessionStorage.getItem('AccessKEY')));
	
	// 비밀번호 변경 버튼 클릭시 비밀번호 입력 창 띄우기
	$("#pw_modify").on(
		"click",
		function() {
			window.open("/member/modifiypw.jsp", "",
					"top=100,left=200,width=550,height=350");
			//location.href="/member/memberout.jsp";
		})

	// 탈퇴 버튼 클릭시 비밀번호 입력 창 띄우기
	$("#member_out").on(
			"click",
			function() {
				if(sessionStorage.getItem('AccessKEY') == null) {
					window.open("/member/memberout.jsp", "",
					"top=100,left=200,width=550,height=350");
		    	} else {
		    		let result = confirm("정말로 탈퇴하시겠습니까?");
		    		if(result){
		    		alert("사용자의 계정이 탈퇴 되었습니다.")
		    		Kakao.API.request({
		                url: '/v1/user/unlink',
		                success: function(response) {
		                    console.log(response);
		                    //callback(); //연결끊기(탈퇴)성공시 서버에서 처리할 함수
		                    Kakao.Auth.logout();
		                    window.location.href='/logout.member'
		                },
		                fail: function(error) {
		                    console.log('탈퇴 미완료')
		                    console.log(error);
		                },
		            })
		    		} else {
		    			return false;
		    		}
		    	}
			})
	
	// 수정 버튼 클릭시
	$("#modify").on("click", function() {
		$(".editable").removeAttr("disabled");
		
		//$("#phoneTD").attr("contenteditable", "true");
		$("#emailTD").attr("contenteditable", "true");
		$("#nicknameTD").attr("contenteditable", "true");
		$("#phoneTD").focus();

		$("#modify").css("display", "none");
		
		$("#phoneCheckResult").text("번호만 입력해주세요.");
		$("#phoneCheckResult").css("color", "gray");
		$("#nicknameCheckResult").text("한글, 영문, 숫자, 특수기호(_)를 조합하여 3~8자로 작성.");
		$("#nicknameCheckResult").css("color", "gray");
		
		
		let ok = $("<button>");
		ok.attr({"disabled" : true, "id" : "ok"});
		ok.text("수정완료");

		let cancel = $("<button>");
		cancel.text("수정취소");
		cancel.attr("type", "button");
		cancel.css("margin-left", "5px")
		cancel.on("click", function() {
			location.reload();
		})

		$("#btns").prepend(cancel);
		$("#btns").prepend(ok);
	})
	
	// -------------Regex-------------------
	// submit 버튼 활성화용 boolean 변수 선언
	let isPhoneOk = true;
	let isEmailOk = true;
	let isNNOk = true;

	// 전화번호 검증
	$("#phoneTD").on("keyup",function() { 
		let phone = $("#phoneTD").val();
		let phoneRegex = /^01[0-9]{1}[0-9]{3,4}[0-9]{4}$/;
		
		if (phone == "") {
			$("#ok").attr("disabled", true);
			$("#phoneCheckResult").text("필수입력 항목입니다.");
			$("#phoneCheckResult").css("color", "red");
			isPhoneOk = false;
			return false;
		}
		
		if(!phoneRegex.test(phone)) {
			$("#ok").attr("disabled", true);
			$("#phoneCheckResult").text("형식이 올바르지 않습니다.");
			$("#phoneCheckResult").css("color", "red");
			return false;
		} else {
			$("#phoneCheckResult").text("올바른 전화번호 형식입니다.");
			$("#phoneCheckResult").css("color", "blue");
			isPhoneOk = true;
			//모든 검증 통과 시 submit 버튼 활성화
			
			if (isPhoneOk && isEmailOk && isNNOk) {
				$("#ok").removeAttr("disabled");
			}
		}
		
	})
	
	// 이메일 검증
	$("#emailTD").on("keyup",function() { 
			let email = $("#emailTD").val();
			let emailRegex = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
			
			if (email == "") {
				$("#ok").attr("disabled", true);
				$("#emailCheckResult").text("필수입력 항목입니다.");
				$("#emailCheckResult").css("color", "red");
				isEmailOk = false;
				return false;
			}
			
			if(!emailRegex.test(email)) {
				$("#ok").attr("disabled", true);
				$("#emailCheckResult").text("형식이 올바르지 않습니다.");
				$("#emailCheckResult").css("color", "red");
				isEmailOk = false;
				return false;
			} else {
				$("#emailCheckResult").text("올바른 이메일 형식입니다.");
				$("#emailCheckResult").css("color", "blue");
				isEmailOk = true;
				//모든 검증 통과 시 submit 버튼 활성화
				
				if (isPhoneOk && isEmailOk && isNNOk) {
					$("#ok").removeAttr("disabled");
				}
			}
		})
		
	// 닉네임 검증
	$("#nicknameTD").on("keyup",function() { 
			let nickname = $("#nicknameTD").val();
			let nicknameRegex = /^[가-힣a-zA-Z0-9_]{3,8}$/;
			
			if (nickname == "") {
				$("#ok").attr("disabled", true);
				$("#nicknameCheckResult").text("필수입력 항목입니다.");
				$("#nicknameCheckResult").css("color", "red");
				isNNOk = false;
				return false;
			}
			
			if(!nicknameRegex.test(nickname)) {
				$("#ok").attr("disabled", true);
				$("#nicknameCheckResult").text("형식이 올바르지 않습니다.");
				$("#nicknameCheckResult").css("color", "red");
				isNNOk = false;
				return false;
			} else {
				$.ajax({
					url : "/nnDuplCheck.member",
					data : {nickname : $("#nickname").val()}
				}).done(function(resp) {
					let result = JSON.parse(resp);
					if (result) {
						$("#ok").attr("disabled", true);
						$("#nicknameCheckResult").text("이미 존재하는 닉네임입니다.");
						$("#nicknameCheckResult").css("color", "red");
						isNNOk = false;
						return false;
					} else {
						$("#nicknameCheckResult").text("사용가능한 닉네임입니다.");
						$("#nicknameCheckResult").css("color", "blue");
						isNNOk = true;

						//모든 검증 통과 시 submit 버튼 활성화
						if (isPhoneOk && isEmailOk && isNNOk) {
							$("#ok").removeAttr("disabled");
						}
					}
				})
			}
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