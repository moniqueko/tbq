<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Sign in</title>
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
						<a href="#" id="myBook">My book</a>
						<c:choose>
							<c:when test="${memberInfo!=null}">
								<a href="#" id="myInfo">My Info</a>
								<a href="/logout">Logout</a>
							</c:when>
							<c:when test="${memberInfo==null}">
								<a href="/login" id="login">Login</a>
								<a href="/join" id="join" class="active">Join</a>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="row justify-content-center">
				<div class="col-md-4">
					<div class="justify-content-center" style="text-align: center">
						<h2>Join Us?</h2><br>
						<div class="container-sm" id="tb">
							<div class="col-md-12 form-group">

							<form:form name="memberForm" id="memberForm">
								<table>
									<tr>
										<td>ID</td>
										<td>
											<input type="text" style="width:200px;" id="memberId"  name="memberId" oninput="idCheck();" class="form-control"/>
											<div id="idCheckDiv"></div>
										</td>
									</tr>
									<tr>
										<td>E-mail</td>
										<td>
											<input type="text" style="width:200px;" id="memberEmail"  name="memberEmail" oninput="emailCheck();" class="form-control"/>
											<div id="emailCheckDiv"></div>
										</td>
									</tr>
									<tr>
										<td>Password</td>
										<td><input type="password"  style="width:200px;" id="memberPw"  name="memberPw" onkeyup="enterKey();" class="form-control"/></td>
									</tr>
									<tr>
										<td colspan="2" style="text-align: center"  id="msg"><br>
											<p><a href="#" class="readmore" onclick="validation();">Submit</a></p>
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

	</div>

	<div class="site-section">
	<%@ include file="/WEB-INF/jsp/component/section.jsp" %>
	</div>
</main>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>
<script>
		function validation() { //이메일 정규식 추가
		let memberId = document.getElementById("memberId");
		let memberPw = document.getElementById("memberPw");
		let memberEmail = document.getElementById("memberEmail");

		const regExp = /^[A-Za-z]{1}[A-Za-z0-9_-]{3,11}$/; //아이디 정규식
		const pwExp = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/; //비밀번호 정규식
		const emailRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 정규식

		const tb = document.getElementById('tb');
		const msg = document.getElementById('msg');

		if (!memberId) {
			msg.innerHTML = "Id is empty";
			tb.append(msg);
			return false;
		}
		if (!memberPw) {
			msg.innerHTML = "Password is empty";
			tb.append(msg);
			return false;
		}
		if (!memberEmail) {
			msg.innerHTML = "Email is empty";
			tb.append(msg);
			return false;
		}
		if(!regExp.test(memberId)) {
			alert('Id must start with alphabet and should be 4~12 length.');
			return false;
		}
		if(!pwExp.test(memberPw)) {
			alert('PW must be mixed with English/Number/!@#$%^&* and 8~16 length.');
			return false;
		}
		if(!emailRegExp.test(memberEmail)) {
			alert('Wrong email form');
			return false;
		}

			$.ajax({
				url: "/emailDupl",
				type: "POST",
				data: JSON.stringify(memberEmail),
				dataType: "JSON",
				contentType: "application/json",
				accept: "application/json",
				success: function(result) {

					if(result.data ==1){
						alert("이메일 중복입니다. 다른 이메일을 입력해주세요.");

					}else if(result.data ==0){ //이메일 통과

						$.ajax({
							url: "/idCheck",
							type: "POST",
							data: JSON.stringify(memberId),
							dataType: "JSON",
							contentType: "application/json",
							accept: "application/json",
							success: function(result) {

								if(result.data ==1){// 아이디 중복
									alert("아이디 중복입니다. 다른 아이디를 입력해주세요.");

								}else if(result.data ==0){
									signIn();//******모두 통과하면 실행
								}


							},
							error: function(result) {
								console.log(result.responseText);
							}
						});


					}

				},
				error: function(result) {
					console.log(result.responseText);
				}
			});

	}

	function enterKey() {
		if (window.keyCode === 13) {
			validation();
		}
	}

	function idCheck(){ //아이디 입력시
		let memberId = document.getElementById("memberId").value;

		$.ajax({
			url: "/idCheck",
			type: "POST",
			data: JSON.stringify(memberId),
			dataType: "JSON",
			contentType: "application/json",
			accept: "application/json",
			success: function(result) {
				console.log(result.data);
				console.log(result);

				if(result.data ==1){// 아이디 중복
					document.getElementById("idCheckDiv").innerHTML = "<span style='color: red;'>아이디 중복</span>";


				}else if(result.data ==0){
					document.getElementById("idCheckDiv").innerHTML = "<span style='color: green;'>사용가능한 아이디</span>";
				}

			},
			error: function(result) {
				console.log(result.responseText);
			}
		});
	}

	function emailCheck(){
		let memberEmail = document.getElementById("memberEmail").value;

		$.ajax({
			url: "/emailDupl",
			type: "POST",
			data: JSON.stringify(memberEmail),
			dataType: "JSON",
			contentType: "application/json",
			accept: "application/json",
			success: function(result) {

				if(result.data ==1){
					document.getElementById("emailCheckDiv").innerHTML = "<span style='color: red;'>이메일 중복</span>";

				}else if(result.data ==0){
					document.getElementById("emailCheckDiv").innerHTML = "<span style='color: green;'>사용가능한 이메일</span>";

				}else if(memberId==null|| memberId==''){
					document.getElementById("emailCheckDiv").innerHTML = "<span style='color: green;'>이메일을 입력해주세요</span>";
				}

			},
			error: function(result) {
				console.log(result.responseText); //responseText의 에러메세지 확인
			}
		});
	}

	function signIn(){
		let memberId = document.getElementById("memberId").value;
		let memberPw = document.getElementById("memberPw").value;
		let memberEmail = document.getElementById("memberEmail").value;

		var data = {
			'memberId' : memberId,
			'memberPw' : memberPw,
			'memberEmail' : memberEmail
		};

		$.ajax({
			url: "/join",  //회원가입완료
			type: "POST",
			data: JSON.stringify(data),
			dataType: "JSON",
			contentType: "application/json",
			accept: "application/json",
			success: function(result) {
				console.log(result.data);
				console.log("전송/저장 성공");
				alert('회원가입이 완료되었습니다. 다시 로그인해 주세요');

				//location.href="/login";

			},
			error: function(result) {
				console.log(result.data);
				alert('회원가입 실패. 다시 시도해 주세요');
				console.log(result.responseText); //responseText의 에러메세지 확인
			}
		});

	}

</script>
