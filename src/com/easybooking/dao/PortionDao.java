package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Portion;
import com.sun.xml.internal.ws.wsdl.writer.document.Port;

public interface PortionDao {
	public ArrayList<Portion> getPortion();
	public Portion getDataById(int id);
	public Integer addPortion(Portion portion);
	public Integer updatePortion(Portion portion);
	public Integer deletePortion(Portion portion);
	public ArrayList<Portion> getMaxID();
	public ArrayList<Portion> getPortionForMarquee(int sessionMarquee_id);
}
