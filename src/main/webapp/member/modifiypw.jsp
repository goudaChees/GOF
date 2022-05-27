<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
body {
	width: 500px;
	height: 300px;
	text-align: center;
}
</style>
</head>

<body>
	
	<p>현재 비밀번호</p>
	<input type="text" name="nowpw" id="nowpw">
	<br>
	<p style="color:gray">영문 소문자, 대문자, 숫자를 조합하여 8~12자로 작성</p>
	<p>새 비밀번호</p>
	<input type="text" name="newpw" id="newpw">
	<div id="pw1"></div>
	<br>
	<p>새 비밀번호 확인</p>
	<input type="text" name="newrepw" id="newrepw" disabled>
	<br>
	<div id="pw2"></div>
	<br>
	<br>
	<input type="button" value="변경하기" id="modify" disabled>
	<input type="button" value="그만두기" onclick="window.close()">

	<script>
	$("#modify").on("click", function() {
		$.ajax({
			type:"POST",
			url: "/pwCheck.member",
			data: {nowpw:$("#nowpw").val()}
		}).done(function(resp){
			if(resp == "false"){
				alert("비밀번호가 올바르지 않습니다.");
				$("#nowpw").val("");
				$("#newpw").val("");
				$("#newrepw").val("");
				$("#pw1").text("");
				$("#pw2").text("");
				$("#nowpw").focus();
			} else {
				$.ajax({
					type:"POST",
					url: "/pwChange.member",
					data: {newpw:$("#newpw").val(), newrepw:$("#newrepw").val()}
				}).done(function(resp){
					alert("비밀번호 변경이 완료되었습니다.");
					window.close();
				})

			}
		})
	})
	
	$("#newpw").on("keyup", function() {
		let newpw = $("#newpw").val();
		let pwRegex = /^[a-zA-Z0-9]{8,12}$/gm;
		let pwResult = pwRegex.test(newpw);
		
		if(!pwResult){
			$("#newrepw").attr("disabled", true);
			$("#pw1").text("비밀번호 형식에 맞지 않습니다.");
			$("#pw1").css("color", "red");
		} else {
			$("#newrepw").removeAttr("disabled");
			$("#pw1").text("비밀번호 형식 일치.");
			$("#pw1").css("color", "blue");
			$("#newrepw").on("keyup", function() {
				let newpw = $("#newpw").val();
				let check = $("#newrepw").val();
				
				if (newpw == check) {
						$("#modify").removeAttr("disabled");
						$("#pw2").text("비밀번호가 일치합니다.");
						$("#pw2").css("color", "blue");
						
					} else {
						$("#pw2").text("비밀번호을 확인하세요");
						$("#pw2").css("color", "red");
					}
			})
		}
	})
	
</script>
</body>
</html>