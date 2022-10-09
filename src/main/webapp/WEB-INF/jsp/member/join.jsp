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

		var idcheck = document.forms["memberForm"]["memberId"].value;
		var pwcheck = document.forms["memberForm"]["memberPw"].value;
		var emailcheck = document.forms["memberForm"]["memberEmail"].value;

		var regExp = /^[A-Za-z]{1}[A-Za-z0-9_-]{3,11}$/; //아이디 정규식
		var pwExp = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/; //비밀번호 정규식
		var emailregExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 정규식


		var tb = document.getElementById('tb');
		var msg = document.getElementById('msg');


		if (idcheck == null || idcheck == "") {

			msg.innerHTML = "아이디가 입력되지 않았습니다.";
			tb.append(msg);

			return false;

		} else if (pwcheck == null || pwcheck == "") {

			msg.innerHTML = "비밀번호가 입력되지 않았습니다";
			tb.append(msg);

			return false;

		} else if(!regExp.test(idcheck)) {

			alert('아이디 첫글자는 영문이어야하며 4~12자의 영문 대소문자와 숫자,하이픈,언더바 사용가능')
			return false;

		} else if(!pwExp.test(pwcheck)) {

			alert('비밀번호는 영문/숫자/특수문자(!@#$%^&*)를 포함하여 8~16자로 입력해야합니다.')
			return false;

		} else if(!emailregExp.test(emailcheck)) {

			alert('이메일 형식이 맞지 않습니다.')
			return false;

		} else{

			$.ajax({
				url: "/emailDupl",
				type: "POST",
				data: JSON.stringify(emailcheck),
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
							data: JSON.stringify(idcheck),
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

								console.log(result.responseText); //responseText의 에러메세지 확인
							}
						});


					}

				},
				error: function(result) {

					console.log(result.responseText); //responseText의 에러메세지 확인
				}
			});



		}
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
