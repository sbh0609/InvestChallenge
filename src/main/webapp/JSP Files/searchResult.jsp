<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<jsp:useBean id="gsc" class="DAO.GetstockCode"/>
	<jsp:useBean id="apiData" class="service.GetapiData"/>
	<jsp:useBean id="gsd" class="service.GetstockData"/>
	<%
		request.setCharacterEncoding("UTF-8");
		String searchWord = request.getParameter("searchWord");
		String currentprice = gsd.OnlyPrice(searchWord);
		String [][] dailychart= gsd.StockDailyInfo(searchWord);
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

        <!-- Main Content -->
        <div class="flex flex-wrap -mx-2">
            <!-- Chart Section -->
            <div class="w-full lg:w-2/3 px-2 mb-4">
                <div class="border p-4">
                    <h2 class="font-semibold mb-2"><%= searchWord %></h2>
                    <!-- Placeholder for Chart -->
                    <canvas id="stockChart" width="400" height="200"></canvas>
                </div>
            </div>

            <!-- Form Section -->
            <div class="w-full lg:w-1/3 px-2 mb-4">
                <div class="border p-4">
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="price">
                            가격
                        </label>
                        <div id="initialCurrentPrice"><%= currentprice %></div>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="quantity">
                            수량
                        </label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="number" id="quantity" name="quantity" placeholder="주">
                    </div>
                    <div class="mb-6">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="quantity">
                            주문금액
                        </label>
                        <div id="totalPrice"></div>
                    </div>
                    <div class="flex items-center justify-between">
                        <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button" id="buyButton">
                            매수
                        </button>
                        <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button" id="sellButton">
                            매도
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
    <%-- 실시간 현재가 --%>
    <script>
    // 주식 현재가를 업데이트하는 함수
    function updateCurrentPrice() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'getCurrentPrice.jsp?searchWord=' + encodeURIComponent('<%= searchWord %>'), true);
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
	<%--실시간 총 가격 설정  --%>
    <script>
    document.getElementById('quantity').addEventListener('input', function() {
        var quantity = this.value;
        var searchWord = encodeURIComponent('<%= searchWord %>'); // JSP에서 검색어 가져오기

        // AJAX 요청 생성 및 보내기
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'calculatePrice.jsp?searchWord=' + searchWord + '&quantity=' + quantity, true);
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                // 응답 받기
                var price = this.responseText;
                // 결과를 표시하는 부분 업데이트
                document.getElementById('totalPrice').innerHTML = price;
            }
        };
        xhr.send();
    });
	</script>


	<script>
    document.getElementById('buyButton').addEventListener('click', function() {
        var quantity = document.getElementById('quantity').value;
        var totalPrice = document.getElementById('totalPrice').textContent.trim();
        var searchWord = encodeURIComponent('<%= searchWord %>');
        var userId = '<%= session.getAttribute("user_id") %>'; // 세션에서 userId 가져오기

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'buyStock.jsp', true);
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                // 처리 결과에 따른 클라이언트 측 로직
                console.log('매수 처리 완료: ', this.responseText);
            }
        };
        xhr.send('quantity=' + quantity + '&totalPrice=' + totalPrice + '&searchWord=' + searchWord + '&userId=' + userId);
    });
	</script>
	<script>
    document.getElementById('sellButton').addEventListener('click', function() {
        var quantity = parseInt(document.getElementById('quantity').value);
        var totalPrice = parseInt(document.getElementById('totalPrice').textContent.trim());
        var searchWord = encodeURIComponent('<%= searchWord %>');
        var userId = '<%= session.getAttribute("user_id") %>';

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'sellStock.jsp', true);
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                alert(this.responseText);
            }
        };
        xhr.send('quantity=' + quantity + '&totalPrice=' + totalPrice + '&searchWord=' + searchWord + '&userId=' + userId);
    });
	</script>

</body>

</html>