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
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
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
											aria-current="page" href="#" style="color: #664E55">지출의
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
											aria-current="page" href="#" style="color: #664E55">지출의
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
											aria-current="page" href="/csmain.cscenter"
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
									<li class="nav-item"><a class="nav-link"
										href="/csmain.cscenter">자주 묻는 질문</a></li>
									<li class="nav-item"><a class="nav-link" 
										href="/csemail.cscenter">1:1 문의하기</a></li>
									<li class="nav-item"><a class="nav-link active" data-toggle="tab"
										href="#csmap">찾아 오시는 길</a></li>
								</ul>
							</div>
						</div>
						<div class="row w-100 m-0" id="CsArea">
							<div class="col-12">
								<!-- 				탭1 자주묻는질문 -->
								<div class="tab-content">
<!-- 								탭2 1:1 메일문의 -->
									<div class="tab-pane fade"></div>
									<div class="tab-pane fade"></div>
									<!-- 						탭3 오시는길		 -->
									<div class="tab-pane fade show active" id="cscontact">
										<div class="row w-100 m-0">
											<div class="col-12"><b>오시는 길</b></div>
											<div class="col-12"><br></div>
										</div>
										<div class="csmapArea">
											<div class="row w-100 m-0">
												<div class="col-12"><h5><b>주소 : 서울특별시 중구 남대문로 120 대일빌딩 2F, 3F</b></h5></div>
												<div class="col-12"><br></div>
											</div>
											<div class="row w-100 m-0">
												<div class="col-12"><h6><b>버스</b></h6></div>
												<div class="col-12"></div>
												<div class="col-12"><b>우리은행 종로지점 정류장</b> </div>
												<div class="col-12"><b>지선</b> 163 / 172 / 201
													/ 262 / 401 / 406 / 701 / 704 / N15 / N62</div>
												<div class="col-12">
													<b>마을</b> 7017 / 7021 / 7022 
												</div>
												<div class="col-12">
													<b>간선</b> 8110
												</div>
											</div>
											<div class="row w-100 m-0">
												<div class="col-12"><br></div>
											</div>
											<div class="row w-100 m-0">
												<div class="col-12"><h6><b>지하철</b></h6> </div>
												<div class="col-12"></div>
												<div class="col-12"> 2호선 을지로입구역 3번출구 100M / 1호선
													종각역 4번, 5번 출구 200M</div>
											</div>
										</div>
										<div class="csmapArea2">
											<div class="row w-100 m-0">
												<div class="col-12">
													<div id="map" style="width:500px;height:400px;"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row w-100 m-0" id="footer" style="background-color:#A2BAAC; font-weight:bold">
			<div class="col-12 d-lg-none">
				<div style="margin-left:40px ; margin-top:20px;text-align:left">
					<a href="/cscenter/csmain.jsp" class="footerLink"><span>자주 묻는 질문</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/cscenter/csmain.jsp" class="footerLink"><span style="margin-left:20px">1 : 1 문의</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/cscenter/csmain.jsp" class="footerLink"><span style="margin-left:20px">찾아오시는 길</span></a><br>
					<div style="margin-top:35px ; text-align:left">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩 2층, 3층</span><br>
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span><span style="margin-left:20px" class="footerLetter">|</span><span>E-MAIL : 4989 - 4284 </span><br>
						<span style="color:#FFF2CC">COPYRIGHT BY PHOENIX  </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-9">
				<div style="margin-left:40px ; margin-top:20px;text-align:left">
					<a href="/cscenter/csmain.jsp" class="footerLink"><span>자주 묻는 질문</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/cscenter/csmain.jsp" class="footerLink"><span style="margin-left:20px">1 : 1 문의</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/cscenter/csmain.jsp" class="footerLink"><span style="margin-left:20px">찾아오시는 길</span></a><br>
					<div style="margin-top:30px ; text-align:left; margin-bottom:15px">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩 2층, 3층</span><br>
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span><span style="margin-left:20px" class="footerLetter">|</span><span style="margin-left:20px" class="footerLetter">E-MAIL : 4989 - 4284 </span><br>
						<span style="color:#FFF2CC">COPYRIGHT BY YUNJI AYEONG WOOHYENG JEONGYOEN HEESEUNG IN  PHOENIX  </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-3" style="text-align:right">
				<img src="/img/footerLogo.png" style="width:70%;margin-right:10px;margin-top:10%">
			</div>
		</div>
	</div>
	<script>
		var container = document.getElementById('map');
		var options = { 
			center: new kakao.maps.LatLng(37.56792863494778, 126.98304380248652), //지도의 중심좌표.
			level: 3 
			};

		var map = new kakao.maps.Map(container, options);
		//지도 api 스크립트
	
	
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