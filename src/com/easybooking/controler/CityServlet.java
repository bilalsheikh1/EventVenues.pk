package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.easybooking.dao.CityDao;
import com.easybooking.daoImp.CityDaoImp;
import com.easybooking.dto.CityDTO;
import com.easybooking.model.City;
import com.google.gson.Gson;

/**
 * Servlet implementation class CityServlet
 */
@WebServlet("/CityServlet")
public class CityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */   
    public CityServlet() {
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
		
		String name , date;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date dates = new Date();
		PrintWriter pw = response.getWriter();
		City cityBean = new City();
		CityDao cityDao = new CityDaoImp();
		Gson gson = new Gson();
		
			if(request.getParameter("Action")!=null){
				
				if(request.getParameter("Action").equals("Add City")){ 
					if(request.getParameter("name")!=null && !request.getParameter("name").equals("")){
						
						System.out.println("ok ok ok insertd");
						
						name = request.getParameter("name");
						date = sdf.format(dates);
				
						cityBean.setName(name);
						cityBean.setCreated_at(date);
				
						int i = cityDao.insert(cityBean);
						int serialNo = 0 ;
						for(City c : cityDao.getCities()){
							serialNo++;
							pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+c.getName()+"</td>" 
									   + "<td>"+c.getCreated_at()+"</td><td>"+c.getUpdated_at()+"</td><td><a href='#'><input type='image' src='img/updateicon.png' onclick='getData("+c.getId()+")' /></a>"
										+ "<input type='image' id='image' src='img/deleteicon.png' onclick='deleterecord("+c.getId()+")' /></td></tr>");
						}
					}
				}
				
				else {
					if(request.getParameter("name")!=null && !request.getParameter("name").equals("")){
						System.out.println("ok ok ok o k");
						int id = Integer.parseInt(request.getParameter("Action"));
						name = request.getParameter("name");
						date = sdf.format(dates);
					  
						cityBean.setId(id);
						cityBean.setName(name);
						cityBean.setUpdated_at(date);
					
						cityDao.update(cityBean);
						
						int serialNo = 0 ;
						for(City c : cityDao.getCities()){
							serialNo++;
							pw.write("<tr><td>"+serialNo+"</td>"+ "<td>"+c.getName()+"</td>" 
									+"<td>"+c.getCreated_at()+"</td><td>"+c.getUpdated_at()+"</td><td><a href='#'><input type='image' src='img/updateicon.png' onclick='getData("+c.getId()+")'  /></a>"
										+ "<input type='image' id='image' src='img/deleteicon.png' onclick='deleterecord("+c.getId()+")' /></td></tr>");
						}
					}
				
				}
				
				
			}
			
			if(request.getParameter("method")!=null){
				
				if(request.getParameter("method").equals("getData")){
					int id = Integer.parseInt(request.getParameter("id"));
					cityBean = cityDao.getDataById(id);
				
					CityDTO dto = new CityDTO();
					dto.setCityId(""+cityBean.getId());
					dto.setCityName(cityBean.getName());
				 
					pw.write(gson.toJson(dto));
				}
				
					else if(request.getParameter("method").equals("delete")){
						byte b = 0;
						cityBean.setId(Integer.parseInt(request.getParameter("id")));
						cityBean.setActive(b);
						int i = cityDao.delete(cityBean);
						byte serial=0; 
						for(City c : cityDao.getCities()){ serial++;
							pw.write("<tr><td>"+serial+"</td>" + "<td>"+c.getName()+"</td>" 
									+ "<td>"+c.getCreated_at()+"</td><td>"+c.getUpdated_at()+"</td><td><a href='#'><input type='image' src='img/updateicon.png' onclick='getData("+c.getId()+")' /></a>"
										+ "<input type='image' id='image' src='img/deleteicon.png' onclick='deleterecord("+c.getId()+")' /></td></tr>");
						}
				}
		}
				
	}

}
