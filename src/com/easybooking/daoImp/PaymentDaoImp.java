package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.PaymentDao;
import com.easybooking.model.Payment;

public class PaymentDaoImp implements PaymentDao{

	@Override
	public Integer insertPaymentRecord(Payment payment) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(payment);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer updatePaymentRecord(Payment payment) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(payment);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deletePaymentRecord(Payment payment) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(payment);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Payment getDataByID(int id) {
		// TODO Auto-generated method stub
		Payment payment = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		payment = session.get(Payment.class, id);
		session.close();
		factory.close();
		return payment;
	}

	@Override
	public ArrayList<Payment> getPaymentRecord() {
		// TODO Auto-generated method stub
		ArrayList<Payment> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Payment>)session.createQuery("from Payment").list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public ArrayList<Payment> getPaymentPending() {
		// TODO Auto-generated method stub
		
		ArrayList<Payment> list ;
		String q ="from Payment where active = 1" ; 
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();  
		list = (ArrayList<Payment>) session.createQuery(q).list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer updatePaymentRecordActive0(int marquee_id) {
		// TODO Auto-generated method stub
		int i = 0 ;
		String query= "Update Payment set active = 0 where marquee_id="+marquee_id;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		Query q = session.createQuery(query);
		q.executeUpdate();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}
	
}
