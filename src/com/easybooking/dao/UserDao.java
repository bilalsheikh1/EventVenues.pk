package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.User;

public interface UserDao {
	public ArrayList<User> getAllRecord(int id);
	public User getDataById(int id);
	public Integer addRecord(User user);
	public Integer updateRecord(User user);
	public Integer deleteRecord(User user);
	public ArrayList<User> checkValidEmail(String email , String password );
	public Integer checkEmailInDb(String email);
	public Integer updateUserByHQL(User user);
	public Integer updateUserByHQLActive(User user);
}
