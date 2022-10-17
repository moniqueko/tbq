<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Write</title>
</head>

<body>
<%@ include file="/WEB-INF/jsp/component/header.jsp" %>

<main id="main">
<div class="site-section pb-0 site-portfolio">
	<div class="container">

		<div class="row mb-5 align-items-end">
			<div class="col-md-6" data-aos="fade-up">
				<h2>Write</h2>
				<p class="mb-0">Upload your favorite quotes and share the quotes with community!
				</p>
			</div>

		</div>

		<div class="row">
			<div class="col-md-6 mb-5 mb-md-0" data-aos="fade-up">

				<form:form enctype="multipart/form-data" id="bookWriteForm" role="form">

					<div class="row">
						<div class="col-md-12 form-group">
							<label for="lang">Language</label>
							<input type="radio" name="lang" value="KOR" id="lang"/>&nbsp;Korean
							<input type="radio" name="lang" value="ENG"/>&nbsp;English
							<div class="validate"></div>
						</div><br>
						<div class="col-md-12 form-group">
							<label for="title">Title</label>
							<input type="text" name="title" class="form-control" id="title" data-rule="minlen:4" data-msg="Please enter at least 4 chars" />
							<div class="validate"></div>
						</div>
						<div class="col-md-12 form-group">
							<label for="writer">Author</label>
							<input type="text" class="form-control" name="writer" id="writer" data-rule="minlen:4" data-msg="Please enter at least 4 chars" />
							<div class="validate"></div>
						</div>
						<div class="col-md-12 form-group">
							<label for="bookImg">Image</label>
							<input type="file" name="bookImg" id="bookImg" accept=".jpg, .png"/>
							<div class="validate"></div>
						</div>
						<div class="col-md-12 form-group">
							<label for="quotes">Quotes (Do not include any ",")</label>
							<input type="text" class="form-control" name="quotes" id="quotes" data-rule="minlen:4" data-msg="Please insert up to 150 characters" />
							<div class="validate"></div>
						</div>

						<div class="col-md-12 form-group">
							<a href="#" onclick="plus();"><i class='fas fa-plus'></i>&nbsp; Add (up to 3 quotes)</a>
						</div>

						<div class="col-md-12 form-group" id="quote1">
							<input type="text" class="form-control" name="quotes" id="quotes2" data-rule="minlen:4" data-msg="Please insert up to 150 characters" />
							<div class="validate"></div>
						</div>

						<div class="col-md-12 form-group" id="quote2">
							<input type="text" class="form-control" name="quotes" id="quotes3" data-rule="minlen:4" data-msg="Please insert up to 150 characters" />
							<div class="validate"></div>
						</div>

						<div class="col-md-12 form-group">
							<label for="contents">Comment (Up to 500 characters) </label>
							<textarea class="form-control" name="contents" id="contents" cols="30" rows="10" data-rule="required" data-msg="Write comments here"></textarea>
							<div class="validate"></div>
						</div>

						<div class="col-md-6 form-group">
							<input type="button" class="readmore d-block w-100" value="Write" onclick="validation();">
						</div>
					</div>
				</form:form>

			</div>

			<div class="col-md-4 ml-auto order-2" data-aos="fade-up">
				<ul class="list-unstyled">
					<li class="mb-3">
						<strong class="d-block mb-1">How to use TBQ?</strong>
						<span>It's easy to write and share your favorite quotes!</span>
					</li>
					<li class="mb-3">
						<strong class="d-block mb-1">Follow the steps</strong>
						<div>
							1. Choose the language of the book<br>
							2. Fill all boxes<br>
							3. Pick and upload an image of the quote<br>
							4. Share your image and thoughts with TBQ users
						</div>
					</li>
					<li class="mb-3">
						<strong class="d-block mb-1">Need support?</strong>
						<span>enjuk0507@gmail.com</span>
					</li>
				</ul>
			</div>

		</div>

	</div>

</div>
</main>

<hr><br>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<script>
	const quote1 = document.getElementById("quote1");
	const quote2 = document.getElementById("quote2");
	let cnt = 0;

	$(document).ready(function(){
		quote1.style.display='none';
		quote2.style.display='none';
	})

	function plus(){
		cnt = cnt + 1;

		if(cnt==1) {
			quote1.style.display = 'block';
		}else if(cnt==2){
			quote2.style.display = 'block';
		}else{
			alert("Quotes can be added up to 3");
		}

	}

	function validation() {

		var title = document.getElementById("title").value;
		var img = document.getElementById("bookImg").value;
		var contents = document.getElementById("contents").value;
		var writer = document.getElementById("writer").value;
		var quotes = document.getElementById("quotes").value;

		var checked = document.getElementsByName('lang');
		var lang;

		for (let i = 0; i < checked.length; i++) {
			if (checked[i].checked == true) {
				lang = checked[i].value;
			}
		}

		if (title == null || title == "") {
			alert('제목을 입력해주세요');
			title.focus();
			return false;
		}else if (img == null) {
			alert('이미지를 첨부해주세요');
			return false;
		}else if (contents == null || contents =="") {
			alert('텍스트를 입력해주세요');
			contents.focus();
			return false;
		}else if (writer == null || writer =="") {
			alert('작가를 입력해주세요');
			writer.focus();
			return false;
		}else if (quotes == null || quotes =="") {
			alert('문장을 입력해주세요');
			writer.focus();
			return false;
		}else if (lang==null) {
			alert('언어를 선택해주세요');
			lang.focus();
			return false;
		}else {
			submit();
		}

	}

	function submit() {
		const form = $('#bookWriteForm')[0];
		const data = new FormData(form);

		$.ajax({
			type: "POST",
			url: "/addBook",
			data: data,
			dataType: "JSON",
			contentType: false,
			processData: false,
			success: function (result) {
				document.location = "/bookList";
			},
			error: function (error) {
				alert("Error occurred");
				history.back();
			}
		});
	}
</script>