package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Admin;

public interface AdminDao {
	public ArrayList<Admin> checkValidEmail(String email , String password );
	public Integer insert(Admin admin);
	public Integer update(Admin admin);
	public Integer delete(Admin admin);
	public Admin getDataByID(int id);
	public ArrayList<Admin> getData();
}
