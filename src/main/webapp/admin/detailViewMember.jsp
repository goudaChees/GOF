<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail Member</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/admin/adminmemberpage.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


	
<script>
	function openChild(){
		window.name = "parentForm";
		
		openWin = window.open("/admin/banishMember.jsp", "",
				"top=100,left=200,width=550,height=350");	
	}
	
	function openChild2(){
		window.name = "parentForm";
		
		openWin2 = window.open("/admin/adminModifyMember.jsp", "",
		"top=100,left=200,width=550,height=350");
		
// 		openWin2 = window.open("/admin/adminPwCheck.jsp", "",
// 				"top=100,left=200,width=550,height=350");	임시로 가려둠

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
	<div class="container w-100">
		<div class="row" id="header">
			<div class="col-12">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="/index.jsp" style="color:#664E55">앞날의 지침</a>
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
											aria-current="page" href="/list.brd1?cpage=1" style="color:#664E55">지출의 참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color:#664E55">선택의 참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csmain.cscenter" style="color:#664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/adminmain.admin" style="color:#664E55">관리자페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
										aria-current="page" href="#"><i class="bi bi-box-arrow-right" style="color:#664E55"></i></a></li>
									</c:when>
									<c:when test="${loginID !=null}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd1?cpage=1" style="color:#664E55">지출의 참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color:#664E55">선택의 참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csmain.cscenter" style="color:#664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active" 
											aria-current="page" href="/mypage.member" style="color:#664E55">마이페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
										aria-current="page" href="#"><i class="bi bi-box-arrow-right" style="color:#664E55"></i></a></li>
									</c:when>
									<c:otherwise>
										<li class="nav-item nonMember"><a class="nav-link active"
											aria-current="page" href="#" style="color:#664E55">지출의 참견</a></li>
										<li class="nav-item nonMember"><a class="nav-link active"
											aria-current="page" href="#" style="color:#664E55">선택의 참견</a></li>
										<li class="nav-item nonMember"><a class="nav-link active"
											aria-current="page" href="#" style="color:#664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/joinform.member" style="color:#664E55">회원가입</a></li>
									</c:otherwise>
								</c:choose>
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
								<p>Admin Page</p>
								<ul class="nav nav-tabs">
									<li class="nav-item"><a class="nav-link active"
										aria-current="page" href="/adminmain.admin">회원 정보 관리</a></li>
									<li class="nav-item"><a class="nav-link" 
										href="/adminBoardsList.admin">게시글 관리</a></li>
									<li class="nav-item"><a class="nav-link" 
										href="/adminReplyList.admin">댓글 관리</a></li>
								</ul>
							</div>	
						</div>
							
						<div class="row" id="MyPage">
							<div class="col-12">	
								<form action="adminUpdate.admin" method="post">
									<div class="row" id="MypageArea">
										<div class="col-12">
											<div class="row">
												<div class="col-12" id="MyPageAreaHeader">${mdto.id}'s Information</div>
												<input type="hidden" value="${mdto.id}" name="id" id="userId">
											</div>
											<div class="row" align=center>
												<div class="col-4">ID</div>
												<div class="col-8">${mdto.id}</div>
											</div>
											<div class="row">
												<div class="col-4">NAME</div>
												<div class="col-8">
													<input type=text value="${mdto.name }" class="editable"
													name=name id="nameTD" disabled>
												</div>
											</div>
											<div class="row">
												<div class="col-4">PHONE</div>
												<div class="col-8">
													<input type=text value="${mdto.phone }" class="editable"
														name=phone id="phoneTD" disabled>
												</div>
												<div class="col-4"></div>
												<div class="col-8" id="phoneCheckResult"></div>
											</div>
											<div class="row">
												<div class="col-4">EMAIL</div>
												<div class="col-8">
													<input type=text value="${mdto.email }" class="editable"
														name=email id="emailTD" disabled>
												</div>
												<div class="col-4"></div>
												<div class="col-8" id="emailCheckResult"></div>
											</div>
											<div class="row">
												<div class="col-4">PHONE</div>
												<div class="col-8">
													<input type=text value="${mdto.phone }" class="editable"
														name=phone id="phoneTD" disabled>
												</div>
												<div class="col-4"></div>
												<div class="col-8" id="phoneCheckResult"></div>
											</div>
											<div class="row">
												<div class="col-4">EMAIL</div>
												<div class="col-8">
													<input type=text value="${mdto.email }" class="editable"
														name=email id="emailTD" disabled>
												</div>
												<div class="col-4"></div>
												<div class="col-8" id="emailCheckResult"></div>
											</div>
											<div class="row">
												<div class="col-4">NICKNAME</div>
												<div class="col-8">
													<input type=text value="${mdto.nickname }" class="editable"
														name=nickname id="nicknameTD" disabled>
												</div>
												<div class="col-4"></div>
												<div class="col-8" id="nicknameCheckResult"></div>
											</div>
											<div class="row">
												<div class="col-4">JOINDATE</div>
												<div class="col-8">${mdto.joindate }</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-12">
											<br><input id="adminTF" type="text" style="color: red;" value="관리자 확인이 필요합니다." disabled>
										</div>
									</div>
									
									<br>
									<div class="row w-100 m-10" align=center>
										<div class="col-12" id="btns">
											<button id="back" type="button">뒤로가기</button>
											<button id="modify" type="button">수정하기</button>
											<button id="banish" type="button">강제 추방</button>
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

</body>
<script>

	// 뒤로가기 
	$("#back").on("click", function(){
		location.href="/adminmain.admin";
	})
	
	// 수정버튼 클릭 시
	$("#modify").on("click", function(){
		openChild2();
		$("#adminTF").on("focus", function(){
			$("#adminTF").css("display","none");
			
			$("#modify").css("display", "none");
			$("#banish").css("display", "none");
			let ok = $("<button>");
			ok.text("수정완료");
		
			let cancel = $("<button>");
			cancel.text("취소");
			cancel.attr("type","button");
			cancel.attr("id","canbtn");
			cancel.on("click", function(){
				location.reload();
			})
		
			$("#btns").append(ok);
			$("#btns").append(cancel);
			
		})


	})
	
	$("#banish").on("click", function(){
		openChild();
		
	})
	



</script>

</html>