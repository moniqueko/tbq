<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


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

    <title>회원가입</title>

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

            <div class="justify-content-center" style="text-align: center">
                <h2>회원가입</h2><br>
                <div class="container-sm" id="tb">

                    <form:form name="memberForm" id="memberForm">
                        <table class="table table-bordered">

                            <tr><td>아이디</td><td><input type="text" style="width:200px;" id="memberId"  name="memberId" oninput="idcheck()"/>
                                <div id="idcheck"></div>
                            </td></tr>
                            <tr><td>이메일</td><td><input type="text" style="width:200px;" id="memberEmail"  name="memberEmail" oninput="emailCheck()"/>
                                <div id="msg"></div></td></tr>
                            <tr><td>비밀번호</td><td><input type="password"  style="width:200px;" id="memberPw"  name="memberPw" onkeyup="enterkey()"/></td></tr>
                            <tr><td>회원타입</td><td><input type="radio" name="memberGrant" value="0"/>관리자
                                <input type="radio" name="memberGrant" value="1"/>일반회원</td></tr>
                            <tr><td colspan="2">
                                <input type="button" value="회원가입"  onclick="validation()"></td></tr>

                        </table>

                    </form:form>
                </div>
            </div>
        </div>

    </div>

</div>



<script>

    function validation() { //이메일 정규식 추가

        var idcheck = document.forms["memberForm"]["memberId"].value;
        var pwcheck = document.forms["memberForm"]["memberPw"].value;
        var emailcheck = document.forms["memberForm"]["memberEmail"].value;
        var memberGrant = document.forms["memberForm"]["memberGrant"].value;


        var regExp = /^[A-Za-z]{1}[A-Za-z0-9_-]{3,11}$/; //아이디 정규식
        var pwExp = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/; //비밀번호 정규식
        var emailregExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 정규식


        var tb = document.getElementById('tb');
        var msg = document.getElementById('msg');


        if (idcheck == null || idcheck == "") {

            msg.innerHTML = "아이디가 입력되지 않았습니다.";
            tb.append(msg);

            return false;

        } else if (pwcheck == null || pwcheck == "") {

            msg.innerHTML = "비밀번호가 입력되지 않았습니다";
            tb.append(msg);

            return false;

        } else if (memberGrant == null || memberGrant == "") {

            msg.innerHTML = "회원타입을 선택해 주세요";
            tb.append(msg);

            return false;

        } else if(!regExp.test(idcheck)) {

            alert('아이디 첫글자는 영문이어야하며 4~12자의 영문 대소문자와 숫자,하이픈,언더바 사용가능')
            return false;

        } else if(!pwExp.test(pwcheck)) {

            alert('비밀번호는 영문/숫자/특수문자(!@#$%^&*)를 포함하여 8~16자로 입력해야합니다.')
            return false;

        } else if(!emailregExp.test(emailcheck)) {

            alert('이메일 형식이 맞지 않습니다.')
            return false;

        } else{

            $.ajax({
                url: "/emailDupl",
                type: "POST",
                data: JSON.stringify(emailcheck),
                dataType: "JSON",
                contentType: "application/json",
                accept: "application/json",
                success: function(result) {

                    if(result.data ==1){
                        alert("이메일 중복입니다. 다른 이메일을 입력해주세요.");

                    }else if(result.data ==0){ //이메일 통과

                        $.ajax({
                            url: "/idCheck",
                            type: "POST",
                            data: JSON.stringify(idcheck),
                            dataType: "JSON",
                            contentType: "application/json",
                            accept: "application/json",
                            success: function(result) {

                                if(result.data ==1){// 아이디 중복
                                    alert("아이디 중복입니다. 다른 아이디를 입력해주세요.");

                                }else if(result.data ==0){
                                    signin();//******모두 통과하면 실행
                                }


                            },
                            error: function(result) {

                                console.log(result.responseText); //responseText의 에러메세지 확인
                            }
                        });


                    }

                },
                error: function(result) {

                    console.log(result.responseText); //responseText의 에러메세지 확인
                }
            });



        }
    }

    function enterkey() {
        if (window.event.keyCode == 13) {
            validation();
        }
    }

    function idcheck(){ //아이디 입력시

        var memberId = document.forms["memberForm"]["memberId"].value;

        $.ajax({
            url: "/idCheck",
            type: "POST",
            data: JSON.stringify(memberId),
            dataType: "JSON",
            contentType: "application/json",
            accept: "application/json",
            success: function(result) {
                console.log(result.data);
                console.log(result);

                if(result.data ==1){// 아이디 중복
                    document.getElementById("idcheck").innerHTML = "<span style='color: red;'>아이디 중복</span>";


                }else if(result.data ==0){
                    document.getElementById("idcheck").innerHTML = "<span style='color: green;'>사용가능한 아이디</span>";
                }


            },
            error: function(result) {

                console.log(result.responseText); //responseText의 에러메세지 확인
            }
        });
    }

    function emailCheck(){
        var memberEmail = document.forms["memberForm"]["memberEmail"].value;

        $.ajax({
            url: "/emailDupl",
            type: "POST",
            data: JSON.stringify(memberEmail),
            dataType: "JSON",
            contentType: "application/json",
            accept: "application/json",
            success: function(result) {

                if(result.data ==1){
                    document.getElementById("msg").innerHTML = "<span style='color: red;'>이메일 중복</span>";

                }else if(result.data ==0){
                    document.getElementById("msg").innerHTML = "<span style='color: green;'>사용가능한 이메일</span>";

                }else if(memberId==null|| memberId==''){
                    document.getElementById("msg").innerHTML = "<span style='color: green;'>이메일을 입력해주세요</span>";
                }

            },
            error: function(result) {

                console.log(result.responseText); //responseText의 에러메세지 확인
            }
        });
    }



    function signin(){

        let memberId = document.forms["memberForm"]["memberId"].value;
        let memberPw = document.forms["memberForm"]["memberPw"].value;
        let memberEmail = document.forms["memberForm"]["memberEmail"].value;

        //라디오 버튼 값 가져오기
        let checked = document.getElementsByName('memberGrant');
        let radiocheck = Array.from(checked).find(radio => radio.checked);
        let memberGrant = radiocheck.value;


        var data = {
            'memberId' : memberId,
            'memberPw' : memberPw,
            'memberEmail' : memberEmail,
            'memberGrant' : memberGrant
        };

        $.ajax({
            url: "/signin",  //회원가입완료
            type: "POST",
            data: JSON.stringify(data),
            dataType: "JSON",
            contentType: "application/json",
            accept: "application/json",
            success: function(result) {
                console.log(result.data);
                console.log("전송/저장 성공");

                alert('회원가입이 완료되었습니다. 다시 로그인해 주세요');

                location.href="/login";

            },
            error: function(result) {
                console.log(result.data);
                alert('회원가입 실패. 다시 시도해 주세요');
                console.log(result.responseText); //responseText의 에러메세지 확인
            }
        });

    }

</script>

</body>
</html>