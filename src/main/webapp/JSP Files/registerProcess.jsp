<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="udao" class="utility.ConnectDb"/>
<jsp:useBean id="user" class="utility.userVO"/>
<%	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String username = request.getParameter("username");
	user.setId(id);
	user.setPw(pw);
	user.setUsername(username);
	int result = udao.add(user);
	if (result == 1) {
		response.sendRedirect("login.jsp");
	}
	else {
		response.sendRedirect("register.jsp");
	}
%>
<%--
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/investchallenge?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
	
	try {
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url, "root", "passwd");
		String sql = "insert into user values (?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		pstmt.setString(2, request.getParameter("pw"));
		pstmt.setString(3, request.getParameter("username"));
		
		int result = pstmt.executeUpdate();
		
		if (result == 1) {
			response.sendRedirect("login.jsp");
		}
		else {
			response.sendRedirect("register.jsp");
		}
	}
	
	catch (Exception e) {
		e.printStackTrace();
	}
	
	finally {
		if (conn != null) conn.close();
		if (pstmt != null) pstmt.close();
	}
%>
--%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>