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
							<label for="contents">Comment</label>
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

<script>
	const title = document.getElementById("title");
	const img = document.getElementById("bookImg");
	const contents = document.getElementById("contents");
	const writer = document.getElementById("writer");

	const checked = document.getElementsByName('lang');
	let lang;

	for (let i = 0; i < checked.length; i++) {
		if (checked[i].checked == true) {
			lang = checked[i].value;
		}
	}

	function validation() {


		if (!title.value) {
			alert('제목을 입력해주세요');
			title.focus();
			return false;
		}

		if (!img.value) {
			alert('이미지를 첨부해주세요');
			return false;
		}

		if (!contents.value) {
			alert('텍스트를 입력해주세요');
			contents.focus();
			return false;
		}

		if (!writer.value) {
			alert('작가를 입력해주세요');
			return false;
		}

		if (lang==null) {
			alert('언어를 선택해주세요');
			return false;
		}
		submit();

	}

	function submit() {
		const memberUuid = '${memberInfo.memberId}';
		const form = $('#bookWriteForm')[0];
		const data = new FormData(form);
		data.append("memberUuid", memberUuid);

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
				alert("에러발생");
			}
		});
	}
</script>