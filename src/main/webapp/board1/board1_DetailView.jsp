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
<i class="bi bi-hand-thumbs-up"></i><!-- 좋아요 아이콘 -->

<style>
* {
	box-sizing: border-box;
}

div {
	border: 1px solid black;
	text-align: center;
	margin: 0px;
}

#graph>div,.replyViewcontainer>div {
	float: left;
}

.replyViewcontainer{
	display:block;
}

#agreeRatio {
	background-color: aqua;
}

#disagreeRatio {
	background-color: bisque;
}

.good_path:hover{
	cursor:pointer;
}
</style>
</head>
<body>
	<div class="container w-100"
		style="max-width: 100%; padding: 0; margin: 0; position: relative;">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<a class="navbar-brand" href="index.jsp">앞날의 지침</a>
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
							aria-current="page" href="#">선택의 참견</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">고객센터</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">회원가입</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<!-- 게시글--------------------------------------------------------------------------------------------- -->
	<div id="viewContainer" style="width: 70%; margin: auto;">
		<div id="board_vIew" class="row">
			<div id="title" class="col-10">${dto.title }</div>
			<div id="view_Count" class="col-2">${dto.view_count }</div>
			<div id="img_Box" class="col-5">
				<img src="files/${dto.fileName }" style="width: 100%; height: 100%;">
			</div>
			<div id="contents_Box" class="col-7">
				<div id="item">${dto.item}</div>
				<div id="contents">${dto.contents}</div>
			</div>
			<div id="item_price">전체 금액 : ${dto.item_price}</div>
			<div>
				<div id="graph" style="width: 70%; margin: auto;">
					<div style="width:${agreeRatio}%;height:10px" id="agreeRatio"></div>
					<div style="width:${disagreeRatio}%;height:10px" id="disagreeRatio"></div>
				</div>
				<form action="/write.brd1_reply">
					<input type="hidden" name="parent_seq" value=${dto.seq }>
					<div id="radio" style="margin-top: 10px;">
						<input type="radio" value="승인" name="agree" checked>승인 :
						${dto.agree_count } <input type="radio" value="불가" name="agree">불가
						: ${dto.disagree_count }
					</div>
			</div>
			<!-- 	댓글------------------------------------------------------------------------- -->
			<!-- 댓글 작성--------------------------------------------------------------------------->
			<div id="replyWriteContainer">
				<div id="reply_Write" class="row">
					<div id="right" style="border: 0px" class="col-9">
						<div style="border: 0px; text-align: left;" id="writer">
							${nickname} <input type="hidden" name="nickname"
								value=${nickname }>
						</div>
						<div style="border: 0px">
							<input type="text" placehold="왜 그렇게 생각하나요?" style="width: 100%;"
								name="contents" id="contents_reply">
						</div>
					</div>
					<div id="left" class="col-3" style="border: 0px">
						<input type="submit" value="reply" id="reply">
					</div>
				</div>
			</div>
				<hr>
				</form>
				<!-- --댓글 View------------------------------------------------------------------------------ -->
				<c:forEach var="i" items="${list }">
					<form action="/modify.brd1_reply">
						<div class="replyViewcontainer" class="row">
							<div class="col-2" style="border:0px">
								<div>
									<img src="/img/${i.agree}.png" style="width: 80%">
								</div>
								<div class="radio" style="margin-top: 10px; display: none">
									<input type="radio" name="agree_re" value="승인">승인 <input
										type="radio" name="agree_re" value="불가">불가
								</div>
							</div>
							<div class="col-8" style="border:0px">
								<div class="writer">작성자 : ${i.writer }</div>
								<input type="text" name="reply_contents" value='${i.contents }' readonly> 
								<input type="hidden" name="replySeqToUpdate" value=${i.seq }>
								<input type="hidden" name="parent_seq2" value=${dto.seq }>
								<div>${i.write_date }</div>
							</div>
							<div class="col-2" style="border:0px">
								<c:if test="${i.writer==nickname}">
									<div class="reply_btns">
										<input type="hidden" name="preAgree" value=${i.agree }>
										<input type="button" value="수정" class="modify_btn"> <input
											type="button" value="삭제" class="delete_btn">
									</div>
								</c:if>
								<div>
									<svg  class="good_path" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
  <path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"
/>
</svg><div style="display:inline-block; border:0px" id="${i.seq}" value="g")>${i.good }</div>
								</div>
								<div>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
  <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
</svg><div style="display:inline-block; border:0px" id="c${i.seq}">${i.good }</div>
								</div>
							</div>
						</div>
					</form>
				</c:forEach>
				<!-- 게시글 목록, 수정, 삭제 버튼---------------------------------------------------------- -->
			<div id="btns" style="text-align: right;">
				<input type="button" id="toList" value="목록으로">
				<c:if test="${nickname==dto.writer }">
					<input type="button" id="modify" value="수정하기">
					<input type="button" id="delete" value="삭제하기">
				</c:if>
			</div>
		</div>
	</div>
	<div class="row w-100 m-0" id="footer">
		<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
	</div>
	<div></div>

	<script>
	<!--  게시글 script-------------------------------------------------------------------- -->
		
// 		로드 시 해당 ID가 댓글을 쓴 적이 있으면 댓글 막음
		window.onload = function(){	
			$.ajax({
				url:"/isGoodChecked.brd1",
				data:{
					board1_Seq:${dto.seq}
				}
			})
			
			if(${didIDwrite}){
				$("#contents_reply").attr("readonly",true);
				$("#contents_reply").attr("placeholder","댓글은 한 게시물 당 한 개만 작성이 가능합니다.");
			}
		}
		
		
		$("#toList").on("click",function(){
			location.href="/list.brd1?cpage=1";
		})
		$("#modify").on("click",function(){//수정하기
			location.href="/toModifyForm.brd1?seq=${dto.seq}";
		})
		$("#delete").on("click",function(){
			let result = confirm("정말 삭제하시겠습니까?")
			if(result){
				location.href="/delete.brd1?seq=${dto.seq}";
			}
		})
	<!-- 댓글 script-------------------------------------------------------------------- -->

	
		$("#reply").on("click",function(){		
// 			1. 제출 시 radio 체크여부 확인
			if(!$('input:radio[name="agree"]').is(":checked")){
				alert("'승인','불가' 두가지 사항 중 선택해 주세요.");
				return false;
			}
// 			2. 댓글 공백 시 제출 불가
			if($("#contents_reply").val().trim()==''){
				alert("댓글 내용을 입력해주세요.");
				return false;
			}
		})
	
//			3. 댓글 수정 기능
		$(".modify_btn").on("click",function(){
			$(this).css('display','none');//수정 버튼 none처리
			$(this).parent().parent().prev().children().eq(1).attr('readonly',false);
			//댓글창 text창 활성화
			//disable은 parameter로 안 넘어가서 readonly 이용 
			let agreeRadio = $(this).parent().parent().prev().prev().children().eq(1);
			agreeRadio.css('display','inline-block');
			//라디오 선택 부분 활성화
			
			
			if($(this).prev().val()=='승인'){//원래의 선택 값 부분에 dafault로 선택 처리
				agreeRadio.children()[0].checked=true;
			}else if($(this).prev().val()=='불가'){
				agreeRadio.children()[1].checked=true;
			}
			
			//수정 버튼 클릭 시 수정 버튼 대신 완료버튼으로 치환
			let ok = $("<button>");
			ok.text("완료");
			ok.attr("class","complete_btn");
			ok.attr("type","submit");
			$(this).parent().prepend(ok);
			
			agreeRadio.children().change(function() {//radio 선택 변경 때마다 해당 이미지 변경
			    if (agreeRadio.children()[0].checked) {
			    	agreeRadio.children().parent().prev().children().attr("src","/img/승인.png")
			    	console.log(agreeRadio.children().val());
			    }else if(agreeRadio.children()[1].checked) {
 			    	agreeRadio.children().parent().prev().children().attr("src","/img/불가.png")
			    }
			    console.log(agreeRadio.children()[0].checked);
			});
			
			ok.on("click",function(){//댓글 공백 제한 처리
				if($(this).parent().parent().prev().children().eq(1).val().trim()==''){
					alert("댓글 내용을 입력해주세요.");
					return false;
				}
				
			})
		})
//			4. 댓글 삭제 기능
		$(".delete_btn").on("click",function(){
			let seq = $(this).parent().parent().prev().children().eq(2).val();
			let board_Seq = $(this).parent().parent().prev().children().eq(3).val(); 
			location.href="/delete.brd1_reply?seq="+seq+"&board_Seq="+board_Seq;
		})
//			5. 댓글 좋아요 기능		
		$(".good_path").on("click",function(){
						
			$.ajax({
				url:"/good.brd1_reply",
				data:{
					board1_Seq : $(this).parent().parent().prev().children().eq(3).val(),
					reply1_Seq : $(this).parent().parent().prev().children().eq(2).val()
				},
				dataType:"json"
			}).done(function(resp){
				let id = resp.seq;
				console.log(id);
				$('#'+id).text(resp.good);
			})
		})
		
	</script>
</body>
</html>