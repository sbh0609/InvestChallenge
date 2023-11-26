<%@ page import="java.sql.*" %>
<%@ page import="utility.ConnectDB" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
	
<body>
	<% 
	 	out.println(".");
		ConnectDB db = new ConnectDB();
		db.connect();

    %>
</body>
</html>

                  <%--String id = rs.getString("id");
                    System.out.println("Username: " + id);
                    String stockName = rs.getString("stock_name");
                	// 매입가
                	int purchasePrice = rs.getInt("buy_price");
                	// 잔고수량
                    int stockQuantity = rs.getInt("stock_quantity");
                    // 현재가 임시로
                    int realPrice = rs.getInt("buy_price");
                    // 평가손익
                    int ProfitLossValuation = (realPrice * purchasePrice) * stockQuantity;
                    // 수익률
                    int rateOfReturn = (ProfitLossValuation / (purchasePrice * stockQuantity)) * 100;
                    // 평가금액
                    int marketValue = realPrice * stockQuantity;
                    
                    System.out.println("Stock Name: " + stockName + "<br>");
                    System.out.println("Buy Price: " + purchasePrice + "<br>");
                    System.out.println("Stock Quantity: " + stockQuantity + "<br>"); --%>