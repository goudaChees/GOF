<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Member</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
<script>
	function openChild(){
		window.name = "parentForm";
		
		openWin = window.open("/admin/banishMember.jsp", "",
				"top=100,left=200,width=550,height=350");	
	}
	
	function openChild2(){
		window.name = "parentForm";
		
		openWin2 = window.open("/admin/adminPwCheck.jsp", "",
				"top=100,left=200,width=550,height=350");	

	}
	function setChildText(){
		document.getElementById("adminTF").value = openWin2.document.getElementById("cTF").value;	
	}

	

</script>	
<style>
p {
	margin: 20px 0px;
}

div {
/* 	border: 1px solid black; */
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
						<a class="navbar-brand" href="/index.jsp">앞날의 지침</a>
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
									aria-current="page" href="list.brd2">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/csmain.cscenter">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/adminmain.admin">관리자페이지</a></li>
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
						<a class="navbar-brand" href="/index.jsp">앞날의 지침</a>
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
									aria-current="page" href="list.brd2">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/csmain.cscenter">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/mypage.member">마이페이지</a></li>
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
						<a class="navbar-brand" href="/index.jsp">앞날의 지침</a>
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
									aria-current="page" href="list.brd2">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/csmain.cscenter">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="joinform.member">회원가입</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</c:otherwise>
	</c:choose>
	<div class="container">
		<div class="row">
			<div class="col">
				<p>Admin Page</p>
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						data-toggle="tab" href="#memberManagement">회원 정보 관리</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#postManagement">게시글 관리</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#replyManagement">댓글 관리</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane fade show active" id="memberManagement">
						<form action="/adminUpdate.admin" method="post">
							<div class="row">
								<div class="col">
									<div class="row">
										<div class="col">${mdto.id}'s Information</div>
										<input type="hidden" value="${mdto.id}" id="userId">
									</div>
									<div class="row">
										<div class="col-3">ID</div>
										<div class="col-4">${mdto.id }
										<input type=hidden value="${mdto.id }" class="editable" name=id id="idTD">
										</div>
									</div>
									<div class="row">
										<div class="col-3">NAME</div>
										<div class="col-4">
											<input type=text value="${mdto.name }" class="editable"
												name=name id="nameTD">
										</div>
									</div>
									<div class="row">
										<div class="col-3">PHONE</div>
										<div class="col-4">
											<input type=text value="${mdto.phone }" class="editable"
												name=phone id="phoneTD">
										</div>
										<div class="col-5" id="phoneCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">EMAIL</div>
										<div class="col-4">
											<input type=text value="${mdto.email }" class="editable"
												name=email id="emailTD">
										</div>
										<div class="col-5" id="emailCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">NICKNAME</div>
										<div class="col-4">
											<input type=text value="${mdto.nickname }" class="editable"
												name=nickname id="nicknameTD">
										</div>
										<div class="col-5" id="nicknameCheckResult"></div>
									</div>
									<div class="row">
										<div class="col-3">JOINDATE</div>
										<div class="col-4">${mdto.joindate }</div>
									</div>
									<div class="row">
										<div class="col-12">
											<br>
										</div>
									</div>

									<div class="row" align=center>
										<div class="col-12" id="btns">
											<button id="back" type="button">뒤로가기</button>
											<button id="modifyComplete" type="submit">수정완료</button>
											<button id="cancel" type="button">취소 </button>
											<button id="banish" type="button">강제 추방</button>
										</div>
									</div>


								</div>
							</div>


						</form>
					</div>
					<div class="tab-pane fade" id="postManagement">
						<p>post list.</p>
					</div>
					<div class="tab-pane fade" id="replyManagement">
						<p>reply list.</p>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script>

	// 뒤로가기 
	$("#back").on("click", function(){
		location.href="/adminmain.admin";
	})
	
	// 취소버튼
	$("#cancel").on("click", function(){
		location.href="/adminmain.admin";
	})
	
	$("#banish").on("click", function(){
		openChild();	
	})
	
	
</script>
</html>
