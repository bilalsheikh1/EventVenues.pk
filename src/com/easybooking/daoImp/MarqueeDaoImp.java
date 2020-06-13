package com.easybooking.daoImp;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.MarqueeDao;
import com.easybooking.model.Marquee;

public class MarqueeDaoImp implements MarqueeDao {
	
	@Override
	public Integer addMarquee(Marquee marquee) {
		// TODO Auto-generated method stub
		int i  = 0 ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction();
		i = (int) session.save(marquee);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override 
	public Marquee getDataById(int id) {
		// TODO Auto-generated method stub
		Marquee marquee = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction(); 
		marquee = session.get(Marquee.class, id);
		session.close(); 
		factory.close(); 
		return marquee;
	}

	@Override
	public Integer updateMarquee(Marquee marquee) {
		// TODO Auto-generated method stub
		int i = 0;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction();
		session.update(marquee);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deleteMarquee(Marquee marquee) {
		// TODO Auto-generated method stub
		int i =0 ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction();
		session.delete(marquee);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<Marquee> getMarqueeData() {
		// TODO Auto-generated method stub
		ArrayList<Marquee> list ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Marquee>) session.createQuery("from Marquee where active = 1 ").list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public ArrayList<Marquee> getMarqueeDataForApproved(int id) {
		// TODO Auto-generated method stub
		ArrayList<Marquee> list ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Marquee>) session.createQuery("from Marquee where active = "+id).list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public List getMaxID() {
		// TODO Auto-generated method stub
//		ArrayList<Marquee> list ;
		List list;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction();
		list=(ArrayList<Marquee>) session.createQuery("select max(id) from Marquee").list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer updateMarqueeActive(int marquee_id, byte active) {
		// TODO Auto-generated method stub
		int i = 0 ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction();
		org.hibernate.Query q = (org.hibernate.Query) session.createQuery("update Marquee set active = :active where id = :id");
	    q.setParameter("active", active);
	    q.setParameter("id", marquee_id);
	    i = q.executeUpdate();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}
	
	

	@Override
	public ArrayList<Marquee> limitMArqueeIndexPage() {
		// TODO Auto-generated method stub
		ArrayList<Marquee> list ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Marquee>) session.createQuery("from Marquee LIMIT 6").list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public ArrayList<Marquee> getDataByUserId(int created_by) {
		// TODO Auto-generated method stub
		ArrayList<Marquee> list = null;
		try{ 
			Session session ;
			SessionFactory factory = HibernateUtil.getSesssionFactory();
			session=factory.openSession(); 
			session.beginTransaction();
			list = (ArrayList<Marquee>) session.createQuery("from Marquee where created_by = "+created_by+" and active = 1").list();  
			session.close();  
			factory.close();
		}
			catch(Exception e){
				e.printStackTrace();
				}
		return list;
	}
 
	@Override
	public ArrayList<Marquee> getMarqueeByCity(int cityID) {
		// TODO Auto-generated method stub
		ArrayList<Marquee> list ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
 		session.beginTransaction();
		list = (ArrayList<Marquee>) session.createQuery("from Marquee where city_id = "+cityID+" and active = 1").list();
		session.close(); 
		factory.close();
		return list;
	}

	@Override
	public ArrayList<Marquee> getMarqueeByCityAreaWise(int cityID, int areaID) {
		// TODO Auto-generated method stub
		ArrayList<Marquee> list ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
 		session.beginTransaction(); 
		list = (ArrayList<Marquee>) session.createQuery("from Marquee where city_id = "+cityID+" and area_id = "+areaID+" and active = 1").list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Integer rejectMarquee(int marquee_id, String reason) {
		// TODO Auto-generated method stub
		int i = 0 ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession();
		session.beginTransaction(); 
		org.hibernate.Query q = (org.hibernate.Query) session.createQuery("update Marquee set active = :active , rejectedReason =:rejectedReason where id = :id");
	    q.setParameter("active", (byte) 2);
	    q.setParameter("rejectedReason", reason);
	    q.setParameter("id", marquee_id);
	    i = q.executeUpdate();
		session.getTransaction().commit();
		session.close();
		factory.close(); 
		return i;
	}

	@Override
	public ArrayList<Marquee> getNearByMarquees(String address) {
		// TODO Auto-generated method stub
		ArrayList<Marquee> list ;
		Session session ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		session = factory.openSession(); 
 		session.beginTransaction();  
 		list = (ArrayList<Marquee>) session.createQuery("from Marquee where address2 like '%"+address+"%' and active = 1 ").list();
		session.close(); 
		factory.close(); 
		return list; 
	}
	
	
}
