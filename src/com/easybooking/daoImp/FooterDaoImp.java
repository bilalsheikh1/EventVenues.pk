package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.FooterDao;
import com.easybooking.model.Footer;

public class FooterDaoImp implements FooterDao{

	@Override
	public Integer insertFooter(Footer footer) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(footer);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer updateFooter(Footer footer) {
		// TODO Auto-generated method stub
		int i =0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(footer);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deleteFooter(Footer footer) {
		// TODO Auto-generated method stub
		int i =0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(footer);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<Footer> getFooterData() {
		// TODO Auto-generated method stub
		ArrayList<Footer> list =null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Footer>) session.createQuery("from Footer").list();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Footer getDataById(int id) {
		// TODO Auto-generated method stub
		Footer footer = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		footer = session.get(Footer.class,id);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return footer;
	}
	
}
