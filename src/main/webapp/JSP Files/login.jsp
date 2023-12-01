<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Invest Challenge</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<style>
	  body {
	    font-family: 'Inter', sans-serif;
	  }
	</style>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="bg-white text-gray-800">
  <div class="min-h-screen flex flex-col items-center justify-center">
    <h1 class="text-4xl font-semibold mb-10">Invest Challenge</h1>
    <div class="bg-white shadow-md rounded-lg p-6 w-96">
      <form class="flex flex-col space-y-4" action="loginProcess.jsp" method="post">
        <input class="border rounded px-4 py-2" type="text" placeholder="아이디" name="id">
        <input class="border rounded px-4 py-2" type="password" placeholder="비밀번호" name="pw">
        <input class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600" type="submit" value="로그인">
        <input class="border border-gray-300 px-4 py-2 rounded hover:bg-gray-100" type="button" value="회원가입" onclick="location.href='register.jsp'">
      </form>
    </div>
  </div>
</body>
</html>