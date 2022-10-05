<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page isELIgnored="false" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <title>비밀번호 찾기</title>

    <style>
        body{font-family: 'Noto Sans KR', sans-serif;}
        h2{text-align: left;}

        a:link {color: black;}
        a:visited {color: black;}
        a:hover {color: black; text-decoration: none;}
        a:active {color: black;}

    </style>
</head>

<body>
<br><br>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <h2>비밀번호 찾기</h2>
            <div class="justify-content-center" style="text-align: center">
                <form:form action="/findPw" name="memberEditForm" id="memberEditForm" method="POST">
                    <table class="table table-bordered">
                        <tr>
                            <td style="text-align:center;">아이디</td>
                            <td><input type="text" name="memberId" id="memberId"></td>
                        </tr>
                        <tr>
                            <td style="text-align:center;">이메일</td>
                            <td><input type="text" name="memberEmail" id="memberEmail" oninput="emailCheck()" onkeyup="enterkey()"><div id="emailCheck"></div></td>
                        </tr>

                        <tr>
                            <td colspan="2"><input type="submit" value="비밀번호 찾기"></td>
                        </tr>

                    </table>
                </form:form>

            </div>
        </div>
    </div>
</div>

<script>
    function enterkey() {
        if (window.event.keyCode == 13) {

            memberEditForm.submit();

        }
    }

    function emailCheck(){ //아이디 입력시

        var memberId = document.forms["memberEditForm"]["memberId"].value;
        var memberEmail = document.forms["memberEditForm"]["memberEmail"].value;
        var data = {
            'memberId': memberId,
            'memberEmail' : memberEmail
        };

        $.ajax({
            url: "/emailCheck",
            type: "POST",
            data: JSON.stringify(data),
            dataType: "JSON",
            contentType: "application/json",
            accept: "application/json",
            success: function(result) {

                if(result.data ==0){
                    document.getElementById("emailCheck").innerHTML = "<span style='color: red;'>아이디와 이메일이 일치하지 않습니다.</span>";

                }else if(result.data ==1){
                    document.getElementById("emailCheck").innerHTML = "<span style='color: green;'>아이디와 이메일이 일치 합니다.</span>";

                }else if(memberId==null|| memberId==''){
                    document.getElementById("emailCheck").innerHTML = "<span style='color: green;'>아이디를 입력해주세요</span>";
                }


            },
            error: function(result) {

                console.log(result.responseText); //responseText의 에러메세지 확인
            }
        });
    }

</script>
</body>
</html>