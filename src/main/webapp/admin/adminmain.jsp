<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/admin/adminmain.css">
<link rel="stylesheet" href="/css/common.css">
</head>
<body>
	<div class="container w-100">
		<div class="row w-100 m-0" id="header">
			<div class="col-12 p-0">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
					<div class="container-fluid">
						<a class="navbar-brand" href="/index.jsp" style="color:#664E55"><img src="/img/logo.png" id="logo"></a>
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
									aria-current="page" href="/list.brd1?cpage=1" style="color:#664E55">살까말까</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/list.brd2" style="color:#664E55">최저가경매</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/csmain.cscenter" style="color:#664E55">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/adminmain.admin" style="color:#664E55">관리자페이지</a></li>
								<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="#"><i class="bi bi-box-arrow-right" style="color:#664E55"></i></a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>

		<div class="row w-100 m-0" id="content">
			<div class="d-none d-lg-block col-3"></div>
			<div class="col-12 col-lg-6">
				<div class="row w-100 m-0" id="AdminPageOutLine">
					<div class="col-12">
						<div class="row w-100 m-0" id="AdminPageHeader">
							<div class="col-12">
								<p>[관리자 전용] 페이지 입니다.</p>
								<ul class="nav nav-tabs">
									<li class="nav-item"><a class="nav-link active"
										aria-current="page" href="/adminmain.admin">회원 정보 관리</a></li>
									<li class="nav-item"><a class="nav-link" 
										href="/adminBoardsList.admin">게시글 관리</a></li>
									<li class="nav-item"><a class="nav-link" 
										href="/adminReplysList.admin?board=1">댓글 관리</a></li>
								</ul>
							</div>
						</div>
				
						<div class="row w-100 m-0"  id="memberManagement">
							<div class="col-12 p-0">
								<div class="row w-100 m-0">
									<div class="col-12" id="memberlistHeader">Member List</div>
									<div class="col-12"></div>
								</div>

								<div class="row w-100 m-0">
									<div class="col-12 p-0" id="searchBar">								
										<form action="/searchMember.admin">
											<select class="form-select" aria-label="Default select example"
												name="searchCategory">
												
												<option value="1">ID</option>
												<option value="2">이름</option>
												<option value="3">닉네임</option>
											</select>
											<input type="text" placeholder="검색하실 내용을 입력하세요"
												name="toSearch"> 
											<input type="submit" value="검색">
										</form>
										<div class="row w-100 m-0">
										</div>
									</div>
								</div>


								<div class="row w-100 m-0" id="memberHeader">
									<div class="d-none d-lg-block col-1">No.</div>
									<div class="d-none d-lg-block col-lg-3">ID</div>
									<div class="d-none d-lg-block col-lg-3">NickName</div>
									<div class="d-none d-lg-block col-2">Name</div>
									<div class="d-none d-lg-block col-lg-3">JoinDate</div>
								</div>
								
								<c:forEach var="i" items="${list}">
									<a href="/detailViewMember.admin?id=${i.id}">
									<div class="row w-100 m-0 memberinfo">
										<div class="col-1 p-0 d-none d-lg-block">${i.seq}</div>
										<div class="col-6 p-0 col-lg-3 listNN">${i.id}</div>										
										<div class="col-6 p-0 col-lg-3">${i.nickname}</div>
										<div class="col-6 p-0 col-lg-2">${i.name}</div>
										<div class="col-6 p-0 col-lg-3">${i.joindate}</div>
									</div>
									</a>
								</c:forEach>
								

								
							</div>
						</div>							
						<div class="row w-100 m-0 memberlistPageNavi">
							<div class="col-12">
								${pageNavi}
							</div>
						</div>
					</div>
				
				</div>
			</div>
		</div>
		<div class="row w-100 m-0" id="footer" style="background-color:#A2BAAC; font-weight:bold">
			<div class="col-12 p-0 d-lg-none">
				<div style="padding-top: 20px; padding-bottom:10px; text-align: center; font-size:min(14px,3.5vw);">
					<a href="/csmain.cscenter" class="footerLink">
						<span>자주 묻는 질문</span></a>
					<span style="margin-left: 20px" class="footerBar">|</span> 
					<a href="/csemail.cscenter" class="footerLink">
						<span style="margin-left: 20px">1 : 1 문의</span></a>
					<span style="margin-left: 20px" class="footerBar">|</span> 
					<a href="/csmap.cscenter" class="footerLink">
						<span style="margin-left: 20px;">찾아오시는 길</span></a><br>
					<div style="margin-top: 15px; text-align: center">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩 2층, 3층</span><br> 
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span>
						<span style="margin-left: 10px; margin-right:10px" class="footerLetter">|</span>
						<span>E-MAIL : 4989 - 4284 </span><br> 
						<span style="color: #FFF2CC;font-size:min(15px,4vw);line-height:40px;">COPYRIGHT BY PHOENIX </span>
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
	//로그아웃 관련 공통기능

  	// SDK를 초기화. 사용할 앱의 JavaScript 키
  	Kakao.init('b956cab5ef7dbe5bc1f861614a4b2061');
    //console.log(Kakao.isInitialized());
    
    //item을 localStorage에 저장하는 메소드
    function saveToDos(token) { 
		typeof(Storage) !== 'undefined' && sessionStorage.setItem('AccessKEY', JSON.stringify(token)); 
	};


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