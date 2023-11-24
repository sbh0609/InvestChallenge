package utility;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.io.FileWriter;
import java.io.IOException;

public class GetapiData {
	private String apiKey = System.getenv("KISAPP_KEY");
    private String apiSecret = System.getenv("KISSECRET_KEY");
    private static final String URL_BASE = "https://openapi.koreainvestment.com:9443";
    
    //입력 창에서 받아온 데이터로 변경
    private static final String STOCK_CODE = "000660";
     //주식 현재가를 조회하는 메소드
    public String LiveStockPrice() {
    	String token = new ConnectKIS().readTokenFromFile();
        StringBuilder response1 = new StringBuilder();

        try {
            String path = "uapi/domestic-stock/v1/quotations/inquire-price";
            URL url = new URL(URL_BASE + "/" + path + "?fid_cond_mrkt_div_code=J&fid_input_iscd=" + STOCK_CODE);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("authorization", "Bearer " + token);
            conn.setRequestProperty("appKey", apiKey);
            conn.setRequestProperty("appSecret", apiSecret);
            conn.setRequestProperty("tr_id", "FHKST01010100");
            
            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;

                while ((inputLine = in.readLine()) != null) {
                    response1.append(inputLine);
                }
                in.close();
                
                System.out.println(response1.toString());
            } else if (responseCode == 401) { // 토큰 만료 시 재발급
                new ConnectKIS().issueToken();
            } else {
                System.out.println("Error Code: " + responseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return response1.toString();
    }
    
    public String DailyChartprice() {
    	 String token = new ConnectKIS().readTokenFromFile();
    	 StringBuilder response = new StringBuilder();
//         현재 날짜 yyyymmdd
         SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); 
         Calendar c1 = Calendar.getInstance();
         String strToday = sdf.format(c1.getTime());
         System.out.println(strToday);
         
         try {
        	 String path = "uapi/domestic-stock/v1/quotations/inquire-daily-itemchartprice";
        	 URL url = new URL(URL_BASE + "/" + path + "?fid_cond_mrkt_div_code=J&fid_input_iscd=" + STOCK_CODE + "&fid_input_date_1=20231111&fid_input_date_2="+strToday+"&fid_org_adj_prc=0&fid_period_div_code=D");
        	 HttpURLConnection conn = (HttpURLConnection) url.openConnection();

             conn.setRequestMethod("GET");
             conn.setRequestProperty("Content-Type", "application/json");
             conn.setRequestProperty("authorization", "Bearer " + token);
             conn.setRequestProperty("appKey", apiKey);
             conn.setRequestProperty("appSecret", apiSecret);
             conn.setRequestProperty("tr_id", "FHKST03010100");
             
             int responseCode = conn.getResponseCode();
             if (responseCode == HttpURLConnection.HTTP_OK) {
                 BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                 String inputLine;
                 
                 while ((inputLine = in.readLine()) != null) {
                     response.append(inputLine);
                 }
                 in.close();
                 
                 System.out.println(response.toString());
             } else if (responseCode == 401) { // 토큰 만료 시 재발급
                 new ConnectKIS().issueToken();
             } else {
                 System.out.println("Error Code: " + responseCode);
             }
         } catch (Exception e) {
             e.printStackTrace();
             return null;
         }
         return response.toString();
             
    }
    
//    public void saveJsonToFile(String jsonData, String filePath) {
//        try (FileWriter file = new FileWriter(filePath)) {
//            file.write(jsonData);
//            file.flush();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
         
    	
//파일 별 실생 원할 대 주석 풀기
//    public static void main(String[] args) {
//        GetapiData apiData = new GetapiData();
//        String priceData = apiData.LiveStockPrice();
//       
//        if (priceData != null) {
//            System.out.println("정상 실행!");
//        } else {
//            System.out.println("Failed to retrieve stock price data.");
//        }
//        String dailyData = apiData.DailyChartprice();
//        if (dailyData != null) {
//            System.out.println("정상 실행!");
//            apiData.saveJsonToFile(dailyData, "daily.json");
//        } else {
//            System.out.println("Failed to retrieve daily data.");
//        }
//    }
}