<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Welcome, ${memberInfo.memberId} : Admin Page</title>
</head>

<body>
<%@ include file="/WEB-INF/jsp/component/header.jsp" %>
<main id="main">
	<div class="site-section pb-0 site-portfolio">
		<div class="container">
			<div class="row mb-5 align-items-end">
				<div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
					<h2>Admin page</h2>
					<p class="mb-0">Admin page</p>
				</div>
				<div class="col-md-12 col-lg-6 text-left text-lg-right" data-aos="fade-up" data-aos-delay="100">
					<div id="menus" class="menus">
						<a href="/" >Home</a>
						<a href="/boardAdmin" >Board</a>
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

				<div class="row justify-content-center">
					<div class="col-md-4">
						<div class="justify-content-center" style="text-align: center">

							<h2>Hello, ${memberInfo.memberId}</h2><br>
							<div class="container-sm">
								<p><a href="/logout" class="readmore">Logout</a></p>
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

