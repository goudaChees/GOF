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
                    <input type="text" id="id" name="id">
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
                    <input type="submit" value="회원가입" id="submitRg">
                    <input type="reset" value="다시 입력">
                </div>
            </div>

        </div>
    </form>

    <script>
        document.getElementById("search").onclick = function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    var roadAddr = data.roadAddress;
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("roadAddress").value = roadAddr;
                }
            }).open();
        }
		$("#checkId").on("click",function(){
			if($("#id").val()==""){
				alert("ID를 입력해주세요");
				return;
			}
			$.ajax({
				url:"/duplCheck.member",
				data:{id:$("#id").val()}
			}).done(function(resp){
				let div = $("<div>");
				let result = JSON.parse(resp)
				if(result){
					$("#duplCheckResult").css("color","red");
					$("#duplCheckResult").text("이미 존재하는 아이디입니다.")
				}else{
					$("#duplCheckResult").css("color","blue");
					$("#duplCheckResult").text("사용가능한 아이디입니다.")
				}
			})
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