package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.AdminDao;
import com.easybooking.model.Admin;

public class AdminDaoImp implements AdminDao{
	
	@Override
	public ArrayList<Admin> checkValidEmail(String email, String password) {
		// TODO Auto-generated method stub
		ArrayList<Admin> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction(); 
		list = (ArrayList<Admin>) session.createQuery("from Admin where email = '"+email+"' and password = '"+password+"'").list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer insert(Admin admin) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(admin);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer update(Admin admin) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(admin);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}
 
	@Override
	public Integer delete(Admin admin) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(admin);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Admin getDataByID(int id) {
		// TODO Auto-generated method stub
		Admin admin = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		admin = session.get(Admin.class, id);
		session.close();
		factory.close();
		return admin;
	}
 
	@Override
	public ArrayList<Admin> getData() {
		// TODO Auto-generated method stub
		ArrayList<Admin> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction(); 
		list = (ArrayList<Admin>) session.createQuery("from Admin where active = 1").list();
		session.close();
		factory.close();
		return list;
	}

}
