<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>
<c:set var="isUpdate" value="${board!=null}"/>
<html>
<head>
    <title></title>
</head>
<body>
    <form:form enctype="multipart/form-data" id="bookWriteForm">
        <table class="table table-bordered">
            <colgroup>
                <col style="width:20%">
                <col style="width:auto">
            </colgroup>
            <tbody>
                <tr>
                    <th class="table-light align-middle">책 제목</th>
                    <td>
                        <input type="text" class="form-control" id="title"
                               name="title" value="${board.title}">
                    </td>
                </tr>
                <tr>
                    <th class="table-light align-middle">저자</th>
                    <td>
                        <input type="text" class="form-control" id="writer"
                               name="writer" value="${board.writer}">
                    </td>
                </tr>

                <tr>
                    <th class="table-light">이미지 업로드</th>
                    <td>
                        <div>
                            <input class="form-control" type="file"
                                   id="bookImg" name="bookImg" accept=".jpg, .png">
                        </div>
                        <c:if test="${board.img != null && board.img != ''}">
                            <div>
                                <img src="/bookImg/${board.bookUuid}" style="width:50px; height: 50px;">
                            </div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th class="table-light">메모</th>
                    <td>
                        <textarea class="form-control" rows="5" id="contents"
                                  name="contents">${board.contents}</textarea>
                    </td>
                </tr>
            </tbody>
        </table>
    </form:form>

    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
        <button class="btn btn-secondary btn-lg me-md-2" type="button"
                onclick="location.href='/bookList'">취소
        </button>
        <button class="btn btn-primary btn-lg" type="button"
                onclick="${isUpdate ? 'validationEdit();': 'validation();'}">등록
        </button>
    </div>

            </main>

            <jsp:include page="/WEB-INF/jsp/component/footer.jsp"/>
        </div>
    </div>


    <script>
        function validation() {
            const title = document.getElementById("title");
            const img = document.getElementById("bookImg");
            const contents = document.getElementById("contents");
            const writer = document.getElementById("writer");

            if (!title.value) {
                alert('제목을 입력해주세요');
                title.focus();
                return false;
            }

            if (!img.value) {
                alert('이미지를 첨부해주세요');
                return false;
            }

            if (!contents.value) {
                alert('텍스트를 입력해주세요');
                contents.focus();
                return false;
            }

            if (!writer.value) {
                alert('작가를 입력해주세요');
                return false;
            }
             submit();

        }

        function submit() {
            const memberUuid = '${memberInfo.memberId}';
            const form = $('#bookWriteForm')[0];
            const data = new FormData(form);

            data.append("memberUuid", memberUuid);

            $.ajax({
                type: "POST",
                url: "/addBook",
                data: data,
                dataType: "JSON",
                contentType: false,
                processData: false,
                success: function (result) {
                        document.location = "/bookList";
                },
                error: function (error) {
                    alert("에러발생");
                }
            });
        }

        function submitEdit() {
            const bookUuid = '${board.bookUuid}';
            const form = $('#bookWriteForm')[0];
            const data = new FormData(form);

            $.ajax({
                type: "POST",
                url: "/addBook/" + bookUuid,
                data: data,
                dataType: "JSON",
                contentType: false,
                processData: false,
                success: function (result) {
                    document.location = "/bookList";
                },
                error: function (error) {
                    alert("에러발생");
                }
            });
        }

    </script>
</body>
</html>
