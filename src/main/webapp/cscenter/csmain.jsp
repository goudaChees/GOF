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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed298afa01dbe436406160c176a6dde2"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
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
											aria-current="page" href="/list.brd1?cpage=1"
											style="color: #664E55">살까말까</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color: #664E55">최저가 경매</a></li>
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
											aria-current="page" href="/list.brd1?cpage=1"
											style="color: #664E55">살까말까</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color: #664E55">최저가 경매</a></li>
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
											aria-current="page" href="#" style="color: #664E55">살까말까</a></li>
										<li class="nav-item nonMember"><a class="nav-link active"
											aria-current="page" href="#" style="color: #664E55">최저가 경매</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csmain.cscenter" style="color: #664E55">고객센터</a></li>
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
									<li class="nav-item"><a class="nav-link" data-toggle="tab"
										href="#csmail">1:1 문의하기</a></li>
									<li class="nav-item" id="mapck"><a class="nav-link" data-toggle="tab"
										href="#cscontact">찾아 오시는 길</a></li>
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
														게시판 이용 방법 입니다. <br> <strong>살까? 말까? >> </strong> <br>
														살까 말까 고민되는 물건이 있으신가요? <br> 혼자서 답이 전혀 나오지 않는다면 참견러들에게
														물어보세요! <br> 고민하는 물건의 사진을 한장 찍어서 업로드 하면 끝! <br> 
														<c:choose>
															<c:when test="${loginID !=null}">
																<a href="/list.brd1?cpage=1">살까말까 바로가기</a> <br> <br> 
																<strong>최저가 경매! >> </strong> <br> 더 저렴한 곳 어디 없나~?  <br> 숨은 고수들이
																더 저렴한 곳을 찾아주실거에요! <br> 경매를 시작하고! 낙찰까지 진행해보세요. 숨은 혜택이
																있을지도!? <a href="/list.brd2"><br>최저가 경매 바로가기</a> <br>
															</c:when>
															<c:when test="${loginID == null}">
																<a class="nonMember" href="#" >살까말까 바로가기</a> <br> <br> 
																<strong>최저가 경매! >> </strong> <br> 더 저렴한 곳 어디 없나~?  <br> 숨은 고수들이
																더 저렴한 곳을 찾아주실거에요! <br> 경매를 시작하고! 낙찰까지 진행해보세요. 숨은 혜택이
																있을지도!? <a class="nonMember" href="#" ><br>최저가 경매 바로가기</a> <br>
															</c:when>
														</c:choose>
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
														aria-controls="panelsStayOpen-collapsefour">Q.
														1:1 문의를 하고 싶어요!</button>
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
														placeholder="제목을 작성해 주세요">
												</div>
												<div class="col-2">내용</div>
												<div class="col-10">
													<textarea name="emailContents" id="emailContentsBox"
														placeholder="내용을 작성해 주세요"></textarea>
												</div>
											
											
											<c:choose>
												<c:when test="${loginID == null}">
													<div class="row w-100 m-0">
														<div class="col-2">메일 주소</div>
														<div class="col-10">
															<input type=text name="emailAddr" id="emailAddrBox"
																placeholder="연락 받을 메일 주소를 작성해 주세요">
														</div>
													</div>
												</c:when>
											</c:choose>
											
											</div>
											<div class="row w-100 m-0"><br><br></div>											
											<div class="row w-100 m-0">
												<div class="col-12">
													<button type=submit>Send Email</button>
												</div>
											</div>
										</form>
									</div>
									<!-- 지도 api 추가 -->
									<div class="tab-pane fade" id="cscontact">
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
												<div class="col-12"> <b>우리은행 종로지점 정류장</b> </div>
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
												<div class="col-12"><h6><b>지하철</b></h6></div>
												<div class="col-12"></div>
												<div class="col-12"> 2호선 을지로입구역 3번출구 100M </div>
												<div class="col-12"> 1호선
													종각역 4번, 5번 출구 200M </div>
											</div>
										</div>
										<div class="csmapArea2">
											<div class="row w-100 m-0">
												<div class="col-12">
													<div id="map" style="width:500px;height:400px;"></div>
												</div>
											</div>
										<!--  지도 api 마감 -->
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
					<a href="/csmain.cscenter" class="footerLink"><span>자주 묻는 질문</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csemail.cscenter" class="footerLink"><span style="margin-left:20px">1 : 1 문의</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csmap.cscenter" class="footerLink"><span style="margin-left:20px">찾아오시는 길</span></a><br>
					<div style="margin-top:35px ; text-align:left">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩 2층, 3층</span><br>
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span><span style="margin-left:20px" class="footerLetter">|</span><span>E-MAIL : 4989 - 4284 </span><br>
						<span style="color:#FFF2CC">COPYRIGHT BY PHOENIX  </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-9">
				<div style="margin-left:40px ; margin-top:20px;text-align:left">
					<a href="/csmain.cscenter" class="footerLink"><span>자주 묻는 질문</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csemail.cscenter" class="footerLink"><span style="margin-left:20px">1 : 1 문의</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csmap.cscenter" class="footerLink"><span style="margin-left:20px">찾아오시는 길</span></a><br>
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
	setTimeout(function(){ map.relayout(); }, 1500);
		function relayout() {    
		    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
		    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
		    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
		    map.relayout();
		}
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