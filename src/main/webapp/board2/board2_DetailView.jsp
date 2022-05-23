<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
	integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
	integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
	crossorigin="anonymous"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<style>
* {
	border: 1px solid black;
	box-sizing: border-box;
	text-align: center;
}
</style>
</head>
<body>
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
									aria-current="page" href="/list.brd2">선택의 참견</a></li>
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="csmain.cscenter">고객센터</a></li>

								<c:choose>
									<c:when test="${loginID =='admin'}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="#">관리자페이지</a></li>
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="logout.member"><i
												class="bi bi-box-arrow-right"></i></a></li>
									</c:when>
									<c:when test="${loginID !=null}">
										<li class="nav-item"><a class="nav-link active"
											aria-current="page" href="mypage.member">마이페이지</a></li>
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
		<div class="row">
			<div class="col-10">${dto.title}</div>
			<div class="col-2">조회수 : ${dto.view_count}</div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row">
					<div style="display: none;" id="wtime">${dto.write_date}</div>
					<div class="col-12" id="limit"></div>
					<div class="col-12">${dto.contents}</div>
				</div>
				<div class="row">
					<div class="col-9"></div>
					<div class="col-3">
						<button type="button" id="listview">
						<a href="list.brd2" style="text-decoration:none">게시판으로 돌아가기</a>
						</button>
						<c:if test="${(dto.nickname == loginNN && cck== false)||(loginID = admin)}">
							<button type="button" id="modi">수정하기</button>
							<button type="button" id="del">삭제하기</button>
						</c:if>
					</div>
				</div>
				<div class="row" id="replywriter">
					<c:if test="${cck == false && wck == false}">
						<form action="/write.brd2_reply" method="post">
							<div class="row">
								<div class="col-12">
									<div class="row">
										<div class="col-3">
											<input type="text" id="writer" value="${loginNN}" style="display: none"> 
												<input type="text" placeholder="ex)1000" name="price" id="wprice" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" /> 
												<input type="text" name="pseq" value="${dto.seq}" style="display: none">
												<div id="wpriceno"></div>
										</div>
										<div class="col-6">
											<input type="text" placeholder="내용을 입력해주세요" name="contents" id="contents">
										</div>
										<div class="col-3">
											<button type="submit" id="btn1">작성</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</c:if>
					<!-- 				댓글 작성 한적이 없거나 선택되지 않았다면 뎃글 작성 가능 -->
				</div>
	<c:if test="${crdto != null}">
				<div class="row">
					<div class="col-2">${crdto.price}</div>
					<div class="col-8">
						<div class="row">
							<div class="col-6">${crdto.nickname}</div>
							<div class="col-6">${crdto.wirte_date}</div>
							<div class="col-12">${crdto.contents}</div>
						</div>
					</div>
					<div class="col-2">작성자의 선택 댓글</div>
				</div>
		</c:if>
				<div class="row">
					<div class="col-12">
						<c:forEach var="i" items="${rdto}">
							<div class="row">
								<div class="col-2 price">
								<input type="text" value="${i.price}" class="editable" disabled>
								</div>
								<div class="col-8 contents">
									<div class="row">
										<div class="col-6">${i.nickname}</div>
										<div class="col-6">${i.wirte_date}</div>
										<div class="col-12 incontents">
										<input type="text" value="${i.contents}" class="editable" disabled>
										</div>
									</div>
								</div>
								<div class="col-2">
									<c:if test="${loginNN == dto.nickname && cck == false}">
									선택<input type="radio" name="choice" value="${i.seq}"
											class="choice">
									</c:if>
									<c:if test="${(i.nickname == loginNN && cck== false)||(loginID = admin)}">
										<button class="modibtn">수정</button>
										<button class="delbtn" value="${i.seq}">삭제</button>
									</c:if>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
		</div>
	</div>


	<script>
	const end = function(text){
		if($("#limit").text()=='종료'){
		$("#replywriter").css("display","none");
		$("#wprice").css("display","none");
		$("#contents").css("display","none");
		$("#btn1").css("display","none");
		$("#modi").css("display","none");
		$(".choice").css("display","none");
		$(".modibtn").css("display","none");
		}
	};
 	setInterval(end, 1000);
	$("#del").on("click",function(){
		result = window.confirm("정말 삭제하시겟습니까?");
		if(result){
			location.href = "/del.brd2?seq="+${dto.seq}
		}
		//글 삭제
	})
	$("#modi").on("click",function(){
		result = window.confirm("정말 수정하시겟습니까?");
		if(result){
			location.href = "/modi.brd2?seq="+${dto.seq}
		}
		//글 수정
	})
	$(".delbtn").on("click",function(){
		reulst = window.confirm("정말 삭제하시겟습니까?");
		if(reulst){
		$.ajax({
			url:"/del.brd2_reply",
			dataType:"json",
			data:{rseq:$(this).val(),
				pseq:${dto.seq}}
		}).always(function(){
			location.reload();
		})
		}
	})
	//댓글 삭제
	$(".choice").on("click",function(){
		result = window.confirm("정말 선택하시겟습니까?");
		if(result){
			$.ajax({
				url:"/choice.brd2_reply",
				dataType:"json",
				data:{rseq:$(this).val()
				}
				}).always(function(){
					location.reload();
				})
			}
	})
	//댓글 선택
	$(".modibtn").on("click",function(){
		result = window.confirm("수정 하시겟습니까?");
		if(result){
			$(this).parent().siblings(".price").children().removeAttr("disabled");
			$(this).parent().siblings(".contents").children().children(".incontents").children().removeAttr("disabled");
			$(this).css("display","none");
			$(this).siblings().css("display","none");
			$(".choice").css("disply","none");
			let ok = $("<button>");
			ok.attr("type","button");
			ok.attr("class","modiok");
			ok.text("수정 완료");
			
			let cancel = $("<button>");
			cancel.text("취소");
			cancel.attr("type","button");
			cancel.on("click",function(){
				location.reload();
			});
			$(this).parent().append(ok);
			$(this).parent().append(cancel);
			$(".modiok").on("click",function(){
			$.ajax({
				url : "/modi.brd2_reply",
				dataType:"json",
				data:{
					rseq:$(this).siblings().val(),
					price:$(this).parent().siblings(".price").children()[0].value,
					contents:$(this).parent().siblings(".contents").children().children(".incontents").children()[0].value
				}
			}).always(function(){
				location.reload();
			})
			})
		}
	})
	//댓글 수정
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
					document.getElementById(id).textContent="종료";
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
	        let time = $("#wtime").text();
	        let dateObj = new Date(time);
	        dateObj.setMinutes(dateObj.getMinutes() +10);
			countDownTimer("limit", dateObj);
	        
	</script>
</body>
</html>