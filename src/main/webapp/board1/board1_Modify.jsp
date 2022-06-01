<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>살까말까 - 글 수정하기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/board1/board1_Modify.css">
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
				<div class="row w-100 m-0" id="board1Outline">
					<div class="col-12">
						<div class="row w-100 m-0" id="writingHeader">
							<div class="col-12">
								<p>살까말까</p>
								<span>살까말까 고민하고 있니? </span>
							</div>
						</div>
						<form action="/modify.brd1" enctype="multipart/form-data" method="post">
							<div class="row w-100 m-0" id="writingArea">
								<div class="col-12">
									<input type="text" placeholder="글 제목을 입력해주세요" maxlength=40 name="title" id="title" size="70" value="${dto.title}"><br>
									<input type="hidden" name="seq" size="70" value="${dto.seq}">
								</div>
								<div class="col-4">
									<div id="img_Box" class="thumbnail">
										<c:choose>
											<c:when test="${dto.fileName==null }">
												<img src="/img/pig2.png"  id="i${dto.seq}">
											</c:when>
											<c:otherwise>
												<img src="files/${dto.fileName }"  id="i${dto.seq}">
											</c:otherwise>
										</c:choose>
            							<input type="hidden" id="isImgDeleted" name="isImgDeleted" value="N">
					            	</div>
								</div>
								<div class="col-8">
									<input type="text" placeholder="물건명을 입력해주세요" name="item" id="item" value="${dto.item }" maxlength=30><br>
            						<input type="text" placeholder="가격을 입력해주세요" name="item_price" value="${dto.item_price }" id="item_price" maxlength=9 oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" /><br>
					            	<c:if test="${dto.fileName!=null}">
				            			<input type="button" value="파일 제거" id="delete">
				            		</c:if>
				            		<label for="upload_file">파일 첨부</label>
				            		<input type="file" name="file" id="upload_file" accept="image/*" onchange="isFileImg(this)">
								</div>
								<div class="col-12">
									<textarea placeholder="이 물건을 꼭 사야하는 이유" name="contents" rows="10" cols="70" maxlength=1000>${dto.contents }</textarea><br>
								</div>
								<div class="col-12">
									<input type="button" value="목록으로" id="goToList" class="writingBtns">
		          					<input type="submit" value="저장하기" id="submit" class="writingBtns">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="row w-100 m-0" id="footer" style="background-color: #A2BAAC; font-weight: bold;">
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
						<span class="footerLetter">E-MAIL : ttaengerang@gmail.com </span><br> 
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
	 	
	 	const reader = new FileReader();
	 	reader.onload = (readerEvent) =>{
	 		document.querySelector("#i"+${dto.seq}).setAttribute("src",readerEvent.target.result);
	 		console.log(readerEvent.target.result);
	 	}

	     document.querySelector("#upload_file").addEventListener("change",(changeEvent) => {
	       const imgFile = changeEvent.target.files[0];
	       reader.readAsDataURL(imgFile);
	     })
	     

	     $("#delete").on("click",function(){
				if(${loginID==null}){
					alert("로그인 후 이용가능합니다.");
					location.href="/index.jsp"
				}
	    	 $("#i"+${dto.seq}).attr("src","/img/pig2.png");//삭제 버튼 클릭 시 이미지 바꿈
	    	 $("#isImgDeleted").val("Y");//이미지 삭제 하는 경우
	     })
		
	  	$("#goToList").on("click",function(){
			if(${loginID==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp"
			}
	    	 location.href="/list.brd1?cpage=1";
	     })
	     
		$("#submit").on("click",function(){
			if(${loginID==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp";
			}
			
         let item_price = $("#item_price").val().trim();
         let title= $("#title").val().trim();
         let item = $("#item").val().trim();;
		
         if(title==''||item_price==''||item==''){
        	 alert("제목, 물건명, 가격은 필수 입력 사항입니다.");
        	 return false;
         }
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
		  
		  let uploadFile = $("#upload_file").val();
		  	function isFileImg(obj){
		  		
			  pathPoint = obj.value.lastIndexOf('.');
			  filePoint = obj.value.substring(pathPoint+1,obj.length);
			  fileType=filePoint.toLowerCase();
			  console.log($("#upload_file").val())
			  
			  if(fileType!='jpg'&&fileType!='png'&&fileType!='jpeg'&&fileType!='gif'){

				  if(${dto.fileName!=null}){
					$("#img_section").attr("src","files/${dto.fileName }");
				  }else{
					$("#img_section").attr("src","/img/pig2.png");	  
				  }
				 alert("이미지 파일만 등록이 가능합니다.");
// 				 parentObj = obj.parentNode;
// 				 node = parentObj.replaceChild(obj.cloneNode(true),obj);
					console.log($("#upload_file").val())
					$("#upload_file").val("");
					console.log($("#upload_file").val())
				 return false;
			  }


	  			}
       
	 </script>
</body>
</html>