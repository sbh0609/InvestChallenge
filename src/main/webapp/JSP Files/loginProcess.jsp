<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dao" class="DAO.LoginDAO"/>
<jsp:useBean id="user" class="utility.userVO"/>
<%--
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/investchallenge?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
	
	try {
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url, "root", "passwd");
		String sql = "select * from user where id = ? and pw = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		pstmt.setString(2, request.getParameter("pw"));
		
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			String id = rs.getString("id");
			String name = rs.getString("username");
			
			session.setAttribute("user_id", id);
			session.setAttribute("user_name", name);
			
			response.sendRedirect("main.jsp");
		}
		
		else {
			out.println("로그인 실패");
			response.sendRedirect("login.jsp");
		}
	}
	
	catch(Exception e) {
		e.printStackTrace();
	}
	
	finally {
		if (conn != null) conn.close();
		if (pstmt != null) pstmt.close();
		if (rs != null) rs.close();
	}
	%>
--%>
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
		session.setAttribute("user_id", user.getId());
		session.setAttribute("user_name", user.getUsername());
		
		response.sendRedirect("main.jsp");
	}
	
	else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>