package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.AreaDao;
import com.easybooking.model.Area;

public class AreaDaoImp implements AreaDao {

	
	@Override
	public ArrayList<Area> getAreas() {
		// TODO Auto-generated method stub
		ArrayList<Area> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session= factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Area>) session.createQuery("from Area").list(); 
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;	
	}

	@Override
	public Integer insertArea(Area area) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(area);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer updateArea(Area area) {
		// TODO Auto-generated method stub
		int i  = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(area);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deleteArea(Area area) {
		// TODO Auto-generated method stub
		int i  = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(area);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;   
	}

	@Override
	public Area getDataById(int id) {
		// TODO Auto-generated method stub
		Area area = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();  
		area=session.get(Area.class, id); 
		session.getTransaction();
		session.close();
		factory.close();
		return area;
	}

	@Override
	public ArrayList<Area> getAreaByCity_id(int city_id) {
		// TODO Auto-generated method stub
		String q= "from Area where city_id = "+city_id;
		ArrayList<Area> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Area>) session.createQuery(q).list();
		session.getTransaction();
		session.close();
		factory.close();
		return list;  
	}

}
