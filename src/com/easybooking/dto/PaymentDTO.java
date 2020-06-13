package com.easybooking.dto;

public class PaymentDTO {
	
	private int id , marqueeID;
	private String marqueeName , whichMonthDate ;
	private double monthly , yearly;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMarqueeName() {
		return marqueeName;
	}
	public void setMarqueeName(String marqueeName) {
		this.marqueeName = marqueeName;
	}
	public String getWhichMonthDate() {
		return whichMonthDate;
	}
	public void setWhichMonthDate(String whichMonthDate) {
		this.whichMonthDate = whichMonthDate;
	}
	public double getMonthly() {
		return monthly;
	}
	public void setMonthly(double monthly) {
		this.monthly = monthly;
	}
	public double getYearly() {
		return yearly;
	}
	public void setYearly(double yearly) {
		this.yearly = yearly;
	}
	public int getMarqueeID() {
		return marqueeID;
	}
	public void setMarqueeID(int marqueeID) {
		this.marqueeID = marqueeID;
	}
	
	
	
}
