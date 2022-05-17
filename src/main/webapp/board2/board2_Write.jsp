<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
* {
	text-align: center;
}
</style>
</head>
<body>
	<form action="write.brd2" method="get">
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
				title
			</div>
		</div>
		<div class="row">
			<div class="col-2">
				left
			</div>
			<div class="col-8">
				<div id="summernote"></div>
			</div>
			<div class="col-2">
				right
			</div>
		</div>
		<div class="row">
			<div class="col-8">
			</div>
			<div class="col-2">
				<button type="submit">작성하기</button>
			</div>
			<div class="col-2">
				<button type="button" id="bkack">취소하기</button>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				footer
			</div>
		</div>
	</div>
</form>
	<script>
		$('#summernote').summernote({
		  placeholder: 'Hello stand alone ui',
		  tabsize: 2,
		  height: 300,
		  toolbar: [
			['style', ['style']],
			['font', ['bold', 'underline', 'clear']],
			['color', ['color']],
			['para', ['ul', 'ol', 'paragraph']],
			['table', ['table']],
			['insert', ['link']],
			['view', ['fullscreen', 'codeview', 'help']]
		  ]
		});
	  </script>
</body>
</html>