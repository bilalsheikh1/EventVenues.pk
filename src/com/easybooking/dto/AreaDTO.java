package com.easybooking.dto;

import java.util.ArrayList;

public class AreaDTO {
	
	private int id , city_id;
	private String name;
//	private ArrayList<String> listName;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCity_id() {
		return city_id;
	}
	public void setCity_id(int city_id) {
		this.city_id = city_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
