package DAO;
import utility.ConnectDB;
import utility.userVO;

import java.sql.*;

public class LoginDAO {
	
	public int add(userVO user) {
		ConnectDB db = new ConnectDB();
		db.connect();
		Connection conn = db.getConn();
		String sql = "insert into User values (?, ?, ?, ?)";
		int result = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserPassword());
			pstmt.setInt(4, user.getTotalAmount());
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			db.disconnect(conn);
		}
		return result;
	}
	
	public userVO login(String id, String pw) {
		ConnectDB db = new ConnectDB();
		db.connect();
		Connection conn = db.getConn();
		userVO user = null;
		String sql = "select * from User where user_id = ? and user_password = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  id);
			pstmt.setString(2,  pw);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				user = new userVO();
				user.setUserId(rs.getString("user_id"));
				user.setUserPassword(rs.getString("user_password"));
				user.setUserName(rs.getString("user_name"));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			db.disconnect(conn);
		}
		return user;
	}
}