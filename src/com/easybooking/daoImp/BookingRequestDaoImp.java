package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.BookingRequestDao;
import com.easybooking.model.Booked;
import com.easybooking.model.BookingRequest;

public class BookingRequestDaoImp implements BookingRequestDao {
	
	@Override
	public Integer insertBooking(BookingRequest request) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.save(request);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer updateBookingByHQL(BookingRequest request) {
		// TODO Auto-generated method stub
 		int i = 0;
		String query="";
		if(request.getBookedDate()!=null){
  			query = "update BookingRequest set active = '"+request.getActive()+"'  where shift = '"+request.getShift()+"' and bookedDate = '"+request.getBookedDate()+"' and marquee_id = "+request.getMarquee().getId()+" and user_id = "+request.getUser_id().getId()+" and eventName ='"+request.getEventName()+"' and capacity = "+request.getCapacity();
		}
		else if(request.getActive()!=null){ 
			query = "update BookingRequest set active = '"+request.getActive()+"'  where id="+request.getId();
		}
		else { 
			query = "update BookingRequest set cost = '"+request.getCost()+"' , advance = '"+request.getAdvance()+"' where id = "+request.getId();
		}
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
//		session.update(request); 
 		Query q = session.createQuery(query);
		i = q.executeUpdate(); 
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deleteBooking(BookingRequest request) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(request);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<BookingRequest> getBooking(int marqueeID) {
		// TODO Auto-generated method stub 
		ArrayList<BookingRequest> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();   
		list = (ArrayList<BookingRequest>) session.createQuery("from BookingRequest where active = 1 and CURRENT_DATE <= bookedDate and marquee_id = "+marqueeID).list();   
		session.close(); 
		factory.close();
		return list;
	} 

	@Override
	public BookingRequest getDataById(int id) {
		// TODO Auto-generated method stub
		BookingRequest request = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		request = session.get(BookingRequest.class, id);
		session.close();
		factory.close();
		return request;
	}

	@Override
	public Integer getMaxID() {
		// TODO Auto-generated method stub
		Integer i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		i=(int)session.createQuery("select MAX(id) from BookingRequest").list().get(0);
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<BookingRequest> checkBookingStatus(String date , String shift , int userID , int marqueeID ) {
		// TODO Auto-generated method stub
		ArrayList<BookingRequest> list = new ArrayList<BookingRequest>();; 
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
  		session.beginTransaction();      
//  		for(int i = 0 ; i < portionID.length ; i++){
  			String q = "from BookingRequest  where bookedDate = '"+date+"' and  shift = '"+shift+"' and user_id = "+userID+" and marquee_id = "+marqueeID+" and active = 1";// and portion_id = "+portionID[i];
  				list .addAll( (ArrayList<BookingRequest>) session.createQuery(q).list());
//  		}
		session.close(); 
		factory.close();
		return list;  
	}

	@Override
	public Integer updateBooking(BookingRequest request) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(request);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer updateBookingAmountByHQL( int id , double advance ) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		Query q = session.createQuery("update BookingRequest set advance = '"+advance+"' where id = "+id);
		q.executeUpdate();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<BookingRequest> getBookingByUser(int userID) {
		// TODO Auto-generated method stub
		ArrayList<BookingRequest> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<BookingRequest>)session.createQuery("from BookingRequest where user_id = "+userID+" ORDER BY bookedDate DESC").list();
		session.close();
		factory.close();
		return list; 
	}
	
	@Override
	public Integer updateBookingByHQLCost(BookingRequest request) {
		// TODO Auto-generated method stub
		int i= 0 ;
		String query = "update BookingRequest set cost = '"+request.getCost()+"' , advance = '"+request.getAdvance()+"' where id = "+request.getId();
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
//	session.update(request); 
		Query q = session.createQuery(query);
		i = q.executeUpdate(); 
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public ArrayList<Integer> getBookingIdInsertIntoBookedTable(BookingRequest request) {
		// TODO Auto-generated method stub
		ArrayList<Integer> list = new ArrayList<Integer>();
		String q="";
		if(request.getActive()==2){ 
			q="select id from BookingRequest where shift = '"+request.getShift()+"' and bookedDate = '"+request.getBookedDate()+"' and marquee_id = "+request.getMarquee().getId()+" and eventName ='"+request.getEventName()+"' and capacity = "+request.getCapacity()+" and active = 2";
		}
		else{
			q="select id from BookingRequest where shift = '"+request.getShift()+"' and bookedDate = '"+request.getBookedDate()+"' and marquee_id = "+request.getMarquee().getId()+" and user_id = "+request.getUser_id().getId()+" and eventName ='"+request.getEventName()+"' and capacity = "+request.getCapacity()+" and active = 1";
		}
		
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction(); 
		list = (ArrayList<Integer>) session.createQuery(q).list();
		session.getTransaction().commit();
		session.close();
		factory.close();
		return list; 
	}

	@Override
	public ArrayList<BookingRequest> checkAvailiblityByMarqueeIdPortionID(String date, String shift, int marquee_id,
			int[] portionID) {
		// TODO Auto-generated method stub
		ArrayList<BookingRequest> list=null;
		String q="";
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		for(int i = 0 ; i<portionID.length ; i++ ){ 
			q = "from BookingRequest where bookedDate = '"+date+"' and  shift = '"+shift+"' and portion_id = "+portionID[i]+" and marquee_id ="+marquee_id;
			list = (ArrayList<BookingRequest>) session.createQuery(q).list();
		}
		System.out.println(list.size());
		session.close();
		factory.close();
		return list;
	}



} 
