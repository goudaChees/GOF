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
</style>
</head>
<body>
	<div class="container">
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
							aria-current="page" href="/list.brd2">선택의 참견</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="/csmain.cscenter">고객센터</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="/mypage.member">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="/logout.member"><i class="bi bi-box-arrow-right"></i></a></li>
					</ul>
				</div>
			</div>
		</nav>
		<div class="row">
			<div class="col">
				<p>My Page</p>
				<ul class="nav nav-tabs">
				  <li class="nav-item">
				    <a class="nav-link" href="/mypage.member">내 정보 보기</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link active" aria-current="page" href="/myWriting.member?board=1&page=1">내 글 보기</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="/myReply.member?board=1&page=1">내 댓글 보기</a>
				  </li>
				</ul>
				
				<div class="row">
					<div class="col-12" id="mywriting">	
						<div class="row">
							<div class="col-12" style="text-align:right">
								<button id="toBoard1">지출의 참견</button>
								<button id="toBoard2">선택의 참견</button>
							</div>
						</div>				
						<div class="row">
				            <div class="col-8">제목</div>
				            <div class="col-4">작성일자</div>
				        </div>
				        <c:forEach var='i' items="${list }">
					        <div class="row">
					        	<div class="col-8">${i.title }</div>
				            	<div class="col-4">${i.formed_WriteDate }</div>
					        </div>
				        </c:forEach>
				        <div class="row">
				        	<div class="col-12">${pageList }</div>
				        </div>
					</div>
				</div>					
			</div>
		</div>
	</div>
	<script>
		$("#toBoard1").on("click",function(){
			location.href="/myWriting.member?board=1&page=1";
		})
		
		$("#toBoard2").on("click",function(){
			location.href="/myWriting.member?board=2&page=1";
		})
	</script>
</body>
</html>