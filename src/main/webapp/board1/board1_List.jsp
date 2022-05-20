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

/* div { */
/* 	border: 1px solid black; */
/* 	text-align: center; */
/*   margin: 0px; */
/* } */
#list_Middle>div {
	float: left;
}

#boardHeader>div {
	float: left;
}

.boardList>div {
	float: left;
}

span{
	font-weight: bolder;
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
	<div id="list_Container" style="width: 70%; margin: auto;">
		<div id="list_Header">
			<div style="text-align: left; border: 0px; font-size: 25px;">지출의참견</div>
			<div style="text-align: left; border: 0px;">살까말까 답정너들을 위한 참견러들의
				지침</div>
		</div>
		<div id="list_Middle" style="text-align: right;">
			<div style="width: 20%">
			<form action="/search.brd1">
				<select class="form-select" aria-label="Default select example"
					name="searchCategory">
					<option value="0">선택</option>
					<option value="1">작성자</option>
					<option value="2">제목</option>
					<option value="3">물건명</option>
				</select>
			</div>
			<div style="width: 40%; text-align: left;">
				<input type="text" placeholder="검색하실 내용을 입력하세요" name="searchTarget" style="width: 70%"> 
				<input type="submit" value="검색">
			</div>
			<br>
			</form>
		</div>
		<div id="list_Bottom">
			<div border="1" align="center" id="wrapper"
				style="width: 70%; margin: auto;" class="row">
				<c:forEach var="i" items="${list}">
					<div width="100%" class="boardList">
						<div class="col-4">
						<img src="#">
						</div>
						<div class="col-7">
							<div class="row">
								<input type="hidden" value=${i.seq }>
								<div class="col-12" style="text-align: left; overflow: hidden;">
									<a href="#" class="title">${i.title}</a>
								</div>
								<div align="center" class="col-5" class="item">${i.item}</div>
								<div align="center" class="col-7" class="writer">${i.writer}</div>
								<div align="center" class="col-12">${i.write_date}</div>
							</div>	
						</div>
						<div class="col-">${i.view_count}</div>
					</div>
					<br>
					<hr>
				</c:forEach>
			</div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">${navi}</div>
			<div class="col-2">
				<input type="button" id="write" value="글쓰기">
			</div>
		</div>
	</div>
	<div class="row w-100 m-0" id="footer">
		<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
	</div>

</body>
</html>