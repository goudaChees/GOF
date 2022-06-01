<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>살까말까</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/board1/board1_List.css">
<link rel="stylesheet" href="/css/common.css">
<script>
function getCookie(name) {
    var cookie = document.cookie;
    
    if (document.cookie != "") {
        var cookie_array = cookie.split("; ");
        for ( var index in cookie_array) {
            var cookie_name = cookie_array[index].split("=");
            
            if (cookie_name[0] == "popupYN") {
                return cookie_name[1];
            }
        }
    }
    return ;
}

function openPopup(url) { 
    var cookieCheck = getCookie("popupYN");
    console.log(cookieCheck);
    if (cookieCheck != "N")
        window.open(url, '', 'width=500,height=750,left=500,top=200')
}


</script>
</head>
<body onload="javascript:openPopup('popup.jsp')">
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
								<c:choose>
									<c:when test="${loginID =='admin'}">
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
									</c:when>
									<c:otherwise>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd1?cpage=1" style="color:#664E55">살까말까</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/list.brd2" style="color:#664E55">최저가경매</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="/csnotice.cscenter" style="color:#664E55">고객센터</a></li>
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
				<div class="row w-100 m-0" id="board1Outline">
					<div class="col-12">
						<div class="row w-100 m-0" id="board1Header">
							<div class="col-12">
								<p>살까말까</p>
								<span>살까말까 고민하고 있니? </span>
							</div>
							<div class="col-12">
								<form action="/search.brd1">
									<select class="form-select" aria-label="Default select example"
										name="searchCategory">
										<option value="0">선택</option>
										<option value="1">작성자</option>
										<option value="2">제목</option>
										<option value="3">물건명</option>
									</select>
									<input type="text" placeholder="검색하실 내용을 입력하세요" name="searchTarget">
									<input type="submit" value="검색">
								</form>
							</div>
						</div>
						<div class="row w-100 m-0" id="board1List">
							<div class="col-12 p-0">
								<c:forEach var="i" items="${list}">
									<a href="/detail.brd1?seq=${i.seq}" class="list">
										<div class="row w-100 writing">
											<div class="col-3">
												<div class="thumbnail">
													<c:choose>
														<c:when test="${i.fileName==null }">
															<img src="/img/pig2.png"  id="${i.seq}">
														</c:when>
														<c:otherwise>
															<img src="files/${i.fileName }"  id="${i.seq}">
														</c:otherwise>
													</c:choose>
												</div> 
											</div>
											<div class="col-9">
												<div class="row">
													<input type="hidden" value=${i.seq }>
													<div class="col-12 itemLine" id="itemName_${i.seq }">${i.item}</div>
													<div class="col-12 writingTitle"><span id="n${i.seq }" style="display:none;"><img src="/img/new.gif" style="width:25px;"></span> ${i.title} <p class="d-none d-sm-inline">${i.reply_count }</p></div>
													<div class="col-12 writingEtc">
														${i.writer} <i class="bi bi-dot"></i><span id="w${i.seq }"> ${i.write_date} </span><i class="bi bi-dot"></i> 조회 ${i.view_count}
													</div>
												</div>	
											</div>
										</div>
									</a>
								</c:forEach>
								<div class="row w-100 m-0">
									<div class="col-12">${navi}</div>
									<div class="col-12" style="text-align:right">
										<input type="button" id="write" value="글쓰기">
									</div>
								</div>
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
	
	<script>
		
		window.onload=function(){//날짜 반환
			
			let today=new Date();//오늘날짜
			
			toYear = today.getFullYear();
			toMonth = today.getMonth()+1;
			toDate = today.getDate()

			for(let i=0;i<${glist}.length;i++){
				let seq = ${glist}[i].seq;
				let write_date = new Date(${glist}[i].write_date);
				
				year = write_date.getFullYear();
				month = write_date.getMonth()+1;
				date = write_date.getDate();
				hour = write_date.getHours();
				minutes = write_date.getMinutes();
				
				if(toYear==year&&toMonth==month&&toDate==date){
					write_date = hour +":"+minutes;
					$("#w"+seq).text(write_date);
					$("#n"+seq).css("display","inline-block");
				}else{
					let twoYear = year.toString().substring(2,4);
					write_date = twoYear +"."+month +"."+date;
					$("#w"+seq).text(write_date);					
				}
				
				if($("#itemName_"+seq).text().length>15){
					let name = $("#itemName_"+seq).text().substr(0, 15);
					let content = "[ "+name+"... ]";
					$("#itemName_"+seq).text(content);
					
				}else if($("#itemName_"+seq).text().length<=15){
					let name = $("#itemName_"+seq).text();
					let content = "[ "+name+" ]";
					$("#itemName_"+seq).text(content);
				}
			}
		}	
		
		$(".list").on("click",function(){
			if(${loginID==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp"
			}
		})
		
		$("#write").on("click",function(){
			if(${loginID==null}){
				alert("로그인 후 이용가능합니다.")
				location.href="/index.jsp"
			}
			location.href="/board1/board1_Write.jsp";
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
</body>
</html>