<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    session.invalidate();
	// response.sendRedirect("main.jsp"); 을 밑처럼 바꿔서 알람뜨게 바꿈 
	%>
	<script>
		alert("로그아웃 되었습니다.");
 		window.location.href = 'main.jsp';
	</script>
	<% 
%>
</body>
</html>