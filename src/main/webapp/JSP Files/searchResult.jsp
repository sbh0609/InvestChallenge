<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="gsc" class="DAO.GetstockCode"/>
<%
		request.setCharacterEncoding("UTF-8");
		String searchWord = request.getParameter("searchWord");
	
		//데이터베이스로 검색 수행
		// db db = new db();
		//List<String> searchResults = db.searchInDatabase(searchWord);
	%>

	
	<h2>Search Results for "<%= searchWord %>"</h2>
	<%
	String code = gsc.getStockCode(searchWord);
	%>
	<%=code %>
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
		String sql = "select * from stocklist where `한글 종목약명` like ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "%"+searchWord+"%");
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			String code = rs.getString("단축코드");
			String name = rs.getString("한글 종목약명");
			%>
			<ul>
			<%=code %> <%=name %>
			</ul>
			<%
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
    <ul>
    
    </ul> 
</body>
</html>