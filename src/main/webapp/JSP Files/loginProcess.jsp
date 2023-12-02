<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dao" class="DAO.LoginDAO"/>
<jsp:useBean id="user" class="utility.userVO"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	user = dao.login(id, pw);
	
	if (id.trim().isEmpty()) {
		%>
		<script>
    		alert("아이디를 입력하세요.");
  	   		window.location.href = 'login.jsp';
	 	</script>
		<% 
	}
	else if (pw.trim().isEmpty()) {
		%>
		<script>
    		alert("비밀번호를 입력하세요.");
  	   		window.location.href = 'login.jsp';
	 	</script>
		<% 
	}
	else if (user != null) {
		session.setAttribute("user_id", user.getId());
		session.setAttribute("user_name", user.getUsername());
		
		response.sendRedirect("main.jsp");
	} 
	else {
		// response.sendRedirect("login.jsp");를 밑처럼바꿔서 알람뜨게바꿈
		%>
		<script>
    		alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
  	   		window.location.href = 'login.jsp';
	 	</script>
		<% 
	}
%>
</body>
</html>