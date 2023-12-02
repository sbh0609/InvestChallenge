package DAO;
import utility.ConnectDB;
import utility.userVO;

import java.sql.*;

public class LoginDAO {
	
	public int add(userVO user) {
		// 아이디, 비밀번호, 유저이름이 null이거나 빈 문자열인 경우
	    if (user.getId() == null || user.getId().isEmpty() ||
	        user.getPw() == null || user.getPw().isEmpty() ||
	        user.getUsername() == null || user.getUsername().isEmpty()) {
	        return -2;
	    }
	    
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
	        // SQLException을 통해 데이터베이스 관련 예외를 처리
	        e.printStackTrace();

	        // 아이디 중복 오류인 경우
	        if (e.getErrorCode() == 1062) {
	            result = -1;
	        } else {
	            // 다른 예외 처리 코드 작성 가능
	            result = -3;
	        }
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