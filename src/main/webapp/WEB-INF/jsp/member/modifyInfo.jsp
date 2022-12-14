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
									<label for="memberPwCheck" style="text-align: left">PW check</label>
									<input type="password" id="memberPwCheck"  name="memberPw" class="form-control" onkeyup="pwCheck();"/>
									<div id="pwCheckDiv"></div>
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
	function pwCheck(){
		if (document.getElementById('memberPw').value ==
				document.getElementById('memberPwCheck').value) {
			document.getElementById("pwCheckDiv").innerHTML = "<span style='color: green;'>PW matching</span>";
		} else if(document.getElementById('memberPw').value == "" ||
				document.getElementById('memberPwCheck').value == "") {
			document.getElementById("pwCheckDiv").innerHTML = "<span style='color: red;'>PW is Empty</span>";
		}else{
			document.getElementById("pwCheckDiv").innerHTML = "<span style='color: red;'>PW not matching</span>";
		}

	}

	function validation() {
		let idcheck = document.getElementById('memberId').value;
		let pwcheck = document.getElementById('memberPw').value;
		let emailcheck = document.getElementById('memberEmail').value;
		let pwDoubleCheck = document.getElementById('memberPwCheck').value;

		const pwExp = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/;
		const emailregExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		const tb = document.getElementById('tb');
		const msg = document.getElementById('msg');

		if(!pwcheck){
			msg.innerHTML = "PW is empty";
			tb.append(msg);
			return false;

		}else if(!pwDoubleCheck){
			msg.innerHTML = "PW Check is empty";
			tb.append(msg);
			return false;

		}else if(pwDoubleCheck!=pwcheck){
			msg.innerHTML = "PW not matching";
			tb.append(msg);
			return false;

		}else if(!emailcheck){
			msg.innerHTML = "E-mail is empty";
			tb.append(msg);
			return false;
		}

		if(!pwExp.test(pwcheck)) {
			alert('Follow PW format: mixed with alphabet/number/!@#$%^&*_- within 8~16 long')
			return false;

		} else if(!emailregExp.test(emailcheck)) {
			alert('Please follow E-mail format')
			return false;

		} else{

			var data = {
				'memberId': idcheck,
				'memberEmail' : emailcheck
			};

			$.ajax({
				url: "/emailCheck", //????????? ????????? ????????????. 0:????????? 1:??????
				type: "POST",
				data: JSON.stringify(data),
				dataType: "JSON",
				contentType: "application/json",
				accept: "application/json",
				success: function(result) {

					if(result.code == 200){ //?????? ????????? ?????? ???????????? ?????? ?????? ??????.
						modifyInfo();

					}else if(result.code == 401){ //????????? ????????? ??????

						$.ajax({
							url: "/emailDupl",
							type: "POST",
							data: emailcheck,
							dataType: "JSON",
							contentType: "application/json",
							accept: "application/json",
							success: function(result) {

								if(result.code == 406){ //?????? db??? ?????? ????????????
									alert("This E-mail address is used");
									return;

								}else if(result.code == 200){ //db??? ?????? ?????? ????????? ?????????

									if(result.data == 1){ //?????? or ????????? ????????? ??????
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
						url: "/emailDupl", //????????? ?????? ?????????
						type: "POST",
						data: memberEmail,
						dataType: "JSON",
						contentType: "application/json",
						accept: "application/json",
						success: function(result) {

							if(result.code == 406){ //?????? db??? ?????? ????????????
								document.getElementById("msg").innerHTML = "<span style='color: red;'>The E-mail is used</span>";

							}else if(result.code == 200){ //db??? ?????? ?????? ????????? ?????????

								if(result.data == 1){ //????????? ???????????? ?????????
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

					//?????? ???????????????

				}else if(result.code == 200){ //????????? ????????? ??????
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
				if(result.status==404){
					alert('Failed to modify. Please follow Id/Pw/E-mail format')
					return false;

				}else if(result.status==406){
					alert('Failed to modify. Duplicated Id/Pw/E-mail.')
					return false;

				}else if(result.status==200){
					alert('Modified');
					location.href="/member/"+ memberUuid;
				}

			},
			error: function(result) {
				console.log(result.responseText);
			}
		});

	}

	function del(){
		let memberUuid = '${member.memberUuid}';
		let check = confirm("Are you sure to leave TBQ?");

		if(check==false){
			history.back();
		}

		$.ajax({
			type: "POST",
			url: "/member/del",
			data: memberUuid,
			dataType: "text",
			contentType : "application/json",
			processData : false,
			success: function(result) {
				alert("Deletion success. Good bye!");
				location.href="/";
			},
			error: function(request, status, error) {
				console.log("ERROR : "+request.status+"\n"+"message"+request.responseText+"\n"+"error:"+error);

				alert("Error occurred");
			}
		});

	}

</script>
