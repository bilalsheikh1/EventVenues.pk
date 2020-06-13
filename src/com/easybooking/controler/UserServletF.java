package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.easybooking.dao.UserDao;
import com.easybooking.daoImp.UserDaoImp;
import com.easybooking.encrypt.Encrypt;
import com.easybooking.model.User;

/**
 * Servlet implementation class UserServletF
 */
@WebServlet("/UserServletF")
public class UserServletF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServletF() {
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
		
		String name , email , password , contact , cnic ,dates ;
		Integer id = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();	
		
		HttpSession session = request.getSession();
		PrintWriter pw = response.getWriter();
		
//		ArrayList<User> list = new ArrayList<User>();
		
		User userBean = new User();
		UserDao userDao = new UserDaoImp();
		
		if(request.getParameter("Login")!=null){ 
			String msg ="";
			email = request.getParameter("email");
			password = Encrypt.getMd5(request.getParameter("password"));
			 
			msg="Please Correct Email & Password";
			
			for(User u : userDao.checkValidEmail(email, password)){
				
				id=u.getId(); 
				
				session.setAttribute("userName",u.getName()); 
				session.setAttribute("id",id);  
				session.setMaxInactiveInterval(60*60*24);

				msg= "index.jsp";
			} 
			pw.write(msg); 
		}
		
		else if(request.getParameter("signup")!=null){ 
		
				name = request.getParameter("name");
				email = request.getParameter("email");
				cnic = request.getParameter("cnic");
				password = Encrypt.getMd5(request.getParameter("password"));
				contact = request.getParameter("contact");
				dates = sdf.format(date);
					
				
				if(name.equals(" ") && email.equals(" ") && password.equals(" ")&& contact.equals(" ")){
						pw.write("Please Fill All text filed first");
				}
				
				else {
					userBean.setName(name);
					userBean.setEmail(email);
					userBean.setPassword(password); 
					userBean.setContact(contact);
//					userBean.setCnic(cnic);
					userBean.setCreated_at(dates);
					int i = userDao.addRecord(userBean);
					pw.write("Acount Register");
					}
			 
		}
		
		else if(request.getParameter("method")!=null){
			if(request.getParameter("method").equals("checkEmail")){
				email = request.getParameter("email");
				int i = userDao.checkEmailInDb(email); 
				if(i > 0){ 
					pw.write("used");
				}
				else{
					pw.write("not used");
				}
			}   
			else if(request.getParameter("method").equals("updateContact")){
				id=Integer.parseInt(request.getParameter("id"));
				contact = request.getParameter("contact");
				userBean.setId(id);
				userBean.setContact(contact);
				userDao.updateUserByHQL(userBean);
				pw.write(contact);   
			}
			else if(request.getParameter("method").equals("updatePassword")){
				
				id=Integer.parseInt(request.getParameter("id"));
				password = Encrypt.getMd5(request.getParameter("currentPassword"));
				String newPassword=Encrypt.getMd5(request.getParameter("newPassword"));
				userBean=userDao.getDataById(id);
				if(password.equals(userBean.getPassword())){
					userBean.setPassword(newPassword);
					userBean.setId(id);
					userBean.setContact("");
					userDao.updateUserByHQL(userBean);
					pw.write("Password Updated");
				} 
				else{ 
					pw.write("password not match");
				}
			}
		}
		
		
		else if(request.getParameter("session")!=null){
			if(request.getParameter("session").equals("logout")){
				session.invalidate();
				response.sendRedirect("frontend/login.jsp");   
			}
		}
		
	}
}