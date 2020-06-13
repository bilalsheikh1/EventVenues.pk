package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.easybooking.dao.PortionDao;
import com.easybooking.daoImp.PortionDaoImp;
import com.easybooking.dto.PortionDTO;
import com.easybooking.model.Marquee;
import com.easybooking.model.Portion;
import com.google.gson.Gson;

/**
 * Servlet implementation class Portion
 */
@WebServlet("/Portion")
public class PortionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PortionServlet() {
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
		String lawn = "" , capacity="";
		Integer totalPortion , marquee_id = null;
		
		
		PortionDao portionDao = new PortionDaoImp();
		Portion portionBean = new Portion();
		Marquee marqueeBean = new Marquee();
		
		
		PrintWriter pw = response.getWriter(); 
		HttpSession session = request.getSession();
		Gson gson = new Gson();
		
		if(request.getParameter("type")!=null && request.getParameter("totalPortion")!=null){
			
			totalPortion = Integer.parseInt(request.getParameter("totalPortion"));
		
			System.out.println(request.getParameter("type")+ " tpye");
			int type = Integer.parseInt(request.getParameter("type")); // type for id  
			
			marquee_id= Integer.parseInt(""+session.getAttribute("marquee_id"));
			
			if( type == 0 ){// type 0 means insert > 0 means update
				
				for(int i = 1 ; i<=totalPortion ; i++){
					
					if ( request.getParameter("lawn"+i)!=null && request.getParameter("capacity"+i)!=null ){
					  
						lawn = request.getParameter("lawn"+i); 
						capacity = request.getParameter("capacity"+i);
						portionBean.setName(lawn);
						portionBean.setPortionCapacity(capacity);
						marqueeBean.setId(marquee_id);
						portionBean.setMarquee(marqueeBean);
						portionDao.addPortion(portionBean);
					
					}
				}
				
				ArrayList<Portion> listMaxId = new ArrayList<Portion>();
				listMaxId = portionDao.getMaxID();
				session.setAttribute("portion_id", listMaxId.get(0));
				String portion_id  = ""+listMaxId.get(0);
				pw.write("part2-part3"+portion_id);
			}
			
			else if( type > 0 ){// type 0 means insert > 0 means update type use for id
				
				int id = type-totalPortion;
				
				for(int i = 1 ; i<=totalPortion ; i++){
					
					if ( request.getParameter("lawn"+i)!=null && request.getParameter("capacity"+i)!=null ){
						
						id++;
						
						lawn = request.getParameter("lawn"+i); 
						capacity = request.getParameter("capacity"+i);
						portionBean.setName(lawn);
						portionBean.setPortionCapacity(capacity);
						marqueeBean.setId(marquee_id);
						portionBean.setMarquee(marqueeBean);
						portionBean.setId(id);
						portionDao.updatePortion(portionBean);
						
					}
				}
				pw.write("part2-part3");
			}
			
		}
		
		
		else if(request.getParameter("method")!=null){
			if(request.getParameter("method").equals("getData")){
				ArrayList<Portion> list = new ArrayList<Portion>();
				list = portionDao.getPortionForMarquee(Integer.parseInt(""+session.getAttribute("marquee_id")));
				ArrayList<Portion> dto = new ArrayList<Portion>();
				for(Portion p : list){
					Portion portion = new Portion();
					portion.setName(p.getName());
					portion.setId(p.getId());
					portion.setPortionCapacity(p.getPortionCapacity());
					dto.add(portion);
				}
				pw.write(gson.toJson(dto));
			}
			
			else if(request.getParameter("method").equals("update")){
				
				totalPortion = Integer.parseInt(request.getParameter("portionID")); //  in this condition total portion means portion id
				lawn = request.getParameter("lawn");
				capacity = request.getParameter("capacity");
				marquee_id = Integer.parseInt(request.getParameter("marquee_id"));
				
				
				marqueeBean.setId(marquee_id);   
				portionBean.setMarquee(marqueeBean); 
				portionBean.setId(totalPortion);
				portionBean.setName(lawn);
				portionBean.setPortionCapacity(capacity); 
				
				portionDao.updatePortion(portionBean);      
				    
				portionBean = portionDao.getDataById(totalPortion);
				PortionDTO dto = new PortionDTO();
				ArrayList<PortionDTO> lsit = new ArrayList<PortionDTO>();
				dto.setId(portionBean.getId());	
				dto.setName(portionBean.getName());
				dto.setCapcity(portionBean.getPortionCapacity());
				dto.setNameID(request.getParameter("nameID"));   
				dto.setCapacityID(request.getParameter("capacityID"));
				lsit.add(dto);
				pw.write(gson.toJson(lsit));       
				    
			}
			
			else if (request.getParameter("method").equals("delete")){
				
				totalPortion = Integer.parseInt(request.getParameter("portionID"));; 
				portionBean.setId(totalPortion);
				
				portionDao.deletePortion(portionBean);
			}
			
		}
		
	}

}	
