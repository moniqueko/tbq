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

<title>로그인</title>

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
           <h2>관리자 페이지</h2><br>
            <div class="container-sm">  
		 		<table class="table table-bordered">
					<tr><td>국내주소 입력</td><td><input type="button" value="이동" onclick="location.href='../address'"></td></tr>
					<tr><td>해외주소 입력</td><td><input type="button" value="이동" onclick="location.href='../addressEng'"></td></tr>
					<tr><td>국내 사업장</td><td><input type="button" value="이동" onclick="location.href='../addressList'"></td></tr>
					<tr><td>국내 사업장(카카오)</td><td><input type="button" value="이동" onclick="location.href='../kakaoList'"></td></tr>
					<tr><td>해외 사업장</td><td><input type="button" value="이동" onclick="location.href='../addressEngList'"></td></tr>
					<tr><td>공시쓰기</td><td><input type="button" value="이동" onclick="location.href='../invest'"></td></tr>
					<tr><td>공시목록</td><td><input type="button" value="이동" onclick="location.href='../listPage'"></td></tr>
					<tr><td>회원목록</td><td><input type="button" value="이동" onclick="location.href='../memberList'"></td></tr>
					<tr><td>미디어목록</td><td><input type="button" value="이동" onclick="location.href='../mediaList'"></td></tr>
					<tr><td colspan="2">
					<input type="button" value="로그아웃" onclick="location.href='../logout'"></td></tr>
				</table>
		

			</div>
		</div>
	</div>
   </div>
</div>


</body>
</html>