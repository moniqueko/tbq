<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Find Password</title>
</head>

<body>
<%@ include file="/WEB-INF/jsp/component/header.jsp" %>
<main id="main">
	<div class="site-section pb-0 site-portfolio">
		<div class="container">
			<div class="row mb-5 align-items-end">
				<div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
					<h2>Lost Password?</h2>
					<p class="mb-0">Find Password</p>
				</div>
				<div class="col-md-12 col-lg-6 text-left text-lg-right" data-aos="fade-up" data-aos-delay="100">
					<div id="menus" class="menus">
						<a href="/" >Home</a>
						<a href="/bookList" >Book List</a>
						<a href="/myBook" >My book</a>
						<c:choose>
							<c:when test="${memberInfo!=null}">
								<a href="/member/${memberInfo.memberUuid}" id="myInfo">My Info</a>
								<a href="/logout">Logout</a>
							</c:when>
							<c:when test="${memberInfo==null}">
								<a href="/login" id="login" class="active">Login</a>
								<a href="/join" id="join">Join</a>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="row justify-content-center">
				<div class="col-md-4">
					<div class="justify-content-center" style="text-align: center">
						<h2>Find Password</h2><br><br>
						<div class="container-sm" id="tb">

							<form:form action="/findPw" name="memberEditForm" id="memberEditForm" method="POST">
								<div class="col-md-12 form-group">
									<label for="memberId">ID</label>
									<input type="text" id="memberId"  name="memberId" class="form-control"/>
								</div>

								<div class="col-md-12 form-group">
									<label for="memberEmail">E-mail</label>
									<input type="text" id="memberEmail"  name="memberEmail" oninput="emailCheck();" class="form-control" onkeyup="enterKey();"/>
									<div id="emailCheck"></div>
								</div>

								<div class="col-md-12 form-group">
									<div id="msg"></div>
									<div><input type="submit" value="Find" class="readmore"></div>
								</div>
							</form:form>

						</div>
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
			memberEditForm.submit();
		}
	}

	function emailCheck(){ //아이디 입력시

		var memberId = document.forms["memberEditForm"]["memberId"].value;
		var memberEmail = document.forms["memberEditForm"]["memberEmail"].value;
		var data = {
			'memberId': memberId,
			'memberEmail' : memberEmail
		};

		$.ajax({
			url: "/emailCheck",
			type: "POST",
			data: JSON.stringify(data),
			dataType: "JSON",
			contentType: "application/json",
			accept: "application/json",
			success: function(result) {

				if(result.status==401){
					document.getElementById("emailCheck").innerHTML = "<span style='color: red;'>Id and E-mail not matching</span>";

				}else if(result.status==200){
					document.getElementById("emailCheck").innerHTML = "<span style='color: green;'>Member Identified</span>";

				}else if(memberId==null|| memberId==''){
					document.getElementById("msg").innerHTML = "<span style='color: green;'>Id is empty</span>";

				}else if(memberEmail==null || memberEmail==''){
					document.getElementById("msg").innerHTML = "<span style='color: green;'>E-mail is empty</span>";
				}

			},
			error: function(result) {

				console.log(result.responseText); //responseText의 에러메세지 확인
			}
		});
	}

</script>
