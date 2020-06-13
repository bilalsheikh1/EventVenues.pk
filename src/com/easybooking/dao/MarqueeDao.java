package com.easybooking.dao;

import java.util.ArrayList;
import java.util.List;

import com.easybooking.model.Marquee;

public interface MarqueeDao {
	public Integer addMarquee(Marquee marquee);
	public Marquee getDataById(int id);
	public Integer updateMarquee(Marquee marquee);
	public Integer updateMarqueeActive(int marquee_id , byte active);
	public Integer rejectMarquee(int marquee_id , String reason);
	public Integer deleteMarquee(Marquee marquee);
	public ArrayList<Marquee> getMarqueeData();
	public ArrayList<Marquee> getMarqueeDataForApproved(int id);
	public List getMaxID();
	public ArrayList<Marquee> limitMArqueeIndexPage();
	public ArrayList<Marquee> getDataByUserId(int id);
	public ArrayList<Marquee> getMarqueeByCity(int cityID);
	public ArrayList<Marquee> getMarqueeByCityAreaWise(int cityID , int areaID);
	public ArrayList<Marquee> getNearByMarquees(String address);
}
 	