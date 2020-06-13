package com.easybooking.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.easybooking.dao.UserDao;
import com.easybooking.daoImp.UserDaoImp;
import com.easybooking.encrypt.Encrypt;
import com.easybooking.model.User;
import com.google.gson.Gson;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
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
		
		String name , email , password , contact  ,dates ;
		Integer id= null;
		
		User userBean = new User();
		UserDao userDao = new UserDaoImp();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();	
		PrintWriter pw = response.getWriter();
		ArrayList<User> list = new ArrayList<User>();
		Gson gson = new Gson(); 
		HttpSession session = request.getSession();
		
		if(request.getParameter("Action")!=null){ // Action means id in hidden text field id is 0 so insert data;
			id = Integer.parseInt(request.getParameter("Action"));
			if(id == 0){
				
				name = request.getParameter("name");
				email = request.getParameter("email");
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
					userBean.setCreated_at(dates);
				
//					userBean= new User(0, name, email, password, contact, cnic, dates,"", 1, 0);
					int i = userDao.addRecord(userBean);
					pw.write("Acount Register");
					}
			
			}
			else if (id > 0){ // Action means id in hidden text field id is > 0  so update data;
				
				
				id = Integer.parseInt(request.getParameter("Action"));
				name = request.getParameter("name");
				email = request.getParameter("email");
				password = request.getParameter("password");
				contact = request.getParameter("contact");
				dates = sdf.format(date);
					if(name.equals(" ") && email.equals(" ") && password.equals(" ") && contact.equals(" ")){
						pw.write("Please Fill All text filed first");
						
					}
				
					else {
						userBean.setId(id);
						userBean.setName(name);
						userBean.setEmail(email);
						userBean.setPassword(password);
						userBean.setContact(contact);
						userBean.setUpdated_at(dates);
						int i = userDao.updateRecord(userBean);
						pw.write("User Updated");
					}
				
			}
		}
		
		else if(request.getParameter("Login")!=null){
				email = request.getParameter("email");
				password = Encrypt.getMd5(request.getParameter("password"));
				
				list = userDao.checkValidEmail(email, password);
				email="Please Correct Email & Password";
		
				for(User u : list){
					email = "dashboard.jsp";
					session.setAttribute("admin","Muhammad Bilal");
					session.setAttribute("active",u.getActive());
				}
				pw.write(email);
		}
		
		else if (request.getParameter("method")!=null){
			if(request.getParameter("method").equals("delete") && request.getParameter("id")!=null){
				id= Integer.parseInt(request.getParameter("id"));
				userBean.setId(id);
				userBean.setActive((byte) 0); 
				userDao.updateUserByHQLActive(userBean);
				int serialNo = 0;
 				for(User u : userDao.getAllRecord(1)){
					serialNo++;
					pw.write("<tr> <td>"+serialNo+"</td>" + "<td>"+u.getName()+"</td>" + "<td>"+u.getEmail()+"</td>"+ "<td>"+u.getContact()+"</td>"+ 
								"<td><a href=adduser.jsp?id="+u.getId()+">"//<input type='image' src='img/updateicon.png'></a>"
									+ "<input type='image' id='image' src='img/deleteicon.png' onclick='deleterecord("+u.getId()+")' /></td></tr>");
				}
			}
			else if (request.getParameter("method").equals("approved")){
				id= Integer.parseInt(request.getParameter("id"));
				userBean.setId(id);
				userBean.setActive((byte) 1); 
				userDao.updateUserByHQLActive(userBean);
				userDao.getAllRecord(1);
				int serialNo = 0;
				for(User u : userDao.getAllRecord(0)){ 
					serialNo++;
					pw.write("<tr> <td>"+serialNo+"</td>" + "<td>"+u.getName()+"</td>" + "<td>"+u.getEmail()+"</td>"+ "<td>"+u.getContact()+"</td>"+ 
									 "<td><input type='image' id='image' src='img/checked.png' onclick='approvedRecord("+u.getId()+")' /></td></tr>");
				}  
			}
		}
		else if(request.getParameter("session")!=null){
			if(request.getParameter("session").equals("destroy")){
				session.invalidate();
				response.sendRedirect("backend/index.jsp");
			}
		}
 	}

}
