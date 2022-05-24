<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객센터</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/cscenter/csmain.css">

</head>
<body>
	<div class="container w-100">
		<div class="row" id="header">
			<div class="col-12">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="/index.jsp" style="color: #664E55">앞날의
							지침</a>
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
											aria-current="page" href="/list.brd1?cpage=1" style="color: #664E55">지출의
												참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color: #664E55">선택의
												참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csmain.cscenter"
											style="color: #664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/adminmain.admin"
											style="color: #664E55">관리자페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#"><i
												class="bi bi-box-arrow-right" style="color: #664E55"></i></a></li>
									</c:when>
									<c:when test="${loginID !=null}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd1?cpage=1" style="color: #664E55">지출의
												참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color: #664E55">선택의
												참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csmain.cscenter"
											style="color: #664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/mypage.member"
											style="color: #664E55">마이페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#"><i
												class="bi bi-box-arrow-right" style="color: #664E55"></i></a></li>
									</c:when>
									<c:otherwise>
										<li class="nav-item nonMember"><a class="nav-link active"
											aria-current="page" href="#" style="color: #664E55">지출의
												참견</a></li>
										<li class="nav-item nonMember"><a class="nav-link active"
											aria-current="page" href="#" style="color: #664E55">선택의
												참견</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#"
											style="color: #664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/joinform.member"
											style="color: #664E55">회원가입</a></li>
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
				<div class="row w-100 m-0" id="CsCenterOutline">
					<div class="col-12">
						<div class="row w-100 m-0" id="CsCenterHeader">
							<div class="col-12">
								<p>고객센터</p>
								<ul class="nav nav-tabs">
									<li class="nav-item"><a class="nav-link active"
										data-toggle="tab" href="#csmain">자주 묻는 질문</a></li>
									<li class="nav-item"><a class="nav-link" 
										data-toggle="tab" href="#csmail">1:1 문의하기</a></li>
								</ul>
							</div>
						</div>
						<div class="row w-100 m-0" id="CsArea">
							<div class="col-12">
								<!-- 				탭1 자주묻는질문 -->
								<div class="tab-content">
									<div class="tab-pane fade show active" id="csmain">
										<!-- 					아코디언 bootstrap -->

										<div class="accordion" id="accordionPanelsStayOpenExample">
											<br>
											<!-- 								아코디언 1번 -->
											<div class="accordion-item">
												<h2 class="accordion-header" id="panelsStayOpen-headingOne">
													<button class="accordion-button" type="button"
														data-bs-toggle="collapse"
														data-bs-target="#panelsStayOpen-collapseOne"
														aria-expanded="true"
														aria-controls="panelsStayOpen-collapseOne">안녕하세요!
														앞날의 지침입니다.</button>
												</h2>
												<div id="panelsStayOpen-collapseOne"
													class="accordion-collapse collapse show"
													aria-labelledby="panelsStayOpen-headingOne">
													<div class="accordion-body">
														<strong>앞날의 지침</strong> 에 오신 것을 환영합니다!
													</div>
												</div>
											</div>
											<br>
											<!-- 								아코디언 2번 -->
											<div class="accordion-item">
												<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
													<button class="accordion-button collapsed" type="button"
														data-bs-toggle="collapse"
														data-bs-target="#panelsStayOpen-collapseTwo"
														aria-expanded="false"
														aria-controls="panelsStayOpen-collapseTwo">Q. 게시판
														이용 방법이 궁금해요!</button>
												</h2>
												<div id="panelsStayOpen-collapseTwo"
													class="accordion-collapse collapse"
													aria-labelledby="panelsStayOpen-headingTwo">
													<div class="accordion-body">
														게시판 이용 방법 입니다. <br> <strong>지출의 참견 >> </strong> <br>
														살까 말까 고민되는 물건이 있으신가요? <br> 혼자서 답이 전혀 나오지 않는다면 참견러들에게
														물어보세요! <br> 고민하는 물건의 사진을 한장 찍어서 업로드 하면 끝! <br> <a
															href="#">지출의 참견 바로가기</a> <br> <br> <strong>선택의
															참견 >> </strong> <br> 지금 이 가격 맞나? 고민 되신다면!? <br> 숨은 고수들이
														더 싼곳을 찾아주실거에요! <br> 경매를 시작하고! 낙찰까지 진행해보세요. 숨은 혜택이
														있을지도!? <a href="#"><br>선택의 참견 바로가기</a> <br>
													</div>
												</div>
											</div>
											<br>
											<!-- 								아코디언 3번 -->
											<div class="accordion-item">
												<h2 class="accordion-header"
													id="panelsStayOpen-headingThree">
													<button class="accordion-button collapsed" type="button"
														data-bs-toggle="collapse"
														data-bs-target="#panelsStayOpen-collapseThree"
														aria-expanded="false"
														aria-controls="panelsStayOpen-collapseThree">Q.
														댓글이 안써져요!</button>
												</h2>
												<div id="panelsStayOpen-collapseThree"
													class="accordion-collapse collapse"
													aria-labelledby="panelsStayOpen-headingThree">
													<div class="accordion-body">
														댓글이 안써지는 경우는 크게 두가지로 나뉩니다. <br> <strong>1.
															회원 가입을 해주세요! </strong> <br> 회원가입의 절차는 매우 빠르답니다. 회원가입을 진행해
														주세요! <br> <a href="/joinform.member">회원 가입 하러 가기</a>
														<br> <br> <strong>2. 댓글을 이미 다셨어요! </strong> <br>
														혹시 댓글을 이미 다신 것은 아니신가요? <br> 저희는 한 컨텐츠에 한개의 댓글만 작성할 수
														있답니다! <br>

													</div>
												</div>
											</div>
											<br>
											<!-- 								아코디언 4번 -->
											<div class="accordion-item">
												<h2 class="accordion-header" id="panelsStayOpen-headingfour">
													<button class="accordion-button collapsed" type="button"
														data-bs-toggle="collapse"
														data-bs-target="#panelsStayOpen-collapsefour"
														aria-expanded="false"
														aria-controls="panelsStayOpen-collapsefour">Q. 1:1
														문의를 하고 싶어요!</button>
												</h2>
												<div id="panelsStayOpen-collapsefour"
													class="accordion-collapse collapse"
													aria-labelledby="panelsStayOpen-headingfour">
													<div class="accordion-body">
														해결되지 않은 궁금증은 <strong> 이메일 </strong> 로 연락해 주세요. <br> <br>
														<a href="/cscenter/csemail.jsp">1:1 문의 바로 가기</a> <br>


													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 						탭2 1:1메일문의		 -->
									<div class="tab-pane fade" id="csmail">
										<form action="/sendmail.cscenter" method="post">
											<div class="row w-100 m-0">
												<div class="col-12">사이트 관련 문의사항을 보내주세요.</div>
											</div>
											<div class="row w-100 m-0" id="emailBox">
												<div class="col-2">제목</div>
												<div class="col-10">
													<input type=text name="emailTitle" id="emailTitleBox"
														placeholder="Input Mail Title">
												</div>
												<div class="col-2">내용</div>
												<div class="col-10">
													<textarea name="emailContents" id="emailContentsBox"
														placeholder="input Mail Contents"></textarea>
												</div>
											</div>
											<div class="row w-100 m-0">
												<div class="col-12">
													<button type=submit>Send Email</button>
												</div>
											</div>
										</form>
									</div>
								</div>
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
	<script>
	$(".nonMember").on("click",function(){ // 로그인 하지 않고 게시판 1,2 클릭 시 팝업
		Swal.fire({
		  icon: 'info',
		  text: '로그인 후 사용 가능합니다.'
		})
	})
	
	$(".bi-box-arrow-right").on("click",function(){
			  if (!Kakao.Auth.getAccessToken()) {
			  Swal.fire({
				  text: '로그아웃 하시겠습니까?',
				  showCancelButton: true,
				  confirmButtonText: '로그아웃',
				  cancelButtonText: '취소',
				}).then((result) => {
				  if (result.isConfirmed) {				
				    location.href="/logout.member";				  
				  } 
				})
				return
			  }
			// -- 로그아웃 버튼 클릭시 카카오톡으로 로그인한 사용자의 토큰을 반납.
			let result = confirm("로그아웃 하시겠습니까?");
			if(!result){
				return false;
			} else {
			  Kakao.Auth.logout(function() {
	      			alert("로그아웃 되었습니다.");
	      			location.href="/logout.member";
	   		 	})
			}
		  })
	</script>
</body>

</html>