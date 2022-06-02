<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지 - 회원관리</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/admin/adminmemberpage.css">
<link rel="stylesheet" href="/css/common.css">
	
<script>
	function openChild(){
		window.name = "parentForm";
		
		openWin = window.open("/admin/banishMember.jsp", "",
				"top=100,left=200,width=550,height=350");	

	}
	
	function openChild2(){
		window.name = "parentForm";
		
		openWin2 = window.open("/admin/adminModifyMember.jsp", "",
				"top=100,left=200,width=550,height=350");

// 		openWin2 = window.open("/admin/adminPwCheck.jsp", "",
// 				"top=100,left=200,width=550,height=350");	임시로 가려둠

	}
	function setChildText(){
		document.getElementById("adminTF").value = openWin2.document.getElementById("cTF").value;	
	}

</script>	

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
									aria-current="page" href="/csnotice.cscenter" style="color:#664E55">고객센터</a></li>
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
				<div class="row w-100 m-0" id="memberPageOutline">
					<div class="col-12">
						<div class="row w-100 m-0" id="memberPageHeader">
							<div class="col-12">
							<a href="/adminmain.admin"><img src="/img/nametagadmin.png" id="nametag"></a><br>
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
							
					<div class="row" id="memberPage">
						<div class="col-12">	
							<form action="adminUpdate.admin" method="post">
								<div class="row" id="memberPageArea">
									<div class="col-12">
										<div class="row">
											<div class="col-12" id="memberPageAreaHeader">${mdto.id}'s Information</div>
											<input type="hidden" value="${mdto.id}" name="id" id="userId">
										</div>
										<div class="row" align=center>
											<div class="col-4">ID</div>
											<div class="col-8">${mdto.id}</div>
										</div>
										<div class="row">
											<div class="col-4">NAME</div>
											<div class="col-8">
												<input type=text value="${mdto.name}" class="editable"
												name=name id="nameTD" disabled>
											</div>
										</div>
										<div class="row">
											<div class="col-4">PHONE</div>
											<div class="col-8">
												<input type=text value="${mdto.phone}" class="editable"
													name=phone id="phoneTD" disabled>
											</div>												
												<div class="col-4"></div>
												<div class="col-8" id="phoneCheckResult"></div>
											</div>
										<div class="row">
											<div class="col-4">EMAIL</div>
											<div class="col-8">
												<input type=text value="${mdto.email}" class="editable"
													name=email id="emailTD" disabled>
											</div>
											<div class="col-4"></div>
											<div class="col-8" id="emailCheckResult"></div>
										</div>
										<div class="row">
											<div class="col-4">NICKNAME</div>
											<div class="col-8">
												<input type=text value="${mdto.nickname}" class="editable"
													name=nickname id="nicknameTD" disabled>
											</div>
											<div class="col-4"></div>
											<div class="col-8" id="nicknameCheckResult"></div>
										</div>
										<div class="row">
											<div class="col-4">JOINDATE</div>
											<div class="col-8">${mdto.joindate}</div>
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-12">
										<input id="adminTF" type="text" style="color: red; width:200px; background-color:white;" value="관리자 확인이 필요합니다. " disabled>
									</div>
								</div>
									
								<br>
								<div class="row w-100 m-10" align=center>
									<div class="col-12" id="btns">
										<button id="back" type="button">뒤로가기</button>
										<button id="modify" type="button">수정하기</button>
										<button id="banish" type="button">강제 추방</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
	<div class="row w-100 m-0" id="footer" style="background-color: #A2BAAC; font-weight: bold;">
			<div class="col-12 p-0 d-lg-none">
				<div style="padding-top: 20px; padding-bottom:10px; text-align: center; font-size:min(14px,3.5vw);">
					<a href="/csnotice.cscenter" class="footerLink">
						<span>공지사항</span></a>
					<span style="margin-left: 20px" class="footerBar">|</span>
					<a href="/csmain.cscenter" class="footerLink">
						<span style="margin-left: 20px">자주 묻는 질문</span></a>
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
						<span class="footerLetter">E-MAIL : ttaengerang@gmail.com </span><br> 
						<span style="color: #FFF2CC;font-size:min(15px,4vw);line-height:40px;">COPYRIGHT BY PHOENIX </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-9">
				<div style="margin-left:40px ; margin-top:20px;text-align:left">
					<a href="/csnotice.cscenter" class="footerLink"><span>공지사항</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csmain.cscenter" class="footerLink"><span style="margin-left:20px">자주 묻는 질문</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csemail.cscenter" class="footerLink"><span style="margin-left:20px">1 : 1 문의</span></a><span style="margin-left:20px" class="footerBar">|</span>
					<a href="/csmap.cscenter" class="footerLink"><span style="margin-left:20px">찾아오시는 길</span></a><br>
					<div style="margin-top:30px ; text-align:left; margin-bottom:15px">
						<span class="footerLetter">ADDRESS : 서울 중구 남대문로 120 대일빌딩 2층, 3층</span><br>
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span><span style="margin-left:20px" class="footerLetter">|</span><span style="margin-left:20px" class="footerLetter">E-MAIL : ttaengerang@gmail.com </span><br>
						<span style="color:#FFF2CC">COPYRIGHT BY YUNJI AYEONG WOOHYENG JEONGYOEN HEESEUNG IN  PHOENIX  </span>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block col-lg-3" style="text-align:right">
				<img src="/img/footerLogo.png" style="width:70%;margin-right:10px;margin-top:10%">
			</div>
		</div>
</div>

</body>
<script>

	// 뒤로가기 
	$("#back").on("click", function(){
		location.href="/adminmain.admin";
	})
	
	// 수정버튼 클릭 시
	$("#modify").on("click", function(){
		openChild2();
		$("#adminTF").on("focus", function(){
			$("#adminTF").css("display","none");
			
			$("#modify").css("display", "none");
			$("#banish").css("display", "none");
			let ok = $("<button>");
			ok.text("수정완료");
		
			let cancel = $("<button>");
			cancel.text("취소");
			cancel.attr("type","button");
			cancel.attr("id","canbtn");
			cancel.on("click", function(){
				location.reload();
			})
		
			$("#btns").append(ok);
			$("#btns").append(cancel);
			
		})

	})
	
	$("#banish").on("click", function(){
		openChild();
		
	})

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

</html>