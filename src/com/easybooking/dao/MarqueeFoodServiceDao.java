package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.MarqueeFoodService;

public interface MarqueeFoodServiceDao {
	public ArrayList<MarqueeFoodService> getData();
	public Integer insert(MarqueeFoodService service);
	public Integer update(MarqueeFoodService service);
	public Integer delete(MarqueeFoodService service);
	public ArrayList<MarqueeFoodService> getMaxID();
	public ArrayList<MarqueeFoodService> getServicesForMarquee(int marquee_id);
}
