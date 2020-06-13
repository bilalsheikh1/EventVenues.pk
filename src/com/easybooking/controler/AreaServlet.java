package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.easybooking.dao.AreaDao;
import com.easybooking.daoImp.AreaDaoImp;
import com.easybooking.dto.AreaDTO;
import com.easybooking.model.Area;
import com.easybooking.model.City;
import com.google.gson.Gson;

/**
 * Servlet implementation class AreaServlet
 */
@WebServlet("/AreaServlet")
public class AreaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AreaServlet() {
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
		String name ;
		Integer city_id;
		
		Area area = new Area();
		AreaDao areaDao = new AreaDaoImp();
		City city = new City();
		
		PrintWriter pw = response.getWriter();
		Gson gson = new Gson();
		
		if(request.getParameter("Action")!=null){
			if(request.getParameter("Action").equals("Add Area")){ 
				if(!request.getParameter("name").equals("") && request.getParameter("city")!=null){
					name = request.getParameter("name");
					city_id = Integer.parseInt(request.getParameter("city"));
				
					area.setName(name);
					city.setId(city_id);
					area.setCity(city);
				
					areaDao.insertArea(area);
				
					int serialNo = 0 ; 
                	for(Area a : areaDao.getAreas()){  
                		serialNo++;
                		pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+a.getName()+"</td><td>"+a.getCity().getName()+"</td>"   
							+ "<td><a href='#' ><input type='image' src='img/updateicon.png' onclick='getData("+a.getId()+")' /></a>"
									+ "<a href='#'><input type='image' id='image' src='img/deleteicon.png' onclick=deleterecord("+a.getId()+") value='a.getId()' /></a></td></tr>");
                		}
				}
			}
			else{
				if(!request.getParameter("name").equals("") && request.getParameter("city")!=null){
						
						name = request.getParameter("name");
						city_id = Integer.parseInt(request.getParameter("city"));
						int id = Integer.parseInt(request.getParameter("Action"));
				
						area.setId(id);  
						area.setName(name);
						city.setId(city_id);
						area.setCity(city);
				
						areaDao.updateArea(area);
				
						byte serialNo = 0 ; 
                		
						for(Area a : areaDao.getAreas()){  
                		serialNo++;
                		pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+a.getName()+"</td><td>"+a.getCity().getName()+"</td>"   
							+ "<td><a href='#'><input type='image' src='img/updateicon.png' onclick='getData("+a.getId()+")' /></a>"
									+ "<a href='#'><input type='image' id='image' src='img/deleteicon.png' onclick=deleterecord("+a.getId()+") value='a.getId()' /></a></td></tr>");
                		}
				}
			}
		}
		
		else if(request.getParameter("method")!=null){
			int id;
			if(request.getParameter("method").equals("delete")){
				
				id = Integer.parseInt(request.getParameter("id"));
				    
				area.setId(id);
				areaDao.deleteArea(area);
				 
				int serialNo = 0 ; 
                
				for(Area a : areaDao.getAreas()){  
                	serialNo++;
                	pw.write("<tr><td>"+serialNo+"</td>" + "<td>"+a.getName()+"</td><td>"+a.getCity().getName()+"</td>"   
							+ "<td><a href='#'><input type='image' src='img/updateicon.png' onclick='getData("+a.getId()+")' /></a>"
									+ "<a href='#'><input type='image' id='image' src='img/deleteicon.png' onclick=deleterecord("+a.getId()+") value='a.getId()' /></a></td></tr>");
                }
                   
			}
			else if (request.getParameter("method").equals("getData")){
				id = Integer.parseInt(request.getParameter("id"));
				area = areaDao.getDataById(id);
				AreaDTO dto = new AreaDTO();
				dto.setId(area.getId());
				dto.setName(area.getName());
				dto.setCity_id(area.getCity().getId());
				pw.write(gson.toJson(dto));   
			}
			
			else if (request.getParameter("method").equals("getAreaById")){
				city_id = Integer.parseInt(request.getParameter("city_id"));
				ArrayList<AreaDTO> list = new ArrayList<AreaDTO>(); 
				for(Area a  : areaDao.getAreaByCity_id(city_id)){
					AreaDTO dto = new AreaDTO(); 
					dto.setId(a.getId());
					dto.setName(a.getName());
					list.add(dto);
				}
				pw.write(gson.toJson(list));
			}
		}
		
	}

}
