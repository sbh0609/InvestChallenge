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
	
	if (user != null) {
		session.setAttribute("user_id", user.getUserId());
		session.setAttribute("user_name", user.getUserName());
		
		response.sendRedirect("main.jsp");
	}
	
	else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>