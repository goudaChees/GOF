<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<style>
    *{
        box-sizing: border-box;
    }
    div{
         border:1px solid black; 
        text-align: center;
    }

</style>
</head>
<body>
	<form method="post" action="join.member">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    회원 가입 정보 입력
                </div>
            </div>

            <div class="row">
                <div class="col-3">아이디</div>
                <div class="col-9">
                    <input type="text" id="id" name="id" placeholder="영문,숫자 5~11자">
                </div>
                <div class="col-3"></div>
                <div class="col-9" id="idCheckResult"></div>
            </div>
            <div class="row">
                <div class="col-3">패스워드</div>
                <div class="col-9">
                    <input type="password" id="pw1" name="pw1">
                </div>
                <div class="col-3"></div>
                <div class="col-9" id="pwCheckResult"></div>
            </div>
            <div class="row">
                <div class="col-3">패스워드 확인</div>
                <div class="col-9">
                    <input type="password" id="pw2">
                </div>
                <div class="col-3"></div>
                <div class="col-9" id="pw2CheckResult"></div>
            </div>
            <div class="row">
                <div class="col-3">이름</div>
                <div class="col-9">
                    <input type="text" id="name" name="name">
                </div>
                <div class="col-3"></div>
                <div class="col-9" id="nameCheckResult"></div>
            </div>
            <div class="row">
                <div class="col-3">전화번호</div>
                <div class="col-9">
                    <input type="text" id="phone" name="phone">
                </div>
                <div class="col-3"></div>
                <div class="col-9" id="phoneCheckResult"></div>
            </div>
            <div class="row">
                <div class="col-3">이메일</div>
                <div class="col-9">
                    <input type="text" id="email" name="email">
                </div>
                <div class="col-3"></div>
                <div class="col-9" id="emailCheckResult"></div>
            </div>
            <div class="row">
                <div class="col-3">닉네임</div>
                <div class="col-9">
                    <input type="text" id="nickname" name="nickname">
                </div>
                <div class="col-3"></div>
                <div class="col-9" id="nicknameCheckResult"></div>
            </div>
            
            <div class="row">
                <div class="col-12" style="text-align: center;">
                    <input type="submit" value="회원가입" id="join">
                    <input type="reset" value="다시 입력">
                </div>
            </div>

        </div>
    </form>

    <script>
        let isIdOk = false;
        let isPwOk = false;
        
		$("#id").on("keyup",function(){ // 아이디 입력 검증
			let id = $("#id").val();
			if(id==""){
				$("#idCheckResult").css("color","red");
				$("#idCheckResult").text("ID는 필수 입력 정보입니다.")
			}
            let idRegex = /[a-z0-9_]{5,11}/;
            let idResult = idRegex.test(id);
            if (!idResult) {
            	$("#idCheckResult").css("color","red");
				$("#idCheckResult").text("영문 소문자, 숫자, 특수기호(_)를 조합하여 5~11자로 작성");
            }else{
            	$.ajax({
    				url:"/duplCheck.member",
    				data:{id:$("#id").val()}
    			}).done(function(resp){
    				let result = JSON.parse(resp)
    				if(result){
    					$("#idCheckResult").css("color","red");
    					$("#idCheckResult").text("이미 존재하는 아이디입니다.")
    				}else{
    					$("#idCheckResult").css("color","blue");
    					$("#idCheckResult").text("사용가능한 아이디입니다.")
    					isIdOk=true;
    				}
    			})
            }
		})
		
		$("#pw").on("keyup",function(){ // 비밀번호 입력 검증
			let pw = $("#pw").val();
			if(pw==""){
				$("#pwCheckResult").css("color","red");
				$("#pwCheckResult").text("패스워드는 필수 입력 정보입니다.")
			}
            let idRegex = /[a-z0-9_]{5,11}/;
            let idResult = idRegex.test(id);
            if (!idResult) {
            	$("#idCheckResult").css("color","red");
				$("#idCheckResult").text("영문 소문자, 숫자, 특수기호(_)를 조합하여 5~11자로 작성");
            }else{
            	$.ajax({
    				url:"/duplCheck.member",
    				data:{id:$("#id").val()}
    			}).done(function(resp){
    				let result = JSON.parse(resp)
    				if(result){
    					$("#idCheckResult").css("color","red");
    					$("#idCheckResult").text("이미 존재하는 아이디입니다.")
    				}else{
    					$("#idCheckResult").css("color","blue");
    					$("#idCheckResult").text("사용가능한 아이디입니다.")
    					isIdOk=true;
    				}
    			})
            }
		})
		
        $("#pw2").on("keyup", function () {
            let pw1 = $("#pw1").val();
            let pw2 = $("#pw2").val();
            if (pw2 == pw1) {
                $("#checkPw").css("color", "blue");
                $("#checkPw").text("패스워드가 일치합니다.");
                
            } else {
                $("#checkPw").css("color", "red");
                $("#checkPw").text("패스워드가 일치하지 않습니다.");
            }
        })

        $("#submitRg").on("click", function () {
            let id = $("#id").val();
            let idRegex = /^[a-z][a-z0-9_]{7,13}$/;
            let idResult = idRegex.test(id);
            if (!idResult) {
                alert("입력하신 아이디를 사용하실 수 없습니다.")
                $("#id").val("");
                $("#id").focus();
                return false;
            }

            let pw1 = $("#pw1").val();
            let pwRegex = /^[^ \n\t]{8,16}$/;
            let pwResult = pwRegex.test(pw1);
            if (!pwResult) {
                alert("입력하신 비밀번호를 사용하실 수 없습니다.")
                $("#pw1").val("");
                $("#pw2").val("");
                $("#pw1").focus();
                return false;
            }

            if($("#pw2").val()!=pw1){
                alert("비밀번호를 다시 입력해주세요.")
                $("#pw2").val("");
                $("#pw2").focus();
                return false;
            }

            let name = $("#name").val();
            let nameRegex = /^[가-힣]{2,5}$/;
            let nameResult = nameRegex.test(name);
            if (!nameResult) {
                alert("이름의 입력 형식을 다시 확인해주세요.")
                $("#name").val("");
                $("#name").focus();
                return false;
            }

            let phone = $("#phone").val();
            let phoneRegex = /^01[0-9]-?[0-9]{3,4}-?[0-9]{4}$/;
            let phoneResult = phoneRegex.test(phone);
            if (!phoneResult) {
                alert("전화번호의 입력 형식을 다시 확인해주세요.")
                $("#phone").val("");
                $("#phone").focus();
                return false;
            }

            let email = $("#email").val();
            let emailRegex = /^([^ \n\t])+@([^ \n\t]+\.[^ \n\t]{2,5})$/;
            let emailResult = emailRegex.test(email);
            if (!emailResult) {
                alert("이메일 주소의 입력 형식을 다시 확인해주세요.")
                $("#email").val("");
                $("#email").focus();
                return false;
            }
        })

    </script>
</body>
</html>