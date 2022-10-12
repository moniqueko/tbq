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
<script>
	var title = document.getElementById("title").value;
	var contents = document.getElementById("contents").value;
	var writer = document.getElementById("writer").value;
	var quotes = document.getElementById("quotes").value;

	function validation() {

		if (title == null || title === "") {
			alert('제목을 입력해주세요');
			return false;

		}else if (contents == null || contents ==="") {
			alert('텍스트를 입력해주세요');
			return false;

		}else if (writer == null || writer ==="") {
			alert('작가를 입력해주세요');
			return false;

		}else if (quotes == null || quotes ==="") {
			alert('문장을 입력해주세요');
			return false;

		}else {
			submitEditBook();
		}

	}

	function submitEditBook() {
		console.log("실행됨");

		const bookUuid = '${book.bookUuid}';
		const form = $('#bookWriteForm')[0];
		const data = new FormData(form);

		data.append("bookUuid",bookUuid);

		$.ajax({
			type: "POST",
			url: "/editBook",
			data: JSON.stringify(data),
			dataType: "JSON",
			contentType: false,
			processData: false,
			success: function (result) {
				document.location = "/bookList";
			},
			error: function (error) {
				alert("Error occurred");
			}
		});
	}
</script>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>