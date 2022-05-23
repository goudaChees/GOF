<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>myPage</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/member/myReply.css">

</head>
<body>
	<div class="container">
		<div class="row w-100 m-0" id="header">
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
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#" style="color: #664E55">지출의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/list.brd2" style="color: #664E55">선택의
										참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/csmain.cscenter"
									style="color: #664E55">고객센터</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="/mypage.member"
									style="color: #664E55">마이페이지</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#"><i
										class="bi bi-box-arrow-right" style="color: #664E55"></i></a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>

		<div class="row w-100 m-0" id="content">
			<div class="d-none d-lg-block col-3"></div>
			<div class="col-12 col-lg-6">
				<div class="row w-100 m-0" id="MyPageOutline">
					<div class="col-12">
						<div class="row w-100 m-0" id="MyPageHeader">
							<div class="col-12">
								<p>My Page</p>
								<ul class="nav nav-tabs">
									<li class="nav-item"><a class="nav-link"
										href="/mypage.member">내 정보 보기</a></li>
									<li class="nav-item"><a class="nav-link"
										href="/myWriting.member?board=1&page=1">내 글 보기</a></li>
									<li class="nav-item"><a class="nav-link active"
										aria-current="page" href="/myReply.member?board=1&page=1">내
											댓글 보기</a></li>
								</ul>
							</div>
						</div>
						<div class="row w-100 m-0" id="myreply">
							<div class="col-12">
								<div class="row w-100 m-0">
									<div class="col-12" id="listbtns">
										<button id="toBoard1">지출의 참견</button>
										<button id="toBoard2">선택의 참견</button>
									</div>
								</div>
								<div class="row w-100 m-0" id="myreplylist">
									<div class="col-12 p-0">
										<div class="row w-100 m-0">
											<div class="col-12 col-lg-8">내용</div>
											<div class="d-none d-lg-block col-4">작성일자</div>
										</div>
										<c:forEach var='i' items="${replyList }">
											<div class="row w-100 m-0">
												<div class="col-8 p-0 d-none d-lg-block">${i.contents }</div>
												<div class="col-4 p-0 d-none d-lg-block">${i.formed_WriteDate }</div>
												<div class="col-12 p-0 d-block d-lg-none">${i.contents }</div>
												<div class="col-12 p-0 d-block d-lg-none">${i.formed_WriteDate }</div>
											</div>
										</c:forEach>
										<div class="row w-100 m-0">
											<div class="col-12">${pageList }</div>
										</div>
									</div>
								</div>
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
	<script>
		$("#toBoard1").on("click",function(){
			location.href="/myReply.member?board=1&page=1";
		})
		
		$("#toBoard2").on("click",function(){
			location.href="/myReply.member?board=2&page=1";
		})
		
		$(".bi-box-arrow-right").on("click",function(){
			  Swal.fire({
				  title: '로그아웃 하시겠습니까?',
				  showCancelButton: true,
				  confirmButtonText: '로그아웃',
				  cancelButtonText: '취소',
				}).then((result) => {
				  if (result.isConfirmed) {
				    location.href="/logout.member";
				  } 
				})
		  })
	</script>
</body>
</html>