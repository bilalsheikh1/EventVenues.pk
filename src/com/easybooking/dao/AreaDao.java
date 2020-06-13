package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Area;

public interface AreaDao {
	public ArrayList<Area> getAreas();
	public Integer insertArea(Area area);
	public Integer updateArea(Area area);
	public Integer deleteArea(Area area);
	public Area getDataById(int id);
	public ArrayList<Area> getAreaByCity_id(int city_id);
}
