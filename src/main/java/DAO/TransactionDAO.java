package DAO;

import utility.ConnectDB;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import utility.TransactionVO;

public class TransactionDAO {
	public List<TransactionVO> getTransactionList(String userId) {
		List<TransactionVO> list = new ArrayList<>();
		ConnectDB db = new ConnectDB();
		db.connect();
		Connection conn = db.getConn();
		try {
			String sql = "select * from Transaction where user_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				TransactionVO transaction = new TransactionVO();
				transaction.setTransactionId();
				transaction.setUserId();
				transaction.setStockId();
				transaction.setTransactionId();
				transaction.setTransactionId();
			}
		}
	}
}