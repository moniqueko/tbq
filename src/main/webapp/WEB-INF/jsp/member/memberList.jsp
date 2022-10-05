<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>

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

<title>회원목록</title>

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
        <div class="col-md-10">
        <h2>회원목록</h2>
	        <div class="justify-content-center" style="text-align: center">
				<table class="table table-bordered">
					<tr>
						<th style="text-align:center;">회원아이디</th>
						<th style="text-align:center;">가입일</th>
						<th style="text-align:center;">마지막로그인</th>
						<th style="text-align:center;">회원타입</th>
						<th style="text-align:center;">수정</th>
						<th style="text-align:center;">삭제</th>
					</tr>
					<c:forEach var="member" items="${member}" varStatus="status">
						<tr data-uuid="${member.memberUuid}">
							<td>${member.memberId}</td>
							<td>${member.memberRegiDate}</td>
							<td>${member.memberLastLogin}</td>
							
								<c:if test="${member.memberGrant==0}">
									<td>관리자</td>
								</c:if>
									<c:if test="${member.memberGrant==1}">
									<td>일반회원</td>
								</c:if>
							
							<td style="text-align:center;"><a href="/member/edit/${member.memberUuid}">수정</a></td>
							<td style="text-align:center;"><a href="#" onclick="del(this)">삭제</a></td>
					
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<br><br>
				<div class="row justify-content-md-center">
					<div class="text-center">
						<ul class="pagination">
							<!-- 이전prev -->
							<c:if test="${pm.prev }">
								<li><a href="memberList?page=${pm.startPage-1}">[&laquo;]</a></li>
							</c:if>
							<!-- 페이지블럭 -->
						<c:forEach var="idx" begin="${pm.startPage }" end="${pm.endPage }">
							<!-- 삼항연산자를 사용해서 class로 스타일적용  -->
				 			<li ${pm.cri.page == idx? 'class=active':''}>
				 				<a href="memberList?page=${idx }">[&nbsp;${idx}&nbsp;]&nbsp;&nbsp;</a>
				 			</li>				
						</c:forEach>
							<!-- 다음next -->
							<c:if test="${pm.next && pm.endPage > 0}">
								<li><a href="memberList?page=${pm.endPage+1}">[&raquo;]</a></li>
							</c:if>
						</ul>
					</div>
			
		</div>
	</div>
</div>



<script>
function del(obj){
	
	//uuid만 서버에 보내서 inuse상태 변경
	var uuid = obj.parentElement.parentElement.dataset.uuid;

	var check = confirm("정말 삭제 하시겠습니까?");
	
	if(check==false){
		location.href="/memberList";   
	}
	
	$.ajax({
		type: "POST",
        url: "/member/del", 
        data: JSON.stringify(uuid),
        dataType: "JSON",
        contentType : "application/json",
        processData : false,
        success: function(result) {
        	
        	if(result.code==200){
        		alert("회원 삭제 완료");
        		console.log(result.message);
        		location.href="/memberList";       
        		
        	}else if(result.code==410){
        		console.log(result.message);
        		
        	}else if(result.code==409){
        		console.log(result.message);

        	        }
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