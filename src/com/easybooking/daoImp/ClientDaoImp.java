package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.ClientDao;
import com.easybooking.model.Client;

import jdk.nashorn.internal.runtime.regexp.JoniRegExp.Factory;

public class ClientDaoImp implements ClientDao{

	@Override
	public ArrayList<Client> getClients() {
		// TODO Auto-generated method stub
		ArrayList<Client> list ;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Client>) session.createQuery("from Client").list();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer insertClient(Client client) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(client);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
		
	}

	@Override
	public Integer updateClient(Client client) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(client);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deleteClient(Client client) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory  = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(client);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Client getDataById(int id) {
		// TODO Auto-generated method stub
		Client client = null;
		return client;
	}

}
