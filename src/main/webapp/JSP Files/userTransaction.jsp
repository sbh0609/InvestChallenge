<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utility.TransactionVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래내역</title>
</head>
<body>
<jsp:useBean id="tdao" class="DAO.TransactionDAO"/>
<%
	String id = (String)session.getAttribute("user_id");
	if (id == null) {
		%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location.href = 'login.jsp';
		</script>
<%
	}%>
	
	<table border="1" width="1000">
		<tr><td>transaction_id</td><td>user_id</td><td>stock_id</td><td>transaction_type</td>
		<td>quantity</td><td>transaction_price</td><td>transaction_date</td>
<%
	for(TransactionVO t : tdao.getTransactionList(id)) {
%>
		<tr>
		<td><%=t.getTransactionId() %></td>
		<td><%=t.getUserId() %></td>
		<td><%=t.getStockId() %></td>
		<td><%=t.getTransactionType() %></td>
		<td><%=t.getQuantity() %></td>
		<td><%=t.getTransactionPrice() %></td>
		<td><%=t.getTransactionDate() %></td>
		</tr>
<%
	}
%>
	</table>

</body>
</html>