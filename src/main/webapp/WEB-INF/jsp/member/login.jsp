<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<title>로그인</title>

<style>
	body{font-family: 'Noto Sans KR', sans-serif;}
	h2{text-align: left;}

	a:link {color: black;}
    a:visited {color: black;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black;}
    
</style>
</head>

<body>
<br><br>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
        
        <div class="justify-content-center" style="text-align: center">
           <h2>로그인</h2><br>
            <div class="container-sm">  
		 
				<form:form name="memberForm" id="memberForm">
					<table class="table table-bordered">
						<tr><td>아이디</td><td><input type="text"  style="width:200px;" id="memberId"  name="memberId" /></td></tr>
						<tr><td>비밀번호</td><td><input type="password"  style="width:200px;" id="memberPw"  name="memberPw" onkeyup="enterkey()"/></td></tr>
						<tr><td colspan="2">
						<input type="button" value="로그인"  onclick="login()">
						<input type="button" value="비밀번호 찾기"  onclick="location.href='../findPw'">
						<input type="button" value="회원가입" onclick="location.href='../signin'"></td></tr>
					</table>
				</form:form>
			</div>
		</div>
	</div>
   </div>
</div>



<script>
	function enterkey() {
		if (window.event.keyCode == 13) {
			login();
		}
	}


	function login(){
		
		let memberId = document.forms["memberForm"]["memberId"].value;
		let memberPw = document.forms["memberForm"]["memberPw"].value;
		
		var data = {
			'memberId' : memberId,
			'memberPw' : memberPw
		};
		   
		console.log("아이디"+memberId);

		 
		$.ajax({
	             url: "/login",  
	             type: "POST",
	             data: JSON.stringify(data),
	             dataType: "JSON",
	             contentType: "application/json",
	             accept: "application/json",
	             success: function(result) {          

	            	 console.log(result.code+":"+result.message);
 
	            	 if(result.code==200){
	            		 if(result.data == '1'){
	            			 alert('일반회원 로그인 성공');
			            	 location.href="../loginOk";
			            	 
	            		 }else if(result.data=='2'){
		            		 console.log("관리자 로그인");
		            		 location.href="../adminOk";
		            	 }	            		 
	            	 }else if(result.code==408){
	            		 console.log(result.message);
	            		 alert('아이디나 패스워드가 일치하지 않습니다');
	            		 
	            	 }else if(result.code==409){
	            		 console.log(result.message);
	            		 alert('회원정보 없음: 로그인 실패');
	            	 }
		            	 
		            		 
	            	 },

	             error: function(result) {
	                 console.log(result.responseText); //responseText의 에러메세지 확인
	             }
	         });
			
	}


</script>

</body>
</html>