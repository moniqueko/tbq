<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>The Book Quotes</title>
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
                        <a href="/" id="home" class="active">Home</a>
                        <a href="/bookList" id="bookList">Book List</a>
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

            <div id="portfolio-grid" class="row no-gutter" data-aos="fade-up" data-aos-delay="200">
                <c:forEach var="book" items="${board}" varStatus="status" end="8">
                    <div class="item web col-sm-6 col-md-4 col-lg-4 mb-4">
                        <a href="/view/${book.bookUuid}" class="item-wrap fancybox">
                            <div class="work-info" data-uuid="${book.bookUuid}">
                                <h3>${book.title}</h3>
                                <span>${book.writer}</span>
                            </div>
                            <img class="img-fluid" src="/bookImg/${book.bookUuid}">
                        </a>
                    </div>
                </c:forEach>

            </div>
        </div>

    </div>

    <div class="site-section">
        <%@ include file="/WEB-INF/jsp/component/section.jsp" %>
    </div>

</main>

<%@ include file="/WEB-INF/jsp/component/footer.jsp" %>

</body>

</html>