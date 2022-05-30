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
		document.getElementById("cUserId").value = opener.document.getElementById("userId").value;
	}
	window.onload = function(){
		getParentText();
	}	
	function setParentText(){
		opener.document.getElementById("adminTF").value = document.getElementById("cTF").value; 
	}

	function close_reload(){
		window.opener.location.reload();
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
<body onBeforeUnload="close_reload()">
	<br>
	<b><font size="5" color="gray">관리자 확인이 필요합니다.</font></b>
	<br>
	<p>
		<br><input type="text" id="cUserId" disabled>님의
		<br> 정보를 수정하려면 비밀번호를 입력해주세요
	</p>
	<br>
	<input type="password" name="pw" id="pw">
	<br>
	<br>
	<input type="hidden" value="" id ="cTF">
	<input type="button" value="확인" onclick="AdminPwSend()" id="submit">
	<input type="button" value="취소" onclick="window.opener.location.reload(); window.close()">

	<script>
	
// 	$("#AdminPwSend").on("click",function(){
// 		AdminPwSend();
// 	})
	
	function AdminPwSend(){
		let parent = window.opener;
		let message = $("#pw").val();
		$.ajax({
			type: "post",
			url: "/adminPwCheck.admin",
			data: {adminPw: $("#pw").val()}
		}).done(function(resp){
			if (resp == "false"){
				alert("올바른 비밀번호를 입력해 주십시오.");
				window.close();
			}else {
				let result = confirm("확인 되었습니다.");
				if (result) {
					$("#cTF").attr("value", " ");
					setParentText();
					let tf = parent.document.getElementById('adminTF');
					tf.removeAttribute("disabled");
					tf.focus();
					
					let cls = parent.document.getElementsByClassName('editable');
					for (let i = 0; i < cls.length; i++ ){
						cls[i].removeAttribute("disabled");
					}
					window.close();
				}else {
					
				}
			}
			
		})
	}
	
	$("#submit").on("click", function(event){
        window.onbeforeunload = null;
	});
	</script>
</body>
</html>