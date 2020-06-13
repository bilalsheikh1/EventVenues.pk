package com.easybooking.dto;

public class BookedDTO {
	private int id , capacity ,portionID;
	private String date , shift , eventName , marqueeName ,name ,contact ,portionName;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) { 
		this.date = date;
	} 
	public String getShift() {
		return shift;
	}
	public void setShift(String shift) {
		this.shift = shift;
	}
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public String getMarqueeName() {
		return marqueeName;
	}
	public void setMarqueeName(String marqueeName) {
		this.marqueeName = marqueeName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public int getPortionID() {
		return portionID;
	}
	public void setPortionID(int portionID) {
		this.portionID = portionID;
	}
	public String getPortionName() {
		return portionName;
	}
	public void setPortionName(String portionName) {
		this.portionName = portionName;
	}
	
	
}
