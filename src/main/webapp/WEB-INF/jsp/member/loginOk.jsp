<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/component/head.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반회원 로그인 성공</title>
</head>

<body>
<br><br>
<div class="container">
   <div class="row justify-content-center">
     <div class="col-md-4">
        
        <div class="justify-content-center" style="text-align: center">
           <h2>일반회원 로그인</h2><br>
            <div class="container-sm">  
		 	${memberInfo.memberId}님 로그인 성공<br><br>

		 		<table class="table table-bordered">
					<tr><td>국내 사업장</td><td><input type="button" value="이동" onclick="location.href='../addressList'"></td></tr>
					<tr><td>국내 사업장(카카오)</td><td><input type="button" value="이동" onclick="location.href='../kakaoList'"></td></tr>
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