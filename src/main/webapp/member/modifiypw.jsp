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
	height: 350px;
	text-align: center;
}
</style>
</head>

<body>
	<br>
	<p>현재 비밀번호</p>
	<input type="password" name="nowpw" id="nowpw">
	<br>
	<p>새 비밀번호</p>
	<input type="password" name="newpw" id="newpw">
	<div id="pw1"></div>
	<br>
	<p>새 비밀번호 확인</p>
	<input type="password" name="newrepw" id="newrepw">
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
	
	let isPwOk = false;
	let isPw2Ok = false;

	$("#newpw").on("keyup", function() {
		let newpw = $("#newpw").val();
		let pwRegex = /^[a-zA-Z0-9]{8,12}$/gm;
		let pwResult = pwRegex.test(newpw);
		
		if(!pwResult){
			$("#pw1").text(
			"영문 소문자, 대문자, 숫자를 사용하여 8~12자로 작성");
			$("#newpw").css("border", "1px solid red");
			$("#newrepw").css("border", "1px solid red");
			$("#pw1").css("color", "red");
			isPwOk = false;
			isPw2Ok = false;
			$("#modify").attr("disabled","true");
			return false;
		} else {
			$("#pw1").text("");
			$("#newpw").css("border", "1px solid blue");
			let check = $("#newrepw").val();
			isPwOk = true;				
			
			if (check == newpw) {
				$("#newrepw").css("border", "1px solid blue");
				$("#pw2").css("color", "blue");
				$("#pw2").text("패스워드가 일치합니다.");
				isPwOk = true;

				//모든 검증 통과 시 submit 버튼 활성화
				if (isPwOk && isPw2Ok) {
					$("#modify").removeAttr("disabled");
				}
			} else {
				$("#newrepw").css("border", "1px solid red");
				$("#pw2").css("color", "red");
				$("#pw2").text("패스워드가 일치하지 않습니다.");
				isPw2Ok = false;
				
				$("#modify").attr("disabled","true");
				return false;
			}
			}
	
		})
		
		
		$("#newrepw").on("keyup",function() { // 비번2 일치 검증
						let newpw = $("#newpw").val();
						let check = $("#newrepw").val();
							if (check == "") {
								$("#newrepw").css("border", "1px solid red");
								$("#pw2").css("color", "red");
								$("#pw2").text("비밀번호 입력을 확인해주세요.");
								isPw2Ok = false;
								
								$("#modify").attr("disabled","true");
								return false;
							}
							if (check == newpw) {
								$("#newrepw").css("border", "1px solid blue");
								$("#pw2").css("color", "blue");
								$("#pw2").text("패스워드가 일치합니다.");
								isPw2Ok = true;			

								//모든 검증 통과 시 submit 버튼 활성화
								if (isPwOk && isPw2Ok) {
									$("#modify").removeAttr("disabled");
								}
							} else {
								$("#newrepw").css("border", "1px solid red");
								$("#pw2").css("color", "red");
								$("#pw2").text("패스워드가 일치하지 않습니다.");
								isPw2Ok = false;
									
								$("#modify").attr("disabled","true");
								return false;
							}

					})
	
</script>
</body>
</html>