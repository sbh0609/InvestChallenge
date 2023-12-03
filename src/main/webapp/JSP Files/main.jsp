<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utility.ConnectDB" %>
<%@ page import="org.json.JSONObject" %>
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
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<style>
	    body {
	        font-family: 'Inter', sans-serif;
	    }
	</style>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="bg-white text-gray-800">
<jsp:useBean id="connectKIS" class="utility.ConnectKIS"/>
<jsp:useBean id="gsd" class="service.GetstockData"/>

<%
    if (connectKIS.readTokenFromFile() == null) {
        connectKIS.issueToken();
    }
	String [][] KPdailychart = gsd.StockDailyInfo("삼성전자");
	String [][] KDdailychart = gsd.StockDailyInfo("에코프로비엠");
%>
    <div class="container mx-auto p-4">
        <!-- Header -->
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

        <!-- Content -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <!-- Chart Section -->
            <div>
                <h2 class="text-xl font-semibold mb-2">KOSPI (삼성전자)</h2>
                <%-- 
                <img src="https://via.placeholder.com/900x300?text=KOSPI+Chart" alt="KOSPI Chart" class="mb-4">
                 --%>
                <canvas id="KP" width="900" height="300"></canvas>
                <h2 class="text-xl font-semibold mb-2">KOSDAQ (에코프로비엠)</h2>
                <%-- 
                <img src="https://via.placeholder.com/900x300?text=KOSDAQ+Chart" alt="KOSDAQ Chart">
                --%>
                <canvas id="KD" width="900" height="300"></canvas>
            </div>

            <!-- Action Section -->
            <div class="flex flex-col items-center justify-center">
                <h2 class="text-3xl font-bold mb-6">Invest Challenge</h2>                
            	<button class="w-1/4 mb-4 px-6 py-3 bg-gray-200 rounded shadow hover:bg-gray-300" type="submit" onclick="location.href='userStock.jsp'">내 자산 확인하기</button>
                <button class="w-1/4 px-6 py-3 bg-blue-500 text-white rounded shadow hover:bg-blue-600">주식 거래</button>
                <br>
                <input class="w-1/4 px-6 py-3 bg-blue-500 text-white rounded shadow hover:bg-blue-600" type="button" value="거래내역" onclick="location.href='userTransaction.jsp'">
            </div>
        </div>
    </div>
    <script>
        var ctx = document.getElementById('KP').getContext('2d');
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

        <% if (KPdailychart != null) {
            for (int i = 0; i < KPdailychart.length; i++) {
            %>
            chart.data.labels.push('<%= KPdailychart[i][0] %>'); // 날짜 추가
            chart.data.datasets[0].data.push(<%= KPdailychart[i][1] %>); // 종가 추가
            <%
            }
        } %>
        chart.update();
    </script>
    <script>
        var ctx = document.getElementById('KD').getContext('2d');
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

        <% if (KDdailychart != null) {
            for (int i = 0; i < KDdailychart.length; i++) {
            %>
            chart.data.labels.push('<%= KDdailychart[i][0] %>'); // 날짜 추가
            chart.data.datasets[0].data.push(<%= KDdailychart[i][1] %>); // 종가 추가
            <%
            }
        } %>
        chart.update();
    </script>
</body>

</html>