package com.easybooking.daoImp;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.easybooking.config.HibernateUtil;
import com.easybooking.dao.BookedDao;
import com.easybooking.model.Booked;
import com.easybooking.model.BookingRequest;
import com.easybooking.model.Marquee;
import com.easybooking.model.Portion;

import antlr.collections.List;

public class BookedDaoImp implements BookedDao{
	
	@Override
	public Integer insertBooking(Booked booking) {
		// TODO Auto-generated method stub
		int i = 0;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession(); 
		session.beginTransaction();
		session.save(booking); 
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer updateBooking(Booked booking) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		session.update(booking);
		session.getTransaction().commit();
		session.close();
		factory.close();
		return i;
	}

	@Override
	public Integer deleteBooking(Booked booking) {
		// TODO Auto-generated method stub
		int i = 0 ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		session.delete(booking); 
		session.getTransaction().commit();
		session.close(); 
		factory.close();
		return i;
	} 

	@Override
	public ArrayList<Booked> getBooking() {
		// TODO Auto-generated method stub
		ArrayList<Booked> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Booked>) session.createQuery("from Booked where active = 1").list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public Booked getDataById(int id) {
		// TODO Auto-generated method stub
		Booked booking = null;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		booking = session.get(Booked.class, id);
		session.close();
		factory.close();
		return booking; 
	} 
 
	@Override
	public ArrayList<Booked> getBookingApprovedUpcoming(int marquee_id) {
		// TODO Auto-generated method stub
		ArrayList<Booked> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();   
		session.beginTransaction(); 
		list = (ArrayList<Booked>) session.createQuery("from Booked b WHERE CURRENT_DATE <= b.bookingRequest.bookedDate and b.marquee_id = "+marquee_id).list();
		session.close();
		factory.close();
		return list;
	}

	@Override 
	public ArrayList<Booked> countApprovedReqest(int marquee_id) {
		// TODO Auto-generated method stub
		ArrayList<Booked> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();      
		list = (ArrayList<Booked>) session.createQuery("from Booked b WHERE CURRENT_DATE <= b.bookingRequest.bookedDate and marquee_id = "+marquee_id).list();
		session.close();
		factory.close();
		return list; 
	} 
	  
	@Override
	public ArrayList<Booked> checkAvailiblityByMarqueeID( int marquee_id) {
		// TODO Auto-generated method stub 
		ArrayList<Booked> list1 = null;
		ArrayList<Booked> list = null;
		java.util.List<Booked> listi = new ArrayList<Booked>();
		String q = "";
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession(); 
  		session.beginTransaction();      
//		if(shift.equals("")){
			q = "from Booked b where marquee_id = "+marquee_id ;
			list = (ArrayList<Booked>) session.createQuery(q).list();
//		}
// 		else{   
//			for(int i = 0 ; i<portionID.length ; i++ ){   
//				System.out.println("loop is "+portionID[i]); 
//				q = "from Booked b where b.bookingRequest.bookedDate = '"+date+"' and  b.bookingRequest.shift = '"+shift+"' and b.bookingRequest.portion_id = "+portionID[i]+" and marquee_id ="+marquee_id;
//				Query qu = session.createQuery(q);
//				System.out.println(qu.list());
//				listi.addAll(  qu.list() );
////				for (Booked b : list1) { 
////					System.out.println(b.getBookingRequest().getBookedDate());
////					list.add(b);
////					}
//			}       
////			list = (ArrayList<Booked>) qu.getResultList();
//		}  
		session.close(); 
		factory.close();
		return list;
	}

	@Override 
	public ArrayList<Booked> reports(String startDate, String endDate, int marquee) {
		// TODO Auto-generated method stub
		ArrayList<Booked> list ;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();  
		list = (ArrayList<Booked>) session.createQuery("from Booked b where b.marquee_id = "+marquee+" and b.bookingRequest.bookedDate between '"+startDate+"' and '"+endDate+"'").list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public ArrayList<Booked> getFilterData( String date, String shift,  int marquee_id) {
		// TODO Auto-generated method stub
		ArrayList<Booked> list ;
		String q ="";
		if(date.equals("") || date == null){
			q = "from Booked b where b.bookingRequest.shift = '"+shift+"' and marquee_id = "+marquee_id; 
		}
		else{
		 q = "from Booked b where b.bookingRequest.bookedDate = '"+date+"' and b.bookingRequest.shift = '"+shift+"' and marquee_id = "+marquee_id;
		}
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Booked>) session.createQuery(q).list();
		session.close();
		factory.close();
		return list;
	}
 
	@Override 
	public ArrayList<Booked> getRemainingData(String date , int marquee_id) {
		// TODO Auto-generated method stub
		ArrayList<Booked> list ;
		String q = "";
		if(date.equals("")){  
			q = "from Booked b where b.bookingRequest.cost-b.bookingRequest.advance > 0  and marquee_id ="+marquee_id; 			 	
		} 
		else {
			q = "from Booked b where b.bookingRequest.bookedDate = '"+date+"' and b.bookingRequest.cost-b.bookingRequest.advance > 0  and marquee_id ="+marquee_id;

		}   
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();  
		session.beginTransaction();
		list = (ArrayList<Booked>) session.createQuery(q).list();
		session.close();
		factory.close();
		return list;
	}

	@Override
	public ArrayList<Booked> checkAvailiblityByPortionMarquee(String date, String shift, int marquee_id,
			int portionID[]) {
		// TODO Auto-generated method stub
		
		ArrayList<Booked> list = new ArrayList<Booked>();;
		SessionFactory factory = HibernateUtil.getSesssionFactory();	
		Session session = factory.openSession();
		session.beginTransaction();
		for(int i : portionID){
			String q = "from Booked b where b.bookingRequest.bookedDate = '"+date+"' and  b.bookingRequest.shift = '"+shift+"' and b.bookingRequest.portion_id = "+i+" and marquee_id ="+marquee_id;
			list.addAll((ArrayList<Booked>) session.createQuery(q).list());
		}
		session.close();
		factory.close();    
		System.out.println(" size is "+list.size());
		return list;
	}

	@Override
	public ArrayList<Booked> getParticularMarqueeBooking(int marquee_id) {
		// TODO Auto-generated method stub
//		Booked b = null;
		ArrayList<Booked> list = null;
		String q = "from Booked where marquee_id = "+marquee_id; 
		SessionFactory factory = HibernateUtil.getSesssionFactory();
		Session session = factory.openSession();
		session.beginTransaction();
		list = (ArrayList<Booked>) session.createQuery(q).list();
		session.getTransaction().commit();
		session.close();
		return list;
	}


	
}
