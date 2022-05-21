<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<style>
* {
	box-sizing: border-box;
}

div {
border: 1px solid black;
text-align: center;
margin: 0px;
}
</style>
</head>
<body>
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
							aria-current="page" href="#">고객센터</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">회원가입</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<div id="viewContainer"  style="width:70%; margin: auto;">
		<div id="board_vIew" class="row">
		<div id="title" class="col-10">
		타이틀
		</div>
		<div id="view_Count" class="col-2">
		1
		</div>	
		<div id="img_Box" class="col-5">
			<img src="#">
		</div>
		<div id="contents_Box" class="col-7">
			<div id="item">${dto.item}</div>
			<div id="contents">${dto.contents}</div>
		</div>
		<div id="item_price">전체 금액 : ${dto.item_price}</div>
		<div id="btns" style="text-align: right;">
			<input type="button" id="toList" value="목록으로">
			<c:if test="${nickname==dto.writer }">
				<input type="button" id="modify" value="수정하기">
				<input type="button" id="delete" value="삭제하기">
			</c:if>
		</div>
		</div>
	</div>
	<div class="row w-100 m-0" id="footer">
		<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
	</div>
	<div ></div>
	<script>
		$("#toList").on("click",function(){
			location.href="/list.brd1?cpage=1";
		})
		$("#modify").on("click",function(){
			location.href="/modify.brd1?seq=${dto.seq}";
		})
	</script>
</body>
</html>