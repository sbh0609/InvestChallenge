<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="DAO.GetUserStock" %>
<%@ page import="utility.HoldingVO" %>
<%@ page import="utility.ConnectDB" %>
<%
    String userId = request.getParameter("userId");
	System.out.println("Received userId: " + userId); // userId 로그 출력

	JSONArray jsonArray = new JSONArray();

	if (userId != null) {
		//db연결
		ConnectDB db = new ConnectDB();
		db.connect();
		GetUserStock gu = new GetUserStock();
		gu.getUserStock(userId);
		List<HoldingVO> userStockList = gu.getUserStock(userId);
		for (HoldingVO userStock : userStockList) {
			List<Integer> stockInfo = gu.getStockInfo(userStock);
			JSONObject stockJson = new JSONObject();
			stockJson.put("stockId", userStock.getStockId());
			stockJson.put("profitLossValuation", stockInfo.get(1));
			stockJson.put("quantity", userStock.getQuantity());
			stockJson.put("averageBuyPrice", userStock.getAverageBuyPrice());
			stockJson.put("rateOfReturn", stockInfo.get(2));
			stockJson.put("marketValue", stockInfo.get(3));
			stockJson.put("realPrice", stockInfo.get(0));
		    
		    jsonArray.put(stockJson);
		}
	} else {
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
        return;
    }
	String jsonResponse = jsonArray.toString();
    System.out.println("JSON Response: " + jsonResponse); // JSON 응답 로그 출력	

	response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(jsonResponse);
%>