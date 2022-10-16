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
	<div class="site-section pb-0 site-portfolio">
		<div class="container">
			<div class="row mb-5 align-items-end">
				<div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
					<h2>Book list</h2>
					<p class="mb-0">Books manage</p>
				</div>
				<div class="col-md-12 col-lg-6 text-left text-lg-right" data-aos="fade-up" data-aos-delay="100">
					<div id="menus" class="menus">
						<a href="/" >Home</a>
						<a href="/boardAdmin" class="active">Board</a>
						<a href="/memberList" >Member</a>
						<c:choose>
							<c:when test="${memberInfo!=null}">
								<a href="/member/${memberInfo.memberUuid}" id="myInfo">My Info</a>
								<a href="/logout">Logout</a>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="row no-gutter" data-aos="fade-up" data-aos-delay="200">
					<div class="container">
						<div class="row justify-content-center text-right mb-4">
							<div class="item web col-md-12">
								<table class="table">
									<thead style="text-align: center;">
										<tr>
											<th scope="col" width="10%">#</th>
											<th scope="col" width="30%">Title</th>
											<th scope="col" width="15%">Id</th>
											<th scope="col" width="5%">Scrap</th>
											<th scope="col" width="5%">Count</th>
											<th scope="col" width="15%">Regi Date</th>
											<th scope="col" width="10%">Modify</th>
											<th scope="col" width="10%">Delete</th>
										</tr>
									</thead>

									<tbody>
										<c:if test="${board!=null}">
											<c:forEach var="book" items="${board}" varStatus="status">
												<tr data-uuid="${book.bookUuid}">
													<th scope="row" style="text-align: center;">${pageMaker.totalCount - (pageMaker.cri.page - 1)  *  10 - status.index}</th>
													<td style="text-align: center;"><a href="/view/${book.bookUuid}">${book.title}</a></td>
													<td style="text-align: center;">${book.memberId}</td>
													<td style="text-align: center;">${book.count}</td>
													<td style="text-align: center;">${book.readNum}</td>
													<td style="text-align: center;"><fmt:formatDate value="${book.regiDate}" pattern="yyyy-MM-dd"/></td>
													<td style="text-align: center;"><a href="/editBook/${book.bookUuid}">Modify</a></td>
													<td style="text-align: center;"><a href="#" onclick="del(this);">Delete</a></td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>

							</div>
						</div>
						<c:if test="${book!=null}">
							<c:set var="paginationTargetLink" value="/boardAdmin"/>
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

<script>
	function del(obj){
		let bookUuid = obj.parentElement.parentElement.dataset.uuid;

		let check = confirm("Delete?");

		if(check==false){
			history.back();
		}

		$.ajax({
			type: "POST",
			url: "/book/delete",
			data: bookUuid,
			dataType: "text",
			contentType : "application/json",
			processData : false,
			success: function(result) {
				alert("Deletion success");

				location.href="/boardAdmin";
			},
			error: function(request, status, error) {
				console.log("ERROR : "+request.status+"\n"+"message"+request.responseText+"\n"+"error:"+error);

				alert("Error occurred");
			}
		});

	}

</script>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>
