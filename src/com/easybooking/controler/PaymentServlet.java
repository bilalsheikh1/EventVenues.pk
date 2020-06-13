package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.easybooking.dao.PaymentDao;
import com.easybooking.daoImp.PaymentDaoImp;
import com.easybooking.dto.PaymentDTO;
import com.easybooking.model.Marquee;
import com.easybooking.model.Payment;
import com.google.gson.Gson;

/**
 * Servlet implementation class PaymentServlet
 */
@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentServlet() {
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
		
		Integer id;
		String date=""  ,whichMonthYearDate="";
		double perMonth = 0, perYear = 0;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date dates = new Date();
		PrintWriter pw = response.getWriter();
		
		Payment payment = new Payment();
		PaymentDao paymentDao = new PaymentDaoImp();
		
		if(request.getParameter("Action")!=null){
			if(request.getParameter("Action").equals("insert")){
				if(request.getParameter("marqueeID")!=null){
					
					
					Marquee marquee = new Marquee();
					
					id=Integer.parseInt(request.getParameter("marqueeID"));
					
					whichMonthYearDate = request.getParameter("date");
					
					if(request.getParameter("month")!=null) perMonth = Double.parseDouble(request.getParameter("month"));
					
					if(request.getParameter("year")!=null) perYear = Double.parseDouble(request.getParameter("year"));
					
					date = sdf.format(dates);
					
					payment.setPaymentdate(date);
					payment.setWhichMonthYearDate(whichMonthYearDate);
					payment.setPerMonth(perMonth);
					payment.setPerYear(perYear);
					marquee.setId(id);
					payment.setMarquees(marquee);
					   
					paymentDao.insertPaymentRecord(payment);
					pw.write("Inserted");
				}
			}
			else if(request.getParameter("Action").equals("add-payment")){ 
				Marquee marquee = new Marquee();
				
				id=Integer.parseInt(request.getParameter("marqueeID"));

				whichMonthYearDate = request.getParameter("date");
				
				if(request.getParameter("month")!=null) perMonth = Double.parseDouble(request.getParameter("month"));
				
				if(request.getParameter("year")!=null) perYear = Double.parseDouble(request.getParameter("year"));
				
				date = sdf.format(dates);
				

				payment.setPaymentdate(date);
				payment.setWhichMonthYearDate(whichMonthYearDate);
				payment.setPerMonth(perMonth);
				payment.setPerYear(perYear);
				marquee.setId(id);
				payment.setMarquees(marquee);
				   
				paymentDao.updatePaymentRecordActive0(id);
				paymentDao.insertPaymentRecord(payment);
				
				pw.write("Payment Inserted");
//				 int serialNo = 0 ;
//	                Calendar calendar = Calendar.getInstance();
//
//	                for(Payment p : paymentDao.getPaymentPending()){ 
//	                 	serialNo++;
//	                 	dates = new Date();
//	                 	Date date1 = new Date();
////	                 	calendar = new GregorianCalendar(2,2,2);
////	                	date  = sdf.parse(p.getMarquees().getCreated_at());
////	                	date.setDate(Integer.parseInt(p.getMarquees().getCreated_at()));
//	                	//calendar.setTime(date);
//	                	String y="";
//						try {
//							y = ""+sdf.format(sdf.parse(p.getWhichMonthYearDate()));
//						} catch (ParseException e) {
//							// TODO Auto-generated catch block
//							e.printStackTrace();
//						} 
//	                	String m = y; 
//	                	String d=y;
//
//	                	y=y.substring(0,4); 
//	                	m=m.substring(5,7);    
//	                	d=d.substring(8,10);
//	    
//	                	calendar.set(Integer.parseInt(y),Integer.parseInt(m)-1,Integer.parseInt(d));
//
//	                	y= sdf.format(dates); // in y string here is using current date
//	                	if(p.getPerMonth() > 0){	
//	                		calendar.add(Calendar.MONTH, 1);
//	                	}
//	                	else{
//	                		calendar.add(Calendar.YEAR, 1);	
//	                	}
//	                	dates = calendar.getTime();
//	                	  
//	                	m=sdf.format(dates); // in m string here is using database date
//				
//	                 	if(dates.before(date1)){ 
//	                pw.write("<tr>"+  
//	                    "<td>"+serialNo+"</td>"+ 
//	                    "<td>"+p.getMarquees().getName()+"</td>"+ 
//	                    "<td>"+p.getPerMonth()+"</td>"+
//	                    "<td>"+p.getPerYear()+"</td>"+ 
//	                    "<td>"+p.getWhichMonthYearDate()+"</td>"+   
//	                    "<td>"+p.getPaymentdate()+"</td>"+     
//	                  	"<td><a id='add' data-toggle='modal' onclick='addPayment("+p.getMarquees().getId()+");><input type='image' src='img/cash.png'  /></a>"+
//	                  	"</td></tr>");
//	                } 
//	                 	}
				
			}
			else if(request.getParameter("Action").equals("getData")){
				
				id = Integer.parseInt(request.getParameter("id"));
				payment = paymentDao.getDataByID(id);
				
				Gson gson = new Gson();
				ArrayList<PaymentDTO> list = new ArrayList<PaymentDTO>();
				PaymentDTO dto = new PaymentDTO();
				dto.setId(payment.getId());
				dto.setMarqueeName(payment.getMarquees().getName());
				dto.setMonthly(payment.getPerMonth());
				dto.setYearly(payment.getPerYear()); 
				dto.setWhichMonthDate(payment.getWhichMonthYearDate());
				dto.setMarqueeID(payment.getMarquees().getId());
				list.add(dto); 
				pw.write(gson.toJson(list));
			}
			else if(request.getParameter("Action").equals("update")){
				Marquee marquees  = new Marquee();
				
				id = Integer.parseInt(request.getParameter("id"));
				int marqueeID = Integer.parseInt(request.getParameter("marqueeID"));
				
				whichMonthYearDate = request.getParameter("date");
				
				if(request.getParameter("month")!=null) perMonth = Double.parseDouble(request.getParameter("month"));
				
				if(request.getParameter("year")!=null) perYear = Double.parseDouble(request.getParameter("year"));
				
				date = sdf.format(dates);
				
				payment.setId(id);
				payment.setWhichMonthYearDate(whichMonthYearDate);
				payment.setPerMonth(perMonth);
				payment.setPerYear(perYear);
				marquees.setId(marqueeID);
				payment.setMarquees(marquees);
				payment.setPaymentdate(date);
				
				paymentDao.updatePaymentRecord(payment);
				
			    pw.write("Data Updated");   
	                		
	                	
			}
		}
		
		
	}

}
