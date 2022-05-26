<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>앞날의 지침</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/index.css">

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
	<div class="container">
		<div class="row">
			<div class="col">
				<p>Admin Page</p>
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link"
						href="/adminmain.admin">회원 정보 관리</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/adminBoardsList.admin?board=1">게시글
							관리</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/adminReplyList.admin?board=1">댓글 관리</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane fade show active">
						<div class="row w-100 m-0">
							<div class="col-12" id="listbtns">
								<button id="toBoard1Reply">지출의 참견</button>
								<button id="toBoard2Reply">선택의 참견</button>
							</div>
						</div>
								

		<div id="list_Middle" style="text-align: right;">
			<div style="width: 20%">
				<form action="/searchBrdReply.admin?board=1&page=1">
						<select class="form-select" aria-label="Default select example"
							name="searchCategory">
						<option value="0">선택</option>
						<option value="1">작성자</option>
						<option value="2">내용</option>
						
						</select>
				</div>
				<div style="width: 40%; text-align: left;">
					<input type="text" placeholder="검색하실 내용을 입력하세요"
						name="toSearch" style="width: 70%"> <input
						type="submit" value="검색">
				</div>
				<br>
				</form>
		</div>

		<div id ="replyList">
			<div>
				<c:forEach var="i" items="${listR1 }">
					<div>
						<a href ="/detail.brd1?seq=${i.parent_Seq }">본문 보러가기</a>
					</div>
					<div>
						
					</div>
					<div>${i.writer}</div>
					<div>${i.contents}</div>
					<div>${i.write_date }</div>
					<div>${i.agree }</div>
				</c:forEach>
		</div>
			
		</div>
		<div>
			<div>${pageNavi}
			</div>
		</div>

		<div class="row w-100 m-0" id="footer">
			<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
		</div>		
	<script>
	$("#toBoard1Reply").on("click", function(){
		location.href="/adminReplysList.admin?board=1";
	})
	
	$("#toBoard2Reply").on("click", function(){
		location.href="/adminReplysList.admin?board=2";
	})
	
	</script>

</body>
</html>