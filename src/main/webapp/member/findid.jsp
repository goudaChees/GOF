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
}
</style>
</head>
<body>
	이름 : <input type="text" id="name" placeholder="이름을 적어주세요"><br>
	이메일 :  <input type="text" id="email" placeholder="가입하신 이메일을 적어주세요"><br>
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
			$("#id").css("display","inline");
			$("#findid").css("display","inline");
			$.ajax({
				url:"/findid.member",
				dataType:"json",
				data:{name:$("#name").val(),
					email:$("#email").val()
					}
			}).always(function(resp){
				if(resp==''){
					alert("아이디,이메일을 확인해주세요");
				}else{
					$("#id").val(resp);	
				}
			})
			
		})
	</script>
</body>
</html>