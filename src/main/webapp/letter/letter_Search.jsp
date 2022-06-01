<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/css/common.css">
<style>
body {
	width: 500px;
	height: 350px;
	margin-top: 30px;
	background-color: #E4E0E690;
	text-align:center;
}

#searchBtn{
	font-weight:bold;
	background-color:transparent;
	border:2px solid #C5B8CD;
	border-radius:5px;
	line-height:30px;
	width:50px;
}

#searchBtn:hover{
	background-color:#C5B8CD80;
	cursor:focus;
}

#receiver{
	color: #806c71;
	background-color:white;
	border:2px solid #FFC4A970;
	border-radius:5px;
	width:40%;
}

#nicknameList .row{
	margin-left:2%;
	margin-right:2%;
	border-bottom:1.5px solid #C5B8CD;
	line-height:35px;
}

.header{
	background-color:#C5B8CD;
	font-size: 16px;
	color:white;
	font-weight:bold;
	line-height:30px;
	border-bottom:0px solid transparent;
}

.chooseNN{
	background-color:#F193A180;
	color:white;
	border:0;
	border-radius:5px;
	line-height:27px;
	width:50px;
}

.chooseNN:hover{
	background-color:#F193A1;
}
</style>
</head>

<body>
  <b><font size="3" color="gray">메세지를 보낼 사람의 닉네임을 검색하세요.</font></b>
  <br><br>
  <input type="text"  id="receiver">
  <input type="button" value="검색" id="searchBtn">
  <br>
  <br>
  <input type="hidden" id="target" value="관리자">
  <div class='container' id="nicknameList"></div>
<script>
	function setParentText(){
		opener.document.getElementById("receiver").value = document.getElementById("target").value; 
	}
	
	$("#nicknameList").on("click",".chooseNN",function(){
		
		$("#target").val($(this).val());
		setParentText();
		window.close();
	})
	
	$("#receiver").on("keyup",function(key){         
		if(key.keyCode==13) {             
			$("#searchBtn").click();    
		}     
	});
	
	$("#searchBtn").on("click",function(){
		$("#nicknameList").text("");
		$.ajax({
			url:"/searchNN.letter",
			data :{target : $("#receiver").val()},
			dataType:"json"
		}).done(function(resp){
			let list = resp;
			if(list.length!=0){
				let headerRow = $("<div class=row>");
				let headerCol=$("<div class='col-12 header'>");
				headerCol.append("검색결과");
				headerRow.append(headerCol);
				$("#nicknameList").append(headerRow);
				
				for(let i=0;i<list.length;i++){
					let row = $("<div class=row>");
					
					let col1=$("<div class='col-9'>");
					col1.append(list[i])
					
					let col2=$("<div class='col-3'>");
					
					let btn=$("<button>");
					btn.attr("value",list[i]);
					btn.attr("class","chooseNN");
					btn.append("선택");
					col2.append(btn);					
					
					row.append(col1);
					row.append(col2);
					
					$("#nicknameList").append(row);
				}
			}else {
				let row = $("<div class=row>");
				
				let col1=$("<div class='col-12'>");
				col1.append("검색 결과가 존재하지 않습니다.")
				
				row.append(col1);
				
				$("#nicknameList").append(row);
			}
		})
	})
</script>
</body>
</html>