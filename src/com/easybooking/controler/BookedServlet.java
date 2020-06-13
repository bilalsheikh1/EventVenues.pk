package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import java.util.Properties;
 
//import javax.mail.Message;
//import javax.mail.MessagingException;
//import javax.mail.Multipart;
//import javax.mail.PasswordAuthentication;
//import javax.mail.Session; 
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeBodyPart;
//import javax.mail.internet.MimeMessage;
//import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.ha.backend.Sender;

import com.easybooking.confirmation.EmailSMSSending;
import com.easybooking.dao.BookedDao;
import com.easybooking.dao.BookingRequestDao;
import com.easybooking.daoImp.BookedDaoImp;
import com.easybooking.daoImp.BookingRequestDaoImp;
import com.easybooking.dto.BookedDTO;
import com.easybooking.dto.CalenderDTO;
import com.easybooking.model.Booked;
import com.easybooking.model.BookedServices;
import com.easybooking.model.BookingRequest;
import com.easybooking.model.Marquee;
import com.easybooking.model.Portion;
import com.easybooking.model.User;
import com.google.gson.Gson;
import com.sun.scenario.effect.impl.prism.PrTexture;

import sun.java2d.pipe.SpanShapeRenderer.Simple;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/BookingServlet")
public class BookedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookedServlet() {
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
		
		Integer marqueeID , capacity , userID , id ;
		String eventName="", contact="", shift="" ,bookDate="",check=""; 
		
		HttpSession session = request.getSession();
		PrintWriter pw = response.getWriter();
		Gson gson = new Gson();
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd" , Locale.ENGLISH);
		Date date = new Date();
		
		Booked bookedBean = new Booked();
		BookedDao bookedDao = new BookedDaoImp();
		Marquee marqueeBean = new Marquee();
		User userBean = new User();
		BookingRequest requestBean = new BookingRequest();
		
		
		if(request.getParameter("check")!=null && session.getAttribute("id")!=null && request.getParameter("marqueeID")!=null){
			BookingRequestDao requestDao = new BookingRequestDaoImp();	
			userID = Integer.parseInt(""+session.getAttribute("id"));
			marqueeID = Integer.parseInt(""+request.getParameter("marqueeID"));

			int portionID[]= new int[Integer.parseInt(request.getParameter("portionRange"))];
//			int portion[]= new int[Integer.parseInt(request.getParameter("portionRange"))];
			
			for(int i = 0 ; i < portionID.length; i++){
				if(request.getParameter("portionID"+i)!=null){
					portionID[i]= Integer.parseInt(request.getParameter("portionID"+i));
				}
//				if(request.getParameter("portion"+i)!=null){
////					portion[i] = Integer.parseInt(request.getParameter("portion"+i));
//				} 
			} 
				bookDate = request.getParameter("date");
				shift = request.getParameter("shift");
				ArrayList<Booked> list = new ArrayList<Booked>(); 
				list =bookedDao.checkAvailiblityByPortionMarquee(bookDate, shift, marqueeID, portionID); 
//				for(int i : portionID){	
//					list.addAll( bookedDao.checkAvailiblityByPortionMarquee(bookDate, shift, marqueeID, i));
//				} 
				if (list.size() > 0){  
					if(list.size() == portionID.length){  
						pw.write("Marquee already booked");
					}
					else{
						ArrayList<BookedDTO> listDTO = new ArrayList<BookedDTO>();
						for(Booked b : list){
							BookedDTO dto = new BookedDTO();
							if(b.getBookingRequest().getPortion()!=null) {
								dto.setPortionID(b.getBookingRequest().getPortion().getId());
								dto.setPortionName(b.getBookingRequest().getPortion().getName()); }
								listDTO.add(dto);
							}
						pw.write(gson.toJson(listDTO));
					}
					
				}   
				else {    
					if(requestDao.checkBookingStatus(bookDate, shift, userID, marqueeID ).size() > 0){
						pw.write("already requested"); 
					}
					
					else{
						pw.write("marquee not book");
					}
				}
			
		}
		
		else if(request.getParameter("method")!=null){
			if(request.getParameter("method").equals("getData")){
				
				ArrayList<BookedDTO> list = new ArrayList<BookedDTO>();
				userID = Integer.parseInt(""+session.getAttribute("id"));
				marqueeID = Integer.parseInt(""+session.getAttribute("marquee_id"));
				for ( Booked b : bookedDao.checkAvailiblityByMarqueeID(marqueeID )){
					BookedDTO dto = new BookedDTO();
					dto.setId(b.getId());
					dto.setDate(b.getBookingRequest().getBookedDate());
					dto.setShift(b.getBookingRequest().getShift());
					dto.setEventName(b.getBookingRequest().getEventName());  
					list.add(dto); 
				}
				pw.write(gson.toJson(list)); 
			}
			
			else if(request.getParameter("method").equals("calender")){
				ArrayList<CalenderDTO> list = new ArrayList<CalenderDTO>();
				userID = Integer.parseInt(""+session.getAttribute("id"));
				marqueeID = Integer.parseInt(""+session.getAttribute("marquee_id"));
				for ( Booked b : bookedDao.checkAvailiblityByMarqueeID(marqueeID )){ 
					CalenderDTO dto = new CalenderDTO();
					if(b.getBookingRequest().getPortion()!=null) 
						dto.setTitle(b.getBookingRequest().getPortion().getName()+" "+b.getBookingRequest().getShift());
					else  
					dto.setTitle("Booked "+b.getBookingRequest().getShift());
					dto.setStart(b.getBookingRequest().getBookedDate());
					dto.setBackgroundColor("#0073b7");
					dto.setBorderColor("#0073b7");  
					list.add(dto);
				}
				pw.write(gson.toJson(list)); 
			}
			
			else if(request.getParameter("method").equals("approved")){	
				
				id=Integer.parseInt(request.getParameter("id"));
				marqueeID = Integer.parseInt(request.getParameter("marqueeID"));
				shift = request.getParameter("shift");
				String bookedDate =  request.getParameter("bookedDate"); 
				double cost = Double.parseDouble(request.getParameter("cost"));
				double advance = Double.parseDouble(request.getParameter("advance"));
				userID = Integer.parseInt(request.getParameter("userID"));
				capacity = Integer.parseInt(request.getParameter("capacity"));
				
				eventName = request.getParameter("eventName");
				
				BookingRequestDao bookingRequestDao = new BookingRequestDaoImp();
				
				requestBean.setId(id);
				requestBean.setCost(cost);
				requestBean.setAdvance(advance);
				  
				bookingRequestDao.updateBookingByHQLCost(requestBean);
				
				requestBean.setId(id);     
				marqueeBean.setId(marqueeID);
				requestBean.setMarquee(marqueeBean);
				requestBean.setShift(shift);
				requestBean.setBookedDate(bookedDate); 
				requestBean.setEventName(eventName);
				requestBean.setCapacity(capacity);
				userBean.setId(userID);
				requestBean.setUser_id(userBean);
				requestBean.setActive((byte) 0); 
				
				for(int i : bookingRequestDao.getBookingIdInsertIntoBookedTable(requestBean)){
					requestBean.setId(i); 
					bookedBean.setBookingRequest(requestBean);
					bookedBean.setMarquee_id(marqueeID);
					bookedDao.insertBooking(bookedBean); 
				}
				
				bookingRequestDao.updateBookingByHQL(requestBean);
				
				/**
				Email Sending  
				
			*/
			
			// String user="saad.coder@gmail.com";//change accordingly  
			 //String password="Allah-Hu-Akbar";//change accordingly  
			  final String user = "easy.bookeeng@gmail.com";   
			  final String password = "arbazbilal123";   
			  String to= request.getParameter("email");//"saad.coder@gmail.com";//change accordingly      

			  EmailSMSSending send = new EmailSMSSending();
			  
			  send.email(to, user, password, "javax.net.ssl.SSLSocketFactory", request.getParameter("userName"), request.getParameter("marqueeName"), eventName,
					  shift, bookedDate, advance, cost);
		 
			  
			  send.smsSend("easybooking", "bilal@123", "msg", "number"
					  , "https://bulksms.vsms.net/eapi/submission/send_sms/2/2.0");
			  
				int serialNo=0;
				eventName="";
				for(BookingRequest r : bookingRequestDao.getBooking(Integer.parseInt(""+session.getAttribute("marquee_id")))){
					serialNo++;
					
					if(r.getMarquee().getPortions()!=null){ for(Portion p : r.getMarquee().getPortions()){ if(p.getId() == r.getPortion().getId()){ eventName=p.getName(); } }}
						pw.write("<tr>"+
							"<td>"+serialNo+"</td>"+ 
							"<td>"+r.getEventName()+" ( "+eventName+" )</td>"+
							"<td>"+r.getCapacity()+"</td>"+
							"<td>"+r.getShift()+"</td>"+
							"<td>"+r.getBookedDate()+"</td>"+
							"<td>"+r.getContact()+"</td>"+
							"<td><input type='image' id='image' src='../backend/img/checked.png' onclick='approved("+r.getId()+" , "+r.getMarquee().getId()+")' value="+r.getId()+" />"+  
                  		    "<input type='image' id='image' src='../backend/img/cancel.png' onclick='disApproved("+r.getId()+" , "+r.getMarquee().getId()+")' value="+r.getId()+" />"+    
							"</td></tr>");
				}
			}
			
			else if(request.getParameter("method").equals("getAllData")){
				ArrayList<CalenderDTO> list = new ArrayList<CalenderDTO>();
//				userID = Integer.parseInt(""+session.getAttribute("hallID"));  
				for ( Booked b : bookedDao.getBooking() ){
					CalenderDTO dto = new CalenderDTO();
					dto.setStart(b.getBookingRequest().getBookedDate());
					dto.setTitle(b.getBookingRequest().getEventName()+"  "+b.getBookingRequest().getMarquee().getName());  
					list.add(dto);
				}
				pw.write(gson.toJson(list));
			}
			
			else if(request.getParameter("method").equals("delete")){
				
				requestBean.setActive((byte) 4);  
				requestBean.setId(Integer.parseInt(request.getParameter("requestID")));
				
				System.out.println(requestBean.getId()+" --- "+requestBean.getActive()+" final");
				
				BookingRequestDao requestDao = new BookingRequestDaoImp();	
				requestDao.updateBookingByHQL(requestBean); 
				 
				id = Integer.parseInt(request.getParameter("id"));
				bookedBean.setId(id);  
				
				System.out.println(bookedBean.getId()+" ---  final");
				
//				bookedDao = new BookedDaoImp(); 
				bookedDao.deleteBooking(bookedBean);
				
				System.out.println(bookedBean.getId()+" ---  final");
				
				id = 0;      
  
				for (Booked b : bookedDao.getBookingApprovedUpcoming(Integer.parseInt(""+session.getAttribute("marquee_id")))){
					id++; 
					String userName = "";
                    if(b.getBookingRequest().getUser_id()!=null){  
                      userName = b.getBookingRequest().getUser_id().getName();
                    } 
                    else{
                      userName=b.getBookingRequest().getBookName();   
                    }  
					String d = sdf.format(date);
					pw.write("<tr>"+  
							 "<td>"+id+"</td>"+
							 "<td>"+userName+"</td>"+
							 "<td>"+b.getBookingRequest().getEventName()+"</td>"+
							 "<td>"+b.getBookingRequest().getCapacity()+"</td>"+
							 "<td>"+b.getBookingRequest().getShift()+"</td>"+
							 "<td>"+b.getBookingRequest().getBookedDate()+"</td>"+
							 "<td>"+b.getBookingRequest().getContact()+"</td>"+
							 "<td><a href='#myModal' class='trigger-btn' data-toggle='modal'><input type='image' id='image' src='../backend/img/deleteicon.png' onclick='getID("+b.getId()+" , "+b.getBookingRequest().getId()+")'  /></a>"+
							 "<a href='booking-detail.jsp?id="+b.getId()+"Mb"+d.replaceAll("\\s", "")+"qOXa33T' ><input type='image' id='image' src='../backend/img/detail.png'   /></a></td>"+ 
  							 "</tr>"
							);
				}
				pw.write("Booking Cancel Successfully");
			}
			
			else if(request.getParameter("method").equals("check")){
				
				marqueeID = Integer.parseInt(""+request.getParameter("marquee_id"));
				shift = request.getParameter("shift");
				bookDate = request.getParameter("date"); 
			    
				try {
					date= sdf.parse(bookDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
//				if(bookedDao.checkAvailiblityByMarqueeID(bookDate, shift, marqueeID , null).size() > 0 ){
				if(bookedDao.checkAvailiblityByMarqueeID(marqueeID ).size() > 0 ){
					pw.write("Already Booked On This Date & Shift");
				}
				else{
					pw.write("not");
				}
			}
			
			else if(request.getParameter("method").equals("reports")){
				String startDate = request.getParameter("startDate");
				String endDate = request.getParameter("endDate");  
				marqueeID = Integer.parseInt(""+session.getAttribute("marquee_id"));
				int serialNo = 0;
				for(Booked b : bookedDao.reports(startDate, endDate, marqueeID)){ serialNo++;
					pw.write("<tr>"+
							"<td>"+serialNo+"</td>"+
							"<td>"+b.getBookingRequest().getEventName()+"</td>"+
							"<td>"+b.getBookingRequest().getCapacity()+"</td>"+
							"<td>"+b.getBookingRequest().getShift()+"</td>"+
							"<td>"+b.getBookingRequest().getBookedDate()+"</td>"+
							"<td>"+b.getBookingRequest().getCost()+"</td>"+
							"</tr>"); 
				}
				pw.write("empty"); 
			} 
		}
		
		else if(request.getParameter("filter")!=null){
			if(request.getParameter("filter").equals("dataFilter")){
				
				bookDate = request.getParameter("date");
				shift = request.getParameter("shift");
				marqueeID = Integer.parseInt((request.getParameter("marquee_id")));
				ArrayList<BookedDTO> list = new ArrayList<BookedDTO>();
				String bookerName ="";
				int serial=0;
				for(Booked b : bookedDao.getFilterData(bookDate, shift, marqueeID)){
					serial++;
					if(b.getBookingRequest().getUser_id()!=null){
						bookerName=b.getBookingRequest().getUser_id().getName();
					}
					else {
						bookerName=b.getBookingRequest().getBookName();
					}
					pw.write("<tr>"+
								"<td>"+serial+"</td>"+
								"<td>"+bookerName+"</td>"+
								"<td>"+b.getBookingRequest().getEventName()+"</td>"+
								"<td>"+b.getBookingRequest().getCapacity()+"</td>"+
								"<td>"+b.getBookingRequest().getShift()+"</td>"+
								"<td>"+b.getBookingRequest().getBookedDate()+"</td>"+
								"<td>"+b.getBookingRequest().getContact()+"</td>"+ 
								"<td><input type='image' id='image' src='../backend/img/deleteicon.png' onclick='cancelRequest("+b.getId() +")'/></td>"+
     								"</tr>");
				}
//				pw.write(gson.toJson(list));
			}
			else if(request.getParameter("filter").equals("date")){
				
				marqueeID = Integer.parseInt(request.getParameter("marquee_id"));
				bookDate = request.getParameter("date");
				int serialNo = 0;
				for(Booked b : bookedDao.getRemainingData(bookDate, marqueeID)){ serialNo++;
					String bookerName="";
					if(b.getBookingRequest().getUser_id()!=null){
							bookerName = b.getBookingRequest().getUser_id().getName();
						}
					else {
						bookerName = b.getBookingRequest().getBookName();
					}
					double remaining = b.getBookingRequest().getCost() - b.getBookingRequest().getAdvance();
						pw.write("<tr>"+
								"<td>"+serialNo+"</td>"+
								"<td>"+bookerName+"</td>"+
								"<td>"+b.getBookingRequest().getCost()+"</td>"+
								"<td>"+b.getBookingRequest().getAdvance()+"</td>"+
								"<td>"+remaining+"</td>"+
								"<td>"+b.getBookingRequest().getBookedDate()+"</td>"+
								"<td>"+b.getBookingRequest().getContact()+"</td>"+ 
								"<td><input type='image' id='image' src='../backend/img/deleteicon.png' onclick='cancelRequest("+b.getId()+")' /></td>"+
								"</tr>");
				}
			}
		}
		
	}

}
