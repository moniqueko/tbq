<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Book List</title>
</head>

<body>
<%@ include file="/WEB-INF/jsp/component/header.jsp" %>
<main id="main">
	<div class="site-section">
		<div class="container">
			<div class="row mb-5 align-items-end">
				<div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
					<h2>Are you a bookaholic?</h2>
					<p class="mb-0">Share your quotes from your favorite books! Upload images of quotes, that is all!</p>
				</div>
				<div class="col-md-12 col-lg-6 text-left text-lg-right" data-aos="fade-up" data-aos-delay="100">
					<div id="menus" class="menus">
						<a href="/" class="active">Home</a>
						<a href="#" >Book List</a>
						<a href="#" >My book</a>
						<a href="#" >My Info</a>
						<a href="/login">Login</a>
						<a href="/join" >Join</a>
					</div>
				</div>
			</div>
		</div>


		<div class="site-section pb-0">
			<div class="container">
				<div class="row align-items-stretch">
					<div class="col-md-8" data-aos="fade-up">
						<img src="/bookImg/${book.bookUuid}" alt="Image" class="img-fluid">
					</div>
					<div class="col-md-3 ml-auto" data-aos="fade-up" data-aos-delay="100">
						<div class="sticky-content">
							<h3 class="h3">${book.title}</h3>
							<p class="mb-4"><span class="text-muted">${book.writer}</span></p>

							<div class="mb-5">
								<p>${book.contents}</p>
							</div>
<%--							<h4 class="h4 mb-3"></h4>--%>
<%--							<ul class="list-unstyled list-line mb-5">--%>
<%--								<li></li>--%>
<%--								<li></li>--%>
<%--							</ul>--%>

							<p><a href="/book/${book.bookUuid}" class="readmore">Edit</a></p>
							<p><a href="/book/delete/${book.bookUuid}" class="readmore">Delete</a></p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="site-section pb-0">
			<div class="container">
				<div class="row justify-content-center text-center mb-4">
					<div class="col-5">
						comments here
					</div>
				</div>
			</div>
		</div>

		<div class="site-section pb-0">
			<div class="container">
				<div class="row justify-content-center text-center mb-4">
					<div class="col-5">
						<h3 class="h3 heading">More Quotes?</h3>
						<p>Explore more shared book quotes from other TBQ users</p>
					</div>
				</div>

				<div class="row" data-aos="fade-up" data-aos-delay="200">
					<c:forEach var="board" items="${board}" varStatus="status" end="5">
						<div class="item web col-sm-6 col-md-4 col-lg-4 mb-4">
							<a href="/book/${board.bookUuid}" class="item-wrap fancybox">
								<div class="work-info" data-uuid="${board.bookUuid}">
									<h3>${board.title}</h3>
									<span>${board.writer}</span>
								</div>
								<img class="img-fluid" src="/bookImg/${board.bookUuid}">
							</a>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>


		<div class="site-section pb-0">
			<%@ include file="/WEB-INF/jsp/component/section.jsp" %>
		</div>
	</div>

</main>
<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>
</body>
</html>