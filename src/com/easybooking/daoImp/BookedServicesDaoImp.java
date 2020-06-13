package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.BookedServiceDao;




public class BookedServicesDaoImp implements BookedServiceDao{
	
	@Override
	public Integer insertServices(com.easybooking.model.BookedServices services) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(services);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer updateServices(com.easybooking.model.BookedServices services) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(services);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deleteServices(com.easybooking.model.BookedServices services) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(services);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<com.easybooking.model.BookedServices> getBookedServices() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public com.easybooking.model.BookedServices getDataById(int id) {
		// TODO Auto-generated method stub
		com.easybooking.model.BookedServices services = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		services = session.get(com.easybooking.model.BookedServices.class, id);
		session.close();
		factory.close();
		return services;
	}

}
