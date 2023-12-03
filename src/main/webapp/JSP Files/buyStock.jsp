<%@ page import="DAO.SetHoldingData" %>
<%@ page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    int quantity = Integer.parseInt(request.getParameter("quantity"));
    int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
    String searchWord = request.getParameter("searchWord");
    String userId = request.getParameter("userId");

    SetHoldingData shd = new SetHoldingData();
    try {
    	String resultMessage = shd.ClickBuy(quantity, totalPrice, searchWord, userId);
        out.print(resultMessage);
    } catch (Exception e) {
        e.printStackTrace();
        out.print("매수 처리 실패: " + e.getMessage());
    }
%>
