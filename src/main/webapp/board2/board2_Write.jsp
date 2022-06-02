<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최저가경매 - 글쓰기</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/board2/board2_Write.css">
<link rel="stylesheet" href="/css/common.css">

</head>
<body>
<c:if test="${seq==null}"><form action="write2.brd2" method="post"></c:if>
<c:if test="${seq!=null}"><form action="modi2.brd2" method="post"></c:if>
	<div id="container w-100">
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
										<li class="nav-item"><a class="nav-link active" aria-current="page" href="/list.letter?type=r&page=1">
											<i class="bi bi-envelope" style="color: #664E55"></i></a></li>
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
						<div class="row w-100 m-0" id="header_title">
							<div class="col-12" style="padding-top:10px;">
								<a href="/list.brd2"><img src="/img/nametagbrd2.png" id="nametag"></a><br>
								<span id="brdInfo" style="font-size:16px;margin-left:30px;">최저가 정보가 필요하신가요? </span>
							</div>
						</div>
						<div class="row w-100 m-0" id=board2List>
							<div class="col-12">
								<div class="row w-100 m-0">
									<div class="col-12">

										<input type="text" name="title" maxlength="30" id="title" placeholder="제목은 최대 30자 까지 입력가능합니다." value="${dto.title}">

									</div>
									
									<div class="col-12" id="note_content">
										<textarea id="summernote" name="contents" style="resize: none" maxlength="1200">${dto.contents}</textarea>
									</div>
								
								</div>
								
							</div>
							
						</div>
						<div class="row">
									<div class="col-12" style="text-align:right;">
										<button type="submit" class="write" id="submit">경매시작</button>
										<button type="button" class="write" id="back">취소하기</button>
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
	<c:if test="${seq!=null}"><input type="text" style="display:none" name="seq" value="${seq}"></c:if>
	<input type="text" style="display:none" name="id" value="${loginID}">
</form>

	<script>
	$( document ).ready(function(){
	if(${loginID==null}){
		alert("로그인 후 이용 가능합니다.")
		location.href="/index.jsp"
	}
	})
		$('#summernote').summernote({
		  placeholder: '구매하고 싶은 상품정보를 입력해주세요. 최대 1300자까지 입력가능합니다.',
		  tabsize: 2,
		  height : $("#note_content").height()*1,
			//disableResizeEditor:true,
			toolbar : [[ 'style', [ 'style' ] ],
					['font',[ 'bold', 'underline','clear' ] ],
					[ 'color', [ 'color' ] ],
					[ 'para',[ 'ul', 'ol', 'paragraph' ] ],
			],
		});
		//에디터 내용 텍스트 제거
		function f_SkipTags_html(input, allowed) {
		// 허용할 태그는 다음과 같이 소문자로 넘겨받습니다. (<a><b><c>)
    	allowed = (((allowed || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join('');
    	var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
   		 commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
    	return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
        return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
    	});
		}
		
		
		$("#submit").on("click",function(){
			if(${loginID==null}){
				alert("로그인 후 이용 가능합니다.")
				location.href="/index.jsp"
			}
			if($("#summernote").val()=='' || $("#title").val()==''){
				alert("제목, 내용은 필수 입력 사항입니다.");
		    	 return false;
			}
			var status = false;
			var textCnt = 0; //총 글자수
			var maxCnt = 1200; //최대 글자수
			var editorText = f_SkipTags_html($("#summernote").val()); //에디터에서 태그를 삭제하고 내용만 가져오기
			    editorText = editorText.replace(/\s/gi,""); //줄바꿈 제거
			    editorText = editorText.replace(/&nbsp;/gi, ""); //공백제거

		        textCnt = editorText.length;
			    if(maxCnt > 0) {
		        	if(textCnt > maxCnt) {
		                status = true;
		        	}
			    }
			if(status) {
				alert("등록오류 : 글자수는 최대 "+maxCnt+"까지 등록이 가능합니다. / 현재 글자수 : "+textCnt+"자");
	        	return false;
		    }
			
		})
		
		$("#back").on("click", function(){
			location.href="/list.brd2";
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