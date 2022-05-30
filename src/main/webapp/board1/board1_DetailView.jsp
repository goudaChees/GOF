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
<link rel="stylesheet" href="/css/board1/board1_DetailView.css">
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

						<!-- 게시글--------------------------------------------------------------------------------------------- -->
						<div class="row w-100" id="writingContent">
							<div class="col-12" id="title">${dto.title }</div>
							<div class="col-12" id="writingInfo">${writer }<i class="bi bi-dot"></i>${dto.write_date }<i class="bi bi-dot"></i>조회 ${dto.view_count }</div>
							<div class="col-5">
								<div id="img_Box" class="thumbnail">
									<c:choose>
										<c:when test="${dto.fileName==null }">
											<img src="/img/pig2.png">
										</c:when>
										<c:otherwise>
											<img src="files/${dto.fileName }">
										</c:otherwise>
									</c:choose>
				            	</div>
							</div>
							<div class="col-7">
								<div class="row w-100 m-0" id="contents_Box">
									<div class="col-12" id="item">물건 : ${dto.item}</div>
									<div class="col-12" id="item_price"></div>
									<div class="col-12" id="contents">${dto.contents}</div>
								</div>
							</div>
							
							<div class="col-12" id="graph">
								<div class="row w-100 m-0">
									<div class="col-12" id="graphHeader">투표 현황</div>
									<div class="col-12" id="graphArea">
										<div style="width:${agreeRatio}%;height:13px" id="agreeRatio"></div>
										<div style="width:${disagreeRatio}%;height:13px" id="disagreeRatio"></div>
									</div>
									<div class="col-6" style="text-align:left">승인 : ${dto.agree_count }</div>
									<div class="col-6" style="text-align:right">불가 : ${dto.disagree_count }</div>
								</div>
							</div>
						</div>						
						<br>

						<!-- 	댓글------------------------------------------------------------------------- -->
						<!-- 댓글 작성--------------------------------------------------------------------------->
						
						<div class="row w-100 m-0" id="writeReply">
							<form action="/write.brd1_reply">
								<div class="col-12">
									<input type="hidden" name="parent_seq" value=${dto.seq }>
									<div id="radio">
										<input type="radio" value="승인" name="agree" checked> 승인
										<input type="radio" value="불가" name="agree"> 불가
									</div>
								</div>
									
								<div class="col-9 col-lg-10 m-0" id="left">
									<div id="writer">
										${nickname} <input type="hidden" name="nickname" value=${nickname }>
									</div>
									<div>
										<input type="text" placeholder="왜 그렇게 생각하나요?"
											name="contents" id="contents_reply" maxlength=300>
									</div>
								</div>
								<div class="col3 col-lg-2 m-0" id="right">
									<input type="submit" value="등록" id="reply">
								</div>
							</form>
						</div>
						<br>

						<!-- --댓글 View------------------------------------------------------------------------------ -->
						
							<div class="row w-100 m-0" id="replyList">
								<div class="col-12">
									<c:choose>
										<c:when test='${list[0]==null}'>
											작성된 댓글이 없습니다.
										</c:when>
										<c:otherwise>
											<c:forEach var="i" items="${list }">
												<form action="/modify.brd1_reply">
													<div class="row replyViewcontainer">
														<div class="col-2 reply_img_box">
															<div class="reply_thumbnail">
																<img src="/img/${i.agree}.png">
															</div>
															<div class="radio" style="display: none">
																<input type="radio" name="agree_re" value="승인" id="r1${i.seq }">승인<br>
																<input type="radio" name="agree_re" value="불가" id="r2${i.seq }">불가
															</div>
														</div>
														<div class="col-8">
															<div class="writer" id="r${i.seq }"> ${i.writer } </div>
															<input type="text" name="reply_contents"
																value='${i.contents }' readonly maxlength=300> 
															<input type="hidden" name="replySeqToUpdate" value=${i.seq }>
															<input type="hidden" name="parent_seq2" value=${dto.seq }>
															<div id="w${i.seq }" class="reply_time"></div>
														</div>
														<div class="col-2">
															<c:if test="${i.writer==nickname || id=='admin'}">
																<div class="reply_btns">
																	<input type="hidden" value=${i.contents }>
																	<input type="hidden" value=${i.seq }>
																	<input type="hidden" name="preAgree" value=${i.agree }>
																	<input type="button" value="수정" class="modify_btn">
																	<input type="button" value="삭제" class="delete_btn">
																</div>
															</c:if>
															<div class="thumbup">
																<svg class="good_path" xmlns="http://www.w3.org/2000/svg"
																	width="16" height="16" fill="currentColor"
																	class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
							  										<path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
																</svg>
																<div style="display: inline-block;" id="${i.seq}">${i.good }</div>
															</div>
															<div class="thumbup" style="display: none">
																<svg class="goodcencel_path" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
																	fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
							  										<path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z" />
																</svg>
																<div style="display: inline-block;"
																	id="c${i.seq}">${i.good }</div>
															</div>
														</div>
													</div>
												</form>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						
						<br>

						<!-- 게시글 목록, 수정, 삭제 버튼---------------------------------------------------------- -->
						<div class="row w-100 m-0" id="writingFooter">
							<div class="col-12">
								<input type="button" id="toList" value="목록으로">
								<c:if test="${nickname==dto.writer || id=='admin'}">
									<input type="button" id="modify" value="수정하기">
									<input type="button" id="delete" value="삭제하기">
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row w-100 m-0" id="footer" style="background-color:#A2BAAC; font-weight:bold">
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
						<span>E-MAIL : 4989 - 4284 </span><br> 
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
						<span class="footerLetter">대 표 전 화 : 4989 - 4284</span><span style="margin-left:20px" class="footerLetter">|</span><span style="margin-left:20px" class="footerLetter">E-MAIL : 4989 - 4284 </span><br>
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
	<!--  게시글 script-------------------------------------------------------------------- -->
		window.onload = function(){	
			console.log(${glist});
			if(${nickname==null}){
				alert("로그인 후 이용 가능합니다.")
				location.href="/index.jsp"
			}
//          0. 날짜 변환(오늘날짜는 시간, 전날은 연,월,일 표시)
			let today=new Date();//오늘날짜
			
			toYear = today.getFullYear();
			toMonth = today.getMonth()+1;
			toDate = today.getDate()
			
			
			if(${glist}[0]!=null){
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
					}else{
						
						let twoYear = year.toString().substring(2,4);
						
						write_date = twoYear +"."+month +"."+date;
						$("#w"+seq).text(write_date);					
					}
				}	
				
			}
			
			
			
			// 작성 금액 형식 #,###원으로 변환
			let money=${dto.item_price}
			let moneyForm = "총 금액 : "+money.toLocaleString() +"원"  
			$("#item_price").text(moneyForm)
			
			
			// 로드시 좋아요 한 댓글 검정색 처리	
			if(${nickname==null}){
				location.href="/index.jsp"
			}
			$.ajax({
				url:"/isGoodChecked.brd1",
				data:{
					board1_Seq:${dto.seq}
				},
				dataType:"json"
			}).done(function(res){
				$(res).each(function(){
					$("#c"+this.reply_Seq).parent().css("display","block");
					$("#"+this.reply_Seq).parent().css("display","none");
				})
			})
			
			// 		로드 시 해당 ID가 댓글을 쓴 적이 있으면 댓글 막음
			
			if(${didIDwrite}){
				$("#contents_reply").attr("readonly",true);
				$("#contents_reply").attr("placeholder","댓글은 한 게시물 당 한 개만 작성이 가능합니다.");
			}
			
			// 베스트 댓글 
			if(${glist}[0]!=null){
				if(${glist}[0].good>0){
					let best = $("<img>");
					best.attr("src","/img/thumbup2.png");
					best.css("width","30px");
					$("#r"+${glist}[0].seq).prepend(best)
				}
			}
		}
		 
		
		$("#toList").on("click",function(){
			location.href="/list.brd1?cpage=1";
		})
		$("#modify").on("click",function(){//수정하기
			if(${nickname==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp"
			}
			location.href="/toModifyForm.brd1?seq=${dto.seq}";
		})
		$("#delete").on("click",function(){
			if(${nickname==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp"
			}
			let result = confirm("정말 삭제하시겠습니까?")
			if(result){
				location.href="/delete.brd1?seq=${dto.seq}";
			}
		})
		
		
	<!-- 댓글 script-------------------------------------------------------------------- -->

//		댓글 작성	
		$("#reply").on("click",function(){	
			if(${nickname==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp"
			}
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
			if(${nickname==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp"
			}
			$(this).css('display','none');//수정 버튼 none처리
			$(this).next().css('display','none');//삭제 버튼 none처리
			$(this).parent().parent().prev().children().eq(1).attr('readonly',false);
			//댓글창 text창 활성화
			//disable은 parameter로 안 넘어가서 readonly 이용 
			let agreeRadio = $(this).parent().parent().prev().prev().children().eq(1);
			agreeRadio.css('display','inline-block');
			//라디오 선택 부분 활성화
			let rseq = $(this).prev().prev().val();
			console.log(rseq);
			console.log($(this).prev().val());
 			if($(this).prev().val()=='승인'){//원래의 선택 값 부분에 dafault로 선택 처리
 				agreeRadio.children()[0].checked=true;
//  				$("#r1"+rseq).attr("checked",true);
			}else if($(this).prev().val()=='불가'){
 				agreeRadio.children()[2].checked=true;
// 				$("#r2"+rseq).attr("checked",true);
			}
			
			//수정 버튼 클릭 시 수정 버튼 대신 완료버튼으로 치환
			let ok = $("<button>");
			ok.text("완료");
			ok.attr("class","complete_btn");
			ok.attr("type","submit");
			$(this).parent().prepend(ok);
			
			//수정 버튼 클릭 시 삭제 버튼 대신 취소버튼으로 치환
			let cancel = $("<button>");
			cancel.text("취소");
			cancel.attr({"class":"cancel_btn","type":"button"});
			
			cancel.on("click",function(){

				location.reload();
			})
			$(this).parent().append(cancel);
			
			agreeRadio.children().change(function() {//radio 선택 변경 때마다 해당 이미지 변경
			    if (agreeRadio.children()[0].checked) {
			    	agreeRadio.children().parent().prev().children().attr("src","/img/승인.png")
			    }else if(agreeRadio.children()[2].checked) {
 			    	agreeRadio.children().parent().prev().children().attr("src","/img/불가.png")
			    }
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
			if(${nickname==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp"
			}
			
			result = confirm("댓글을 정말로 삭제하시겠습니까?")
			if(result){
				let seq = $(this).parent().parent().prev().children().eq(2).val();
				let board_Seq = $(this).parent().parent().prev().children().eq(3).val(); 
				location.href="/delete.brd1_reply?seq="+seq+"&board_Seq="+board_Seq;	
			}

		})
//			5. 댓글 좋아요 기능		
		$(".good_path").on("click",function(){	
			if(${nickname==null}){
				alert("로그인 후 이용가능합니다.");
				location.href="/index.jsp"
			}
			$.ajax({
				url:"/good.brd1_reply",
				data:{
					board1_Seq : $(this).parent().parent().prev().children().eq(3).val(),
					reply1_Seq : $(this).parent().parent().prev().children().eq(2).val()
				},
				dataType:"json"
			}).done(function(resp){
				let id = resp.seq;
				$('#'+id).parent().css("display","none");
				$('#'+id).parent().next().css('display','block');
				$('#c'+id).text(resp.good);
			})
		})
//			6. 댓글 좋아요 취소 기능

			$(".goodcencel_path").on("click",function(){
				if(${nickname==null}){
					alert("로그인 후 이용가능합니다.");
					location.href="/index.jsp"
				}		
			$.ajax({
				url:"/cancelGood.brd1_reply",
				data:{
					board1_Seq : $(this).parent().parent().prev().children().eq(3).val(),
					reply1_Seq : $(this).parent().parent().prev().children().eq(2).val()
				},
				dataType:"json"
			}).done(function(resp){
				let id = resp.seq;
				$('#'+id).text(resp.good);
				$('#c'+id).parent().css("display","none");
				$('#c'+id).parent().prev().css("display","block");
			})
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