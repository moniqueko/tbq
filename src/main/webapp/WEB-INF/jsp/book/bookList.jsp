<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Book List</title>

	<style>
	.li {
		float: left;
		margin: 15px;
	}
	.word {
		display: block;
		width: 500px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.title {
		display: block;
		width: 400px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	</style>
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
						<a href="/bookList" class="active">Book List</a>
						<a href="/myBook" >My book</a>
						<c:choose>
							<c:when test="${memberInfo!=null}">
								<a href="#" id="myInfo">My Info</a>
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

			<div class="row no-gutter" data-aos="fade-up" data-aos-delay="200">
					<div class="container">
						<div class="row justify-content-center text-right mb-4">

							<div class="item web col-md-12">
								<ul>
									<li class="li"><a href="/book/kor">Korean</a></li>
									<li class="li"><a href="/book/eng">English</a></li>
								</ul>

								<table class="table">
									<thead>
									<tr>
										<th scope="col" width="5%">#</th>
										<th scope="col" width="35%">Title</th>
										<th scope="col" width="15%">Author</th>
										<th scope="col" width="45%">Quotes</th>
									</tr>
									</thead>
									<tbody>
									<c:if test="${board!=null}">
										<c:forEach var="book" items="${board}" varStatus="status">
											<tr>
												<th scope="row">${pageMaker.totalCount - (pageMaker.cri.page - 1)  *  10 - status.index}</th>
												<td class="title"><a href="/view/${book.bookUuid}">${book.title}</a></td>
												<td>${book.writer}</td>
												<td class="word">${book.quotes}</td>
											</tr>
										</c:forEach>
									</c:if>

									<c:if test="${korean!=null}">
										<c:forEach var="book" items="${korean}" varStatus="status">
											<tr>
												<th scope="row">${pageMaker.totalCount - (pageMaker.cri.page - 1)  *  10 - status.index}</th>
												<td class="title"><a href="/view/${book.bookUuid}">${book.title}</a></td>
												<td>${book.writer}</td>
												<td class="word">${book.quotes}</td>
											</tr>
										</c:forEach>
									</c:if>

									<c:if test="${english!=null}">
										<c:forEach var="book" items="${english}" varStatus="status">
											<tr>
												<th scope="row">${pageMaker.totalCount - (pageMaker.cri.page - 1)  *  10 - status.index}</th>
												<td class="title"><a href="/view/${book.bookUuid}">${book.title}</a></td>
												<td>${book.writer}</td>
												<td class="word">${book.quotes}</td>
											</tr>
										</c:forEach>
									</c:if>

									</tbody>
								</table>
								<p><a href="/book" class="readmore">Write</a></p>
							</div>
						</div>
						<c:if test="${english!=null}">
							<c:set var="paginationTargetLink" value="/book/eng"/>
						</c:if>

						<c:if test="${korean!=null}">
							<c:set var="paginationTargetLink" value="/book/kor"/>
						</c:if>

						<c:if test="${board!=null}">
							<c:set var="paginationTargetLink" value="/bookList"/>
						</c:if>

						<%@ include file="/WEB-INF/jsp/component/pagination.jsp" %>
					</div>

			</div>


		</div>

	</div>

	<div class="site-section">
	<%@ include file="/WEB-INF/jsp/component/section.jsp" %>
	</div>
</main>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>
