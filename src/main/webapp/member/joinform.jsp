<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">	
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/member/joinform.css">
<link rel="stylesheet" href="/css/common.css">

</head>
<body>
	<div class="container w-100">
		<div class="row w-100 m-0" id="header">
			<div class="col-12 p-0">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="/index.jsp" style="color:#664E55"><img src="/img/logo.png" id="logo"></a>
						<button class="navbar-toggler" type="button"
							data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
							aria-controls="navbarNavDropdown" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse justify-content-end"
							id="navbarNavDropdown">
							<ul class="navbar-nav">
								<li class="nav-item nonMember"><a class="nav-link active"
									aria-current="page" href="#" style="color:#664E55">살까말까</a></li>
								<li class="nav-item nonMember"><a class="nav-link active"
									aria-current="page" href="#" style="color:#664E55">최저가경매</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/csmain.cscenter" style="color:#664E55">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/joinform.member" style="color:#664E55">회원가입</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>

		<div class="row w-100 m-0" id="content">
				<div class="d-none d-lg-block col-3"></div>
				<div class="col-12 col-lg-6">
					<div class="row w-100 m-0" id="joinFormOutline">
						<div class="col-12" style="height:100%;">
							<div class="row" id="joinFormHeader">
								<div class="col-12">회원 가입 정보 입력</div>
							</div>
							<div class="row" id="joinFormArea">
								<div class="col-12" style="height:100%;">
									<form method="post" action="join.member" id="joinform">
									<div class="row">
										<div class="col-3">아이디</div>
										<div class="col-9">
											<input type="text" id="id" name="id" placeholder="영문, 숫자 5~11자">
										</div>
										<div class="col-3"></div>
										<div class="col-9" id="idCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">비밀번호</div>
										<div class="col-9">
											<input type="password" id="pw1" name="pw1" placeholder="영문, 숫자 8~12자">
										</div>
										<div class="col-3"></div>
										<div class="col-9" id="pw1CheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">비밀번호 확인</div>
										<div class="col-9">
											<input type="password" id="pw2">
										</div>
										<div class="col-3"></div>
										<div class="col-9" id="pw2CheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">이름</div>
										<div class="col-9">
											<input type="text" id="name" name="name" placeholder="한글 성명 2~5자">
										</div>
										<div class="col-3"></div>
										<div class="col-9" id="nameCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">핸드폰 번호</div>
										<div class="col-9">
											<input type="text" id="phone1" name="phone1" value="010"> - <input type="text"
												id="phone2" name="phone2"> - <input type="text" id="phone3"
												name="phone3">
										</div>
										<div class="col-3"></div>
										<div class="col-9" id="phoneCheckResult"></div>
									</div>
									<div class="row" id="emailInputArea">
										<div class="col-3">이메일</div>
										<div class="col-9">
											<input type="text" id="email" name="email">
											<button type="button" id="sendmail" disabled>인증메일 발송</button><span id="emailresult"></span>
										</div>
										<div class="col-3"></div>
										<div class="col-9">
											<input type="text" id="emailKey" style="display: none;" value="no">
											<input type="text" id="emailKeyInput" style="display: none;" placeholder="인증키 입력">
											<button type="button" id="okbtn" style="display: none;">인증확인</button>
										</div>
										<div class="col-3"></div>
										<div class="col-9" id="emailCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">닉네임</div>
										<div class="col-9">
											<input type="text" id="nickname" name="nickname">
										</div>
										<div class="col-3"></div>
										<div class="col-9" id="nnCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3"></div>
										<div class="col-9" style="text-align: center;">
											<input type="reset"	value="다시 입력" id="reset" class="order-1 order-lg-2">
											<input type="button" value="회원가입" id="join" class="order-2 order-lg-1" disabled> 
										</div>
									</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="d-none d-lg-block col-3">
					<img src="/img/frontpig.png" id="frontpig">
				</div>
			</div>
		<div class="row w-100 m-0" id="footer" style="background-color:#A2BAAC; font-weight:bold">
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
						<span>E-MAIL : 4989 - 4284 </span><br> 
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
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span><span style="margin-left:20px" class="footerLetter">|</span><span style="margin-left:20px" class="footerLetter">E-MAIL : 4989 - 4284 </span><br>
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
	
		$(".nonMember").on("click",function(){ // 로그인 하지 않고 게시판 1,2 클릭 시 팝업
			Swal.fire({
				icon: 'error',
				title: 'Oops...',
				text: '회원 가입 후 이용 가능합니다.'
			})
		})
		
		let isIdOk = false;     // submit 버튼 활성화용 boolean 변수 선언
		let isPwOk = false;
		let isPw2Ok = false;
		let isNameOk = false;
		let isPhoneOk = false;
		let isEmailOk = false;
		let isNNOk = false;       

		$("#id").on("keyup",function() { // 아이디 입력 검증
			let id = $("#id").val();
			if (id == "") {
				$("#id").css("border", "1px solid red");
				$("#idCheckResult").css("color", "red");
				$("#idCheckResult").text("ID는 필수 입력 정보입니다.")
				isIdOk = false;
				$("#join").attr("disabled","true");
				return false;
			}
			let idRegex = /^[a-z0-9_]{5,11}$/;
			let idResult = idRegex.test(id);
			if (!idResult) {
				$("#id").css("border", "1px solid red");
				$("#idCheckResult").css("color", "red");
				$("#idCheckResult").text(
						"영문 소문자, 숫자, 특수기호(_)를 사용하여 5~11자로 작성");
				isIdOk = false;
				$("#join").attr("disabled","true");
				return false;
			} else {
				$.ajax({
					url : "/idDuplCheck.member",
					data : {
						id : $("#id").val()
					}
				}).done(
					function(resp) {
						let result = JSON.parse(resp)
						if (result) {
							$("#id").css("border","1px solid red");
							$("#idCheckResult").css("color","red");
							$("#idCheckResult").text("이미 존재하는 아이디입니다.")
							isIdOk = false;
							$("#join").attr("disabled","true");
							return false;
						} else {
							$("#id").css("border","1px solid blue");
							$("#idCheckResult").css("color","blue");
							$("#idCheckResult").text("사용가능한 아이디입니다.")
							isIdOk = true;
							
							//모든 검증 통과 시 submit 버튼 활성화
							if (isIdOk && isPwOk
									&& isPw2Ok
									&& isNameOk
									&& isPhoneOk
									&& isEmailOk
									&& isNNOk) {
								$("#join").removeAttr("disabled");
							}
						}
					})
				}
			})

		$("#pw1").on("keyup",function() { // 비밀번호 입력 검증
			let pw = $("#pw1").val();
			if (pw == "") {
				$("#pw1").css("border", "1px solid red");
				$("#pw2").css("border", "1px solid red");
				$("#pw1CheckResult").css("color", "red");
				$("#pw1CheckResult").text("비밀번호는 필수 입력 정보입니다.")
				$("#pw2CheckResult").text("");
				isPwOk = false;
				isPw2Ok = false;
				$("#join").attr("disabled","true");
				return false;
			}
			let pwRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$/gm; // 비밀번호 기본 검증
			let pwResult = pwRegex.test(pw);
			if (!pwResult) {
				$("#pw1").css("border", "1px solid red");
				$("#pw2").css("border", "1px solid red");
				$("#pw1CheckResult").css("color", "red");
				$("#pw1CheckResult").text(
						"영문 소문자, 대문자, 숫자를 조합하여 8~12자로 작성");
				$("#pw2CheckResult").text("");
				isPwOk = false;
				isPw2Ok = false;
				$("#join").attr("disabled","true");
				return false;
			} else {
				$("#pw1").css("border", "1px solid blue");
				$("#pw1CheckResult").text("");
				isPwOk = true;
				
				let pw2 = $("#pw2").val();
				if (pw2 == pw) {
					$("#pw2").css("border", "1px solid blue");
					$("#pw2CheckResult").css("color", "blue");
					$("#pw2CheckResult").text("패스워드가 일치합니다.");
					isPw2Ok = true;
					
					//모든 검증 통과 시 submit 버튼 활성화
					if (isIdOk && isPwOk && isPw2Ok && isNameOk
							&& isPhoneOk && isEmailOk && isNNOk) {
						$("#join").removeAttr("disabled");
					}
				} else {
					$("#pw2").css("border", "1px solid red");
					$("#pw2CheckResult").css("color", "red");
					$("#pw2CheckResult").text("패스워드가 일치하지 않습니다.");
					isPw2Ok = false;
					
					$("#join").attr("disabled","true");
					return false;
				}
			}
		})
		
		$("#pw2").on("keyup",function() { // 비번2 일치 검증
			let pw = $("#pw1").val();
			let pw2 = $("#pw2").val();
			if (pw2 == "") {
				$("#pw2").css("border", "1px solid red");
				$("#pw2CheckResult").css("color", "red");
				$("#pw2CheckResult").text("비밀번호 입력을 확인해주세요.")
				isPw2Ok = false;
				
				$("#join").attr("disabled","true");
				return false;
			}
			if (pw2 == pw) {
				$("#pw2").css("border", "1px solid blue");
				$("#pw2CheckResult").css("color", "blue");
				$("#pw2CheckResult").text("패스워드가 일치합니다.");
				isPw2Ok = true;
				
				//모든 검증 통과 시 submit 버튼 활성화
				if (isIdOk && isPwOk && isPw2Ok && isNameOk
						&& isPhoneOk && isEmailOk && isNNOk) {
					$("#join").removeAttr("disabled");
				}
			} else {
				$("#pw2").css("border", "1px solid red");
				$("#pw2CheckResult").css("color", "red");
				$("#pw2CheckResult").text("패스워드가 일치하지 않습니다.");
				isPw2Ok = false;
				
				$("#join").attr("disabled","true");
				return false;
			}
		})
		
		$("#name").on("keyup",function() { // 이름 검증
			let name = $("#name").val();
			if (name == "") {
				$("#name").css("border", "1px solid red");
				$("#nameCheckResult").css("color", "red");
				$("#nameCheckResult").text("이름은 필수 입력 정보입니다.")
				isNameOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			}
			let nameRegex = /^[가-힣]{2,5}$/;
			let nameResult = nameRegex.test(name);
			if (!nameResult) {
				$("#name").css("border", "1px solid red");
				$("#nameCheckResult").css("color", "red");
				$("#nameCheckResult").text("이름의 입력형식이 올바르지 않습니다.");
				isNameOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			} else {
				$("#name").css("border", "1px solid blue");
				$("#nameCheckResult").text("");
				isNameOk = true;

				//모든 검증 통과 시 submit 버튼 활성화
				if (isIdOk && isPwOk && isPw2Ok && isNameOk
						&& isPhoneOk && isEmailOk && isNNOk) {
					$("#join").removeAttr("disabled");
				}
			}
		})
		
		$("#phone1").on("keyup",function() { // 전화번호1 검증
			if($("#phone1")==""||$("#phone2")==""||$("#phone3")==""){
				$("#phone1").css("border", "1px solid red");
				$("#phone2").css("border", "1px solid red");
				$("#phone3").css("border", "1px solid red");
				$("#phoneCheckResult").css("color", "red");
				$("#phoneCheckResult").text("전화번호는 필수 입력 정보입니다.");
				isPhoneOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			}
			
			let phoneRegex1 = /^01[0-9]{1}$/;
			let phoneRegex2 = /^[0-9]{3,4}$/;
			let phoneRegex3 = /^[0-9]{4}$/;

			let phoneResult1 = phoneRegex1.test($("#phone1").val());
			let phoneResult2 = phoneRegex2.test($("#phone2").val());
			let phoneResult3 = phoneRegex3.test($("#phone3").val());

			if (!phoneResult1 || !phoneResult2 || !phoneResult3) {
				$("#phone1").css("border", "1px solid red");
				$("#phone2").css("border", "1px solid red");
				$("#phone3").css("border", "1px solid red");
				$("#phoneCheckResult").css("color", "red");
				$("#phoneCheckResult").text("전화번호의 입력형식이 올바르지 않습니다.");
				isPhoneOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			} else {
				$("#phone1").css("border", "1px solid blue");
				$("#phone2").css("border", "1px solid blue");
				$("#phone3").css("border", "1px solid blue");
				$("#phoneCheckResult").text("");
				isPhoneOk = true;

				//모든 검증 통과 시 submit 버튼 활성화
				if (isIdOk && isPwOk && isPw2Ok && isNameOk
						&& isPhoneOk && isEmailOk && isNNOk) {
					$("#join").removeAttr("disabled");
				}
			}
		})
		
		$("#phone2").on("keyup",function() { // 전화번호2 검증
			if($("#phone1")==""||$("#phone2")==""||$("#phone3")==""){
				$("#phone1").css("border", "1px solid red");
				$("#phone2").css("border", "1px solid red");
				$("#phone3").css("border", "1px solid red");
				$("#phoneCheckResult").css("color", "red");
				$("#phoneCheckResult").text("전화번호는 필수 입력 정보입니다.");
				isPhoneOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			}
			
			let phoneRegex1 = /^01[0-9]{1}$/;
			let phoneRegex2 = /^[0-9]{3,4}$/;
			let phoneRegex3 = /^[0-9]{4}$/;

			let phoneResult1 = phoneRegex1.test($("#phone1").val());
			let phoneResult2 = phoneRegex2.test($("#phone2").val());
			let phoneResult3 = phoneRegex3.test($("#phone3").val());

			if (!phoneResult1 || !phoneResult2 || !phoneResult3) {
				$("#phone1").css("border", "1px solid red");
				$("#phone2").css("border", "1px solid red");
				$("#phone3").css("border", "1px solid red");
				$("#phoneCheckResult").css("color", "red");
				$("#phoneCheckResult").text("전화번호의 입력형식이 올바르지 않습니다.");
				isPhoneOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			} else {
				$("#phone1").css("border", "1px solid blue");
				$("#phone2").css("border", "1px solid blue");
				$("#phone3").css("border", "1px solid blue");
				$("#phoneCheckResult").text("");
				isPhoneOk = true;

				//모든 검증 통과 시 submit 버튼 활성화
				if (isIdOk && isPwOk && isPw2Ok && isNameOk
						&& isPhoneOk && isEmailOk && isNNOk) {
					$("#join").removeAttr("disabled");
				}
			}
		})

		$("#phone3").on("keyup",function() { // 전화번호3 검증
			if($("#phone1")==""||$("#phone2")==""||$("#phone3")==""){
				$("#phone1").css("border", "1px solid red");
				$("#phone2").css("border", "1px solid red");
				$("#phone3").css("border", "1px solid red");
				$("#phoneCheckResult").css("color", "red");
				$("#phoneCheckResult").text("전화번호는 필수 입력 정보입니다.");
				isPhoneOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			}
			
			let phoneRegex1 = /^01[0-9]{1}$/;
			let phoneRegex2 = /^[0-9]{3,4}$/;
			let phoneRegex3 = /^[0-9]{4}$/;

			let phoneResult1 = phoneRegex1.test($("#phone1").val());
			let phoneResult2 = phoneRegex2.test($("#phone2").val());
			let phoneResult3 = phoneRegex3.test($("#phone3").val());

			if (!phoneResult1 || !phoneResult2 || !phoneResult3) {
				$("#phone1").css("border", "1px solid red");
				$("#phone2").css("border", "1px solid red");
				$("#phone3").css("border", "1px solid red");
				$("#phoneCheckResult").css("color", "red");
				$("#phoneCheckResult").text("전화번호의 입력형식이 올바르지 않습니다.");
				isPhoneOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			} else {
				$("#phone1").css("border", "1px solid blue");
				$("#phone2").css("border", "1px solid blue");
				$("#phone3").css("border", "1px solid blue");
				$("#phoneCheckResult").text("");
				isPhoneOk = true;

				//모든 검증 통과 시 submit 버튼 활성화
				if (isIdOk && isPwOk && isPw2Ok && isNameOk
						&& isPhoneOk && isEmailOk && isNNOk) {
					$("#join").removeAttr("disabled");
				}
			}
		})

		$("#email").on("keyup",function() { // 이메일 검증
			let email = $("#email").val();
			if (email == "") {
				$("#email").css("border", "1px solid red");
				$("#emailCheckResult").css("color", "red");
				$("#emailCheckResult")
						.text("이메일은 필수 입력 정보입니다.")
				isEmailOk = false;
				
				$("#join").attr("disabled","true");
				$("#sendmail").attr("disabled","true");
				$("#emailresult").text("");
				$("#emailKeyInput").css("display","none");
				$("#okbtn").css("display","none")
				return false;
			}
			let emailRegex = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
			let emailResult = emailRegex.test(email);
			if (!emailResult) {
				$("#email").css("border", "1px solid red");
				$("#emailCheckResult").css("color", "red");
				$("#emailCheckResult").text(
						"이메일의 입력형식이 올바르지 않습니다.");
				isEmailOk = false;
				
				$("#join").attr("disabled","true");
				$("#sendmail").attr("disabled","true");
				$("#emailresult").text("");
				$("#emailKeyInput").css("display","none");
				$("#okbtn").css("display","none")
				return false;
			} else {
				$("#email").css("border", "1px solid blue");
				$("#emailCheckResult").text("");
				$("#sendmail").removeAttr("disabled");
				
				$("#sendmail").on("click",function(){ // 메일 발송 버튼 클릭시
					let email = $("#email").val();
					if(email == ""){
						 alert("메일칸을 작성해주세요.");
						 isEmailOk = false;
						 $("#join").attr("disabled","true");
						 $("#sendmail").attr("disabled","true");
						 $("#emailresult").text("");
						 $("#emailKeyInput").css("display","none");
						 $("#okbtn").css("display","none")
						 return false;
					}
					$("#sendmail").attr("disabled","true");
					$("#emailresult").css("color","orange");
					$("#emailresult").text("발송중...");					
					
					$.ajax({
						type:"post",
						url:"/send.mail",
						dataType:"json",
						data:{email:$("#email").val()}
					
					}).done(function(resp){
						
						$("#emailKey").val(resp);
						$("#emailresult").css("color","blue");
						$("#emailresult").text("발송완료");
						return false;
					})
					$("#sendmail").removeAttr("disabled");
					$("#sendmail").text("인증메일 재발송");
					$("#emailKeyInput").css("display","inline");
				})
				$("#emailKeyInput").on("keyup",function(){
					 $("#okbtn").css("display","inline")
				})
				$("#okbtn").on("click",function(){
					if($("#emailKey").val()==$("#emailKeyInput").val()){
						$("#emailKeyInput").css("display", "none");
						$("#emailCheckResult").css("color", "blue");
						$("#emailCheckResult").text("이메일 인증 완료");
						isEmailOk = true;

						//모든 검증 통과 시 submit 버튼 활성화
						if (isIdOk && isPwOk && isPw2Ok && isNameOk
								&& isPhoneOk && isEmailOk && isNNOk) {
							$("#join").removeAttr("disabled");
						}
					}else if(!($("#emailKey").val()==$("#emailKeyInput").val())){
						$("#emailKeyInput").css("border", "1px solid red");
						$("#emailCheckResult").css("color", "red");
						$("#emailCheckResult").text("인증키가 일치하지 않습니다.");
						isEmailOk = false;
						
						$("#join").attr("disabled","true");
						return false;
					}	
				})
			}
		})

		$("#nickname").on("keyup",function() { // 닉네임 검증
			let nickname = $("#nickname").val();
			if (nickname == "") {
				$("#nickname").css("border", "1px solid red");
				$("#nnCheckResult").css("color", "red");
				$("#nnCheckResult").text("닉네임은 필수 입력 정보입니다.")
				isNNOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			}
			let nnRegex = /^[가-힣A-Za-z0-9_]{3,6}$/;
			let nnResult = nnRegex.test(nickname);

			if (!nnResult) {
				$("#nickname").css("border", "1px solid red");
				$("#nnCheckResult").css("color", "red");
				$("#nnCheckResult").text(
						"한글, 영문, 숫자, 특수기호(_)를 조합하여 3~6자로 작성");
				isNNOk = false;
				
				$("#join").attr("disabled","true");
				return false;
			} else {
				$.ajax({
					url : "/nnDuplCheck.member",
					data : {nickname : $("#nickname").val()}
				}).done(function(resp) {
					let result = JSON.parse(resp);
					if (result) {
						$("#nickname").css("border","1px solid red");
						$("#nnCheckResult").css("color","red");
						$("#nnCheckResult").text("이미 존재하는 닉네임입니다.")
						isNNOk = false;
					
						$("#join").attr("disabled","true");
						return false;
					} else {
						$("#nickname").css("border","1px solid blue");
						$("#nnCheckResult").css("color","blue");
						$("#nnCheckResult").text("사용가능한 닉네임입니다.")
						isNNOk = true;

						//모든 검증 통과 시 submit 버튼 활성화
						if (isIdOk && isPwOk
								&& isPw2Ok
								&& isNameOk
								&& isPhoneOk
								&& isEmailOk
								&& isNNOk) {
							$("#join").removeAttr("disabled");
						}
					}
				})
			}
		})
		
		
		$("#reset").on("click",function(){
			location.reload();       
		})
		
		
		$("#join").on("click",function(){
			Swal.fire('회원 가입이 완료되었습니다.').then((result) => {
			  if (result.isConfirmed) {
				  $("#joinform").submit();
				  }
			})
		})
		
		
	
	</script>
</body>
</html>