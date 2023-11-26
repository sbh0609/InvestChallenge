<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<div align="center">
<h2>회원가입</h2>
<hr>
<form action="registerProcess.jsp" method="post">
아이디 : <input type="text" name="id"><br>
비밀번호 : <input type="password" name="pw"><br>
이름 : <input type="text" name="username"><br>
<input type="submit" value="가입">
</form>
</div>
</body>
</html>