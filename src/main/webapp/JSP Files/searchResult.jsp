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
	<jsp:useBean id="sbp" class="service.SellBuyPrice"/>
	<%
		request.setCharacterEncoding("UTF-8");
		String searchWord = request.getParameter("searchWord");
	%>
	<h2>Search Results for "<%= searchWord %>"</h2>
	
	<%
	String currentprice = gsd.OnlyPrice(searchWord);
	String [][] dailychart= gsd.StockDailyInfo(searchWord);
	%>

	<div id="initialCurrentPrice">현재가:<%= currentprice %></div>
	<!-- Daily Chart Data Display -->
	<!-- 차트를 표시할 canvas 요소 추가 -->
    <canvas id="stockChart" width="400" height="200"></canvas>
	 <!-- Chart.js를 사용하여 차트 그리기 -->
    
	
	<!-- 실시간 현재가 표시 -->
    <div id="currentPrice">현재가:<%= currentprice %> </div>

    <!-- 수량 입력 필드 -->
    <label for="quantity">수량:</label>
    <input type="number" id="quantity" name="quantity"><br>
    <!-- 매수/매도 가격 표시 -->
    <div id="totalPrice">총 가격:  </div>
    <!-- 매수/매도 버튼 -->
    <button id="buyButton">매수</button>
    <button id="sellButton">매도</button>
    
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
    <script>
    // 주식 현재가를 업데이트하는 함수
    function updateCurrentPrice() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'getCurrentPrice.jsp?searchWord=' + '<%= searchWord %>', true);
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                // 두 현재가 업데이트 요소를 업데이트
                document.getElementById('initialCurrentPrice').innerHTML = this.responseText;
                document.getElementById('currentPrice').innerHTML = '현재가: ' + this.responseText;
            }
        };
        xhr.send();
    }

    // 페이지 로드 시 현재가 업데이트 시작
    window.onload = function() {
        // 5초(5000밀리초)마다 현재가 업데이트
        setInterval(updateCurrentPrice, 10000);
    };
	</script>
    <script>
    document.getElementById('quantity').addEventListener('input', function() {
        var quantity = this.value;
        var searchWord = '<%= searchWord %>'; // JSP에서 검색어 가져오기

        // AJAX 요청 생성 및 보내기
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'calculatePrice.jsp?searchWord=' + searchWord + '&quantity=' + quantity, true);
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                // 응답 받기
                var price = this.responseText;
                // 결과를 표시하는 부분 업데이트
                document.getElementById('totalPrice').innerHTML = '총 가격: ' + price;
            }
        };
        xhr.send();
    });
	</script>

    
</body>
</html>