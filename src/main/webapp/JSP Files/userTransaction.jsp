<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utility.TransactionVO" %>
<%
	String id = (String)session.getAttribute("user_id");
	String name = (String)session.getAttribute("user_name");
%>
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
<body>
<div class="container mx-auto p-4">
        <div class="flex justify-between items-center mb-6">
            <a href="http://localhost:8080/investChallenge/JSP%20Files/main.jsp">
            	<h1 class="text-3xl font-bold">Invest Challenge</h1>
            </a>
            <div class="flex space-x-4">
            	<form method="post" action="searchResult.jsp">
					<div class="search">
						<input class="px-4 py-2 border rounded" type="text" class="form-control puu-right" placeholder="주식을 검색하세요." name="searchWord" />
					</div>
				</form>
                <%	if (id != null) {
					%>
					<div class="px-4 py-2 rounded"><%=id %>(<%=name %>)님 환영합니다.</div>
					<input class="px-4 py-2 bg-blue-400 text-white rounded hover:bg-blue-300" type="button" value="로그아웃" onclick="location.href='logoutProcess.jsp'">
				<%}
					else {
					%>
					<input class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600" type="button" value="로그인" onclick="location.href='login.jsp'">
				<%}
				%>
            </div>
        </div>
<jsp:useBean id="tdao" class="DAO.TransactionDAO"/>
<%
	String userId = (String)session.getAttribute("user_id");
	if (userId == null) {
		%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location.href = 'login.jsp';
		</script>
<%
	}%>
	
	    <!-- Main Content -->
    <div class="flex gap-4">
      <!-- Left Panel -->
      <div class="flex-1">
        <div class="grid grid-rows-1 grid-cols-6 gap-4 mb-4 bg-gray-200 p-4">
         <div class="font-bold text-center">아이디</div>
         <div class="font-bold text-center">주식</div>
         <div class="font-bold text-center">거래</div>
         <div class="font-bold text-center">수량</div>
         <div class="font-bold text-center">거래가</div>
         <div class="font-bold text-center">거래시간</div>
        </div>
        <div class="space-y-2">
        </div>
      </div>
    </div>
    
<%
	for(TransactionVO t : tdao.getTransactionList(id)) {
%>
	<div class="grid grid-rows-1 grid-cols-6 gap-4 mb-4 p-4 border-2">
	   		<div class="text-center"><%= t.getUserId() %></div>
	       	<div class="text-center"><%= t.getStockId() %></div>
	        <div class="text-center"><%= t.getTransactionType() %></div>
	        <div class="text-center"><%= t.getQuantity() %></div>
	        <div class="text-center"><%= t.getTransactionPrice() %></div>
	        <div class="text-center"><%= t.getTransactionDate() %></div>
    </div>
<%
	}
%>
</div>
</body>
</html>