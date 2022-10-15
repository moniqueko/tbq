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
		width: 450px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.title {
		display: block;
		width: 100%;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.keyword{
		border: 1px solid black;
		width: 200px;
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
					<h2>Shared book quotes</h2>
					<p class="mb-0">Check out shared book quotes form others!</p>
				</div>
				<div class="col-md-12 col-lg-6 text-left text-lg-right" data-aos="fade-up" data-aos-delay="100">
					<div id="menus" class="menus">
						<a href="/" >Home</a>
						<a href="/bookList" class="active">Book List</a>
						<a href="/myBook" >My book</a>
						<c:choose>
							<c:when test="${memberInfo!=null}">
								<a href="/member/${memberInfo.memberUuid}" id="myInfo">My Info</a>
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
						<div class="row justify-content-center text-center mb-4">
							<ul>
								<li class="li"><a href="/book/kor">Korean</a></li>
								<li class="li"><a href="/book/eng">English</a></li>
							</ul>
							<div class="item col-md-12">
									<c:if test="${board!=null}">
										<div id="portfolio-grid">
											<c:forEach var="book" items="${board}" varStatus="status" end="8">
												<div class="item col-sm-6 col-md-4 col-lg-4 mb-4">
													<a href="/view/${book.bookUuid}" class="item-wrap fancybox">
														<div class="work-info" data-uuid="${book.bookUuid}">
															<h3>${book.quotes1}</h3>
<%--															<span></span>--%>
														</div>
														<img class="img-fluid" src="/bookImg/${book.bookUuid}">
													</a>
													<br>
													<span style="text-align: center">
														${book.title}<br>
														By ${book.writer}<br>
														scrap(${book.count})
													</span>
												</div>

											</c:forEach>
										</div>
									</c:if>

								<c:if test="${korean!=null}">
									<div id="portfolio-grid">
										<c:forEach var="book" items="${korean}" varStatus="status" end="8">
											<div class="item col-sm-6 col-md-4 col-lg-4 mb-4">
												<a href="/view/${book.bookUuid}" class="item-wrap fancybox">
													<div class="work-info" data-uuid="${book.bookUuid}">
														<h3>${book.quotes1}</h3>
															<%--															<span></span>--%>
													</div>
													<img class="img-fluid" src="/bookImg/${book.bookUuid}">
												</a>
												<br>
												<span style="text-align: center">
														${book.title}<br>
														${book.writer} 작가<br>
														스크랩(${book.count})
													</span>
											</div>

										</c:forEach>
									</div>
								</c:if>

								<c:if test="${english!=null}">
									<div id="portfolio-grid">
										<c:forEach var="book" items="${english}" varStatus="status" end="8">
											<div class="item col-sm-6 col-md-4 col-lg-4 mb-4">
												<a href="/view/${book.bookUuid}" class="item-wrap fancybox">
													<div class="work-info" data-uuid="${book.bookUuid}">
														<h3>${book.quotes1}</h3>
															<%--															<span></span>--%>
													</div>
													<img class="img-fluid" src="/bookImg/${book.bookUuid}">
												</a>
												<br>
												<span style="text-align: center">
														${book.title}<br>
														By ${book.writer}<br>
														scrap(${book.count})
													</span>
											</div>

										</c:forEach>
									</div>
								</c:if>

								<p style="text-align: right"><a href="/book" class="readmore">Write</a></p>
							</div>
							<div class="searchBar">
								<c:if test="${english!=null}">
									<form:form action="/book/eng" method="GET">
										<input type="text" placeholder="author/title/contents" id="keyword" name="keyword" class="keyword">
										<input type="submit" value="Search" class="searchBtn">
									</form:form>

									<c:set var="paginationTargetLink" value="/book/eng"/>
								</c:if>

								<c:if test="${korean!=null}">
									<form:form action="/book/kor" method="GET">
										<input type="text" placeholder="author/title/contents" id="keyword" name="keyword" class="keyword">
										<input type="submit" value="Search" class="searchBtn">
									</form:form>

									<c:set var="paginationTargetLink" value="/book/kor"/>
								</c:if>

								<c:if test="${board!=null}">
									<form:form action="/bookList" method="GET">
										<input type="text" placeholder="author/title/contents" id="keyword" name="keyword" class="keyword">
										<input type="submit" value="Search" class="searchBtn">
									</form:form>

									<c:set var="paginationTargetLink" value="/bookList"/>
								</c:if>


							</div>
						</div>

						<%@ include file="/WEB-INF/jsp/component/paginationSearch.jsp" %>
					</div>

			</div>


		</div>

	</div>

	<div class="site-section">
		<%@ include file="/WEB-INF/jsp/component/section.jsp" %>
	</div>
</main>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>