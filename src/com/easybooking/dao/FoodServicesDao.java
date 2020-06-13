package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.FoodServices;

public interface FoodServicesDao {
	public ArrayList<FoodServices> getService(int active);
	
	public Integer update(FoodServices foodService);
	public Integer delete(FoodServices foodService);
	public FoodServices getDataById(int id);
	public Integer insertMarqueeFoodServices(FoodServices foodServices);
	
	// Update Here ***
	
	public Integer insert(FoodServices foodService);
	public ArrayList<FoodServices> getServicesByMarqueeID(int marquee_id);
	
}
