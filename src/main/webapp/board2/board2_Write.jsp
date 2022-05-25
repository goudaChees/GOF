<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board2 Write page</title>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
</head>
<body>
<c:if test="${seq==null}"><form action="write2.brd2" method="post"></c:if>
<c:if test="${seq!=null}"><form action="modi2.brd2" method="post"></c:if>
	<div id="container">
		<div class="row">
			<div class="row w-100 m-0" >
			<div class="col-12 p-0" >
				<nav class="navbar navbar-expand-lg navbar-light bg-light">
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
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/list.brd1?cpage=1"
									style="color: #664E55">살까말까</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/list.brd2" style="color: #664E55">최저가 경매</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="csmain.cscenter"
									style="color: #664E55">고객센터</a></li>

								<c:choose>
									<c:when test="${loginID =='admin'}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#" style="color: #664E55">관리자페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="logout.member"><i
												class="bi bi-box-arrow-right"></i></a></li>
									</c:when>
									<c:when test="${loginID !=null}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="mypage.member"
											style="color: #664E55">마이페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="logout.member"><i
												class="bi bi-box-arrow-right"></i></a></li>
									</c:when>
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
							<div class="col-12">
								<p>최저가 경매</p>
								<span>최저가 링크를 올려주세요</span>
							</div>
						</div>
						<div class="row w-100 m-0" id=board2List align=center>
							<div class="col-12">
								<div class="row w-100 m-0">
									<div class="col-12">
										<input type="text" name="title" placeholder="제목을 작성해주세요">
									</div>
									
									<div class="col-12" id="note_content">
										<textarea id="summernote" name="contents" style="resize: none">${dto.contents}</textarea>
									</div>
								
								</div>
								
							</div>
							
						</div>
						<div class="row">
									<div class="col-12" style="text-align:right;">
										<button type="submit" class="write">작성하기</button>
										<button type="button" class="write" id="back">취소하기</button>
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
	<c:if test="${seq!=null}"><input type="text" style="display:none" name="seq" value="${seq}"></c:if>
</form>
	<script>
		$('#summernote').summernote({
		  placeholder: '내용을 작성해주세요',
		  tabsize: 2,
		  height : $("#note_content").height()*1,
			//disableResizeEditor:true,
			toolbar : [[ 'style', [ 'style' ] ],
					['font',[ 'bold', 'underline','clear' ] ],
					[ 'color', [ 'color' ] ],
					[ 'para',[ 'ul', 'ol', 'paragraph' ] ],
			]
		});
		
		//$(".note-editor").height($("#note_content").height()*0.8);
		
		$("#submit").on("click",function(){
			if($("#summernote").val()=='' && $("#title").val()==''){
				alert("제목, 내용은 필수 입력 사항입니다.");
		    	 return false;
			}
			
		})
		
		$("#back").on("click", function(){
			location.href="/list.brd2";
		})
		
	  </script>
</body>
</html>