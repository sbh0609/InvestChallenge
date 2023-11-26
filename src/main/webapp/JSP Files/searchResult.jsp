<%@ page import="java.sql.*" %>
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
<%
		request.setCharacterEncoding("UTF-8");
		String searchWord = request.getParameter("searchWord");
	
		//데이터베이스로 검색 수행
		// db db = new db();
		//List<String> searchResults = db.searchInDatabase(searchWord);
	%>

	
	<h2>Search Results for "<%= searchWord %>"</h2>
    <ul>
    
    </ul> 
     
    //데이터가지고 차트 생성하는 부분인데
    //js파일 따로 만들어서 불러오려고하는데
    //js파일은 어디폴더에 넣어야되는지 모르겟음
    <canvas id="stockChart" style="width: 1200px; height: 400px;"></canvas>

    <script>
        function generateRandomData() {
            var data = [];
            for (var i = 0; i < 2000; i++) {
                data.push(Math.floor(Math.random() * (200 - 100 + 1)) + 100); // 100에서 200 사이의 임의의 값 생성
            }
            return data;
    }
        
    var stockData = {
    	labels: ["대", "병", "학", "엄", "준", "표", "대", "병", "학", "엄", "준", "표",
    		"대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", 
    		"엄", "준", "표","대", "병", "학", "엄", "준", "표","대", "병", "학", "엄", "준", "표"],
  	    datasets: [{
       		 label: "",
      		 data: generateRandomData(), // 데이터가 없을 경우 기본값 설정
             backgroundColor: "rgba(75, 192, 192, 0.2)",
      	     borderColor: "rgba(75, 192, 192, 1)",
      	     borderWidth: 1
    }]
};
        // 차트 생성
        document.addEventListener('DOMContentLoaded', function () {
            var ctx = document.getElementById("stockChart").getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: stockData,
                options: {
                	 scales: {
                         yAxes: [{
                             ticks: {
                                 beginAtZero: true,
                                 max: 400 // 최대 높이 설정
                             }
                         }]
                     },
                    legend: {
                        display: false 
                    },
                    responsive: false,
                    maintainAspectRatio: true,
                    height: 400,
                    width: 1200
                }
            });
        });
  </script>
	<%
	String code = gsc.getStockCode(searchWord);
	%>
	<%=code %>
<%--
	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/investchallenge?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
	
	try {
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url, "root", "passwd");
		String sql = "select * from stocklist where `한글 종목약명` like ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "%"+searchWord+"%");
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			String code = rs.getString("단축코드");
			String name = rs.getString("한글 종목약명");
			%>
			<ul>
			<%=code %> <%=name %>
			</ul>
			<%
		}
	}
	
	catch(Exception e) {
		e.printStackTrace();
	}
	
	finally {
		if (conn != null) conn.close();
		if (pstmt != null) pstmt.close();
		if (rs != null) rs.close();
	}
	%>
--%>
    <ul>
    
    </ul> 

</body>
</html>
</html>