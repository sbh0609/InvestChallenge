package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import utility.ConnectDB;
import utility.HoldingVO;

public class SetHoldingData {
    GetHoldingData ghd = new GetHoldingData();

    public void setHoldingRow(int quantity, int totalPrice, String searchWord, String userId) {
        HoldingVO existingHolding = ghd.getHoldingRow(userId, searchWord);

        if (existingHolding != null) {
            // 기존 데이터 업데이트
            updateExistingHolding(existingHolding, quantity, totalPrice);
        } else {
            // 새로운 행 추가
            insertNewHolding(quantity, totalPrice, searchWord, userId);
        }
    }

    private void updateExistingHolding(HoldingVO holding, int quantity, int totalPrice) {
        int newTotalPrice = holding.getTotalPrice() + totalPrice;
        int newQuantity = holding.getQuantity() + quantity;
        int newAverageBuyPrice = newTotalPrice / newQuantity;

        // 데이터베이스 업데이트 로직
        ConnectDB db = new ConnectDB();
        db.connect();
        Connection conn = db.getConn();
        String updateQuery = "UPDATE Holding SET quantity = ?, average_buy_price = ?, total_price = ? WHERE holding_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, newAverageBuyPrice);
            pstmt.setInt(3, newTotalPrice);
            pstmt.setInt(4, holding.getHoldingId());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void insertNewHolding(int quantity, int totalPrice, String stockId, String userId) {
        int averageBuyPrice = totalPrice / quantity;

        // 새로운 Holding 데이터를 데이터베이스에 삽입하는 로직
        ConnectDB db = new ConnectDB();
        db.connect();
        Connection conn = db.getConn();
        String insertQuery = "INSERT INTO Holding (user_id, stock_id, quantity, average_buy_price, total_price) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, stockId);
            pstmt.setInt(3, quantity);
            pstmt.setInt(4, averageBuyPrice);
            pstmt.setInt(5, totalPrice);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
