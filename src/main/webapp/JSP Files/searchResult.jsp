<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta charset="UTF-8">
	<title> /*주식 이름 받아와서 표시 */ </title>
	
</head>
<body>
	<%
		String searchWord = request.getParameter("searchWord");
	
		//데이터베이스로 검색 수행
		// db db = new db();
		//List<String> searchResults = db.searchInDatabase(searchWord);
	%>
	
	<h2>Search Results for "<%= searchWord %>"</h2>
    <ul>
    
    </ul> 
	
</body>
</html>
</html>
왼쪽 주식 실시간
이름 그래프 전일대비 뭐시기 현재가
오른쪽 매수매도 기능 -- 사용자 값하고 연동 