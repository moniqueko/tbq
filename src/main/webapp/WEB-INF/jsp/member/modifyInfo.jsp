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

							<form:form name="memberForm" id="memberForm">
								<div class="col-md-12 form-group">
									<label for="memberId" style="text-align: left">ID</label>
									<input type="text" id="memberId"  name="memberId" class="form-control" oninput="idCheck();" value="${member.memberId}" readonly/>
									<div id="idCheckDiv"></div>
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
									<div id="msg"></div>
										<span><a href="#" class="readmore" onclick="validation();">Modify</a>
											<a href="#" class="readmore" onclick="del();">Delete info</a></span>
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
				data: emailcheck,
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
							data: idcheck,
							dataType: "JSON",
							contentType: "application/json",
							accept: "application/json",
							success: function(result) {

								if(result.data ==1){// 아이디 중복
									alert("아이디 중복입니다. 다른 아이디를 입력해주세요.");

								}else if(result.data ==0){
									modifyInfo();//******모두 통과하면 실행
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
	}

	function enterKey() {
		if (window.event.keyCode === 13) {
			validation();
		}
	}

	function idCheck(){ //아이디 입력시
		let memberId = document.getElementById("memberId").value;

		$.ajax({
			url: "/idCheck",
			type: "POST",
			data: memberId,
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
			data: memberEmail,
			dataType: "JSON",
			contentType: "application/json",
			accept: "application/json",
			success: function(result) {

				if(result.data ==1){
					document.getElementById("emailCheckDiv").innerHTML = "<span style='color: red;'>이메일 중복</span>";

				}else if(result.data ==0){
					document.getElementById("emailCheckDiv").innerHTML = "<span style='color: green;'>사용가능한 이메일</span>";

				}else if(memberEmail==null|| memberEmail==''){
					document.getElementById("emailCheckDiv").innerHTML = "<span style='color: green;'>이메일을 입력해주세요</span>";
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

		var data = {
			'memberId' : memberId,
			'memberPw' : memberPw,
			'memberEmail' : memberEmail
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
				console.log("전송/저장 성공");
				alert('Modified');
				location.href="/admin";

			},
			error: function(result) {
				console.log(result.responseText);
			}
		});

	}

	function del(){
		let check = confirm("Delete?");

		if(check == false){
			history.back();
		}

		let memberUuid = '${member.memberUuid}';

		$.ajax({
			type: "POST",
			url: "/member/del",
			data: memberUuid,
			dataType: "text",
			contentType : "application/json",
			processData : false,
			success: function(result) {
				alert("Deletion success. Good Bye!");

				location.href="/";
			},
			error: function(request, status, error) {
				console.log("ERROR : "+request.status+"\n"+"message"+request.responseText+"\n"+"error:"+error);

				alert("Error occurred");
			}
		});

	}
</script>
