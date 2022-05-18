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
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<style>
* {
	border: 1px solid black;
	box-sizing: border-box;
	text-align: center;
}
</style>
</head>
<body>
	<div id="container">
		<div class="row">
			<div class="col-12">
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
									aria-current="page" href="list.brd2">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="csmain.cscenter">고객센터</a></li>

								<c:choose>
									<c:when test="${loginID =='admin'}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#">관리자페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="logout.member"><i
												class="bi bi-box-arrow-right"></i></a></li>
									</c:when>
									<c:when test="${loginID !=null}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="mypage.member">마이페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="logout.member"><i
												class="bi bi-box-arrow-right"></i></a></li>
									</c:when>
								</c:choose>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>
		<div class="row">
			<div class="col-12">${dto.title}</div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row">
					<div class="col-12">${dto.contents}</div>
				</div>
				<div class="row">
					<div class="col-9"></div>
					<div class="col-3">
						<button type="button" id="modi">수정하기</button>
						<button type="button" id="del">삭제하기</button>
					</div>
				</div>
				<div class="row">
				<c:if test="${cck == false || wcck == false}">
					<form action="/write.brd2_reply" method="post">
						<div class="row">
							<div class="col-12">
								<div class="row">
									<div class="col-3">
										<input type="text" id="writer" value="${loginNN}" disabled>
										<input type="text" placeholder="가격을 입력해주세요" name="price">
									</div>
									<input type="hidden" name="pseq" value="${dto.seq}">
								</div>
								<div class="row">
									<div class="col-7">
										<input type="text" placeholder="내용을 입력해주세요" name="contents">
									</div>
									<div class="col-2">
										<button type="submit" id="btn1">작성</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</c:if>
					
				</div>
				<div class="row">
					<div class="col-12">
						<c:forEach var="i" items="${rdto}">
							<div class="row">
								<div class="col-3">${i.price}</div>
							</div>
							<div class="row">
								<div class="col-8">
									<div class="row">
										<div class="col-3">${i.nickname}</div>
										<div class="col-3">${i.wirte_date}</div>
									</div>
									<div class="row">
										<div class="col-12">${i.contents}</div>
									</div>
								</div>
								<div class="col-1">
									<input type="radio" name="choice" value="선택">
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-12">footer</div>
		</div>
	</div>
	<script>
	$("#del").on("click",function(){
		result = window.confirm("정말 삭제하시겟습니까?");
		if(result){
			location.href = "/del.brd2?seq="+${dto.seq}
		}
		//글 삭제
	})
	$("#modi").on("click",function(){
		result = window.confirm("정말 수정하시겟습니까?");
		if(result){
			location.href = "/modi.brd2?seq="+${dto.seq}
		}
		//글 수정
	})
	</script>
</body>
</html>