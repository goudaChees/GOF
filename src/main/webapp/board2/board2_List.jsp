<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>최저가경매</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/board2/board2_List.css">
<link rel="stylesheet" href="/css/common.css">

</head>
<body>
	<div class="container">
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
								<c:choose>
									<c:when test="${loginID =='admin'}">
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
									</c:when>
									<c:otherwise>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd1?cpage=1" style="color:#664E55">살까말까</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color:#664E55">최저가경매</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csmain.cscenter" style="color:#664E55">고객센터</a></li>
										<li class="nav-item"><a class="nav-link active" 
											aria-current="page" href="/mypage.member" style="color:#664E55">마이페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
										aria-current="page" href="#"><i class="bi bi-box-arrow-right" style="color:#664E55"></i></a></li>
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
				<div class="row w-100 m-0" id="board2Outline">
					<div class="col-12">
						<div class="row w-100 m-0" id="board2Header">
							<div class="col-12">
								<p>최저가 경매</p>
								<span>최저가 링크를 올려주세요</span>
							</div>
						
							<div class="col-12">
								<form action="serch.brd2" method="post">
									<select class="form-select" aria-label="Default select example" id="select1" name="category">
										<option class="select" value="title">제목</option>
										<option class="select" value="writer">작성자</option>
										<option class="select" value="contents">내용</option>
									</select>
									<input type="search" id="search" name="serch" placeholder="검색하실 내용을 입력하세요">
									<input type="submit" id="submit" value="검색">		
								</form>
							</div>
						</div>
					
						<div class="row w-100 m-0" id="board2List" >
							<div class="col-12 p-0 tableheader">
								<div class="row w-100 m-0" align=left>
									<div class="col-12 p-0">
										<div class="row w-100 m-0" align=left>
											<div class="col-md-2 d-none d-md-block">글번호</div>
											<div class="col-md-3 d-none d-md-block">제목</div>
											<div class="col-md-2 d-none d-md-block">작성자</div>
											<div class="col-md-2 d-none d-md-block">조회수</div>
											<div class="col-md-3 d-none d-md-block">제한시간</div>
										</div>
									</div>
								</div>
								<div class="row w-100 m-0" align=center>
								<div class="col-12 p-0">
									<c:forEach var="i" items="${dto}">
										<div class="row w-100 writing">
											<a href="/read.brd2?seq=${i.seq}">
											<div class="col">
												<div class="row w-100 m-0 writingTitle">
													<div class="col-md-2 d-none d-md-block">${i.seq}</div>
													<div class="col-8 col-md-3 title" id="title_limit" style="text-align:left">
														${i.title}
														<c:if test="${i.reply!=0}">[${i.reply}]</c:if>
													</div>
													<div class="col-md-2 d-none d-md-block nickname">${i.nickname}</div>
													<div class="col time" id="${i.write_date}"  style="display:none">${i.write_date}</div>
													<div class="col-md-2 d-none d-md-block">${i.view_count}</div>
													<div class="col-4 col-md-3 limit" id="${i.seq}">
														<div class="spinner-border spinner-border-sm text-secondary" role="status">
 									 						<span class="visually-hidden">Loading...</span>
														</div>
													</div>
												</div>
												<div class="row w-100 m-0 writingEtc">
													<div class="col-12 d-md-none d-md-block">
														${i.nickname} <i class="bi bi-dot"></i> ${i.write_date} <i class="bi bi-dot"></i> 조회 ${i.view_count}
													</div>
												</div>
											</div>
										</a>	
									</div>
								</c:forEach>
								</div>
								</div>
								<div class="row w-100 m-0">
									<div class="col-12">${navi}</div>
									<div class="col-12" style="text-align:right"><a href="/write.brd2"><button class="write">작성하기</button></a></div>
								</div>
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
	window.onload=function(){
		const countDownTimer = function(id, date) {
			let _vDate = new Date(date);
			// 전달 받은 일자 
			let _second = 1000;
			let _minute = _second * 60;
			let _hour = _minute * 60;
			let _day = _hour * 24;
			let timer;
			function showRemaining() {
				let now = new Date();
				var distDt = _vDate - now;
				if (distDt < 0) {
					clearInterval(timer);
					document.getElementById(id).textContent = "종료";
					document.getElementById(id).style.color="#FF595E";
					return;
				}
				let days = Math.floor(distDt / _day);
				let hours = Math.floor((distDt % _day) / _hour);
				let minutes = Math.floor((distDt % _hour) / _minute);
				let seconds = Math.floor((distDt % _minute) / _second);
				//document.getElementById(id).textContent = date.toLocaleString() + "까지 : ";
				//document.getElementById(id).textContent = days + '일 ';
				//document.getElementById(id).textContent += hours + '시간 ';
				document.getElementById(id).textContent = minutes + '분 ';
				document.getElementById(id).textContent += seconds + '초';
				document.getElementById(id).style.color="#1982C4";
			}
			timer = setInterval(showRemaining, 1000);
		}

		for (let i = 0; i < $(".title").length; i++) {
			let id = $(document.querySelectorAll(".limit")[i]).attr('id');
			let time = $(document.querySelectorAll(".time")[i]).attr('id');
			let dateObj = new Date(time);
			dateObj.setMinutes(dateObj.getMinutes() + 30);
			countDownTimer(id, dateObj);
		}
		// 내일까지 countDownTimer('sample02', '04/01/2024 00:00 AM'); 
		// 2024년 4월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용한다. 
		// 		countDownTimer('sample03', '04/01/2024');
		// 2024년 4월 1일까지 countDownTimer('sample04', '04/01/2019');
		// 2024년 4월 1일까지
// 		if(${category}!=null){	 
// 		let mystring='';
//  		if(${category}==title){
			
//  			let	SearchString = ${serch};

//  		}else if(${category} == writer){

//  			let	SearchString = ${serch};
//  		}

//  		let regex = new RegExp(SearchString, "g");
//   		for(let i = 0; i<$(".title").length;i++){
//  			mystring=$(document.querySelectorAll(".title")[i]).val();
//  			mystring.replace(regex, "<em class='highlight'>" + SearchString + "</em>");
//  		}
// 		}
	}
	
	
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