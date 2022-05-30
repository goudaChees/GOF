<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>find PassWord</title>
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
	width: 200px;
	text-align: center;
	margin-bottom: 5px;
}
button {
	border: 2px solid #9D8189;
	border-radius: 15px;
	color: white;
	background-color: #9D8189;
	margin-top: 20px;
	margin-bottom: 15px;
	cursor:pointer;
}

button:hover {
	background-color: #7F626A;
}

button:disabled{
	background-color: #C7B7BB;
	cursor:default;
}

input:focus {
	outline:none;
}

idok{
	margin-bottom: 10px;
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
		<h5>비밀번호 찾기</h5>
		<p><a href="https://accounts.kakao.com/weblogin/find_account_guide?continue=http://www.kakao.com/main#pageFindAccountSelect">카카오 간편 로그인 회원은 여기를 클릭해주세요</a></p>
       <input type="text" id="id" placeholder="아이디를 적어주세요"><br>
       <input type="text" id="email" placeholder="이메일을 적어주세요"><br>
       <span id="isidmeailok" style="display: none">아이디 이메일 확인중</span><br>
       <button id="btn" disabled>메일 발송</button><br>
       <span id="mailok" style="display: none">메일 발송 완료</span><br>
       <input type="text" id="isok" placeholder="인증번호를 입력해주세요" style="display: none"><br>
       <input type="text" id="ck" style="display: none" value="no"><br>
       <input type="text" id="okok" style="display: none" readonly="readonly" value="확인되었습니다."><br>
       <span id="writepw" style="display: none">비밀번호를 입력해주세요</span><br>
       <input type="password" id="newpw" style="display: none"><br>
       <span id="pwck" style="display:none">비밀번호 확인중</span><br>
       <input type="password" id="newpwck" style="display: none"><br>
       <span id="pwck2" style="display:none">비밀번호 확인중</span><br>
       <button id="btn2" style="display: none" disabled>비밀번호 적용</button>
       <script>
       let idok = false;
       let emailok = false;
       
       $("#id").on({
    		   keyup : function(){
    	   $.ajax({
    		   url:"/idisok.member",
    		   dataType:"json",
    		   data:{id:$("#id").val()
    			   }
    	   }).always(function(resp){
    		   if(resp){
        			idok = true;
               }
               if(!resp){
        			idok = false;
               }
    	   })
    	},
    	focusout : function(){
    		$.ajax({
		  		url:"/idandmailok.member",
		  		dataType:"json",
		  		data:{id:$("#id").val(),
		  			email:$("#email").val()}
		  	}).done(function(resp){
		  		if(resp){
		  			if(idok && emailok){
		        		   $("#btn").removeAttr("disabled");
		        		   $("#isidmeailok").css("display","none");
		        	   }
		        	   if(!(idok) || !(emailok)){
		        		   $("#btn").attr("disabled","true");
		        	   }		
		  		}else{
		  			$("#isidmeailok").css("display","inline");
		  			$("#isidmeailok").text("등록한 사용자의 아이디와 이메일이 다릅니다.");
		  			$("#btn").attr("disabled","true");
		  		}
		  	
		  	})
 	   } 
       })
       
       $("#email").on({
    		   keyup : function(){
    	   $.ajax({
    		   url:"/emailok.member",
    		   dataType:"json",
    		   data:{email:$("#email").val()
    			   }

    	   }).done(function(resp){
    		   if(resp){
        			emailok = true;
               }
               if(!resp){
        			emailok = false;
               }
    	   })
    	   },
    	   focusout : function(){
    		  	$.ajax({
    		  		url:"/idandmailok.member",
    		  		dataType:"json",
    		  		data:{id:$("#id").val(),
    		  			email:$("#email").val()}
    		  	}).done(function(resp){
    		  		if(resp){
    		  			if(idok && emailok){
    		        		   $("#btn").removeAttr("disabled");
    		        		   $("#isidmeailok").css("color","blue");
    		        		   $("#isidmeailok").text("등록된 아이디와 이메일입니다.");
    		        	   }
    		        	   if(!(idok) || !(emailok)){
    		        		   $("#btn").attr("disabled","true");
    		        	   }		
    		  		}else{
    		  			$("#isidmeailok").css("display","inline");
    		  			$("#isidmeailok").css("color","red");
    		  			$("#isidmeailok").text("등록한 아이디와 이메일이 다릅니다.");
    		  			$("#btn").attr("disabled","true");
    		  		}
    		  	
    		  	})
 
    	   }
       })
       let inok = false;
       	$("#btn").on("click",function(){

       		$("#btn").text("매일 발송중");
       		$("#btn").attr("disabled","true");

       		$("#isok").css("display","inline");
       		$.ajax({
       			url:"/findpw.mail",
				dataType:"json",
				data:{email:$("#email").val()
					}
       		}).done(function(resp){
       			$("#ck").val(resp);
       			$("#btn").text("메일 재발송");
       			$("#btn").removeAttr("disabled");
       			$("#mailok").css("display","inline");
       		})
       		$("#isok").on("keyup",function(){
       			if($("#ck").val()==$("#isok").val()){
       				$("#okok").css("display","inline");
           			$("#newpw").css("display","inline");
           			$("#newpwck").css("display","inline");
           			$("#btn2").css("display","inline");
           			$("#writepw").css("display","inline");
           			$("#okok").val("인증되었습니다.");
           			inok = true;
       			}else if(!($("#ck").val()==$("#isok").val())){
       				$("#okok").css("display","inline");
       				$("#okok").val("인증번호를 확인해주세요.");
       				inok = false;
       			}
       		})
       		
       	})
       let isPwOk = false;
       let isPwOk2 = false;
       $("#newpw").on({keyup:function(){
    	   let pw = $("#newpw").val();
           let pwRegex = /^[a-zA-Z0-9]{8,12}$/gm;
           let pwResult = pwRegex.test(pw);
           
    	   if (!pwResult) {
        	   $("#newpw").css("border", "1px solid red");
        	   $("#pwck").css("color", "red");
        	   $("#pwck").css("display","inline");
    			$("#pwck").text(
    					"영문 소문자, 대문자, 숫자를 사용하여 8~12자로 작성");
    			isPwOk = false;
           }
    	   if(pwResult){
    		   $("#newpw").css("border", "1px solid blue");
    		   $("#pwck").css("color", "blue");
        	   $("#pwck").css("display","inline");
    			$("#pwck").text(
    					"사용할수 있는 비밀번호 입니다.");
    		   isPwOk = true;
    	   }
       },
    	   focusout : function(){
    		   if($("#newpw").val()==$("#newpwck").val()){
        		   isPwOk2 = true;   
        	   }else{
        		   isPwOk2 = false;
        	   }
    		   if (!isPwOk2) {
            	   $("#newpwck").css("border", "1px solid red");
            	   $("#pwck2").css("color", "red");
            	   $("#pwck2").css("display","inline");
        			$("#pwck2").text(
        					"비밀번호가 다릅니다.");
               }
               if(isPwOk2){
        		   $("#newpwck").css("border", "1px solid blue");
        		   $("#pwck2").css("color", "blue");
            	   $("#pwck2").css("display","inline");
        			$("#pwck2").text(
        					"비밀번호가 같습니다.");
        	   }
               if(isPwOk2 && isPwOk && idok && emailok && inok){
    			   $("#btn2").removeAttr("disabled");
    		   }else if((!isPwOk2)||(!isPwOk)||(!idok)||(!emailok)||(!inok)){
    			   $("#btn2").attr("disabled","true");
    		   }
    	   }
       
       })
       $("#newpwck").on({keyup:function(){
    	   
    	   if($("#newpw").val()==$("#newpwck").val()){
    		   isPwOk2 = true;   
    	   }else{
    		   isPwOk2 = false;
    	   }
           if (!isPwOk2) {
        	   $("#newpwck").css("border", "1px solid red");
        	   $("#pwck2").css("color", "red");
        	   $("#pwck2").css("display","inline");
    			$("#pwck2").text(
    					"비밀번호가 다릅니다.");
           }
           if(isPwOk2){
    		   $("#newpwck").css("border", "1px solid blue");
    		   $("#pwck2").css("color", "blue");
        	   $("#pwck2").css("display","inline");
    			$("#pwck2").text(
    					"비밀번호가 같습니다.");
    	   }
       },
    	   focusout : function(){
    		   if(isPwOk2 && isPwOk && idok && emailok){
    			   $("#btn2").removeAttr("disabled");
    		   }else if((!isPwOk2)||(!isPwOk)||(!idok)||(!emailok)){
    			   $("#btn2").attr("disabled","true");
    		   }
    		   if($("#newpw").val()==$("#newpwck").val()){
        		   isPwOk2 = true;   
        	   }else{
        		   isPwOk2 = false;
        	   }
    	   }
       
       })
       
       	$("#btn2").on("click",function(){
       		if($("#newpw").val()==$("#newpwck").val()){
       		$.ajax({
       			url:"/findpw.member",
       			dataType:"json",
       			data:{id:$("#id").val(),
       				email:$("#email").val(),
       				newpw:$("#newpw").val()
       				}
       		}).done(function(resp){
       			if(resp==1){
       			alert("비밀번호가 변경되었습니다.");
       			window.close();
       			}else {
       				alert("비밀번호가 같은지 확인해주세요");
       			}
       		})
       		}
       	})
       </script>
</body>
</html>