package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import com.easybooking.dao.BookedDao;
import com.easybooking.dao.BookingRequestDao;
import com.easybooking.daoImp.BookedDaoImp;
import com.easybooking.daoImp.BookingRequestDaoImp;
import com.easybooking.model.Booked;
import com.easybooking.model.BookingRequest;
import com.easybooking.model.Marquee;
import com.easybooking.model.Portion;
import com.easybooking.model.User;

/**
 * Servlet implementation class BookingRequestServlet
 */
@WebServlet("/BookingRequestServlet")
public class BookingRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingRequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		Integer marqueeID , capacity , userID;
		String eventName="", contact="", shift="" ,bookDate=""; 
		double cost , advance;
		
		HttpSession session = request.getSession();
		PrintWriter pw = response.getWriter();
		Date date ;
		
		BookingRequest requestBean = new BookingRequest();
		BookingRequestDao requestDao = new BookingRequestDaoImp();
		Marquee marqueeBean = new Marquee();
		Portion portionBean = new Portion();
		User userBean = new User();
		
		
		if(session.getAttribute("id")!=null && request.getParameter("marqueeID")!=null){
			
			userID = Integer.parseInt(""+session.getAttribute("id"));
			marqueeID = Integer.parseInt(""+request.getParameter("marqueeID"));  
			eventName = request.getParameter("name");
			contact = request.getParameter("contact");
			shift = request.getParameter("shift");
			capacity = Integer.parseInt(request.getParameter("capacity")); 
			bookDate = request.getParameter("date");
		    ArrayList<Integer> list = new ArrayList<Integer>();	
		    
			for(int i = 0 ; i<Integer.parseInt(request.getParameter("portionRange")) ; i++){
				if(request.getParameter("portionID"+i)!=null){
					list.add(Integer.parseInt(request.getParameter("portionID"+i)));
				}
			}
			for(int pID : list){
				
				requestBean.setEventName(eventName);  
				requestBean.setContact(contact);
				requestBean.setShift(shift);
				requestBean.setCapacity(capacity);
				requestBean.setBookedDate(bookDate);
				marqueeBean.setId(marqueeID);
				requestBean.setMarquee(marqueeBean);
				portionBean.setId(pID); 
				requestBean.setPortion(portionBean);
				userBean.setId(userID);
				requestBean.setUser_id(userBean);
		 	
				requestDao.insertBooking(requestBean);
			}
			pw.write("Booking Inserted"); 
			 
		}
		else if(request.getParameter("method")!=null){
			if(request.getParameter("method").equals("disApproved")){
				requestBean.setId(Integer.parseInt(request.getParameter("id")));
				requestBean.setActive((byte) 3);  
				requestDao.updateBookingByHQL(requestBean);
				int serialNo=0;
				for(BookingRequest r : requestDao.getBooking(Integer.parseInt(""+session.getAttribute("marquee_id")))){ 
					serialNo++; 
					pw.write("<tr>"+ 
							"<td>"+serialNo+"</td>"+
							"<td>"+r.getEventName()+"</td>"+
							"<td>"+r.getCapacity()+"</td>"+
							"<td>"+r.getShift()+"</td>"+
							"<td>"+r.getBookedDate()+"</td>"+
							"<td>"+r.getContact()+"</td>"+ 
							"<td><input type='image' id='image' src='../backend/img/checked.png' onclick='approved("+r.getId()+" , "+r.getMarquee().getId()+" )' value="+r.getId()+" />"+  
                  			"<input type='image' id='image' src='../backend/img/cancel.png' onclick='disApproved("+r.getId()+" , "+r.getMarquee().getId()+" )' value="+r.getId()+" />"+   
							"</td></tr>");
				}
			}
			
			else if(request.getParameter("method").equals("admin-book")){

				marqueeID = Integer.parseInt(request.getParameter("marquee_id"));
				eventName = request.getParameter("eventName");
				String name = request.getParameter("name");
				contact = request.getParameter("contact");
				capacity = Integer.parseInt(request.getParameter("capacity"));
				cost = Double.parseDouble(request.getParameter("cost"));
				advance =Double.parseDouble(request.getParameter("advance"));
				bookDate = request.getParameter("date");
				shift = request.getParameter("shift");
				
				Booked bookedBean = new Booked();
				BookedDao bookedDao = new BookedDaoImp();
				
				int portionID[]= new int[Integer.parseInt(request.getParameter("portionRange"))];
				
				for(int i = 0 ; i < portionID.length; i++){
					if(request.getParameter("portionID"+i)!=null){
						portionID[i]= Integer.parseInt(request.getParameter("portionID"+i));
					}
				} 
				ArrayList<Booked> list = new ArrayList<Booked>(); 
				list = bookedDao.checkAvailiblityByPortionMarquee(bookDate, shift, marqueeID, portionID);

				if (list.size() > 0 ){
					pw.write("Marquee already booked"); 
				} 
				else{
				
					marqueeBean.setId(marqueeID);
					requestBean.setMarquee(marqueeBean);
					requestBean.setEventName(eventName);
					requestBean.setBookName(name);
					requestBean.setContact(contact);
					requestBean.setCapacity(capacity);
					requestBean.setCost(cost);
					requestBean.setAdvance(advance);
					requestBean.setBookedDate(bookDate);
					requestBean.setShift(shift);
					requestBean.setActive((byte) 2);
					for(int i : portionID){
						portionBean.setId(i);
						requestBean.setPortion(portionBean);
						requestDao.insertBooking(requestBean);
					}	
					ArrayList<Integer> listID = new ArrayList<Integer>();
					System.out.println(shift); 
					listID = requestDao.getBookingIdInsertIntoBookedTable(requestBean);
					
					for(int j : listID){ 
						requestBean.setId(j); 
						bookedBean.setBookingRequest(requestBean);
						bookedBean.setMarquee_id(marqueeID);
					
						bookedDao.insertBooking(bookedBean);
					}
				 
					pw.write("Booking Inserted Successfully");
				}
			}
		} 
		
		else if( request.getParameter("update_advance") !=null ){ 
			
			System.out.println("under "+" ok ok ");
			int id = Integer.parseInt(request.getParameter("id")); 
			advance = Double.parseDouble(request.getParameter("update_advance"));
			 
			requestDao.updateBookingAmountByHQL(id, advance);
			pw.write("Amount Added");
			 
		} 
		
	} 
		
}


