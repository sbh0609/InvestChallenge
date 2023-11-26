package DAO;
import utility.ConnectDB;
import utility.userVO;

import java.sql.*;

public class LoginDAO {
	
	public int add(userVO user) {
		ConnectDB db = new ConnectDB();
		db.connect();
		Connection conn = db.getConn();
		String sql = "insert into user values (?, ?, ?)";
		int result = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPw());
			pstmt.setString(3, user.getUsername());
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
		String sql = "select * from user where id = ? and pw = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  id);
			pstmt.setString(2,  pw);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				user = new userVO();
				user.setId(rs.getString("id"));
				user.setPw(rs.getString("pw"));
				user.setUsername(rs.getString("username"));
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