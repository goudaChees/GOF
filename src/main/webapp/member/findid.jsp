<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
body {
	width: 500px;
	height: 300px;
	text-align: center;
	padding-top: 50px;
	background-color: #FFF4EF;
}
input {
	border: 2px solid #9D8189;
	border-radius: 15px;
	width: 250px;
	text-align: center;
	margin-bottom: 10px;
}
button {
	border: 2px solid #9D8189;
	border-radius: 15px;
	color: white;
	background-color: #9D8189;
	margin-top: 20px;
	margin-bottom: 30px;
	cursor:pointer;
}

button:hover {
	background-color: #7F626A;
}


input:focus {
	outline:none;
}

a{
	text-decoration: none;
	color:#9D8189;
}
a:hover{
	font-weight: bold;
	color:#9D8189;
}

</style>
</head>
<body>
	<h5>아이디 찾기</h5>
	<p><a href="https://accounts.kakao.com/weblogin/find_account_guide?continue=http://www.kakao.com/main#pageFindAccountSelect">카카오 간편 로그인 회원은 여기를 클릭해주세요</a></p>
	이름 : <input type="text" id="name" placeholder="이름을 적어주세요"><br>
	이메일 : <input type="text" id="email" placeholder="가입하신 이메일을 적어주세요"><br>
	<button type="button" id="btn">아이디 찾기</button><br>
	<span style="display:none;" id="findid">찾으시는 ID : </span><input type="text" id="id" readonly="readonly" style="display: none;">
	<script>
		$("#btn").on("click",function(){
			if($("#name").val()==''){
				alert("아이디를 적어주세요")
				return
			}
			if($("#email").val()==''){
				alert("이메일을 적어주세요")
				return
			}
			
			$.ajax({
				url:"/findid.member",
				dataType:"json",
				data:{name:$("#name").val(),
					email:$("#email").val()
					}
			}).always(function(resp){
				if(resp==''){
					alert("올바르지 않거나 가입되어있지 않은 회원입니다.");
				}else{
					$("#id").css("display","inline");
					$("#findid").css("display","inline");
					$("#id").val(resp);	
				}
			})
			
		})
	</script>
</body>
</html>