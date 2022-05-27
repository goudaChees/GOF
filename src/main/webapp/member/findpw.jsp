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
}
</style>
</head>
<body>
       <input type="text" id="id" placeholder="아이디를 적어주세요"><br>
       <span id="idok" style="display: none">아이디 확인중</span><br>
       <input type="text" id="email" placeholder="이메일을 적어주세요"><br>
       <span id="ismeailok" style="display: none">이메일 확인중</span><br>
       <button id="btn" disabled>메일 발송</button><br>
       <span id="mailok" style="display: none">메일 발송 완료</span><br>
       <input type="text" id="isok" placeholder="인증번호 입력해주세요"><br>
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
            	   $("#id").css("border", "1px solid blue");
        		   $("#idok").css("color", "blue");
            	   $("#idok").css("display","inline");
        			$("#idok").text(
        					"등록되어 있는 아이디 입니다.");
        			idok = true;
               }
               if(!resp){
            	   $("#id").css("border", "1px solid red");
            	   $("#idok").css("color", "red");
            	   $("#idok").css("display","inline");
        			$("#idok").text(
        					"등록되어 있지 않은 아이디 입니다.");
        			idok = false;
               }
    	   })
    	},
    	focusout : function(){
 		   if(idok && emailok){
     		   $("#btn").removeAttr("disabled");
     	   }
     	   if(!(idok) || !(emailok)){
     		   $("#btn").attr("disabled","true");
     	   }
 	   }
        
       })
       
       $("#email").on({
    		   keyup : function(){
    	   $.ajax({
    		   url:"/emailok.member",
    		   dataType:"json",
    		   data:{email:$("#email").val()
    			   }
    	   }).always(function(resp){
    		   if(resp){
            	   $("#email").css("border", "1px solid blue");
        		   $("#ismeailok").css("color", "blue");
            	   $("#ismeailok").css("display","inline");
        			$("#ismeailok").text(
        					"등록되어 있는 이메일 입니다.");
        			emailok = true;
               }
               if(!resp){
            	   $("#email").css("border", "1px solid red");
            	   $("#ismeailok").css("color", "red");
            	   $("#ismeailok").css("display","inline");
        			$("#ismeailok").text(
        					"등록되어 있지 않은 이메일 입니다.");
        			emailok = false;
               }
    	   })
    	   },
    	   focusout : function(){
    		   if(idok && emailok){
        		   $("#btn").removeAttr("disabled");
        	   }
        	   if(!(idok) || !(emailok)){
        		   $("#btn").attr("disabled","true");
        	   }
    	   }
       })
       	$("#btn").on("click",function(){
       		$("#btn").text("매일 발송중");
       		$.ajax({
       			url:"/findpw.mail",
				dataType:"json",
				data:{email:$("#email").val()
					}
       		}).always(function(resp){
       			$("#ck").val(resp);
       			$("#btn").text("메일 재발송");
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
       			}else if(!($("#ck").val()==$("#isok").val())){
       				$("#okok").val("인증번호를 확인해주세요.");
       			}
       		})
       		
       	})
       let isPwOk = true;
       $("#newpw").on("keyup",function(){
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
    	   
       })
       $("#newpwck").on("keyup",function(){
    	   let isPwOk2 = false;
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
           if($("#newpw").val()==$("#newpwck").val()){
        	   $("#btn2").removeAttr("disabled");
           }else if(!($("#newpw").val()==$("#newpwck").val())){
        	   $("#btn2").attr("disabled","true");
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
       		}).always(function(resp){
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