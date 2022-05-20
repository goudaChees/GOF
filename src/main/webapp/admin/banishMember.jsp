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
		document.getElementById("cBanId").value = opener.document.getElementById("banId").value;
	}
	window.onload = function(){
		getParentText();
	}
</script>
</head>
<body>

	<br>
	<b><font size="5" color="gray">관리자 확인이 필요합니다.</font></b>
	<br>
	<p>
		<br><input type="text" id="cBanId" disabled>님을 추방하시려면 비밀번호를 입력해주세요
	</p>
	<br>
	<input type="text" name="pw" id="pw">
	<br>
	<br>

	<input type="submit" value="확인" id="banMember">
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