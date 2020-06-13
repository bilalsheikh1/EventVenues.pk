package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.easybooking.dao.FoodServicesDao;
import com.easybooking.daoImp.FoodServicesDaoImp;
import com.easybooking.dto.FoodServiceDTO;
import com.easybooking.model.FoodServices;
import com.easybooking.model.Marquee;
import com.google.gson.Gson;

/**
 * Servlet implementation class FoodServiceServlet
 */
@WebServlet("/FoodServiceServlet")
public class FoodServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodServiceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		Integer marquee_id = 0;
		String name;
		
		FoodServices foodServices = new FoodServices();
		FoodServicesDao foodServicesDao = new FoodServicesDaoImp();
		
		Marquee marquee = new Marquee();
		
		PrintWriter pw = response.getWriter();
		Gson gson = new Gson();
		
		HttpSession session = request.getSession();
			
		 
		if(request.getParameter("Action")!=null){
			if(request.getParameter("Action").equals("Add Service")){
				 
				name = request.getParameter("name");
				marquee_id = Integer.parseInt(""+session.getAttribute("marquee_id"));
				
				foodServices.setName(name);

				marquee.setId(marquee_id);
				foodServices.setMarquee(marquee); 
				 
				foodServicesDao.insert(foodServices);
				
				int serialNo = 0;
				for(FoodServices s : foodServicesDao.getServicesByMarqueeID(marquee_id)){
					serialNo++;
					pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+s.getName()+"</td>"
							  + "<td><input type='image' id='image' src='images/deleteicon.png' onclick='deleteService("+s.getId()+")' /></td></tr>");
				}
			}
			else {
			    name = request.getParameter("name");
			    foodServices.setName(name);
			    foodServices.setId(Integer.parseInt(request.getParameter("Action")));
			    foodServicesDao.update(foodServices);
			    int serialNo = 0;
			    for(FoodServices s : foodServicesDao.getService(1)){
			    	serialNo++;
			    	pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+s.getName()+"</td>"
						    	+ "<td><input type='image' id='image' src='images/deleteicon.png' onclick='deleteService("+s.getId()+")' /></td></tr>");
				}
			}
		}
		
		else if(request.getParameter("method")!=null){
			
			int id = Integer.parseInt(request.getParameter("id"));
			
			if(request.getParameter("method").equals("getData")){
				foodServices = foodServicesDao.getDataById(id);
				FoodServiceDTO dto = new FoodServiceDTO();
				dto.setName(foodServices.getName());
				dto.setId(foodServices.getId());
				pw.write(gson.toJson(dto));
			} 
			
			else if(request.getParameter("method").equals("delete")){

				marquee_id = Integer.parseInt(""+session.getAttribute("marquee_id"));

				foodServices.setActive((byte)0);
				foodServices.setId(id);
				
				foodServicesDao.delete(foodServices);
				
				int serialNo = 0 ; 
				for(FoodServices s : foodServicesDao.getServicesByMarqueeID(marquee_id)){
					serialNo++;
					pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+s.getName()+"</td>"
							  + "<td><input type='image' id='image' src='images/deleteicon.png' onclick='deleteService("+s.getId()+")' /></td></tr>");
				} 
			}
			
			else if(request.getParameter("method").equals("getDataByMarqueeID")){
				int serialNo = 0 ; 
				for(FoodServices s : foodServicesDao.getServicesByMarqueeID(Integer.parseInt(""+session.getAttribute("marquee_id")))){
 					serialNo++;
					pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+s.getName()+"</td>"
							  + "<td><input type='image' id='image' src='images/deleteicon.png' onclick='deleteService("+s.getId()+")' /></td></tr>");
				}
			}
			
			else if(request.getParameter("method").equals("active")){
				foodServices.setActive((byte)1);
				foodServices.setId(id);
				foodServicesDao.update(foodServices);
				int serialNo = 0 ;
				for(FoodServices s : foodServicesDao.getService(0)){
					serialNo++;
					pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+s.getName()+"</td>"
							+ "<td><a href='#'><input type='image' src='img/approve.png' onclick=getData("+s.getId()+") /></a></td></tr>");
				}
			}
		}
	}

}
