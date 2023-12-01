<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dao" class="DAO.LoginDAO"/>
<jsp:useBean id="user" class="utility.userVO"/>
<%	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String username = request.getParameter("username");
	user.setId(id);
	user.setPw(pw);
	user.setUsername(username);
	int result = dao.add(user);
	if (result == 1) {
		response.sendRedirect("login.jsp");
	}
	else {
		response.sendRedirect("register.jsp");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>