<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="utility.ConnectDB" %>
<%@ page import="utility.ConnectKIS" %>
<%@ page import="DAO.GetUserStock" %>
<%@ page import="DAO.UserStock" %>
<%@ page import="service.GetapiData" %>
<%@ page import="DAO.GetstockCode" %>

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
		// 유저아이디 값 string으로 변환 및 사용준비
		String userID = null;
		Object user_idObject = session.getAttribute("user_id");
	
		if (user_idObject != null) {
   		userID = user_idObject.toString();
   		
		} else {
			
			%>
			<script>
            	alert("로그인이 필요한 서비스입니다.");
          	    window.location.href = 'login.jsp';
       	 	</script>
       		<%
			
		}
		
		//db연결
		ConnectDB db = new ConnectDB();
		db.connect();
		// db에서 유저의 주식 정보 가져와서 리스트에 입력
		GetUserStock gu = new GetUserStock();
		gu.getUserStock(userID);
		List<UserStock> userStockList = gu.getUserStock(userID);
		
		GetstockCode gsc = new GetstockCode();
	
		GetapiData gad = new GetapiData();
		
		ConnectKIS connectKIS = new ConnectKIS();
		connectKIS.issueToken();
		
        for (UserStock userStock : userStockList) {
        	// 주식이름은 코드로 변환해서 현재갑 가져오기
        	String stockName = userStock.getStockName();
        	String stockCode = gsc.getStockCode(stockName);
        	String realPrice = gad.LiveStockPrice(stockCode);
        	// 손익 등등 계산식들
        	int intRealPrice = (realPrice != null) ? Integer.parseInt(realPrice) : 0;
        	int profitLossValuation = (intRealPrice - userStock.getBuyPrice()) * userStock.getStockQuantity();
        	double rateOfReturn = ((double) profitLossValuation / (userStock.getBuyPrice() * userStock.getStockQuantity())) * 100;
        	int marketValue = intRealPrice * userStock.getStockQuantity();
        	
    %>
            <div>
                Stock Name: <%= userStock.getStockName() %>, <br>
                Buy Price: <%= userStock.getBuyPrice() %>, <br>
                Stock Quantity: <%= userStock.getStockQuantity() %>, <br>
                Real Price : <%= realPrice %>, <br>
              	ProfitLossValuation : <%= profitLossValuation %>, <br>
              	Rate Of Return : <%= rateOfReturn %>%, <br>
              	MarketValue : <%= marketValue %> <br><br>
            </div>
    <%
        }

    %>
</body>
</html>

