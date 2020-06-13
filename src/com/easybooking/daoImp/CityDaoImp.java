package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.CityDao;
import com.easybooking.model.City;

public class CityDaoImp implements CityDao{
	
	@Override
	public ArrayList<City> getCities() {
		// TODO Auto-generated method stub
		ArrayList<City> list ;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session  session = factory.openSession();
		session.beginTransaction();
		list=(ArrayList<City>)session.createQuery("from City where active=1").list();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;
	}
	@Override
	public Integer insert(City city) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(city);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}
	@Override
	public Integer update(City city) {
//		 TODO Auto-generated method stub 
		int i = 0;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
//		session.update(city);
		Query query= session.createQuery("update City set name = '"+city.getName()+"' , updatedAt = '"+city.getUpdated_at()+"' where id = "+city.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}
	@Override
	public Integer delete(City city) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(city);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i ;
	}
	@Override
	public City getDataById(int id) {
		// TODO Auto-generated method stub
		City city = null;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		city=session.get(City.class, id);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return city;
	}
	
	
}
