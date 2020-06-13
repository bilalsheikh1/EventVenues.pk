package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.FoodServicesDao;
import com.easybooking.model.FoodServices;

public class FoodServicesDaoImp implements FoodServicesDao{
	
	@Override
	public ArrayList<FoodServices> getService(int active) {
		// TODO Auto-generated method stub
		ArrayList<FoodServices> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session  session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<FoodServices>) session.createQuery("from FoodServices where active = "+active).list();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer insert(FoodServices foodService) {
		// TODO Auto-generated method stub
		int i  = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session  session = factory.openSession();
		session.beginTransaction();
		session.save(foodService);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer update(FoodServices foodService) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session  session = factory.openSession();
		session.beginTransaction();
		session.update(foodService);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer delete(FoodServices foodService) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session  session = factory.openSession();
		session.beginTransaction();
		session.delete(foodService);
		session.getTransaction().commit();
		session.close();
		factory.close(); 
		return i;
	}

	@Override
	public FoodServices getDataById(int id) {
		// TODO Auto-generated method stub
		FoodServices services = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session  session = factory.openSession();
		session.beginTransaction();
		services = session.get(FoodServices.class, id);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return services;
	}

	@Override
	public Integer insertMarqueeFoodServices(FoodServices foodServices) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session  session = factory.openSession();
		session.beginTransaction();
		session.save(foodServices);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<FoodServices> getServicesByMarqueeID(int marquee_id) {
		// TODO Auto-generated method stub
		ArrayList<FoodServices> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session  session = factory.openSession();
		session.beginTransaction(); 
		System.out.println("marquee id is : "+marquee_id);
		list = (ArrayList<FoodServices>) session.createQuery("from FoodServices where marquee_id = "+marquee_id).list();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;
	}

}
