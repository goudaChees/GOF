<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN CHECK</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	function getParentText(){
		document.getElementById("cBanId").value = opener.document.getElementById("userId").value;
	}
	window.onload = function(){
		getParentText();
	}
</script>

<style>
body {
	width: 500px;
	height: 350px;
	text-align: center;
	margin-top: 30px;
	background-color: #FFF4EF;
}
input {
	border: 2px solid #9D8189;
	border-radius: 15px;
	width: 250px;
	text-align: center;
	margin-bottom: 5px;
	height: 20px;
}

input[type=button], input[type=submit] {
	border: 2px solid #9D8189;
	border-radius: 15px;
	color: white;
	background-color: #9D8189;
	margin-top: 10px;
	margin-bottom: 5px;
	height: 30px;
}

input:focus {
	outline:none;
}

</style>
</head>
<body>

	<br>
	<b><font size="5" color="gray">관리자 확인이 필요합니다.</font></b>
	<br>
	<p>
		<br><input type="text" id="cBanId" disabled>님을 
		<br>추방하시려면 비밀번호를 입력해주세요
	</p>
	<br>
	<input type="text" name="pw" id="pw">
	<br>
	<br>

	<input type="button" value="확인" id="banMember">
	<input type="button" value="취소" onclick="window.close()">
	<script>
	// ADMIN Password 체크 페이지
		$("#banMember").on("click", function(){			
			$.ajax({
				type: "post",
				url: "/adminPwCheck.admin",
				data: {adminPw : $("#pw").val()}
			}).done(function(resp){
				if(resp == "false"){
					alert("올바른 비밀번호를 입력해주십시오.");
					$("#pw").val("");
				}else {
					//	해당 아이디값을 받아와 삭제 메서드 명령
					let result = confirm("확인 되었습니다.");
					if (result) {
						$.ajax ({
							type:"post",
							url:"/banMember.admin",
							data: {banId : $("#cBanId").val()}	
						}).done(function(resp){
							if(resp){
								window.close();
								opener.location.href="/adminmain.admin";
							}
						})
					}
				}			
			})
		})
		
		
	</script>
</body>
</html>