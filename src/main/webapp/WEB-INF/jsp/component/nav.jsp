<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row mb-5 align-items-end">
    <div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
        <h2>Are you a bookaholic?</h2>
        <p class="mb-0">Share your quotes from your favorite books! Upload images of quotes, that is all!</p>
    </div>
    <div class="col-md-12 col-lg-6 text-left text-lg-right" data-aos="fade-up" data-aos-delay="100">
        <div id="menus" class="menus">
            <a href="/" id="home">Home</a>
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