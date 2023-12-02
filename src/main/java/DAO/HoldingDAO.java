package DAO;

import utility.ConnectDB;
import utility.HoldingVO;
import java.sql.*;

public class HoldingDAO {
	
	public void updateHolding(HoldingVO holding) {
		ConnectDB db = new ConnectDB();
		db.connect();
		Connection conn = db.getConn();
		String sql = "select * from Holding where user_id = ? and stock_id = ?";
		int result = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, holding.getUserId());
			pstmt.setString(2,  holding.getStockId());
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "update Holding set quantity = ?, average_buy_price = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, holding.getQuantity());
				pstmt.setInt(2, holding.getAverageBuyPrice());
				result = pstmt.executeUpdate();
			}
		}
		catch (SQLException e) {
	        // SQLException을 통해 데이터베이스 관련 예외를 처리
	        e.printStackTrace();
		}
		finally {
			db.disconnect(conn);
		}
	}
	
	public static void main(String[] args) {
		HoldingDAO hdao = new HoldingDAO();
		HoldingVO holding = new HoldingVO();
		holding.setHoldingId(1);
		holding.setUserId("umjunsik");
		holding.setStockId("005930");
		holding.setQuantity(20);
		holding.setAverageBuyPrice(66666);
		
		hdao.updateHolding(holding);
	}
}