<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="utility.ConnectDb" %>
<%
	String id = (String)session.getAttribute("user_id");
	String name = (String)session.getAttribute("user_name");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<h2>Invest Challenge</h2>
<hr>
<%	if (id != null) {
	%>
	<%=id %>(<%=name %>)님 환영합니다.
<%}
	else {
	%>
	비로그인 상태입니다.
<%}
%>
<br>
<%=id %>(<%=name %>)
<br><br>
<input type="button" value="로그인" onclick="location.href='login.jsp'">
</div>
<form method="post" action="searchResult.jsp">
		<div class="search">
			<input type="text" class="form-control puu-right" placeholder="주식을 검색하세요." name="searchWord" />
		</div>
	
		<button class="btn btn-primary" type="submit">
			<span class="glyphicon glyphicon-search"></span>
		</button>
	
	</form>
</body>
</html>