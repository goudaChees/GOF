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
	margin-top: 30px;
	background-color: #FEDDE1;
	text-align:center;
}

#searchBtn{
	font-weight:bold;
	background-color:#FEDDE1;
	color:#F193A1;
	border:solid 1px #F193A1;
	border-radius:5px;
}

#searchBtn:hover{
	background-color:#F193A1;
	color:#FEDDE1;
	cursor:focus;
}

#receiver{
	color: #806c71;
	background-color:white;
	border:2px solid #FFC4A970;
	border-radius:5px;
	width:40%;
}
</style>
</head>

<body>
  <b><font size="3" color="gray">메세지를 보낼 사람의 닉네임을 검색하세요.</font></b>
  <br><br>
  <input type="text"  id="receiver">
  <input type="button" value="검색" id="searchBtn">
<script>

</script>
</body>
</html>