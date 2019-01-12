package com.brw.dto;

import java.io.Serializable;
import java.sql.Date;

public class BookBasketDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int basketNo;
	private String userId;
	private String userName;
	private String ISBN;
	private String bookTitle;
	private int price;
	private int quantity;
	private int totalPrice;
	private String pickDate;
	
	public BookBasketDTO() {}

	public BookBasketDTO(int basketNo, String userId, String userName, String iSBN, String bookTitle, int price,
			int quantity, int totalPrice, String pickDate) {
		super();
		this.basketNo = basketNo;
		this.userId = userId;
		this.userName = userName;
		ISBN = iSBN;
		this.bookTitle = bookTitle;
		this.price = price;
		this.quantity = quantity;
		this.totalPrice = totalPrice;
		this.pickDate = pickDate;
	}

	public int getBasketNo() {
		return basketNo;
	}

	public void setBasketNo(int basketNo) {
		this.basketNo = basketNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getISBN() {
		return ISBN;
	}

	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}

	public String getBookTitle() {
		return bookTitle;
	}

	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getPickDate() {
		return pickDate;
	}

	public void setPickDate(String pickDate) {
		this.pickDate = pickDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "BookBasketDTO [basketNo=" + basketNo + ", userId=" + userId + ", userName=" + userName + ", ISBN="
				+ ISBN + ", bookTitle=" + bookTitle + ", price=" + price + ", quantity=" + quantity + ", totalPrice="
				+ totalPrice + ", pickDate=" + pickDate + "]";
	}
	
	
	
}
