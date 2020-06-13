package com.easybooking.controler;
 
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
 
import com.easybooking.dao.GalleryDao;
import com.easybooking.dao.MarqueeDao;
import com.easybooking.daoImp.GalleryDaoImp;
import com.easybooking.daoImp.MarqueeDaoImp;
import com.easybooking.model.Gallery;
import com.easybooking.model.Marquee;
//import com.oreilly.servlet.MultipartRequest;


/**
 * Servlet implementation class GalleryServlet
 */
@WebServlet("/GalleryServlet")
@MultipartConfig
public class GalleryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GalleryServlet() {
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
		
		Gallery galleryBean = new Gallery();
		GalleryDao galleryDao = new GalleryDaoImp();
		Marquee marqueeBean = new Marquee();
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH mm sss");
		Date date = new Date();
		HttpSession session = request.getSession();
		PrintWriter pw = response.getWriter();
		boolean check = false ;
		
		 
		if(request.getParameter("method")!=null){ 
			if(request.getParameter("method").equals("delete")){ 
				
				String img = request.getParameter("imgName"); 
				File file = new File("d:"+File.separator+"uploads"+File.separator+img);
				file.delete();  
				int id = Integer.parseInt(request.getParameter("id"));
				galleryBean.setId(id);  
				galleryDao.deleteImg(galleryBean);
				id = Integer.parseInt(""+session.getAttribute("marquee_id"));
				MarqueeDao marqueeDao = new MarqueeDaoImp();
				marqueeBean = marqueeDao.getDataById(id); 
				for (Gallery g : marqueeBean.getGalleries()){ 
					if(g.getImage()!=null){ 
						pw.write("<div class='container-img' style='display : inline-block;' > <img src='"+request.getContextPath()+"/img/"+g.getImage()+"' class='image' style='border: 2px solid #ec8d3b' />"+    
			              "<div class='middle-img'>"+          
				              "<div class='text-icon'><img src= '../backend/img/delete64.png' onclick='img_delete("+g.getId()+" , "+g.getImage()+" );' style='cursor: pointer;' ></div>"+  
						  "</div></div>"); 
					}
				} 
//				pw.write("Image Deleted");
			}      
		}
		 
		else if(request.getParameter("img")!=null){  
			String img = request.getParameter("folderName"); 
			String saveDirectory= "d:"+File.separator+"uploads"+File.separator+img;
			File file = new File(saveDirectory);
			FileOutputStream fos = null;
			Collection<Part> part1 = request.getParts();
			Integer marquee_id  = Integer.parseInt(""+session.getAttribute("marquee_id"));
			if(ServletFileUpload.isMultipartContent(request)){
				
				if(part1.size() > 1){	
					int i = 0 ;
					for(Part p : part1){
						if(i>2){
							InputStream is = p.getInputStream();
							byte  []b = new byte [is.available()];
							is.read(b);
							fos = new FileOutputStream(saveDirectory+"//"+p.getSubmittedFileName());
							galleryBean.setImage(img+"//"+p.getSubmittedFileName());  
							marqueeBean.setId(marquee_id);
							galleryBean.setMarquee(marqueeBean); 
							galleryBean.setLogo(request.getParameter("logo"));
							galleryDao.addImage(galleryBean);
							fos.write(b);
							fos.close();
						}
						i++;
					}
					MarqueeDao marqueeDao = new MarqueeDaoImp(); 
					marqueeBean = marqueeDao.getDataById(marquee_id); 
					for (Gallery g : marqueeBean.getGalleries()){ 
						if(g.getImage()!=null){ 
							pw.write("<div class='container-img' style='display : inline-block;' > <img src='/EasyBooking/img/"+g.getImage()+"' class='image' style='border: 2px solid #ec8d3b' />"+    
				              "<div class='middle-img'>"+          
 				              "<div class='text-icon'><img src= '../backend/img/delete64.png' onclick='img_delete("+g.getId()+" , "+g.getImage()+" );' style='cursor: pointer;' ></div>"+  
							  "</div></div>"); 
						}
					} 
			}
		}
		}
		else{
		try{
		
//		Integer marquee_id = Integer.parseInt(""+session.getAttribute("marquee_id"));
		Integer marquee_id  = Integer.parseInt(""+session.getAttribute("marquee_id"));
		Collection<Part> parts = request.getParts();
		
		
		marqueeBean.setId(marquee_id);
		galleryBean.setMarquee(marqueeBean);
		
		String directory = sdf.format(date);
		String saveDirectory= "d:"+File.separator+"uploads"+File.separator+directory;
		File file = new File(saveDirectory);
		FileOutputStream fos = null;
		
			if(ServletFileUpload.isMultipartContent(request)){
				file.mkdir();
				int i = 1 ;
					if(parts.size() > 2 ){	
						for(Part p : parts){
							
								InputStream is = p.getInputStream();
								byte  []b = new byte [is.available()];
								is.read(b);
								fos = new FileOutputStream(saveDirectory+"//"+p.getSubmittedFileName());
								if(i==1){
									galleryBean.setLogo(directory+"//"+p.getSubmittedFileName());
								}
								else{ 
									galleryBean.setImage(directory+"//"+p.getSubmittedFileName()); 
								}
								galleryDao.addImage(galleryBean);
								fos.write(b);
								fos.close();
								i++;
						}
						check = true;
					}
				}
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
			if(check == true){
				pw.write("Completed");
			}
			else{
				pw.write("Please Follw the msg");
			}
		}
	}
	}
	