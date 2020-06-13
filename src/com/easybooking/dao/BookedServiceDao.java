package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.BookedServices;

public interface BookedServiceDao {
	public Integer insertServices (BookedServices services);
	public Integer updateServices (BookedServices services);
	public Integer deleteServices (BookedServices services);
	public ArrayList<BookedServices> getBookedServices();
	public BookedServices getDataById (int id);
}
