package com.easybooking.daoImp;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.PortionDao;
import com.easybooking.model.Portion;

public class PortionDaoImp implements PortionDao{
	
	@Override
	public ArrayList<Portion> getPortion() {
		// TODO Auto-generated method stub
		ArrayList<Portion> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Portion>)session.createQuery("from Portion").list();
		session.close();
		return list;
	}
	@Override
	public Portion getDataById(int id) {
		// TODO Auto-generated method stub
		Portion portion = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		portion = session.get(Portion.class, id);
		session.close(); 
//		System.out.println(portion.getName()); 
		return portion;
	}
	@Override
	public Integer addPortion(Portion portion) {
		// TODO Auto-generated method stub
		int i  = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(portion);
		session.getTransaction().commit();
		session.close();
		return i;
	}
	@Override
	public Integer updatePortion(Portion portion) {
		// TODO Auto-generated method stub
		int i  = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(portion);
		session.getTransaction().commit();
		session.close();
		return i;
	}
	@Override
	public Integer deletePortion(Portion portion) {
		// TODO Auto-generated method stub
		int i  = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(portion);
		session.getTransaction().commit();
		session.close();
		return i;
	}
	@Override
	public ArrayList<Portion> getMaxID() {
		// TODO Auto-generated method stub
		ArrayList<Portion> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list=(ArrayList<Portion>) session.createQuery("select max(id) from Portion").list();
		session.getTransaction().commit();
		session.close();
		return list;
	}
	@Override
	public ArrayList<Portion> getPortionForMarquee(int sessionMarquee_id) {
		// TODO Auto-generated method stub
		ArrayList<Portion> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Portion>) session.createQuery("from Portion where marquee_id = "+sessionMarquee_id).list();
		session.getTransaction().commit();
		session.close();
		return list;
	}
	
	
	
}
