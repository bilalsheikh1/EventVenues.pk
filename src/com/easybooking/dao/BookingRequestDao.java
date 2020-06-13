package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Booked;
import com.easybooking.model.BookingRequest;;

public interface BookingRequestDao {
	public Integer insertBooking (BookingRequest request);
	public Integer updateBookingByHQL (BookingRequest request);
	public Integer updateBookingByHQLCost (BookingRequest request);
	public Integer updateBookingAmountByHQL (int id , double advance);
	public Integer updateBooking (BookingRequest request);
	public Integer deleteBooking (BookingRequest request);
	public ArrayList<BookingRequest> getBooking(int marqueeID);
	public ArrayList<Integer> getBookingIdInsertIntoBookedTable(BookingRequest request);
	public BookingRequest getDataById(int id);
	public Integer getMaxID();
	public ArrayList<BookingRequest> checkBookingStatus(String bookedDate , String shift , int userID , int marqueeID ); // use for reqest farword to admin or not
	public ArrayList<BookingRequest> getBookingByUser(int userID);
	public ArrayList<BookingRequest> checkAvailiblityByMarqueeIdPortionID(String date, String shift, int marquee_id, int []portionID); 
	
//	public Integer deleteBookingBySameDate(String bookedDate , String shift , int marquee_id);
}

