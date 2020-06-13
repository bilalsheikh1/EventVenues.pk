package com.easybooking.controler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.easybooking.dao.FooterDao;
import com.easybooking.daoImp.FooterDaoImp;
import com.easybooking.model.Footer;
import com.google.gson.Gson;

/**
 * Servlet implementation class FooterServlet
 */
@WebServlet("/FooterServlet")
@MultipartConfig
public class FooterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FooterServlet() {
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
		String phone,email,address,logo = "",message;
		Integer id;
		
		PrintWriter pw = response.getWriter();
		Gson gson = new Gson();
		
		Footer footer = new Footer();
		FooterDao footerDao = new FooterDaoImp();
		
		if(request.getParameter("method")!=null){
			if(request.getParameter("method").equals("insert")){
				String saveDirectory="d:"+File.separator+"uploads"+File.separator+"footer-img";
				File file = new File(saveDirectory); 
				Collection<Part> part = request.getParts();
				FileOutputStream fos;
				
				if(ServletFileUpload.isMultipartContent(request)){
					if(part.size() > 0){
						if(!request.getParameter("phone").equals("") && !request.getParameter("email").equals("") &&  
								!request.getParameter("address").equals("") && !request.getParameter("message").equals("")){
									phone = request.getParameter("phone");
									email = request.getParameter("email");
									address = request.getParameter("address");
									message = request.getParameter("message");
												
									footer.setPhone(phone);
									footer.setEmail(email);
									footer.setAddress(address);
									footer.setMessage(message);
						      
									for(Part p : part){
										if(p.getSubmittedFileName()!=null)
											logo = p.getSubmittedFileName();
											InputStream is = p.getInputStream();;
											byte b[] = new byte[is.available()];
											is.read(b);
											fos = new FileOutputStream(saveDirectory+"//"+p.getSubmittedFileName());
											fos.write(b);
											fos.close();	
									}

									footer.setLogo(logo);
									footerDao.insertFooter(footer);
						
									pw.write("Inserted");
						}
					}
						
					
				}
			}
			else if(request.getParameter("method").equals("getDataByID")){
				id=Integer.parseInt(request.getParameter("id"));
				footer = footerDao.getDataById(id); 
				pw.write(gson.toJson(footer));
			}
			
			else if(request.getParameter("method").equals("update")){
				if(!request.getParameter("phone").equals("") && !request.getParameter("email").equals("") &&  
						!request.getParameter("address").equals("") && !request.getParameter("message").equals("")){
				
							String saveDirectory="d:"+File.separator+"uploads"+File.separator+"footer-img";
							File file = new File(saveDirectory); 
							Collection<Part> part = request.getParts();
							FileOutputStream fos = null;
				
							if(ServletFileUpload.isMultipartContent(request)){
								if(part.size() > 0){
				
									id = Integer.parseInt(request.getParameter("id"));
						
									phone = request.getParameter("phone");
									email = request.getParameter("email");
									address = request.getParameter("address");
									message = request.getParameter("message");
						
									footer.setId(id);
									footer.setPhone(phone);
									footer.setEmail(email);
									footer.setAddress(address);
									footer.setMessage(message);
									
									byte i = 0;
									
									for(Part p : part){ i++;
										if(i==5){
											if(p.getSubmittedFileName()!=null){
												logo = p.getSubmittedFileName();
												InputStream is = p.getInputStream();
												byte b[] = new byte[is.available()];
												is.read(b);
												if(!logo.equals("")){ 
													fos = new FileOutputStream(saveDirectory+"//"+p.getSubmittedFileName());
													fos.write(b);
													fos.close();   
												}
												else{
													logo = request.getParameter("img_name");
												}
											}
										}
									}
									footer.setLogo(logo); 
									footerDao.updateFooter(footer);
								}
								int serial = 0;
								for(Footer f : footerDao.getFooterData()){ serial++;
								pw.write("<tr>"+
										"<td>"+serial+"</td>"+
										"<td><img src='/EasyBooking/img/footer-img/"+f.getLogo()+"' width='100%' height='15%' ></td>"+
										"<td>"+f.getPhone()+"</td>"+
										"<td>"+f.getEmail()+"</td>"+
										"<td>"+f.getAddress()+"</td>"+ 
										"<td>"+f.getMessage()+"</td>"+
										"<td><img src='img/updateicon.png' style='cursor: pointer;' onclick='getUserByID("+f.getId()+")' /></td>"+
										"</tr>");  
					
								}
							}
					}
				}
			}
		}
	}