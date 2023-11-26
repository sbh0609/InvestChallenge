package utility;


import java.sql.*;

import org.apache.jasper.tagplugins.jstl.core.Out;

import utility.userVO;

public class ConnectDB {
	
	Connection conn = null ;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//환경변수 설정
	String dbusername = System.getenv("DB_NAME");
	String dbpassword = System.getenv("DB_PASSWORD");
	
	
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/investchallenge?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
	
	public void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url,"root","passwd");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void disconnect() {
		if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
	
	public int add(userVO user) {
		connect();
		String sql = "insert into user values (?, ?, ?)";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPw());
			pstmt.setString(3, user.getUsername());
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return result;
	}
	
	public userVO login(String id, String pw) {
		userVO user = null;
		connect();
		String sql = "select * from user where id = ? and pw = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  id);
			pstmt.setString(2,  pw);
			rs = pstmt.executeQuery();
			
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
			disconnect();
		}
		return user;
	}
	
//	public static void main(String[] args) {
//		ConnectDB db = new ConnectDB();
//        db.connect();
//        
//        if (db.conn != null) {
//            System.out.println("데이터베이스 연결 성공!");
//            try {
//                String sql = "SELECT username FROM jdbc_test";
//                PreparedStatement pstmt = db.conn.prepareStatement(sql);
//                ResultSet rs = pstmt.executeQuery();
//                
//                while (rs.next()) {
//                    String username = rs.getString("username");
//                    System.out.println("Username: " + username);
//                }
//                
//                rs.close();
//                pstmt.close();
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//            db.disconnect(db.conn);
//        } else {
//            System.out.println("데이터베이스 연결 실패.");
//        }
//    }
}