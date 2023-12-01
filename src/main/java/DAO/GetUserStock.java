package DAO;
import utility.ConnectDB;
import java.util.List;
import java.util.ArrayList;
import utility.userVO;

import java.sql.*;


public class GetUserStock {
	
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
}