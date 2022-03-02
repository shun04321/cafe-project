package com.project.dto;

public class OrderDetailDTO {
	private int detailNUM;
	private String userID;
	private int orderID;
	private int productID;
	private int writeREVIEW;
	
	
	public int getWriteREVIEW() {
		return writeREVIEW;
	}
	public void setWriteREVIEW(int writeREVIEW) {
		this.writeREVIEW = writeREVIEW;
	}
	public int getDetailNUM() {
		return detailNUM;
	}
	public void setDetailNUM(int detailNUM) {
		this.detailNUM = detailNUM;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getOrderID() {
		return orderID;
	}
	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}
	
	
}
