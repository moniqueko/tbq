<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>${memberInfo.memberId}'s Book List</title>

	<style>
	.li {
		float: left;
		margin: 15px;
	}
	.word {
		display: block;
		width: 340px;
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
	</style>
</head>

<body>
<%@ include file="/WEB-INF/jsp/component/header.jsp" %>
<main id="main">
	<div class="site-section pb-0 site-portfolio">
		<div class="container">
			<div class="row mb-5 align-items-end">
				<div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
					<h2><c:if test="${scrap!=null}">Scrap Books</c:if>
						<c:if test="${board!=null}">My Books</c:if></h2>
					<p class="mb-0">You can check your books and scraped items.</p>
				</div>
				<div class="col-md-12 col-lg-6 text-left text-lg-right" data-aos="fade-up" data-aos-delay="100">
					<div id="menus" class="menus">
						<a href="/" >Home</a>
						<a href="/bookList">Book List</a>
						<a href="/myBook" class="active">My book</a>
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
						<div class="row justify-content-center text-right mb-4">

							<div class="item web col-md-12">
								<ul>
									<li class="li"><a href="/myBook">My Books</a></li>
									<li class="li"><a href="/scrapBook">Scrap Books</a></li>
								</ul>

								<table class="table">
									<c:if test="${board!=null}">
										<thead style="text-align: center;">
										<tr>
											<th scope="col" width="5%">#</th>
											<th scope="col" width="45%">Title</th>
											<th scope="col" width="20%" style="text-align: center;">Author</th>
											<th scope="col" width="40%">Quotes</th>
										</tr>
										</thead>

										<tbody>
											<c:forEach var="book" items="${board}" varStatus="status">
												<tr>
													<th scope="row">${pageMaker.totalCount - (pageMaker.cri.page - 1)  *  10 - status.index}</th>
													<td class="title"><a href="/view/${book.bookUuid}">${book.title}</a></td>
													<td style="text-align: center;">${book.writer}</td>
													<td class="word">${book.quotes}</td>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>

									<c:if test="${scrap!=null}">
										<thead style="text-align: center;">
										<tr>
											<th scope="col" width="5%">#</th>
											<th scope="col" width="45%">Title</th>
											<th scope="col" width="20%" style="text-align: center;">Author</th>
											<th scope="col" width="15%" style="text-align: center;">Scrap Date</th>
											<th scope="col" width="15%" style="text-align: center;">Scrap count</th>
										</tr>
										</thead>

										<tbody>
											<c:forEach var="book" items="${scrap}" varStatus="status">
												<tr>
													<th scope="row">${pageMaker.totalCount - (pageMaker.cri.page - 1)  *  10 - status.index}</th>
													<td class="title" style="text-align: center;"><a href="/view/${book.bookUuid}">${book.title}</a></td>
													<td style="text-align: center;">${book.writer}</td>
													<td style="text-align: center;"><fmt:formatDate value="${book.regiDate}" pattern="YY-MM-dd"/></td>
													<td style="text-align: center;">${book.count}</td>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>
								</table>
								<p><a href="/book" class="readmore">Write</a></p>
							</div>
						</div>

						<c:if test="${scrap!=null}">
							<c:set var="paginationTargetLink" value="/scrapBook"/>
						</c:if>

						<c:if test="${board!=null}">
							<c:set var="paginationTargetLink" value="/myBook"/>
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
