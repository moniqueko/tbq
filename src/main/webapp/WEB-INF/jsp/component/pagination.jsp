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
                <a href="<c:url value='${start}'/>" aria-label="Start"> <<&nbsp;</a>
            </li>

            <li class="page-item">
                <a href="<c:url value='${prev}'/>" aria-label="Previous"> <&nbsp;</a>
            </li>

            <c:forEach var="idx" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <li>
                    <a href="<c:url value='${paginationTargetLink}?page=${idx}'/>">&nbsp;${idx}&nbsp;</a>
                </li>
            </c:forEach>

            <li>
                <a href="<c:url value='${next}'/>" aria-label="Next">&nbsp;> </a>
            </li>

            <li class="page-item">
                <a href="<c:url value='${end}'/>" aria-label="End">&nbsp;>> </a>
            </li>
        </ul>
    </nav>
</c:if>