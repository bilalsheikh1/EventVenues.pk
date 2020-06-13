package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.easybooking.dao.FoodServicesDao;
import com.easybooking.dao.MarqueeFoodServiceDao;
import com.easybooking.daoImp.FoodServicesDaoImp;
import com.easybooking.daoImp.MarqueeDaoImp;
import com.easybooking.daoImp.MarqueeFoodServiceDaoImp;
import com.easybooking.dto.MarqueeFoodServicesDTO;
//import com.easybooking.daoImp.MarqueeFoodServiceDaoImp;
import com.easybooking.model.FoodServices;
import com.easybooking.model.Marquee;
//import com.easybooking.model.MarqueeFoodService;
import com.easybooking.model.MarqueeFoodService;
import com.google.gson.Gson;

/**
 * Servlet implementation class MarqueeFoodServices
 */
@WebServlet("/MarqueeFoodServices")
public class MarqueeFoodServicesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarqueeFoodServicesServlet() {
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
		
		Integer totalService ,serviceID , marquee_id=44;
		
		
		
		Marquee marqueeBean = new Marquee();
		FoodServices foodServicesBean = new FoodServices();
		MarqueeFoodService marqueeFoodServiceBean ;
		MarqueeFoodServiceDao marqueeFoodServiceDao = new MarqueeFoodServiceDaoImp();
//		FoodServices foodServicesBean = new FoodServices();
//		FoodServicesDao foodServicesDao = new FoodServicesDaoImp();
		
		PrintWriter pw = response.getWriter();
		HttpSession session = request.getSession();
		Gson gson = new Gson();
		
		Set<FoodServices> setfoodServices = new HashSet<FoodServices>();
		Set<Marquee> setMarquees = new HashSet<Marquee>();
		ArrayList<Integer> list1 = new ArrayList<Integer>();
		
		
		if(request.getParameter("totalService")!=null && request.getParameter("type")!=null){
 
			int validate = 0;
			int type = Integer.parseInt(request.getParameter("type"));
			marquee_id = Integer.parseInt(""+session.getAttribute("marquee_id"));
			totalService = Integer.parseInt(request.getParameter("totalService"));
			if(type == 0){ 
					for(int i = 1 ; i<=totalService ; i++){
						if(request.getParameter("service"+i)!=null){
							marqueeFoodServiceBean = new MarqueeFoodService();
							serviceID = Integer.parseInt(request.getParameter("service"+i));
							foodServicesBean.setId(serviceID);
							marqueeBean.setId(marquee_id);
							marqueeFoodServiceBean.setMarquees(marqueeBean);
							marqueeFoodServiceBean.setFoodServices(foodServicesBean);
							marqueeFoodServiceDao.insert(marqueeFoodServiceBean);
							System.out.println("not validate "+validate);
						}
						else {
							validate = 1;
						}
					
					}
						pw.write("part3-part4");
 
			}
			
		}
		
		
		else if(request.getParameter("method")!=null){
			if(request.getParameter("method").equals("getData")){
				ArrayList<MarqueeFoodService> list = new ArrayList<MarqueeFoodService>();
				marquee_id = Integer.parseInt(""+session.getAttribute("marquee_id"));
				list = marqueeFoodServiceDao.getServicesForMarquee(marquee_id);
				ArrayList<MarqueeFoodServicesDTO> dto = new ArrayList<MarqueeFoodServicesDTO>();
				Set<FoodServices> foodServices = new HashSet<FoodServices>();
				for(MarqueeFoodService m : list){
					MarqueeFoodServicesDTO dto2 = new MarqueeFoodServicesDTO();
					dto2.setId(m.getId());
					dto2.setService_id(m.getFoodServices().getId());
					dto.add(dto2);
				}
				pw.write(gson.toJson(dto));
 			}
			
			else if(request.getParameter("method").equals("getService")){

            	int serialNumber=0;
            	   
            	for(MarqueeFoodService s : marqueeFoodServiceDao.getServicesForMarquee(Integer.parseInt(""+session.getAttribute("marquee_id"))) ){ serialNumber++;  
            		pw.write("<tr>"+
            			"<td>"+serialNumber +"</td>"+
            			"<td>"+s.getFoodServices().getName() +"</td>"+ 
            			"<td><input type='image' id='image' src='../backend/img/cancel.png' onclick='deleteService("+s.getId()+")' />"+ 
              		 	"</td>"+
            		"</tr> ");
            	}
			}
			
			else if(request.getParameter("method").equals("delete")){
				int id = Integer.parseInt(request.getParameter("id"));
				marqueeFoodServiceBean = new MarqueeFoodService();
				marqueeFoodServiceBean.setId(id);
				marqueeFoodServiceDao.delete(marqueeFoodServiceBean);
				marquee_id = Integer.parseInt(""+session.getAttribute("marquee_id"));

				for(MarqueeFoodService s : marqueeFoodServiceDao.getServicesForMarquee(marquee_id)){
					list1.add(s.getFoodServices().getId());
				}
					
				  FoodServicesDao foodServicesDao = new FoodServicesDaoImp();
	      		  
//	      		  id = Integer.parseInt(""+session.getAttribute("marquee_id"));
	      		int i = 0;
	        for(FoodServices f : foodServicesDao.getService(1)){ 
	        	
	        	boolean ans=list1.contains(f.getId()); 

	        	if(ans == false)  {i++;   
	      	  			pw.write(f.getName()+" <input type='checkbox' class='minimal' name=name"+i+"  value="+f.getId()+" />");
	      	  			System.out.println("ok "+f.getName()); 
	        		}
	        	}
					
			}
			
			else if(request.getParameter("method").equals("insert")){
				
				marquee_id = Integer.parseInt(""+session.getAttribute("marquee_id"));
				totalService = Integer.parseInt(request.getParameter("totalService"));
				String check = "empty";
				for(int i  = 1 ; i <=totalService ; i++){
					if(request.getParameter("name"+i)!=null){
						
						marqueeFoodServiceBean = new MarqueeFoodService();
						foodServicesBean.setId(Integer.parseInt(request.getParameter("name"+i)));
						marqueeFoodServiceBean.setFoodServices(foodServicesBean);
						marqueeBean.setId(Integer.parseInt(""+session.getAttribute("marquee_id")));
						marqueeFoodServiceBean.setMarquees(marqueeBean);
						
						marqueeFoodServiceDao.insert(marqueeFoodServiceBean);
						
						check="service";
						
					}
					
				}
				
			for(MarqueeFoodService s : marqueeFoodServiceDao.getServicesForMarquee(marquee_id)){
				list1.add(s.getFoodServices().getId());
			}
				
			  FoodServicesDao foodServicesDao = new FoodServicesDaoImp();
      		  int i = 0;
      		  int id = Integer.parseInt(""+session.getAttribute("marquee_id"));
      		  
        for(FoodServices f : foodServicesDao.getService(1)){ 
        	
        	boolean ans=list1.contains(f.getId()); 
//      	    String name="name";
        	if(check.equals("empty")){
        		pw.write(check);
        	}
        	else{ 
        	if(ans == false)  {i++;   
      	  			pw.write(f.getName()+" <input type='checkbox' class='minimal' name=name"+i+"  value="+f.getId()+" />");
      	  			System.out.println("ok "+f.getName()); 
        		}
        	}
        	}
				
		}
			
			
	}
		
}

}
