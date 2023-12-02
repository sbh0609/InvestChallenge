<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dao" class="DAO.LoginDAO"/>
<jsp:useBean id="user" class="utility.userVO"/>
<%	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String username = request.getParameter("username");
	user.setId(id);
	user.setPw(pw);
	user.setUsername(username);
	int result = dao.add(user);
	if (result == 1) {
%>
	<script>
        alert("회원가입이 완료되었습니다.");
      	window.location.href = 'login.jsp';
   	</script>
<%
	}
	else if (result == -1) {		
%>
	<script>
		alert("이미 존재하는 아이디입니다.");
	    window.location.href = 'register.jsp';
	</script>
<%
	}
	else if (result == -2) {
%>
	<script>
		alert("아이디, 비밀번호, 이름을 정확하게 입력하세요.");
	    window.location.href = 'register.jsp';
	</script>
<%
		
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