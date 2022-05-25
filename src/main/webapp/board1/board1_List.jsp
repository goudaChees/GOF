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
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/board1/board1_List.css">

</head>
<body>
	<div class="container w-100">
		
		<div class="row w-100 m-0" id="header">
			<div class="col-12 p-0">
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
									aria-current="page" href="/list.brd1?cpage=1" style="color: #664E55">지출의 참견</a></li>
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
				<div class="row w-100 m-0" id="board1Outline">
					<div class="col-12">
						<div class="row w-100 m-0" id="board1Header">
							<div class="col-12">
								<p>지출의참견</p>
								<span>살까말까 답정너들을 위한 참견러들의 지침</span>
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
									<a href="/detail.brd1?seq=${i.seq}">
										<div class="row w-100 writing">
											<div class="col-3">
												<div class="thumbnail">
													<img src="files/${i.fileName }">
												</div>
											</div>
											<div class="col-9">
												<div class="row">
													<input type="hidden" value=${i.seq }>
													<div class="col-12 writingTitle">[ ${i.item} ] ${i.title} <p class="d-none d-sm-inline">${i.reply_count }</p></div>
													<div class="col-12 writingEtc">
														${i.writer} <i class="bi bi-dot"></i> ${i.write_date} <i class="bi bi-dot"></i> 조회 ${i.view_count}
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
		<div class="row w-100 m-0" id="footer">
			<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
		</div>
	</div>
	
	<script>
		$("#write").on("click",function(){
			location.href="/board1/board1_Write.jsp";
		})		
	</script>
</body>
</html>