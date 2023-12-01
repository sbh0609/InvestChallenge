<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>

	<jsp:useBean id="gsc" class="DAO.GetstockCode"/>
	<jsp:useBean id="apiData" class="service.GetapiData"/>
	<jsp:useBean id="gsd" class="service.GetstockData"/>
	<%
		request.setCharacterEncoding("UTF-8");
		String searchWord = request.getParameter("searchWord");
	%>
	<h2>Search Results for "<%= searchWord %>"</h2>
	
	<%
	String currentprice = gsd.OnlyPrice(searchWord);
	String [][] dailychart= gsd.StockDailyInfo(searchWord);
	%>
	<%= currentprice %>
	<!-- Daily Chart Data Display -->
	<!-- 차트를 표시할 canvas 요소 추가 -->
    <canvas id="stockChart" width="400" height="200"></canvas>
	 <!-- Chart.js를 사용하여 차트 그리기 -->
    <script>
        var ctx = document.getElementById('stockChart').getContext('2d');
        var chart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [],
                datasets: [{
                    label: 'Stock Price',
                    backgroundColor: 'rgb(255, 99, 132)',
                    borderColor: 'rgb(255, 99, 132)',
                    data: []
                }]
            },
            options: {}
        });

        <% if (dailychart != null) {
            for (int i = 0; i < dailychart.length; i++) {
            %>
            chart.data.labels.push('<%= dailychart[i][0] %>'); // 날짜 추가
            chart.data.datasets[0].data.push(<%= dailychart[i][1] %>); // 종가 추가
            <%
            }
        } %>
        chart.update();
    </script>
	
	<!-- 실시간 현재가 표시 -->
    <div id="currentPrice">현재가: </div>

    <!-- 수량 입력 필드 -->
    <label for="quantity">수량:</label>
    <input type="number" id="quantity" name="quantity"><br>

    <!-- 매수/매도 가격 표시 -->
    <div id="totalPrice">총 가격: </div>

    <!-- 매수/매도 버튼 -->
    <button id="buyButton">매수</button>
    <button id="sellButton">매도</button>
</body>
</html>