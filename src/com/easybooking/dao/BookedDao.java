package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Booked;

public interface BookedDao {
	public Integer insertBooking (Booked booking);
	public Integer updateBooking (Booked booking);
	public Integer deleteBooking (Booked booking);
//	public Integer deleteBookingBySameDate (Booked booking);
	public ArrayList<Booked> getBooking();
	public Booked getDataById(int id); 
	public ArrayList<Booked> getBookingApprovedUpcoming(int marquee_id); 
	public ArrayList<Booked> countApprovedReqest(int marquee_id);
	public ArrayList<Booked> checkAvailiblityByMarqueeID(int marquee_id );
	public ArrayList<Booked> checkAvailiblityByPortionMarquee(String date ,String shift ,int marquee_id , int portionID[]);
	public ArrayList<Booked> reports(String startDate ,String endDate ,int marquee);
//	public ArrayList<Booked> getBookingByShift(String shift , int marqueeID);
	public ArrayList<Booked> getFilterData(String date ,String shift  , int marqueeID);
	public ArrayList<Booked> getRemainingData(String date , int marquee_id);
	public ArrayList<Booked> getParticularMarqueeBooking(int marquee_id);
}
