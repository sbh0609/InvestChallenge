<%@ page import="service.SellBuyPrice" %>
<%@ page import="java.lang.Integer" %>
<%@ page contentType="text/plain;charset=UTF-8" %>
<%
    //String searchWord = request.getParameter("searchWord");
    //Integer quantity = Integer.parseInt(request.getParameter("quantity"));
    
    //SellBuyPrice sbp = new SellBuyPrice();
    //Integer price = sbp.sbPrice(searchWord, quantity);
    String searchWord = request.getParameter("searchWord");
    String quantityStr = request.getParameter("quantity");
    Integer price = 0;

    try {
        Integer quantity = Integer.parseInt(quantityStr);
        SellBuyPrice sbp = new SellBuyPrice();
        price = sbp.sbPrice(searchWord, quantity);
    } catch(NumberFormatException e) {
        // 숫자 변환 실패 시의 처리. 예를 들어, price를 0으로 설정
        price = 0;
    }


    // 가격을 문자열로 출력
    out.print(price.toString());
%>