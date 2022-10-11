<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Modify</title>
</head>

<body>
<%@ include file="/WEB-INF/jsp/component/header.jsp" %>

<main id="main">
<div class="site-section pb-0 site-portfolio">
	<div class="container">

		<div class="row mb-5 align-items-end">
			<div class="col-md-6" data-aos="fade-up">
				<h2>Modify</h2>
				<p class="mb-0">Modify article
				</p>
			</div>

		</div>

		<div class="row">
			<div class="col-md-6 mb-5 mb-md-0" data-aos="fade-up">

				<form:form enctype="multipart/form-data" id="bookWriteForm" role="form">

					<div class="row">
						<div class="col-md-12 form-group">
							<label for="title">Title</label>
							<input type="text" name="title" class="form-control" id="title" value="${book.title}"/>
							<div class="validate"></div>
						</div>
						<div class="col-md-12 form-group">
							<label for="writer">Author</label>
							<input type="text" class="form-control" name="writer" id="writer" value="${book.writer}"/>
							<div class="validate"></div>
						</div>
						<div class="col-md-12 form-group">
							<label for="bookImg">Image</label>
							<input type="file" name="bookImg" id="bookImg" accept=".jpg, .png"/>
							<span><c:if test="${book.img!=null}">[Image exist]</c:if></span>
							<div class="validate"></div>
						</div>
						<div class="col-md-12 form-group">
							<label for="quotes">Quotes</label>
							<input type="text" class="form-control" name="quotes" id="quotes" value="${book.quotes1}"/>
							<div class="validate"></div>
						</div>

						<c:if test="${book.quotes2!=null}">
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" name="quotes" id="quotes2" value="${book.quotes2}"/>
								<div class="validate"></div>
							</div>
						</c:if>

						<c:if test="${book.quotes3!=null}">
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" name="quotes" id="quotes3" value="${book.quotes3}"/>
								<div class="validate"></div>
							</div>
						</c:if>

						<div class="col-md-12 form-group">
							<label for="contents">Comment</label>
							<textarea class="form-control" name="contents" id="contents" cols="30" rows="10" >${book.contents}</textarea>
							<div class="validate"></div>
						</div>

						<div class="col-md-6 form-group">
							<input type="button" class="readmore d-block w-100" value="M o d i f y" onclick="validation();">
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
	const contents = document.getElementById("contents");
	const writer = document.getElementById("writer");
	const quotes = document.getElementById("quotes");

	function validation() {
		if (!title.value) {
			alert('제목을 입력해주세요');
			title.focus();
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

		if (!quotes.value) {
			alert('문장을 입력해주세요');
			return false;
		}

		submit();

	}

	function submit() {
		const bookUuid = '${book.bookUuid}';
		const form = $('#bookWriteForm')[0];
		const data = new FormData(form);

		data.append("bookUuid",bookUuid);

		$.ajax({
			type: "POST",
			url: "/modify",
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