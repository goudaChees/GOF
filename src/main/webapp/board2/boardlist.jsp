<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
	integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
	integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
	crossorigin="anonymous"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
* {
	border: 1px solid black;
	box-sizing: border-box;
	text-align: center;
}
</style>
</head>
<body>
	<div id="container">
		<div class="row">
			<div class="col-12">
				<div class="row">
					<div class="col-1">
						logo
					</div>
					<div class="col-3">
					</div>
					<div class="col-2">
						지출의 참견
					</div>
					<div class="col-2">
						선택의 참견
					</div>
					<div class="col-2">
						고객센터
					</div>
					<div class="col-2">
						마이페이지
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				선택의 참견
			</div>
			<div class="col-12">
				최저가를 찾는 자린괴비들의 지침
			</div>
		</div>
		<div class="row">
			<div class="col-6">	
			</div>
			<div class="col-4">
				<input type="text" id="serch" name="serch">
			</div>
			<div class="col-2">
				<button type="submit" id="submit">검색</button>
			</div>
		</div>
		<div class="row">
			<div class="col-2">
				left
			</div>
			<div class="col-8">
				<div class="row">
					<div class="col-2">
						글번호
					</div>
					<div class="col-2">
						제목
					</div>
					<div class="col-2">
						작성자
					</div>
					<div class="col-2">
						제한시간
					</div>
					<div class="col-2">
						작성시간
					</div>
				</div>
				<div class="row">
					<div class="col-1"></div>
					<div class="col-10">list</div>
					<div class="col-1"></div>
				</div>
			</div>
			<div class="col-2">
				right
			</div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				< 1 2 3 4 5 6 7 8 9 10 >
			</div>
			<div class="col-2">
				<button type="button">메인으로</button>
				<button type="button">작성하기</button>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				footer
			</div>
		</div>
	</div>
</body>
</html>