package utility;


import java.sql.*;
import java.util.*;

public class ConnectDB {
	
	Connection conn = null ;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/jspdb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
	
	public void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url,"jspbook","2019156018");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void disconnect(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
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
