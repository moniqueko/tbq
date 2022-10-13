<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Modify Member Information</title>
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
						<a href="/myBook" >My book</a>
						<c:choose>
							<c:when test="${memberInfo!=null}">
								<a href="/member/${memberInfo.memberUuid}" id="myInfo" class="active">My Info</a>
								<a href="/login" id="login">Login</a>
								<a href="/logout">Logout</a>
							</c:when>
							<c:when test="${memberInfo==null}">
								<a href="/login" id="login">Login</a>
								<a href="/join" id="join">Join</a>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="row justify-content-center">
				<div class="col-md-4">
					<div class="justify-content-center" style="text-align: center">
						<h2>Modify Info</h2><br><br>
						<div class="container-sm" id="tb">

							<form:form name="memberForm" id="memberForm" role="form">
								<div class="col-md-12 form-group">
									<label for="memberId" style="text-align: left">ID</label>
									<input type="text" id="memberId"  name="memberId" class="form-control" value="${member.memberId}" readonly/>
								</div>

								<div class="col-md-12 form-group">
									<label for="memberEmail" style="text-align: left">Email</label>
									<input type="email" id="memberEmail"  name="memberEmail" class="form-control" oninput="emailCheck();" value="${member.memberEmail}"/>
									<div id="emailCheckDiv"></div>
								</div>

								<div class="col-md-12 form-group">
									<label for="memberPw" style="text-align: left">Password</label>
									<input type="password" id="memberPw"  name="memberPw" class="form-control" onkeyup="enterKey();"/>
								</div>

								<div class="col-md-12 form-group">
									<span><a href="#" class="readmore" onclick="validation();">Modify</a>
										<a href="#" class="readmore" onclick="del();">Delete info</a></span>
								</div>
							</form:form>
							<div id="msg"></div>
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
	function validation() { //이메일 정규식 추가

		var idcheck = document.forms["memberForm"]["memberId"].value;
		var pwcheck = document.forms["memberForm"]["memberPw"].value;
		var emailcheck = document.forms["memberForm"]["memberEmail"].value;

		var pwExp = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/; //비밀번호 정규식
		var emailregExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 정규식

		var tb = document.getElementById('tb');
		var msg = document.getElementById('msg');

		if (pwcheck == null || pwcheck == "") {

			msg.innerHTML = "Password is empty";
			tb.append(msg);

			return false;

		} else if(!pwExp.test(pwcheck)) {

			alert('Follow PW format: mixed with alphabet/number/!@#$%^&* within 8~16 long')
			return false;

		} else if(!emailregExp.test(emailcheck)) {

			msg.innerHTML = "Please follow E-mail format";
			tb.append(msg);
			return false;

		} else{

			var data = {
				'memberId': idcheck,
				'memberEmail' : emailcheck
			};

			$.ajax({
				url: "/emailCheck", //아이디 이메일 일치여부. 0:불일치 1:일치
				type: "POST",
				data: JSON.stringify(data),
				dataType: "JSON",
				contentType: "application/json",
				accept: "application/json",
				success: function(result) {

					if(result.code == 200){ //원래 이메일 주소 사용할수 있게 하기 위함.
						modifyInfo();

					}else if(result.code == 401){ //새로운 이메일 주소

						$.ajax({
							url: "/emailDupl",
							type: "POST",
							data: emailcheck,
							dataType: "JSON",
							contentType: "application/json",
							accept: "application/json",
							success: function(result) {

								if(result.code == 406){ //이미 db에 두개 있는경우
									alert("This E-mail address is used");
									return;

								}else if(result.code == 200){ //db에 없는 아예 새로운 이메일

									if(result.data == 1){ //본인 or 타인이 이메일 사용
										alert("This E-mail address is used");

									}else if(result.data == 0){
										modifyInfo();
									}

								}else if(result.code == 410){ //No input data error
									console.log(result.message);
								}


							},
							error: function(result) {
								console.log(result.responseText);
							}
						});

					}else if(emailcheck==null|| emailcheck==''){
						document.getElementById("msg").innerHTML = "<span style='color: green;'>E-mail is empty</span>";

					}

				},
				error: function(result) {
					console.log(result.responseText);
				}
			});


		}

	}

	function enterKey() {
		if (window.event.keyCode === 13) {
			validation();
		}
	}

	function emailCheck(){
		var memberId = document.forms["memberForm"]["memberId"].value;
		var memberEmail = document.forms["memberForm"]["memberEmail"].value;

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

				if(result.code == 401){
					$.ajax({
						url: "/emailDupl", //이메일 중복 갯수만
						type: "POST",
						data: memberEmail,
						dataType: "JSON",
						contentType: "application/json",
						accept: "application/json",
						success: function(result) {

							if(result.code == 406){ //이미 db에 두개 있는경우
								document.getElementById("msg").innerHTML = "<span style='color: red;'>The E-mail is used</span>";

							}else if(result.code == 200){ //db에 없는 아예 새로운 이메일

								if(result.data == 1){ //타인이 사용중인 이메일
									document.getElementById("msg").innerHTML = "<span style='color: red;'>The E-mail is used</span>";

								}else if(result.data == 0){
									document.getElementById("msg").innerHTML = "<span style='color: green;'>Available</span>";
								}

							}

						},
						error: function(result) {
							console.log(result.responseText);
						}
					});

					//본인 이메일주소

				}else if(result.code == 200){ //새로운 이메일 주소
					document.getElementById("msg").innerHTML = "<span style='color: green;'>Available (No change)</span>";

				}else if(memberEmail==null|| memberEmail==''){
					document.getElementById("msg").innerHTML = "<span style='color: green;'>Please input E-mail</span>";

				}

			},
			error: function(result) {
				console.log(result.responseText);
			}
		});
	}

	function modifyInfo(){
		let memberId = document.getElementById("memberId").value;
		let memberPw = document.getElementById("memberPw").value;
		let memberEmail = document.getElementById("memberEmail").value;
		let memberUuid = '${member.memberUuid}';

		var data = {
			'memberId' : memberId,
			'memberPw' : memberPw,
			'memberEmail' : memberEmail,
			'memberUuid' : memberUuid
		};

		$.ajax({
			url: "/member/editMember",
			type: "POST",
			data: JSON.stringify(data),
			dataType: "JSON",
			contentType: "application/json",
			accept: "application/json",
			success: function(result) {
				console.log(result.data);

				alert('Modified');

				location.href="/memberList";

			},
			error: function(result) {
				console.log(result.responseText);
			}
		});

	}

</script>
