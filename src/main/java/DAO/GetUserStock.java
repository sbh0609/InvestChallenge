package DAO;
import utility.ConnectDB;
import java.util.List;
import java.util.ArrayList;
import utility.userVO;
import DAO.UserStock;
import service.GetapiData;

import java.sql.*;


public class GetUserStock {
	GetstockCode gsc = new GetstockCode();
	GetapiData gad = new GetapiData();
	
	public List<UserStock> getUserStock(String userID) {
		List<UserStock> userStockList = new ArrayList<>();
		ConnectDB db = new ConnectDB();
		db.connect();
		Connection conn = db.getConn();
		try {
			String sql = "SELECT * FROM user_stocks WHERE user_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  userID);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				UserStock userStock = new UserStock(
                        rs.getString("user_id"),
                        rs.getString("stock_name"),
                        rs.getInt("buy_price"),
                        rs.getInt("stock_quantity")
                );
				 userStockList.add(userStock);
				 System.out.println("User ID: " + userStock.getUserID() +
	                        ", Stock Name: " + userStock.getStockName() +
	                        ", Buy Price: " + userStock.getBuyPrice() +
	                        ", Stock Quantity: " + userStock.getStockQuantity());
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			db.disconnect(conn);
		}
		return userStockList;
	}
	 public List<Integer> getStockInfo (UserStock userStock) {
	    	String stockName = ((UserStock) userStock).getStockName();
	    	String stockCode = gsc.getStockCode(stockName);
	    	String realPrice = gad.LiveStockPrice(stockCode);
	    	int intRealPrice = (realPrice != null) ? Integer.parseInt(realPrice) : 0;
	    	//평가손익
	    	int profitLossValuation = (intRealPrice - ((UserStock)userStock).getBuyPrice()) * ((UserStock)userStock).getStockQuantity();
	    	//수익률
	    	double rateOfReturn = ((double) profitLossValuation / (((UserStock)userStock).getBuyPrice() * ((UserStock)userStock).getStockQuantity())) * 100;
	    	//평가금액
	    	int marketValue = intRealPrice * ((UserStock)userStock).getStockQuantity();
	    	
	    	//리스트의 첫인자 intRealPrice 두번째 인자 profitLossValuation 세번째 인자 rateOfReturn 네번째 인자 marketValue
	    	List<Integer> result = new ArrayList<>();
	    	result.add(intRealPrice);
	    	result.add(profitLossValuation);
	    	result.add((int) rateOfReturn); 
	    	result.add(marketValue);	
	    	
	    	return result;
	    	}
}