package utility;

public class HoldingVO {
	private int holdingId;
	private String userId;
	private String stockId;
	private int quantity;
	private int averageBuyPrice;
	
	public int getHoldingId() {
		return holdingId;
	}
	
	public void setHoldingId(Integer holdingId) {
		this.holdingId = holdingId;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getStockId() {
		return stockId;
	}
	
	public void setStockId(String stockId) {
		this.stockId = stockId;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	
	public int getAverageBuyPrice() {
		return averageBuyPrice;
	}
	
	public void setAverageBuyPrice(Integer averageBuyPrice) {
		this.averageBuyPrice = averageBuyPrice;
	}
}