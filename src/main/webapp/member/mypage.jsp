<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
							<table align=center>
								<tr>
									<th colspan=2 style="text-align:center;">MyPage
								</tr>
								<tr>
									<th>ID
									<td>${dto.id }
								</tr>
								<tr>
									<th>NAME
									<td>${dto.name }
								</tr>
									<th>PHONE
									<td id="phoneTD">${dto.phone }</td>
									<input type=hidden value="phoneInput" name=phone>
								</tr>
								<tr>
									<th>EMAIL
									<td id="emailTD">${dto.email }</td>
									<input type=hidden value="emailInput" name=email>
								</tr>
								<tr>
									<th>NICKNAME
									<td id="nicknameTD">${dto.nickname }</td>
									<input type=hidden value="nicknameInput" name=nickname>
								</tr>
								<tr>
									<th>JOIN_DATE
									<td>${dto.joindate }
								</tr>
							</table>
							<div class="row">
								<div class="col-12"><br></div>
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
	$("#member_out").on("click", function(){
		window.open("/member/memberout.jsp", "",
		"top=100,left=200,width=550,height=350");
		//location.href="/member/memberout.jsp";
	})
	
	$("#modify").on("click", function(){
		$("#phoneTD").attr("contenteditable", "true");
		$("#emailTD").attr("contenteditable", "true");
		$("#nicknameTD").attr("contenteditable", "true");
		$("#phoneTD").focus();

		$("#modify").css("display", "none");

		let ok = $("<button>");
		ok.text("수정완료");
		//ok.css("margin-right", "5px");

		let cancel = $("<button>");
		cancel.text("수정취소");
		cancel.attr("type", "button");
		cancel.on("click", function() {
			location.reload();
		})

		$("#btns").prepend(cancel);
		$("#btns").prepend(ok);
	})
</script>
</html>