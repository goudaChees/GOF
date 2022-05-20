<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board2 Write page</title>
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
<style>
* {
	text-align: center;
}
</style>
</head>
<body>
<c:if test="${seq==null}"><form action="write2.brd2" method="post"></c:if>
<c:if test="${seq!=null}"><form action="modi2.brd2" method="post"></c:if>
	<div id="container">
		<div class="row">
			<div class="col-12">
					<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<a class="navbar-brand" href="/index.jsp">앞날의 지침</a>
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
							aria-current="page" href="#">지출의 참견</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="list.brd2">선택의 참견</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="csmain.cscenter">고객센터</a></li>
						
						<c:choose>
							<c:when test="${loginID =='admin'}">
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">관리자페이지</a></li>
								<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="logout.member"><i class="bi bi-box-arrow-right"></i></a></li>
							</c:when>
							<c:when test="${loginID !=null}">
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="mypage.member">마이페이지</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="logout.member"><i class="bi bi-box-arrow-right"></i></a></li>
							</c:when>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<input type="text" name="title" placeholder="제목을 작성해주세요">
			</div>
		</div>
		<div class="col-12">
<!-- 			<input type="text" name="item" placeholder="물건의 이름을 작성해주세요"> -->
		</div>
		<div class="row">
			<div class="col-2">
			</div>
			<div class="col-8">
				<textarea id="summernote" name="contents"></textarea>
			</div>
			<div class="col-2">
			</div>
		</div>
		<div class="row">
			<div class="col-8">
			</div>
			<div class="col-2">
				<button type="submit">작성하기</button>
			</div>
			<div class="col-2">
				<button type="button" id="bkack">취소하기</button>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				footer
			</div>
		</div>
	</div>
	<c:if test="${seq!=null}"><input type="text" style="display:none" name="seq" value="${seq}"></c:if>
</form>
	<script>
		$('#summernote').summernote({
		  placeholder: '내용을 작성해주세요',
		  tabsize: 2,
		  height: 300,
		  toolbar: [
			['style', ['style']],
			['font', ['bold', 'underline', 'clear']],
			['color', ['color']],
			['para', ['ul', 'ol', 'paragraph']],
			['table', ['table']],
			['insert', ['link']],
		  ]
		});
	  </script>
</body>
</html>