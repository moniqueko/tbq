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
						<a href="/" id="home">Home</a>
						<a href="/bookList" id="bookList">Book List</a>
						<a href="/myBook" id="myBook">My book</a>
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

			<div id="memberLogin">
				<c:if test="${memberInfo==null}">
					<div class="row justify-content-center">
						<div class="col-md-4">
							<div class="justify-content-center" style="text-align: center" id="loginOk">
								<h2>Login</h2><br><br>
								<div class="container-sm" id="tb">
									<form:form name="memberForm" id="memberForm">
										<div class="col-md-12 form-group">
											<label for="memberId">ID</label>
											<input type="text" id="memberId"  name="memberId" class="form-control"/>
										</div>

										<div class="col-md-12 form-group">
											<label for="memberPw">Password</label>
											<input type="password" id="memberPw"  name="memberPw" class="form-control" onkeyup="enterKey();"/>
										</div>

										<div class="col-md-12 form-group">
											<div id="msg"></div>
											<div><a href="#" class="readmore" onclick="validation();">Login</a> &nbsp;
												<a href="/findPw" class="readmore">Find</a></div>
										</div>
									</form:form>
								</div>
							</div>
						</div>
					</div>
				</c:if>
			</div>

		</div>

	</div>

	<div class="site-section">
	<%@ include file="/WEB-INF/jsp/component/section.jsp" %>
	</div>
</main>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>
<script>
	const tb = document.getElementById('tb');
	const msg = document.getElementById('msg');
	const loginOk = document.getElementById('loginOk');

	function enterKey() {
		if (window.event.keyCode == 13) {
			validation();
		}
	}

	function login() {
		let memberId = document.forms["memberForm"]["memberId"].value;
		let memberPw = document.forms["memberForm"]["memberPw"].value;

		var data = {
			'memberId': memberId,
			'memberPw': memberPw
		};

		$.ajax({
			url: "/login",
			type: "POST",
			data: JSON.stringify(data),
			dataType: "JSON",
			contentType: "application/json",
			accept: "application/json",
			success: function (result) {

				if (result.code == 200) {
					if (result.data == '1') {
						loginOk.innerHTML = '<h2>Welcome,'+ memberId+'</h2><br><br>Enjoy TBQ and Have a good day!';

					} else if (result.data == '2') {
						location.href = "/admin";

					} else if(result.data =='3'){ //탈퇴한 회원
						msg.innerHTML = "Login Failed: No Member";
						tb.append(msg);
					}
				} else if (result.code == 401) {
					console.log(result.message);
					msg.innerHTML = "Login Failed: ID/PW not matching";
					tb.append(msg);
				}
			},

			error: function (result) {
				console.log(result.responseText);
			}
		});
	}

	function validation() {

		var idcheck = document.forms["memberForm"]["memberId"].value;
		var pwcheck = document.forms["memberForm"]["memberPw"].value;

		if (idcheck == null || idcheck == "") {
			msg.innerHTML = "Please input ID";
			tb.append(msg);
			return false;

		} else if (pwcheck == null || pwcheck == "") {
			msg.innerHTML = "Please input PW";
			tb.append(msg);
			return false;
		}

		login();

	}

</script>
