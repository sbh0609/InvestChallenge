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
<body class="bg-white text-gray-800">
	<jsp:useBean id="apiData" class="service.GetapiData"/>
	<jsp:useBean id="gsd" class="service.GetstockData"/>
	<jsp:useBean id="sbp" class="service.SellBuyPrice"/>
	<%
		String searchWord = "";
		String currentprice = gsd.OnlyPrice(searchWord);
	%>
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

    <!-- Main Content -->
    <div class="flex gap-4">
      <!-- Left Panel -->
      <div class="flex-1">
        <div class="grid grid-rows-2 grid-cols-4 gap-4 mb-4 bg-gray-200 p-4">
         <div class="font-bold flex justify-center items-center row-span-2">종목명</div>
         <div class="font-bold text-center">평가손익</div>
         <div class="font-bold text-center">잔고수량</div>
         <div class="font-bold text-center">구분</div>
         <div class="font-bold text-center">수익률</div>
         <div class="font-bold text-center">평가금액</div>
         <div class="font-bold text-center">현재가</div>
        </div>
        <div class="space-y-2">
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
    		<div class="grid grid-rows-2 grid-cols-4 gap-4 mb-4 p-4 border-2">
	    		<div class="font-bold flex justify-center items-center row-span-2"><%= userStock.getStockName() %></div>
		       	<div class="text-center"><%= profitLossValuation %></div>
		        <div class="text-center"><%= userStock.getStockQuantity() %></div>
		        <div class="text-center"><%= userStock.getBuyPrice() %></div>
		        <div class="text-center"><%= rateOfReturn %>%</div>
		        <div class="text-center"><%= marketValue %></div>
		        <div class="text-center"><%= realPrice %></div>
            </div>
    <%
        }

    %>
        </div>
      </div>
    </div>
  </div>
</body>
</html>