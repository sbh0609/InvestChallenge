<%@ page import="service.GetstockData" %>
<%@ page contentType="text/plain;charset=UTF-8" %>
<%
    // GetstockData Bean을 생성
    request.setCharacterEncoding("UTF-8");
    GetstockData gsd = new GetstockData();

    // 요청으로부터 searchWord 파라미터를 받음
    String searchWord = request.getParameter("searchWord");
    if (searchWord == null || searchWord.trim().isEmpty()) {
        // 검색어가 없는 경우, 에러 메시지 또는 기본값 설정
        out.print("검색어가 없습니다");
        return;
    }

    // 주식의 현재가를 조회
    String currentprice = gsd.OnlyPrice(searchWord);

    // 현재가를 문자열로 출력
    out.print(currentprice);
%>