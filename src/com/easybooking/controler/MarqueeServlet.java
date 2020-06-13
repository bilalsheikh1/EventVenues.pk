package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import com.easybooking.dao.MarqueeDao;
import com.easybooking.dao.PortionDao;
import com.easybooking.daoImp.MarqueeDaoImp;
import com.easybooking.daoImp.PortionDaoImp;
import com.easybooking.dto.MarqueeDTO;
import com.easybooking.model.Area;
import com.easybooking.model.City;
import com.easybooking.model.Gallery;
import com.easybooking.model.Marquee;
import com.easybooking.model.Portion;
import com.easybooking.model.User;
import com.google.gson.Gson;

/**
 * Servlet implementation class Marquee
 */
@WebServlet("/Marquee")
public class MarqueeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarqueeServlet() {
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
		String name ="",address="",contact="",email="",capacity="" ,location="",address2="", createdAt , creatorId ;
		Integer cityID = null , areaID= null ;
		
		Marquee marqueeBean = new Marquee();
		MarqueeDao marqueeDao = new MarqueeDaoImp();
		City cityBean = new City();
		Area areaBean = new Area();  	
		User user = new User();
		
		PrintWriter pw = response.getWriter();
		Gson gson = new Gson();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		
		HttpSession session = request.getSession();
//		List list ; 
		
		if(request.getParameter("type")!=null && request.getParameter("name")!=null 
				&& request.getParameter("address")!=null && request.getParameter("contact")!=null 
				&& request.getParameter("email")!=null && request.getParameter("capacity")!=null 
				&& Integer.parseInt(request.getParameter("city")) > 0 ){
			if(request.getParameter("type").equals("insert")){
			 	
				name=request.getParameter("name");
				address = request.getParameter("address");
				contact = request.getParameter("contact"); 
				email = request.getParameter("email");
				capacity = request.getParameter("capacity");
				location = request.getParameter("location");
				address2 = request.getParameter("address2");
				createdAt = sdf.format(date);
				cityID = Integer.parseInt(request.getParameter("city"));
				areaID = Integer.parseInt(request.getParameter("area"));
				
				marqueeBean.setName(name);
				marqueeBean.setAddress(address); 
				marqueeBean.setContact(contact);
				marqueeBean.setEmail(email);
				marqueeBean.setCapacity(Integer.parseInt(capacity));
				marqueeBean.setCreated_at(createdAt);
				cityBean.setId(cityID);
				marqueeBean.setCity(cityBean);
				areaBean.setId(areaID);
				marqueeBean.setArea(areaBean);
				marqueeBean.setLocation(location);
				marqueeBean.setAddress2(address2);
				
				creatorId=""+session.getAttribute("id");
//				user.setId(Integer.parseInt(creatorId));
				user.setId(37); 
				marqueeBean.setUser(user);
				
				marqueeDao.addMarquee(marqueeBean);
//				list=
				session.setAttribute("marquee_id", marqueeBean.getId()); 
				String marquee_idSession = ""+marqueeBean.getId();    
				session.setMaxInactiveInterval(10*60*60); // session live 10 hours
				pw.write("part1-part2"+marquee_idSession+"capacity"+capacity); 
			}
			else if(Integer.parseInt(request.getParameter("type")) > 0){ // type is hidden textfiled it save id for update on marquee-register.jsp page when at the time of marqee register 

				name=request.getParameter("name");
				address = request.getParameter("address");
				contact = request.getParameter("contact");
				email = request.getParameter("email");
				capacity = request.getParameter("capacity");
				createdAt = sdf.format(date);
				cityID = Integer.parseInt(request.getParameter("city"));
				areaID = Integer.parseInt(request.getParameter("area"));
				location = request.getParameter("location");
				address2 = request.getParameter("address2");
				
				marqueeBean.setId(Integer.parseInt(request.getParameter("type")));
				marqueeBean.setName(name);
				marqueeBean.setAddress(address);
				marqueeBean.setContact(contact);
				marqueeBean.setEmail(email);
				marqueeBean.setCapacity(Integer.parseInt(capacity));
				marqueeBean.setCreated_at(createdAt);	
				marqueeBean.setLocation(location);
				marqueeBean.setAddress2(address2);
				cityBean.setId(cityID);
				marqueeBean.setCity(cityBean);
				areaBean.setId(areaID);
				marqueeBean.setArea(areaBean);
				user.setId(37); 
				marqueeBean.setUser(user);
				 
				marqueeDao.updateMarquee(marqueeBean);
				pw.write("part1-part2");
			}
		
		}
		
		else if(request.getParameter("method")!=null ){
			if(request.getParameter("method").equals("approved")){
				marqueeDao.updateMarqueeActive(Integer.parseInt(request.getParameter("id")), (byte) 1 );
				int serialNo = 0 ;
				if(request.getParameter("type")!=null){
					if(request.getParameter("type").equals("approved")){
						serialNo++;
						String d = sdf.format(date);
						for(Marquee m : marqueeDao.getMarqueeDataForApproved(2)){
							pw.write("<tr> <td>"+serialNo+"</td></td>"
								+"<td>"+m.getName()+"</td>"
								+"<td>"+m.getAddress()+"</td>"
								+"<td>"+m.getContact()+"</td>"
								+"<td><input type='image' id='image' src='img/checked.png' onclick='approved("+m.getId()+")' value="+m.getId()+" />"
								+"<a href='marquee-detail.jsp?id="+m.getId()+"Mb"+d.replaceAll("\\s", "")+"Ha3g7'><input type='image' id='image' src='img/detail.png' /></a></td></tr>"); 
							} 
					} 
				}
				else{  
					
					for(Marquee m : marqueeDao.getMarqueeDataForApproved(0)){
						serialNo++;
						String d = sdf.format(date); 
						pw.write("<tr> <td>"+serialNo+"</td>"
		                  	+"<td>"+m.getName()+"</td>"
		                  	+"<td>"+m.getAddress()+"</td>"
		                  	+"<td>"+m.getContact()+"</td>"
		                  	+"<td><input type='image' id='image' src='img/checked.png' onclick='approved("+m.getId()+")' value="+m.getId()+" />"
		                  	+"<input type='image' id='image' src='img/cancel.png' onclick='disApproved("+m.getId()+")' value="+m.getId()+"/>"
		                  	+"<a href='marquee-detail.jsp?id="+m.getId()+"Mb"+d.replaceAll("\\s", "")+"3fvS3g7'><input type='image' id='image' src='img/detail.png' /></a></td></tr>"); 
						} 
				}
				
			}
			else if(request.getParameter("method").equals("disApproved")){
//				marqueeDao.updateMarqueeActive(Integer.parseInt(request.getParameter("id")), (byte) 2);
				marqueeDao.rejectMarquee(Integer.parseInt(request.getParameter("id")), request.getParameter("reason"));
				int serialNo = 0;
				if(request.getParameter("type")!=null){
					if(request.getParameter("type").equals("disApproved")){
				for(Marquee m : marqueeDao.getMarqueeDataForApproved(1)){
					serialNo++;
					String d = sdf.format(date);
					pw.write("<tr> <td>"+serialNo+"</td>"
						+"<td>"+m.getName()+"</td>"
						+"<td>"+m.getAddress()+"</td>"
						+"<td>"+m.getContact()+"</td>"
						+"<td><input type='image' id='image' src='img/cancel.png' onclick='disApproved("+m.getId()+")' value="+m.getId()+"/>"
						+"<a href='marquee-detail.jsp?id="+m.getId()+"Mb"+d.replaceAll("\\s", "")+"RxZa3REv'><input type='image' id='image' src='img/detail.png' /></a></td>"
						+ "</tr>"); 
						}
					}
				}
				else{
				
					for(Marquee m : marqueeDao.getMarqueeDataForApproved(0)){
						serialNo++;
						String d = sdf.format(date);
						pw.write("<tr> <td>"+serialNo+"</td>" 
								+"<td>"+m.getName()+"</td>"
								+"<td>"+m.getAddress()+"</td>"
								+"<td>"+m.getContact()+"</td>"
								+"<td><input type='image' id='image' src='img/checked.png' onclick='approved("+m.getId()+")' value="+m.getId()+" />"
								+"<input type='image' id='image' src='img/cancel.png' onclick='disApproved("+m.getId()+")' value="+m.getId()+"/>"
								+"<a href='marquee-detail.jsp?id="+m.getId()+"Mb"+d.replaceAll("\\s", "")+"Ha3g7'><input type='image' id='image' src='img/detail.png' /></a></td></tr>"); 
					}
				}
			}

			else if(request.getParameter("method").equals("getDataOnBackButtonMarquee")){
				int id = Integer.parseInt(""+session.getAttribute("marquee_id"));
				marqueeBean= marqueeDao.getDataById(id); 
				  				
				MarqueeDTO dto = new MarqueeDTO();
				dto.setName(marqueeBean.getName());   
				dto.setAddress(marqueeBean.getAddress());
				dto.setLocation(marqueeBean.getLocation());
				dto.setAddress2(marqueeBean.getAddress2());
				dto.setCapacity(marqueeBean.getCapacity());
				dto.setCityID(marqueeBean.getCity().getId());
				dto.setContact(marqueeBean.getContact());
				dto.setEmail(marqueeBean.getEmail());
				dto.setId(marqueeBean.getId());
				dto.setAreaID(marqueeBean.getArea().getId()); 
				
				pw.write(gson.toJson(dto));
			}  
			 
			else if(request.getParameter("method").equals("update")){
				
				int marqueeID = Integer.parseInt(request.getParameter("marquee_id"));
				int userID = Integer.parseInt(""+session.getAttribute("id"));
				marqueeBean.setId(marqueeID);
				
				areaBean.setId(Integer.parseInt(request.getParameter("areaID")));
				marqueeBean.setArea(areaBean);
				
				cityBean.setId(Integer.parseInt(request.getParameter("cityID")));
				marqueeBean.setCity(cityBean);
				 
				marqueeBean.setName(request.getParameter("name")); 
				marqueeBean.setEmail(request.getParameter("email"));
				marqueeBean.setCapacity(Integer.parseInt(request.getParameter("capacity")));
				marqueeBean.setAddress(request.getParameter("address"));
				marqueeBean.setContact(request.getParameter("contact"));
				marqueeBean.setCreated_at(request.getParameter("createdAt")); 
				user.setId(Integer.parseInt(request.getParameter("created_by")));
				marqueeBean.setUser(user); 
				createdAt = sdf.format(date);
				marqueeBean.setUpdated_at(createdAt);
				marqueeBean.setActive((byte) 1); 
				  
				marqueeDao.updateMarquee(marqueeBean);
				marqueeBean = marqueeDao.getDataById(marqueeID);
				
				MarqueeDTO dto = new MarqueeDTO();
				ArrayList<MarqueeDTO> listDTO = new ArrayList<MarqueeDTO>();
				dto.setName(marqueeBean.getName());
				dto.setEmail(marqueeBean.getEmail());
				dto.setCapacity(marqueeBean.getCapacity());
				dto.setAddress(marqueeBean.getAddress());
				dto.setCapacity(marqueeBean.getCapacity());
				dto.setContact(marqueeBean.getContact()); 
				listDTO.add(dto);
				
				pw.write(gson.toJson(listDTO)); 
			}
			else if(request.getParameter("method").equals("searchCity")){
				cityID=Integer.parseInt(request.getParameter("cityID"));
				sdf = new SimpleDateFormat("dmyyHHmmssz");
				for(Marquee m : marqueeDao.getMarqueeByCity(cityID)){
					String img=""; 
					for(Gallery g : m.getGalleries()){if(g.getImage()!=null){img=g.getImage();break;}}

				String d = sdf.format(date);
				pw.write("<div class='col-lg-4 col-md-6'>"+
	    				"<div class='hall-img'>"+  
	    					"<img src='/EasyBooking/img/"+img+"' width='100%' height='235px' />"+         
	    					"<div class='cost'>"+     
	    						"<h6>Capacity : "+m.getCapacity()+"</h6>"+    	 					
	    					"</div>"+ 
	    					"<div class='city'>"+     
    						"<h6>City : "+m.getCity().getName()+"</h6>"+    	 					
    					"</div>"+
	    					"<div class='hall-n'>"+
	    						"<h3>"+m.getName() +"</h3>"+
	    					"</div>"+ 
	    					"<a href='hall-detail.jsp?id="+m.getId()+"Mb"+d.replaceAll("\\s", "")+"Fw34QVe' ><input type='submit' value='Check Availability' /></a>"+
	    				"</div>"+
	    				"</div>");
				}
			}
			else if(request.getParameter("method").equals("findMarquee")){  
				cityID = Integer.parseInt(request.getParameter("cityID"));
				areaID = Integer.parseInt(request.getParameter("areaID"));
				sdf = new SimpleDateFormat("dmyyHHmmssz");
				for(Marquee m : marqueeDao.getMarqueeByCityAreaWise(cityID, areaID)){
					String img=""; for(Gallery g : m.getGalleries()){if(g.getImage()!=null){img=g.getImage();break;}}
					
					String d = sdf.format(date);
					pw.write("<div class='col-lg-4 col-md-6'>"+
		    				"<div class='hall-img'>"+  
		    					"<img src='/EasyBooking/img/"+img+"' width='100%' height='235px' />"+         
		    					"<div class='cost'>"+     
		    						"<h6>Capacity : "+m.getCapacity()+"</h6>"+    	 					
		    					"</div>"+ 
		    					"<div class='city'>"+     
	    						"<h6>City : "+m.getCity().getName()+"</h6>"+    	 					
	    					"</div>"+
		    					"<div class='hall-n'>"+
		    						"<h3>"+m.getName() +"</h3>"+
		    					"</div>"+ 
		    					"<a href='hall-detail.jsp?id="+m.getId()+"Mb"+d.replaceAll("\\s", "")+"Fw34QVe' ><input type='submit' value='Check Availability' /></a>"+
		    				"</div>"+
		    				"</div>");		
				}
			}
			else if(request.getParameter("method").equals("getNearby")){
				address = request.getParameter("address");
				System.out.println("size is "+marqueeDao.getNearByMarquees(address).size()); 	
				System.out.println("add is "+address);  
				for(Marquee m : marqueeDao.getNearByMarquees(address)){
					    
					pw.write("<div class='col-lg-6'>"+ 
		            "<div class='room-wrap d-md-flex'>"+
		              "<a href='#' class='img' style='background-image: url(images/halls/marina.jpg);'></a>"+
		              "<div class='half left-arrow d-flex align-items-center'>"+
		                "<div class='text p-4 p-xl-5 text-center'>"+
		                  "<p class='star mb-0'><span class='fa fa-star'></span><span class='fa fa-star'></span><span class='fa fa-star'></span><span class='fa fa-star'></span><span class='fa fa-star'></span></p>"+
		                  "<h3 class='mb-3'><a href='rooms.html'>"+m.getName()+"</a></h3>"+
		                  "<ul class='list-accomodation'>"+
		                    "<table  class='table table-accomodation'>"+
		                      "<tr>"+
		                        "<td><span>Max Person:</span></td><td>"+m.getCapacity()+" Persons</td>"+
		                      "</tr>"+
		                      "<tr>"+
		                        "<td><span>Shift:</span></td><td><input type='radio' name='' >Day <input type='radio' name='' >Night </td>"+
		                      "</tr>"+
		                      "<tr>"+
		                        "<td><span>RS:</span></td><td>Select shift </td>"+
		                      "</tr>"+

		                    "</table>"+
		                    
		                  "</ul>"+
		                  "<p class='pt-1'><a href='room-single.html' class='btn-custom px-3 py-2'>View Venue Details <span class='icon-long-arrow-right'></span></a>"+
		                    "<br>"+
		                    "<a href='room-single.html' class='btn btn-primary px-3 py-2'>Book Now </a>"+
		                  "</p>"+
		                  
		                  "</div>"+
		                "</div>"+
		            "</div>"+
		          "</div>");
				} 
 
			}
		}
		
	}
}
