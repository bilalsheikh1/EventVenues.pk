package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.MarqueeFoodServiceDao;
import com.easybooking.model.MarqueeFoodService;

public class MarqueeFoodServiceDaoImp implements MarqueeFoodServiceDao{

	@Override
	public ArrayList<MarqueeFoodService> getData() {
		// TODO Auto-generated method stub
		ArrayList<MarqueeFoodService> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list=(ArrayList<MarqueeFoodService>) session.createQuery("from MarqueeFoodService").list();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer insert(MarqueeFoodService service) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(service);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<MarqueeFoodService> getServicesForMarquee(int marquee_id) {
		// TODO Auto-generated method stub
		ArrayList<MarqueeFoodService> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list =(ArrayList<MarqueeFoodService>) session.createQuery("from MarqueeFoodService where marquee_id = "+marquee_id).list();
		session.close();
		factory.close();
		return list;	
	}

	@Override
	public ArrayList<MarqueeFoodService> getMaxID() {
		// TODO Auto-generated method stub
		ArrayList<MarqueeFoodService> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list =( ArrayList<MarqueeFoodService>)session.createQuery("SELECT MAX(id) FROM MarqueeFoodService").list();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer update(MarqueeFoodService service) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(service);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer delete(MarqueeFoodService service) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(service);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

}
