<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="utility.ConnectDB" %>
<%@ page import="utility.ConnectKIS" %>
<%@ page import="DAO.GetUserStock" %>
<%@ page import="service.GetapiData" %>
<%@ page import="DAO.GetstockCode" %>
<%@ page import="utility.HoldingVO" %>
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
<body class="bg-white text-gray-800" onload="updateStockInfo()">
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
        <div id="stockInfoContainer" class="space-y-2">
        </div>
      </div>
    </div>
  </div>
  <script>
    var userId = '<%= session.getAttribute("user_id") %>';
    function styleTable(table) {
        table.classList.add("text-lg"); // 예시로 Tailwind CSS 텍스트 크기 클래스 추가
    }
    function updateStockInfo() {
        if (!userId) {
            alert("로그인이 필요한 서비스입니다.");
            window.location.href = 'login.jsp';
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'updateStockInfo.jsp?userId=' + encodeURIComponent(userId), true);
        xhr.onreadystatechange = function() {
            if (this.readyState == 4) {
                if (this.status == 200) {
                    var stocks = JSON.parse(this.responseText);
                    var container = document.getElementById("stockInfoContainer");
                    container.innerHTML = ''; // 기존 내용을 클리어합니다.
                    
                    // 새로운 테이블 생성
                    var table = document.createElement('table');
                    styleTable(table);
                    table.classList.add("min-w-full", "divide-y", "divide-gray-200"); // 예시로 Tailwind CSS 클래스 추가

                    // 테이블 헤더 추가
                    var thead = document.createElement('thead');
                    var headerRow = document.createElement('tr');
                    var headers = ['종목명', '평가손익', '잔고수량', '매입가', '수익률', '평가금액', '현재가'];
                    headers.forEach(function(header) {
                        var th = document.createElement('th');
                        th.textContent = header;
                        th.classList.add("px-6", "py-3", "text-left", "text-xs", "font-medium", "text-gray-500", "uppercase", "tracking-wider");
                        headerRow.appendChild(th);
                    });
                    thead.appendChild(headerRow);
                    table.appendChild(thead);

                    // 테이블 본문 추가
                    var tbody = document.createElement('tbody');
                    stocks.forEach(function(stock) {
                        var row = document.createElement('tr');
                        
                        // 원하는 순서로 데이터 추가
                        var dataOrder = ['stockId', 'profitLossValuation', 'quantity', 'averageBuyPrice', 'rateOfReturn', 'marketValue', 'realPrice'];
                        dataOrder.forEach(function(key) {
                            var cell = document.createElement('td');
                            cell.textContent = stock[key];
                            cell.classList.add("px-6", "py-4", "whitespace-nowrap");
                            row.appendChild(cell);
                        });

                        tbody.appendChild(row);
                    });
                    table.appendChild(tbody);

                    container.appendChild(table); // 테이블을 컨테이너에 추가
                } else if (this.readyState == 4) {
                    console.log("Error: ", this.status); // 실패한 경우 상태 코드 출력
                }
            }
        };
        xhr.send();
    }
    window.onload = updateStockInfo;
    setInterval(updateStockInfo, 5000);
	</script>

</body>
</html>