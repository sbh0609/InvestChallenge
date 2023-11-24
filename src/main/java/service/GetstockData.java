package service;
import DAO.GetstockCode;

public class GetstockData {
	
	public String OnlyPrice() {
    	GetapiData gad = new GetapiData();
    	GetstockCode getcode = new GetstockCode();
    	String stock_code = getcode.getStockCode("삼성전자");
    	
    	String livestock = gad.LiveStockPrice(stock_code);
    	return livestock;
    }
    
    public String[][] StockDailyInfo(){
    	GetapiData gad = new GetapiData();
    	GetstockCode getcode = new GetstockCode();
    	String stock_code = getcode.getStockCode("삼성전자");
    	
    	String[][] useforChart =  gad.DailyChartprice(stock_code);
    	return useforChart;
    }
	
//	public static void main(String[] args) {
//		// TODO Auto-generated method stub
//
//	}

}
