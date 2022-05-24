<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/css/board2/board2_List.css">

</head>
<body>
	<div class="container w-100">
		<div class="row" id=header>
			<div class="col-12">
				<nav class="navbar navbar-expand-lg navbar-light bg-light">

					<div class="container-fluid">
						<a class="navbar-brand" href="index.jsp" style="color: #664E55">앞날의
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
									aria-current="page" href="csmain.cscenter"
									style="color: #664E55">고객센터</a></li>

								<c:choose>
									<c:when test="${loginID =='admin'}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#" style="color: #664E55"
											style="color:#664E55">관리자페이지</a></li>
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
			<div class="d-none d-lg-block col-2"></div>
			<div class="col-12 col-lg-8">    
				<div class="row w-100 m-0" id="PageOutline">
					<div class="col-12">
						<div class="row w-100 m-0" id="board2_title">
							<div><br></div>
							<div class="col-12"><b>선택의 참견</b></div>
							<div class="col-12">최저가를 찾는 자린고비들의 지침</div>	
						</div>
						<div class="row"><br></div>
						<div class="row" id="board2_search">
							<form action="serch.brd2" method="post" align=right>
								<div class="row">
									<div class="col-12">
										<select class="from-select: aria-label=select" id="select1"
											name="category">
											<option class="select" value="title">제목</option>
											<option class="select" value="writer">작성자</option>
											<option class="select" value="contents">내용</option>
										</select>
									
										<input type="search" id="search" name="serch">
										<button type="submit" id="submit">검색</button>
									</div>
								</div>
							</form>
						</div>
						<div class="row"><br></div>
						<div class="row" align=center>
							<div class="col-1"></div>
							<div class="col-10">
								<div class="row">
									<div class="col-2">글번호</div>
									<div class="col-4">제목</div>
									<div class="col-2">작성자</div>
									<div class="col-2">조회수</div>
									<div class="col-2">제한시간</div>
									
								</div>
								<c:forEach var="i" items="${dto}">
									<div class="row">
										<div class="col-2">${i.seq}</div>
										<div class="col-4 title">
											<a href="/read.brd2?seq=${i.seq}">${i.title}</a>
											<c:if test="${i.reply!=0}">[${i.reply}]</c:if>
										</div>
										<div class="col-2 nickname">${i.nickname}</div>
										<div class="col time" id="${i.write_date}"  style="display:none">${i.write_date}</div>
										<div class="col-2">${i.view_count}</div>
										<div class="col-2 limit" id="${i.seq}"></div>
									</div>
								</c:forEach>
								<div class="row">
									<div class="col-1"></div>
									<div class="col-10">list</div>
									<div class="col-1"></div>
								</div>
							</div>
							<div class="col-1"></div>
						</div>
						<div class="row">
							<div class="col-2"></div>
							<div class="col-8">${navi}</div>
							<div class="col-2">
								<a href="/index.jsp"><button id="tomain">main으로</button></a> <a
									href="/write.brd2"><button id="write">작성하기</button></a>
							</div>
						</div>
						
					</div>
				</div>
			</div>

		</div>
		<div class="row" id="footer">
			<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
		</div>


	</div>
	<script>
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
			}
			timer = setInterval(showRemaining, 1000);
		}

		for (let i = 0; i < $(".title").length; i++) {
			let id = $(document.querySelectorAll(".limit")[i]).attr('id');
			let time = $(document.querySelectorAll(".time")[i]).attr('id');
			let dateObj = new Date(time);
			dateObj.setMinutes(dateObj.getMinutes() + 10);
			countDownTimer(id, dateObj);
		}
		// 내일까지 countDownTimer('sample02', '04/01/2024 00:00 AM'); 
		// 2024년 4월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용한다. 
		// 		countDownTimer('sample03', '04/01/2024');
		// 2024년 4월 1일까지 countDownTimer('sample04', '04/01/2019');
		// 2024년 4월 1일까지
	</script>

</body>
</html>