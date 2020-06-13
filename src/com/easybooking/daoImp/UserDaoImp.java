package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.UserDao;
import com.easybooking.model.User;

public class UserDaoImp implements UserDao{
	
	@Override
	public ArrayList<User> getAllRecord(int id) {
		// TODO Auto-generated method stub
		ArrayList<User> list ;
		String q="from User where active ="+id;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<User>) session.createQuery(q).list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public User getDataById(int id) {
		// TODO Auto-generated method stub
		User user = null ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		user = session.get(User.class, id );
		session.close();
		factory.close();
		return user;
	}

	@Override
	public Integer addRecord(User user) {
		// TODO Auto-generated method stub
		 int i = 0;
		 SessionFactory factory = HibernateUtil.getSesssionFactory();
		 Session session = factory.openSession();
		 session.beginTransaction();
		 session.save(user);
		 session.getTransaction().commit();
		 session.close();
		 factory.close();
		return i;
	}

	@Override
	public Integer updateRecord(User user) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(user);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deleteRecord(User user) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction(); 
		session.delete(user);
		session.getTransaction().commit(); 
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<User> checkValidEmail(String email, String password) {
		// TODO Auto-generated method stub
		ArrayList<User> list ;
		String q ="from User where email = '"+email+"' and password = '"+password+"'";
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<User>) session.createQuery(q).list();
//		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer checkEmailInDb(String email) {
		// TODO Auto-generated method stub
		Integer i = 0;
		ArrayList<User> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction(); 
		list = (ArrayList<User>) session.createQuery("from User where email = '"+email+"'").list();   
		session.close();
		factory.close();
		if(list.size() > 0){
			i = 1;
		} 
		return i;
	}

	@Override
	public Integer updateUserByHQL(User user) {
		// TODO Auto-generated method stub  
		int i = 0 ;
		String query = "";  
		if(user.getContact()!=null && !user.getContact().equals("")) {
			query = "update User set contact = '"+user.getContact()+"' where id = "+user.getId();
		} 
		else if(user.getPassword()!=null){
			query = "update User set password = '"+user.getPassword()+"' where id = "+user.getId();
		}
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();		
		Query q = session.createQuery(query);
		q.executeUpdate();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer updateUserByHQLActive(User user) {
		// TODO Auto-generated method stub
		int i=0;
		String query="update User set active = "+user.getActive()+" where id = "+user.getId();
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		Query q=session.createQuery(query);
		i = q.executeUpdate();
		session.close();
		factory.close();
		return i;
	}
}
