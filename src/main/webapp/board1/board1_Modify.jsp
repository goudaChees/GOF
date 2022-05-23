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
<style>
    *{
        box-sizing: border-box;
    }
    div{
        border:1px solid black;
        text-align: center;
    }

.write_Box{
  float: left;
}

#file_Box>input{
float:left;
}

</style>

</head>
<body>
     <div class="container w-100" style="max-width:100%;padding: 0;margin: 0;position: relative;">
         <nav class="navbar navbar-expand-lg navbar-light bg-light">
             <div class="container-fluid">
               <a class="navbar-brand" href="index.jsp">앞날의 지침</a>
               <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                 <span class="navbar-toggler-icon"></span>
               </button>
               <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                 <ul class="navbar-nav">
                   <li class="nav-item">
                     <a class="nav-link active" aria-current="page" href="#">지출의 참견</a>
                   </li>
                   <li class="nav-item">
                     <a class="nav-link active" aria-current="page" href="#">선택의 참견</a>
                   </li>
                   <li class="nav-item">
                     <a class="nav-link active" aria-current="page" href="#">고객센터</a>
                   </li>
                   <li class="nav-item">
                     <a class="nav-link active" aria-current="page" href="#">회원가입</a>
                   </li>
                 </ul>
               </div>
             </div>
         </nav>
     </div>		        

	<form action="/modify.brd1" enctype="multipart/form-data" method="post">
		<div id=write_container style="text-align: left; width: 70%; margin: auto;">
			<span style="font-size: 30px;">지출의 참견</span>
	    	<span>구매가 고민되는 상품의 정보를 입력해주세요.</span><br>
        <div style="text-align:center">
          	<input type="text" placeholder="글 제목을 입력해주세요" name="title" id="title" size="70" value="${dto.title}"><br>
          	<input type="hidden" name="seq" size="70" value="${dto.seq}">
          	<div class="write_Box" style="width:50% ; border: 0px;">
          		<div id="img_Box">
            		<img src="files/${dto.fileName}" style="width: 200px; height: 200px;" id="img_section">
            		<input type="hidden" id="isImgDeleted" name="isImgDeleted" value="N">
            	</div>
            	<div id="file_Box">
            		<input type="button" value="삭제하기" id="delete">
            		<input type="file" name="file" id="upload_file" accept="image/*">
            	</div>
          	</div>
          	<div class="write_Box" style="width:50%; height: 200px; border: 0px;">
            	<input type="text" placeholder="물건명을 입력해주세요" name="item" id="item" value="${dto.item }"><br>
            	<input type="text" placeholder="가격을 입력해주세요" name="item_price" value="${dto.item_price }" id="item_price" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" /><br>
          	</div>
          	<textarea placeholder="이 물건을 꼭 사야할 이유가 뭔가요" name="contents" rows="10" cols="70">${dto.contents }</textarea><br>
          	<input type="button" value="목록으로" id="goToList">
          	<input type="submit" value="수정하기" id="submit">
        </div>    
		</div>
	    <div class="row w-100 m-0" id="footer">
	        <div class="col-12">Copyright by Phoenix since 2022 05 00</div>
	    </div>
	 </form>
	 <script>
	 	const reader = new FileReader();
	 	reader.onload = (readerEvent) =>{
	 		document.querySelector("#img_section").setAttribute("src",readerEvent.target.result);
	 		console.log(readerEvent.target.result);
	 	}

	     document.querySelector("#upload_file").addEventListener("change",(changeEvent) => {
	       const imgFile = changeEvent.target.files[0];
	       reader.readAsDataURL(imgFile);
	     })
	     
	     $("#delete").on("click",function(){
	    	 $("#img_section").attr("src","");//삭제 버튼 클릭 시 이미지 내림
	    	 $("#isImgDeleted").val("Y");//이미지 삭제 하는 경우
	     })
		
	  	$("#goToList").on("click",function(){
	    	 loaction.href="/list.brd1?cpage=1";
	     })
	     
		$("#submit").on("click",function(){
         let item_price = $("#item_price").val().trim();
         let title= $("#title").val().trim();
         let item = $("#item").val().trim();;
		
         if(title==''||item_price==''||item==''){
        	 alert("제목, 물건명, 가격은 필수 입력 사항입니다.");
        	 return false;
         }
       })
	 </script>
</body>
</html>