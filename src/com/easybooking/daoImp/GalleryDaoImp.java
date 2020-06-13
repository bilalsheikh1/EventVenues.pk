package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.GalleryDao;
import com.easybooking.model.Gallery;

public class GalleryDaoImp implements GalleryDao{
	
	@Override
	public ArrayList<Gallery> getImage() {
		// TODO Auto-generated method stub
		ArrayList<Gallery> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list=(ArrayList<Gallery>)session.createQuery("from Gallery").list();
		session.close();
		factory.close();
		return list;
	}
	@Override
	public Gallery getDataById(int id) {
		// TODO Auto-generated method stub
		Gallery gallery = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		gallery=session.get(Gallery.class, id);
		session.close();
		factory.close();
		return gallery;
	} 
	@Override
	public Integer addImage(Gallery gallery) {
		// TODO Auto-generated method stub
		int i  = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(gallery);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}
	@Override
	public Integer deleteImg(Gallery gallery) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(gallery);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}
	
 
}
