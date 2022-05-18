<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
* {
	box-sizing: border-box;
}

div {
/* 	border: 1px solid black; */
	text-align: center;
}

.accordion-body {
	text-align : left;
}
#title div{
	font-size : xxx-large;
	text-align : left;
}
#across a{
	font-size : x-large;
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
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">관리자페이지</a></li>
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
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">마이페이지</a></li>
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
								<li class="nav-item"><a class="nav-link active nonMember"
									aria-current="page" href="#">지출의 참견</a></li>
								<li class="nav-item"><a class="nav-link active nonMember"
									aria-current="page" href="list.brd2">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="joinform.member">회원가입</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
			</c:otherwise>
			</c:choose>
	<div id="container">
		<div id="title" >
			<div class="col-6 m-auto">
				고객 센터 
			</div>
			<div class="col-6 m-auto" id="across">
				<a href="/cscenter/csmain.jsp">자주 묻는 질문 게시판</a>
				<a href="/cscenter/csemail.jsp">1:1 문의 게시판</a>
			</div>
		</div>
		<div class="col-6 m-auto" >
			
			<div class="accordion" id="accordionPanelsStayOpenExample">
			<br>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingOne">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
							aria-controls="panelsStayOpen-collapseOne">안녕하세요! 앞날의 지침입니다.
							</button>
					</h2>
					<div id="panelsStayOpen-collapseOne"
						class="accordion-collapse collapse show"
						aria-labelledby="panelsStayOpen-headingOne">
						<div class="accordion-body">
							<strong>앞날의 지침</strong> 에 오신 것을 환영합니다!
						</div>
					</div>
				</div>
				<br> <br>
				<hr>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseTwo"
							aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
							Q 게시판 이용 방법이 궁금해요! </button>
					</h2>
					<div id="panelsStayOpen-collapseTwo"
						class="accordion-collapse collapse"
						aria-labelledby="panelsStayOpen-headingTwo">
						<div class="accordion-body">
							게시판 이용 방법 입니다. <br>
							<strong>지출의 참견 >>  </strong> <br>
							살까 말까 고민되는 물건이 있으신가요? <br>
							혼자서 답이 전혀 나오지 않는다면 참견러들에게 물어보세요! <br>
							고민하는 물건의 사진을 한장 찍어서 업로드 하면 끝! <br>
							<a href ="#">지출의 참견 바로가기</a> <br>
							<strong>선택의 참견 >>  </strong> <br>
							지금 이 가격 맞나? 고민 되신다면!? <br>
							숨은 고수들이 더 싼곳을 찾아주실거에요! <br>
							경매를 시작하고! 낙찰까지 진행해보세요. 숨은 혜택이 있을지도!?
							<a href ="#">선택의 참견 바로가기</a> <br>
						</div>
					</div>
				</div>
				<br> <br>
				<hr>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingThree">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseThree"
							aria-expanded="false"
							aria-controls="panelsStayOpen-collapseThree">Q 댓글이 안써져요! </button>
					</h2>
					<div id="panelsStayOpen-collapseThree"
						class="accordion-collapse collapse"
						aria-labelledby="panelsStayOpen-headingThree">
						<div class="accordion-body">
							댓글이 안써지는 경우는 크게 두가지로 나뉩니다. <br>
							<strong>1. 회원 가입을 해주세요! </strong> <br>
							회원가입의 절차는 매우 빠르답니다. 회원가입을 진행해 주세요! <br>
							<a href="#">회원 가입 하러 가기</a> <br> <br>
							
							<strong>2. 댓글을 이미 다셨어요! </strong> <br>
							혹시 댓글을 이미 다신 것은 아니신가요? <br>
							저희는 한 컨텐츠에 한개의 댓글만 작성할 수 있답니다! <br>
							
						</div>
					</div>
				</div>
			</div>
			
			<br> <br> 
				<hr>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingfour">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapsefour"
							aria-expanded="false" aria-controls="panelsStayOpen-collapsefour">
							Q 1:1 문의를 하고 싶어요! </button>
					</h2>
					<div id="panelsStayOpen-collapsefour"
						class="accordion-collapse collapse"
						aria-labelledby="panelsStayOpen-headingfour">
						<div class="accordion-body">
							해결되지 않은 궁금증은 <strong> 이메일 </strong>
							로 연락해 주세요. <br>
							<br>
							<a href ="/cscenter/csemail.jsp">1:1 문의 바로 가기</a>
							<br>
							
							
						</div>
					</div>
				</div>
			
		</div>
	</div>


</body>
</html>