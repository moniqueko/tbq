<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Login</title>
</head>

<body>
<%@ include file="/WEB-INF/jsp/component/header.jsp" %>
<main id="main">
	<div class="site-section pb-0 site-portfolio">
		<div class="container">
			<div class="row mb-5 align-items-end">
				<div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
					<h2>Are you a bookaholic?</h2>
					<p class="mb-0">Share your quotes from your favorite books! Upload images of quotes, that is all!</p>
				</div>
				<div class="col-md-12 col-lg-6 text-left text-lg-right" data-aos="fade-up" data-aos-delay="100">
					<div id="menus" class="menus">
						<a href="/" >Home</a>
						<a href="/bookList" >Book List</a>
						<a href="#" >My book</a>
						<a href="#" >My Info</a>
						<a href="/login" class="active">Login</a>
						<a href="/join" >Join</a>
					</div>
				</div>
			</div>

			<div class="row justify-content-center">
				<div class="col-md-4">
					<div class="justify-content-center" style="text-align: center">

					   <h2>Login</h2><br>
						<div class="container-sm">
							<form:form name="memberForm" id="memberForm">
								<table class="table table-bordered">
									<tr>
										<td>ID</td>
										<td><input type="text"  style="width:200px;" id="memberId"  name="memberId" /></td>
									</tr>
									<tr>
										<td>Password</td>
										<td><input type="password"  style="width:200px;" id="memberPw"  name="memberPw" onkeyup="enterKey();"/></td>
									</tr>
									<tr style="text-align: center">
										<td colspan="2">
											<input type="button" value="Login"  onclick="login();">
											<input type="button" value="Find PW"  onclick="location.href='/findPw'">
										</td>
									</tr>
								</table>
							</form:form>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>

	<div class="site-section">
	<%@ include file="/WEB-INF/jsp/component/section.jsp" %>
	</div>
</main>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>
<script>
	function enterKey() {
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
	            			 alert('Login Success');
			            	 location.href="/";
			            	 
	            		 }else if(result.data=='2'){
		            		 console.log("관리자 로그인");
		            		 location.href="/adminOk";
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
