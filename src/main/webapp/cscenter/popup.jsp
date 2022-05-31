<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객센터</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed298afa01dbe436406160c176a6dde2"></script> -->
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e3b2ec1cbf323959f82484d3c09baa42"></script> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/css/cscenter/csmain.css">
<link rel="stylesheet" href="/css/common.css">

<script language="JavaScript">

	function setCookie( name, value, expiredays ) {
		var date = new Date();
		date.setDate(date.getDate() + expiredays);
		document.cookie = escape(name) + "=" + escape(value) + "; expires=" + date.toUTCString();
		
	}
    function closePopup() {
        if (document.getElementById("check").value) {
            setCookie("popupYN", "N", 1);
            self.close();
        }
    }


</script>


</head>
<body>

<aside class="popup" id="popupWrap">
  <div class="inner" id="popup_1">
    <div class="area">
      <img src="/img/frontpig.png" alt="배너이미지1">
    </div>
    <input type="checkbox" id="check" onClick="closePopup();"><span>하루동안 보지않기</span>
    <button type="button" onClick="window.close();">[닫기]</button>
  </div>

  <div class="popupbg" style="background:gray;"></div>
</aside>





<script>
// $(document).ready(function () {
// 	  $('.popup').show();
// 	  cookiedata = document.cookie;
// 	  console.log(document.cookie);
// 	  if ( cookiedata.indexOf("popup_1=done") < 0 ){ //쿠키 변경 여부 불러오기
// 	  	document.all['popup_1'].style.visibility = "visible";
// 	  }
// 	  else {
// 	  	document.all['popup_1'].style.display = "none";
// 	  }
// 	  PopupBgDisplay();
// 	});

// 	function PopupNoDisplay_1() {
// 	  setCookie ("popup_1", "done", 1); //쿠키값 변경
// 	  PopupHide();
// 	  window.close();
// 	}

// 	function PopupHide() { //팝업창 지우기
// 	  $('#popup_1').hide();
// 	  PopupBgDisplay(); 
// 	  window.close();
// 	}

// 	function PopupBgDisplay() {	//팝업창이 없어진 경우 배경(popupbg) 지우기
// 	  cookiedata1 = document.cookie;
// 	  if (cookiedata1.indexOf("popup_1=done") > 0)
// 	  {
// 	  	$("#popupWrap").hide();
// 	  }
// 	}
	
// 	  function setCookie(name, value, expiredays) {
// 		    var todayDate = new Date();
// 		    todayDate.setDate(todayDate.getDate() + expiredays);
// 		    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
// 		  }
	


</script>


</body>
</html>