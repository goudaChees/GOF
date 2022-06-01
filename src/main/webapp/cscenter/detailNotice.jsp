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
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed298afa01dbe436406160c176a6dde2"></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e3b2ec1cbf323959f82484d3c09baa42"></script> -->
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
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/cscenter/csdetail.css">
<link rel="stylesheet" href="/css/common.css">

</head>
<body>

	<div class="container w-100">
		<div class="row w-100 m-0" id="header">
			<div class="col-12 p-0">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="/index.jsp" style="color: #664E55"><img
							src="/img/logo.png" id="logo"></a>
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
											aria-current="page" href="/list.brd2" style="color: #664E55">최저가경매</a></li>
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
											aria-current="page" href="/list.brd2" style="color: #664E55">최저가경매</a></li>
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
											aria-current="page" href="#" style="color: #664E55">최저가경매</a></li>
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
									<li class="nav-item"><a class="nav-link active"
										data-toggle="tab" href="#csnotice">공지 사항</a></li>
									<li class="nav-item"><a class="nav-link" 
										href="/csmain.cscenter">자주 묻는 질문</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/csemail.cscenter">1:1 문의하기</a></li>
									<li class="nav-item" id="mapck"><a class="nav-link"
										href="/csmap.cscenter">찾아 오시는 길</a></li>
								</ul>
							</div>
						</div>
						<div class="row w-100 m-0" id="noticeArea">
							<div class="col-12">
								<form action="/udtNotice.cscenter" method="post">
								<div class="row w-100 m-0" id="noticePageArea">
									<div class="col-12">
										<div class="row">
											<div class="col-12" id="noticeHeader">
												<input type="text" value="${dto.title}" class="editable" name="title" id="titleTD" disabled>
											</div>
											<input type="hidden" value="${dto.seq }" name="seq">
										</div>
										
										<div class="row" style="border-bottom:1px solid #516D5C;">
											<div class="col-1"></div>
											<div class="col-4 d-none d-md-block" style="text-align:left;">${dto.write_date}</div>
											<div class="col-2"></div>
											<div class="col-4 d-none d-md-block" style="text-align:right;">${dto.view_count}</div>
											<div class="col-1"></div>
										</div>
										<div class="row">
											<div class="col-12"></div>
										</div>
										<div class="row" align=center id="contentsBox">
											<div class="col-12">
												<textarea class="editable" id="contentsTD" name="contents" style="white-space:normal" disabled >${dto.contents}</textarea>
											</div>
										</div>
										<div class="row" >
											<div class="col-12"></div>
										</div>
										<div class="row w-100 m-0" id="NoticeFooter">
											<div class="col-12" id="btns">
												<input type="button" id="toList" value="목록으로">
												<c:if test="${loginID=='admin'}">
													<input type="button" id="modify" value="수정하기">
													<input type="button" id="delete" value="삭제하기" >
												</c:if>
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

		<div class="row w-100 m-0" id="footer"
			style="background-color: #A2BAAC; font-weight: bold;">
			<div class="col-12 p-0 d-lg-none">
				<div
					style="padding-top: 20px; padding-bottom: 10px; text-align: center; font-size: min(14px, 3.5vw);">
					<a href="/csmain.cscenter" class="footerLink"> <span>자주
							묻는 질문</span></a> <span style="margin-left: 20px" class="footerBar">|</span>
					<a href="/csemail.cscenter" class="footerLink"> <span
						style="margin-left: 20px">1 : 1 문의</span></a> <span
						style="margin-left: 20px" class="footerBar">|</span> <a
						href="/csmap.cscenter" class="footerLink"> <span
						style="margin-left: 20px;">찾아오시는 길</span></a><br>
					<div style="margin-top: 15px; text-align: center">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩
							2층, 3층</span><br> <span class="footerLetter">대 표 전 화 : 4989
							- 4284</span> <span style="margin-left: 10px; margin-right: 10px"
							class="footerLetter">|</span> <span class="footerLetter">E-MAIL
							: ttaengerang@gmail.com </span><br> <span
							style="color: #FFF2CC; font-size: min(15px, 4vw); line-height: 40px;">COPYRIGHT
							BY PHOENIX </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-9">
				<div style="margin-left: 40px; margin-top: 20px; text-align: left">
					<a href="/csmain.cscenter" class="footerLink"><span>자주
							묻는 질문</span></a><span style="margin-left: 20px" class="footerBar">|</span> <a
						href="/csemail.cscenter" class="footerLink"><span
						style="margin-left: 20px">1 : 1 문의</span></a><span
						style="margin-left: 20px" class="footerBar">|</span> <a
						href="/csmap.cscenter" class="footerLink"><span
						style="margin-left: 20px">찾아오시는 길</span></a><br>
					<div
						style="margin-top: 30px; text-align: left; margin-bottom: 15px">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩
							2층, 3층</span><br> <span class="footerLetter">대 표 전 화 : 4989
							- 4284</span><span style="margin-left: 20px" class="footerLetter">|</span><span
							style="margin-left: 20px" class="footerLetter">E-MAIL :
							ttaengerang@gmail.com </span><br> <span style="color: #FFF2CC">COPYRIGHT
							BY YUNJI AYEONG WOOHYENG JEONGYOEN HEESEUNG IN PHOENIX </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-3" style="text-align: right">
				<img src="/img/footerLogo.png"
					style="width: 70%; margin-right: 10px; margin-top: 10%">
			</div>
		</div>
	</div>

	<script>

$("#modify").on("click", function() {
	$(".editable").removeAttr("disabled");
	$("#toList").css("display","none");
	$("#modify").css("display","none");
	$("#delete").css("display","none");
	
	$("#titleTD").attr("contenteditable", "true");
	$("#contentsTD").attr("contenteditable", "true");
	
	
	let ok = $("<button>");
	ok.text("수정완료");
	ok.css("padding","1%");
	ok.css("background-color", "#FFBE46");
	ok.css("line-height", "23px");
	ok.css("color", "white");
	ok.css("width","90px");
	ok.css("font-size","min(17px,3.5vw)");
	ok.css("border-radius", "20px");
	ok.css("border","3px solid #ff8000");
	ok.css("margin-top","2%");

	let cancel = $("<button>");
	cancel.text("수정취소");
	cancel.attr("type", "button");
	cancel.css("padding","1%");
	cancel.css("margin-right", "1%");
	cancel.css("background-color","#B4C8BC");
	cancel.css("line-height","23px");
	cancel.css("color", "white");
	cancel.css("width","90px");
	cancel.css("font-size", "min(17px,3.5vw)");
	cancel.css("border-radius", "20px");
	cancel.css("border","3px solid #516D5C");
	cancel.css("margin-top","2%");
	cancel.attr("id","canbtn");
	cancel.on("click", function() {
		location.reload();
	})
	
	$("#btns").prepend(ok);
	$("#btns").prepend(cancel);
	
	
})


$("#delete").on("click", function(){
	let result = confirm("정말 삭제하시겟습니까?");
	if(result){
		location.href="/deleteNotice.cscenter?seq=${dto.seq}";
	}
})

$("#toList").on("click", function(){
	location.href="/csnotice.cscenter";
})


</script>


</body>
</html>