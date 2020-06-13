package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.City;

public interface CityDao {
	public ArrayList<City> getCities();
	public Integer insert(City city);
	public Integer update(City city);
	public Integer delete(City city);
	public City getDataById(int id);
}
