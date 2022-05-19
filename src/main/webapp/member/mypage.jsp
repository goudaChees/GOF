<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style>
p {
	margin: 20px 0px;
}

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
	<div class="container">
		<div class="row">
			<div class="col">
				<p>My Page</p>
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						data-toggle="tab" href="#mypage">내 정보 보기</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#mywrite">내 글 보기</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#mycontent">내 댓글 보기</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane fade show active" id="mypage">
						<form action="update.member" method="post">
							<div class="row">
								<div class="col" >
									<div class="row">
										<div class="col">MyPage</div>
									</div>
									<div class="row" align=center>
										<div class="col-3">ID</div>
										<div class="col-4">${dto.id }</div>
									</div>
									<div class="row">
										<div class="col-3">NAME</div>
										<div class="col-4">${dto.name }</div>
									</div>
									<div class="row">
										<div class="col-3">PHONE</div>
										<div class="col-4">
											<input type=text value="${dto.phone }" class="editable" name=phone id="phoneTD" disabled>
										</div>
										<div class="col-5" id="phoneCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">EMAIL</div>
										<div class="col-4">
											<input type=text value="${dto.email }" class="editable" name=email id="emailTD" disabled>
										</div>
										<div class="col-5" id="emailCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">NICKNAME</div>
										<div class="col-4">
											<input type=text value="${dto.nickname }" class="editable" name=nickname id="nicknameTD" disabled>
										</div>
										<div class="col-5" id="nicknameCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">JOINDATE</div>
										<div class="col-4">${dto.joindate }</div>
									</div>
									
									
						
								</div>
							</div>
							<div class="row">
								<div class="col-12">
									<br>
								</div>
							</div>
							<div class="row" align=center>
								<div class="col-12" id="btns">
									<button id="modify" type="button">수정하기</button>
									<button id="pw_modify" type="button">비밀번호 수정</button>
									<button id="member_out" type="button">탈퇴하기</button>
								</div>
							</div>

						</form>
					</div>
					<div class="tab-pane fade" id="mywrite">
						<p>Nunc vitae turpis id nibh sodales commodo et non augue.
							Proin fringilla ex nunc. Integer tincidunt risus ut facilisis
							tristique.</p>
					</div>
					<div class="tab-pane fade" id="mycontent">
						<p>Curabitur dignissim quis nunc vitae laoreet. Etiam ut
							mattis leo, vel fermentum tellus. Sed sagittis rhoncus venenatis.
							Quisque commodo consectetur faucibus. Aenean eget ultricies
							justo.</p>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script>
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
				window.open("/member/memberout.jsp", "",
						"top=100,left=200,width=550,height=350");
				//location.href="/member/memberout.jsp";
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
		
		
		
		
</script>
</html>