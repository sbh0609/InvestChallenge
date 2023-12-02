package service;

import java.util.List;

import DAO.GetUserStock;
import DAO.UserStock;
import utility.ConnectDB;

public class BuySellControl {
	
	public void ClickBuy(Integer totalprice, String UserId) {
		//db연결
		ConnectDB db = new ConnectDB();
		db.connect();
		// db에서 유저의 주식 정보 가져와서 리스트에 입력
		GetUserStock gu = new GetUserStock();
		List<UserStock> userStockList= gu.getUserStock(UserId);
	
		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
