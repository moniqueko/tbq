<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Book List</title>

	<style>
		canvas{
			background-image: url("/bookImg/${book.bookUuid}");
			background-position: center;
			background-size: 100% 100%;
			object-fit: cover;
		}
	</style>
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
						<a href="/" id="home">Home</a>
						<a href="/bookList" id="bookList" class="active">Book List</a>
						<a href="/myBook" id="myBook">My book</a>
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

			<div class="site-section pb-0">
				<div class="container">
					<div class="row align-items-stretch">
						<div class="col-md-7" data-aos="fade-up">
							<c:if test="${memberInfo==null}">
								<img src="/bookImg/${book.bookUuid}" alt="Image" class="img-fluid">
							</c:if>

							<c:if test="${memberInfo!=null}">
								<canvas id="canvas" name="canvas" class="img-fluid" width="600" height="700"></canvas><br>
								* (Member only) You can highlight on the image and download it!
							</c:if>
						</div>
						<div class="col-md-4 ml-auto" data-aos="fade-up" data-aos-delay="100">
							<div class="sticky-content">
								<h3 class="h3">${book.title}</h3>
								<p class="mb-4"><span class="text-muted">Author : ${book.writer}</span></p>

								<div class="mb-5">
									<p>${book.contents}</p>
								</div>

									<h4 class="h4 mb-3"></h4>
									<ul class="list-unstyled list-line mb-5">
										<c:if test="${book.quotes!=null}"> <li>${book.quotes1}</li></c:if>
										<c:if test="${book.quotes2!=null}">	<li>${book.quotes2}</li></c:if>
										<c:if test="${book.quotes3!=null}">	<li>${book.quotes3}</li></c:if>
									</ul>
								<c:if test="${memberInfo!=null}">
									<p><a href="#" class="readmore" id="down" onclick="DownloadCanvasAsImage();"><span>Highlight Save</span></a></p>
									<p><a href="#" class="readmore" onclick="addScrap();"><span id="count">Scrap (${book.count})</span></a></p>
									<p><a href="#" class="readmore" onclick="kakaoShare();"><span>Share</span></a></p>
								</c:if>

								<c:if test="${book.memberUuid==memberInfo.memberUuid}">
									<p><a href="/editBook/${book.bookUuid}" class="readmore">Edit</a></p>
									<p><a href="#" class="readmore" onclick="del();">Delete</a></p>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>

			<c:if test="${memberInfo!=null}">
				<div class="site-section pb-0">
					<div class="container">
						<div class="row justify-content-center text-left mb-4">
							<div class="col-md-12 form-group">
								<label for="contents">
									<h3 class="h3">Comment</h3><br>
									<h3 class="h3">-</h3>
								</label><br>

								<!--Comment section-->
								<c:if test="${cmt!=null}">
									<c:forEach var="cmt" items="${cmt}" varStatus="status">
										<div class="col-md-12 form-group" data-uuid="${cmt.cmtUuid}">
											<div class="col-md-10 form-group">${cmt.memberId} | <fmt:formatDate value="${cmt.cmtRegiDate}" pattern="yyyy-MM-dd"/></div>
											<div class="col-md-10 form-group">${cmt.contents} | <a href="#" onclick="cmtDelete(this);">[X]</a></div>

										</div>
									</c:forEach>
								</c:if>

								<textarea class="form-control" name="contents" id="contents" cols="1" rows="1"></textarea>
								<div class="validate"></div>
								<br>
								<a href="#" class="readmore" onclick="cmtWrite();">Write</a>
							</div>

						</div>
					</div>
				</div>
			</c:if>

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
								<a href="/view/${board.bookUuid}" class="item-wrap fancybox">
									<div class="work-info">
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
	</div>

</main>
<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script>
	$(document).ready(function(){
		var canvas = document.querySelector('canvas'),
				c = canvas.getContext('2d');
				c.globalAlpha = 1;
				c.fillStyle = "rgba(255, 255, 0, 0.04)";

		var background = new Image(600, 700);
		background.src = "/bookImg/${book.bookUuid}";

		background.onload = function(){
			c.drawImage(background,0,0,600,700);
		}

		let isDrawing = false;

		function draw(x, y) {

			if (isDrawing) {
				c.beginPath();
				c.arc(x, y, 10, 0, Math.PI*2);
				c.closePath();
				c.fill();

				c.globalCompositeOperation="source-over";
			}
		}

			canvas.addEventListener('mousemove', event =>
					draw(event.offsetX, event.offsetY)
			);
			canvas.addEventListener('mousedown', () => isDrawing = true);
			canvas.addEventListener('mouseup', () => isDrawing = false);

			// document.querySelector('a').addEventListener('click', event =>
			// 		event.target.href = canvas.toDataURL()
			// );

	});

	function DownloadCanvasAsImage(){
		let downloadLink = document.createElement('a');
		downloadLink.setAttribute('download', 'TheBookQuotes.png');
		let canvas = document.getElementById('canvas');
		canvas.toBlob(function(blob) {
			let url = URL.createObjectURL(blob);
			downloadLink.setAttribute('href', url);
			downloadLink.click();
		});
	}


	function del(){
		const bookUuid = '${book.bookUuid}';
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

				location.href="/bookList";
			},
			error: function(request, status, error) {
				console.log("ERROR : "+request.status+"\n"+"message"+request.responseText+"\n"+"error:"+error);

				alert("Error occurred");
			}
		});

	}

	function cmtWrite(){
		const contents = document.getElementById("contents").value;
		const bookUuid = '${book.bookUuid}';

		const data = {
			"bookUuid" : bookUuid,
			"contents" : contents
		};

		$.ajax({
			type: "POST",
			url: "/cmtWrite",
			data: JSON.stringify(data),
			dataType: "JSON",
			contentType : "application/json",
			processData : false,
			success: function(result) {
				location.href="/view/" + bookUuid;
			},
			error: function(request, status, error) {
				console.log("ERROR : "+request.status+"\n"+"message"+request.responseText+"\n"+"error:"+error);

				alert("Error occurred");
			}
		});

	}

	function cmtDelete(obj){
		let cmtUuid = obj.parentElement.parentElement.dataset.uuid;

		const bookUuid = '${book.bookUuid}';

		let check = confirm("Delete?");

		if(check==false){
			return false;
		}

		$.ajax({
			type: "POST",
			url: "/cmtDelete",
			data: cmtUuid,
			dataType: "JSON",
			contentType : "application/json",
			processData : false,
			success: function(result) {

				if(result.status==401){
					alert("Only writer of this comment can delete");
					return false;
				}
				if(result.status==200){
					alert("Deletion success");
					location.href="/view/"+ bookUuid;
				}

			},
			error: function(request, status, error) {
				console.log("ERROR : "+request.status+"\n"+"message"+request.responseText+"\n"+"error:"+error);

				alert("Error occurred");
			}
		});

	}

	function addScrap(){
		const bookUuid = '${book.bookUuid}';
		const span = document.getElementById("count");

		$.ajax({
			type: "POST",
			url: "/addScrap",
			data: bookUuid,
			dataType: "JSON",
			contentType : "application/json",
			processData : false,
			success: function(result) { //저장 성공시에 일반 스크랩된 수 돌려줌

				if(result.status==406){
					alert("Already registered");
					return false;
				}
				span.innerHTML="Scrap (" + result.data + ")";

			},
			error: function(request, status, error) {
				console.log("ERROR : "+request.status+"\n"+"message"+request.responseText+"\n"+"error:"+error);

				alert("Error occurred");
			}
		});

	}

	if (!Kakao.isInitialized()) {
		Kakao.init('3ca30286ce62eef499d71954c63154fc');
	}

	function kakaoShare() {
		Kakao.Link.sendDefault({
			objectType: 'feed',
			content: {
				title: '${book.title}',
				description: '${book.contents}',
				imageUrl: 'https://ifh.cc/g/4hsayZ.jpg',
				link: {
					mobileWebUrl: 'http://localhost:8080/view/${book.bookUuid}',
					webUrl: 'http://localhost:8080/view/${book.bookUuid}',
				},
			},
			buttons: [
				{
					title: '웹으로 보기',
					link: {
						mobileWebUrl: 'http://localhost:8080/view/${book.bookUuid}',
						webUrl: 'http://localhost:8080/view/${book.bookUuid}',
					},
				},
			],
			installTalk: true,
		})
	}

</script>

</body>
</html>