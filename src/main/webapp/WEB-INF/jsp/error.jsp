<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Error</title>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>

<body>
<%@ include file="/WEB-INF/jsp/component/header.jsp" %>
<main id="main">
	<div class="site-section pb-0 site-portfolio">
		<div class="container">
			<div class="row mb-5 align-items-end">
				<div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
					<h2>Access denied</h2>
					<p class="mb-0">Access denied</p>
				</div>
			</div>

			<div class="row justify-content-center">
				<div class="col-md-4">
					<div class="justify-content-center" style="text-align: center">
						<h4>Can not load this page.</h4>
						<br>
						<i class="material-icons" style="font-size:120px">error_outline</i>
						<br><br><br>
						Access denied.
						<br><br>
						<a href="#" class="readmore" onclick="javascript:history.back()">go back</a>
						<br><br>
					</div>
				</div>
			</div>

		</div>

			</div>

		</div>

	</div>
</main>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>
