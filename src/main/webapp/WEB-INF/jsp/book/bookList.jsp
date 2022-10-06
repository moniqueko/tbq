<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>

<html>
<head>
    <title>책 리스트</title>
</head>

<body>
<br><br>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <h2>회원목록</h2>
            <div class="justify-content-center" style="text-align: center">
                <table class="table table-bordered">
                    <tr>
                        <th style="text-align:center;">이미지</th>
                        <th style="text-align:center;">수정</th>
                        <th style="text-align:center;">삭제</th>
                    </tr>
                    <c:forEach var="book" items="${board}" varStatus="status">
                        <tr data-uuid="${book.bookUuid}">
                            <td><img src="/bookImg/${book.bookUuid}" style="width: 300px; height: 300px;"></td>
                            <td style="text-align:center;"><a href="/book/${book.bookUuid}">수정</a></td>
                            <td style="text-align:center;"><a href="#" onclick="del(this)">삭제</a></td>

                        </tr>
                    </c:forEach>
                </table>
            </div>

            <br><br>
            <div class="row justify-content-md-center">
                <div class="text-center">
                    <c:set var="paginationTargetLink" value="/bookList"/>
                    <%@ include file="/WEB-INF/jsp/component/pagination.jsp" %>
                </div>

            </div>
        </div>
    </div>
</div>


    <script>
        function del(obj){

            var uuid = obj.parentElement.parentElement.dataset.uuid;
            var check = confirm("정말 삭제 하시겠습니까?");

            if(check==false){
                location.href="/bookList";
            }

            $.ajax({
                type: "POST",
                url: "/book/delete",
                data: JSON.stringify(uuid),
                dataType: "JSON",
                contentType : "application/json",
                processData : false,
                success: function(result) {
                    alert("회원 삭제 완료");
                    console.log(result);

                    location.href="/bookList";
                },
                error: function(request, status, error) {
                    console.log("ERROR : "+request.status+"\n"+"message"+request.responseText+"\n"+"error:"+error);

                    alert("오류발생");
                }
            });

        }
    </script>

</body>
</html>