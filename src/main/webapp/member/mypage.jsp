<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style>
p {
	margin: 20px 0px;
}
</style>
</head>
<body>
	<form action="update.member" method="post">
		<table align=center>
			<tr>
				<th colspan=2 class="head">MyPage
			</tr>
			<tr>
				<th>ID
				<td>${dto.id }
			</tr>
			<tr>
				<th>NAME
				<td>${dto.name }
			</tr>
			<th>PHONE
			<td><input type=text value="${dto.phone }" class="editable"
				name=phone disabled>
			</tr>
			<tr>
				<th>EMAIL
				<td><input type=text value="${dto.email }" class="editable"
					name=email disabled>
			</tr>
			<tr>
				<th>NICKNAME
				<td><input type=text value="${dto.nickname }" class="editable"
					name=zipcode disabled>
			</tr>
			<tr>
				<th>JOIN_DATE
				<td>${dto.joindate }
			</tr>

			<tr>
				<td colspan=2 align=center>
					<button id="pw_modify" type="button">비밀번호 수정</button>
			</tr>
			<tr>
				<td colspan=2 align=center id="btns">
					<button id="modify" type="button">수정하기</button>
			</tr>
			<tr>
				<td colspan=2 align=center>
					<button id="out" type="button">탈퇴하기</button>
			</tr>
		</table>
	</form>
</body>

</html>