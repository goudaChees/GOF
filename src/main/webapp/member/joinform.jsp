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
                <div class="col-9" id="pw1CheckResult"></div>
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
                    <input type="text" id="phone1" name="phone1">-
                    <input type="text" id="phone2" name="phone3">-
                    <input type="text" id="phone3" name="phone3">
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
                <div class="col-9" id="nnCheckResult"></div>
            </div>
            
            <div class="row">
                <div class="col-12" style="text-align: center;">
                    <input type="submit" value="회원가입" id="join" disabled>
                    <input type="reset" value="다시 입력">
                </div>
            </div>

        </div>
    </form>

    <script>
        let isIdOk = false;
        let isPwOk = false;
        let isPw2Ok = false;
        let isNameOk = false;
        let isPhoneOk = false;
        let isEmailOk = false;
        let isNNOk = false;
        
		$("#id").on("keyup",function(){ // 아이디 입력 검증
			let id = $("#id").val();
			if(id==""){
				$("#id").css("border","1px solid red");
				$("#idCheckResult").css("color","red");
				$("#idCheckResult").text("ID는 필수 입력 정보입니다.")
				isIdOk = false;
				return false;
			}
            let idRegex = /[a-z0-9_]{5,11}/;
            let idResult = idRegex.test(id);
            if (!idResult) {
            	$("#id").css("border","1px solid red");
            	$("#idCheckResult").css("color","red");
				$("#idCheckResult").text("영문 소문자, 숫자, 특수기호(_)를 조합하여 5~11자로 작성");
				isIdOk = false;
				return false;
            }else{
            	$.ajax({
    				url:"/idDuplCheck.member",
    				data:{id:$("#id").val()}
    			}).done(function(resp){
    				let result = JSON.parse(resp)
    				if(result){
    					$("#id").css("border","1px solid red");
    					$("#idCheckResult").css("color","red");
    					$("#idCheckResult").text("이미 존재하는 아이디입니다.")
    					isIdOk = false;
    					return false;
    				}else{
    					$("#id").css("border","1px solid blue");
    					$("#idCheckResult").css("color","blue");
    					$("#idCheckResult").text("사용가능한 아이디입니다.")
    					isIdOk=true;
    					console.log(isIdOk);
    				}
    			})
            }
		})
		
		$("#pw1").on("keyup",function(){ // 비밀번호 입력 검증
			let pw = $("#pw1").val();
			if(pw==""){
				$("#pw1").css("border","1px solid red");
				$("#pw1CheckResult").css("color","red");
				$("#pw1CheckResult").text("비밀번호는 필수 입력 정보입니다.")
				isPwOk=false;
				return false;
			}
			let pwRegex = /[a-zA-Z0-9]{8,12}/gm; // 비밀번호 기본 검증
            let pwResult = pwRegex.test(pw);
            if (!pwResult) {
            	$("#pw1").css("border","1px solid red");
            	$("#pw1CheckResult").css("color","red");
				$("#pw1CheckResult").text("영문 소문자, 대문자, 숫자를 조합하여 8~12자로 작성");
				isPwOk=false;
				return false;
            }else{
            	$("#pw1").css("border","1px solid blue");
				$("#pw1CheckResult").text("");
				isPwOk=true;
            }
		})
		
        $("#pw2").on("keyup", function () { // 비번2 일치 검증
            let pw1 = $("#pw1").val();
            let pw2 = $("#pw2").val();
            if(pw2==""){
				$("#pw2").css("border","1px solid red");
				$("#pw2CheckResult").css("color","red");
				$("#pw2CheckResult").text("비밀번호 입력을 확인해주세요.")
				isPw2Ok=false;
				return false;
			}
            if (pw2 == pw1) {
            	$("#pw2").css("border","1px solid blue");
                $("#pw2CheckResult").css("color", "blue");
                $("#pw2CheckResult").text("패스워드가 일치합니다.");
                isPw2Ok = true;
            }else {
            	$("#pw2").css("border","1px solid red");
                $("#pw2CheckResult").css("color", "red");
                $("#pw2CheckResult").text("패스워드가 일치하지 않습니다.");
                isPw2Ok = false;
                return false;
            }
        })
        
        $("#name").on("keyup",function(){ // 이름 검증
        	let nameRegex = /^[가-힣]{2,5}$/;
            let nameResult = nameRegex.test($("#name").val());
            if (!nameResult) {
            	$("#name").css("border","1px solid red");
            	$("#nameCheckResult").css("color", "red");
                $("#nameCheckResult").text("이름의 입력형식이 올바르지 않습니다.");
                isNameOk = false;
                return false;
            }else{
            	$("#name").css("border","1px solid blue");
            	$("#nameCheckResult").text("");
                isNameOk = true;
            }
        })
        
        $("#phone3").on("keyup",function(){ // 전화번호 검증
        	let phoneRegex1 = /01[0-9]{1}/;
        	let phoneRegex2 = /[0-9]{3,4}/;
        	let phoneRegex3 = /[0-9]{4}/;
        	
        	let phoneResult1 = phoneRegex1.test($("#phone1").val());
        	let phoneResult2 = phoneRegex2.test($("#phone2").val());
        	let phoneResult3 = phoneRegex3.test($("#phone3").val());
        	
        	if (!phoneResult1||!phoneResult2||!phoneResult3) {
            	$("#phone1").css("border","1px solid red");
            	$("#phone2").css("border","1px solid red");
            	$("#phone3").css("border","1px solid red");
            	$("#phoneCheckResult").css("color", "red");
                $("#phoneCheckResult").text("전화번호의 입력형식이 올바르지 않습니다.");
                isPhoneOk = false;
                return false;
            }else{
            	$("#phone1").css("border","1px solid blue");
            	$("#phone2").css("border","1px solid blue");
            	$("#phone3").css("border","1px solid blue");
            	$("#phoneCheckResult").text("");
            	isPhoneOk = true;
            }
        })
        
        $("#email").on("keyup",function(){ // 이메일 검증
        	let emailRegex = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
            let emailResult = emailRegex.test($("#email").val());
            if (!emailResult) {
            	$("#email").css("border","1px solid red");
            	$("#emailCheckResult").css("color", "red");
                $("#emailCheckResult").text("이메일의 입력형식이 올바르지 않습니다.");
                isEmailOk = false;
                return false;
            }else{
            	$("#email").css("border","1px solid blue");
            	$("#emailCheckResult").text("");
            	isEmailOk = true;
            }
        })
        
        $("#nickname").on("keyup",function(){ // 닉네임 검증
			let nickname = $("#nickname").val();
			if(nickname==""){
				$("#nickname").css("border","1px solid red");
				$("#nnCheckResult").css("color","red");
				$("#nnCheckResult").text("닉네임은 필수 입력 정보입니다.")
				isNNOk = false;
				return false;
			}
            let nnRegex = /[가-힣A-Za-z0-9_]{3,8}/;
            let nnResult = nnRegex.test(nickname);
            
            if (!nnResult) {
            	$("#nickname").css("border","1px solid red");
            	$("#nnCheckResult").css("color","red");
				$("#nnCheckResult").text("한글, 영문, 숫자, 특수기호(_)를 조합하여 3~8자로 작성");
				isNNOk = false;
				return false;
            }else{
            	$.ajax({
    				url:"/nnDuplCheck.member",
    				data:{nickname:$("#nickname").val()}
    			}).done(function(resp){
    				let result = JSON.parse(resp)
    				if(result){
    					$("#nickname").css("border","1px solid red");
    					$("#nnCheckResult").css("color","red");
    					$("#nnCheckResult").text("이미 존재하는 닉네임입니다.")
    					isNNOk = false;
    					return false;
    				}else{
    					$("#nickname").css("border","1px solid blue");
    					$("#nnCheckResult").css("color","blue");
    					$("#nnCheckResult").text("사용가능한 닉네임입니다.")
    					isNNOk=true;
    					
    					//모든 검증 통과 시 submit 버튼 활성화
    					if(isIdOk&&isPwOk&&isPw2Ok&&isNameOk&&isPhoneOk&&isEmailOk&&isNNOk){ 
    			        	$("#join").removeAttr("disabled");
    			        }
    				}
    			})
            }
		})
		
        
        
		
    </script>
</body>
</html>