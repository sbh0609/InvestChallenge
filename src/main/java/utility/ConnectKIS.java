package utility;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ConnectKIS {
    private String apiKey = "apkey";
    private String apiSecret = "secret";
    private String baseUrl = "https://openapi.koreainvestment.com:9443";

    public static void main(String[] args) {
        ConnectKIS connectKIS = new ConnectKIS();
        connectKIS.issueToken();
    }

    public void issueToken() {
        try {
            URL url = new URL(baseUrl + "/oauth2/tokenP");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setDoOutput(true);

            String jsonInputString = "{\"grant_type\": \"client_credentials\", \"appkey\": \"" + apiKey + "\", \"appsecret\": \"" + apiSecret + "\"}";
            
            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.writeBytes(jsonInputString);
                wr.flush();
            }

            int responseCode = con.getResponseCode();
            System.out.println("POST Response Code :: " + responseCode);

            if (responseCode == HttpURLConnection.HTTP_OK) { //success
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer response = new StringBuffer();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();

                System.out.println(response.toString());
            } else {
                System.out.println("POST request not worked");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
