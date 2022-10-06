<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="total" value="${pageMaker.totalPage+1}"/>

<c:set var="start" value="${String.format('%s?page=1', paginationTargetLink)}"/>

<c:set var="prevHref" value="${String.format('%s?page=%d', paginationTargetLink, pageMaker.cri.page-1)}"/>

<c:set var="nextHref" value="${String.format('%s?page=%d', paginationTargetLink, pageMaker.cri.page+1)}"/>

<c:set var="end" value="${String.format('%s?page=%d', paginationTargetLink, total)}"/>

<c:set var="prev" value="${1 > pageMaker.cri.page-1 ? '#' : prevHref}"/>

<c:set var="next" value="${total < pageMaker.cri.page+1 ? '#' : nextHref}"/>

<c:if test="${pageMaker != null}">
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <li class="page-item">
                <a class="page-link" href="<c:url value='${start}'/>" aria-label="Start">
                    <%--<span aria-hidden="true"></span>--%>
                        <i class="fa-solid fa-angles-left" style="line-height: 1.5;" aria-hidden="true"></i>
                </a>
            </li>

            <li class="page-item">
                <a class="page-link" href="<c:url value='${prev}'/>" aria-label="Previous">
                    <%--<span aria-hidden="true">prev</span>--%>
                        <i class="fa-solid fa-angle-left" style="line-height: 1.5;" aria-hidden="true"></i>
                </a>
            </li>

            <c:forEach var="idx" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <li class='page-item ${pageMaker.cri.page == idx ? "active" : ""}'>
                    <a class="page-link" href="<c:url value='${paginationTargetLink}?page=${idx}'/>">${idx}</a>
                </li>
            </c:forEach>

            <li class="page-item">
                <a class="page-link" href="<c:url value='${next}'/>" aria-label="Next">
                    <%--<span aria-hidden="true">next</span>--%>
                        <i class="fa-solid fa-angle-right" style="line-height: 1.5;" aria-hidden="true"></i>
                </a>
            </li>

            <li class="page-item">
                <a class="page-link" href="<c:url value='${end}'/>" aria-label="End">
                    <%--<span aria-hidden="true">»</span>--%>
                        <i class="fa-solid fa-angles-right" style="line-height: 1.5;" aria-hidden="true"></i>
                </a>
            </li>
        </ul>
    </nav>
</c:if>