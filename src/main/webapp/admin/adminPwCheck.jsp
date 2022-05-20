<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN CHECK</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>

	<br>
	<b><font size="5" color="gray">관리자 확인이 필요합니다.</font></b>
	<br>
	<p>
		<br>비밀번호를 입력해주세요
	</p>
	<br>
	<input type="text" name="pw" id="pw">
	<br>
	<br>

	<input type="submit" value="확인" id="adminPwCheck">
	<input type="button" value="취소" onclick="window.close()">
	<script>
	// ADMIN Password 체크 페이지
		$("#adminPwCheck").on("click", function(){			
			$.ajax({
				type: "post",
				url: "/pwCheck.member",
				data: {nowpw: $("#pw").val()}
			}).done(function(resp){
				if(resp == "false"){
					alert("올바른 비밀번호를 입력해주십시오.");
					$("#pw").val("");
				}else {
					let result = confirm("확인 되었습니다.");
					if (result) {				
						window.close();	
					} else {

					}					
				}
				
			})
		})
		
		
	</script>
</body>
</html>