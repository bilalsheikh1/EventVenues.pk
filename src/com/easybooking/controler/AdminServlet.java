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

import com.easybooking.dao.AdminDao;
import com.easybooking.daoImp.AdminDaoImp;
import com.easybooking.dto.AdminDTO;
import com.easybooking.encrypt.Encrypt;
import com.easybooking.model.Admin;
import com.easybooking.model.User;
import com.google.gson.Gson;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
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
		int id=0;
		String name = "",email = "" , password = "" ;
		
		Admin admin = new Admin();
		AdminDao adminDao = new AdminDaoImp();
		
		ArrayList<Admin> list = new ArrayList<Admin>();
		PrintWriter pw = response.getWriter();
		HttpSession session = request.getSession();
		Gson gson = new Gson();
				
		if(request.getParameter("Login")!=null){
			email = request.getParameter("email");
//			password = Encrypt.getMd5(request.getParameter("password"));
			password = request.getParameter("password"); 
			
			list = adminDao.checkValidEmail(email, password);
			email="Please Correct Email & Password";
	
			for(Admin a : list){
				email = "dashboard.jsp";
				session.setAttribute("admin",a.getName());
				session.setAttribute("active",a.getActive());
			}
			pw.write(email);
		}
		
		else if(request.getParameter("method")!=null){
			if(request.getParameter("method").equals("insert")){
				
				if(!request.getParameter("name").equals("") && !request.getParameter("email").equals("") && 
						!request.getParameter("password").equals("")){
				
					name = request.getParameter("name");
					email = request.getParameter("email");
					password = request.getParameter("password");
				
					admin.setName(name);
					admin.setEmail(email);
					admin.setPassword(password);
				
					adminDao.insert(admin);
					byte serial = 0;
					for(Admin a : adminDao.getData()){ serial++;
						pw.write("<tr>"+
								"<td>"+serial+"</td>"+
								"<td>"+a.getName()+"</td>"+
								"<td>"+a.getEmail()+"</td>"+
								"<td>"+a.getPassword()+"</td>"+
								"<td><img src='img/updateicon.png' style='cursor: pointer;' onclick='getUserByID("+a.getId()+")' /><img src='img/deleteicon.png' style='cursor: pointer;' onclick='deleteUser("+a.getId()+")' /></td>"+
								"</tr>");
						}
				}
			}
			else if(request.getParameter("method").equals("update")){ 
				if(!request.getParameter("name").equals("") && !request.getParameter("email").equals("") && 
						!request.getParameter("password").equals("")){
							id = Integer.parseInt(request.getParameter("id"));
							name = request.getParameter("name");
							email = request.getParameter("email");
							password = request.getParameter("password");
				
							admin.setId(id);
							admin.setName(name);
							admin.setEmail(email);
							admin.setPassword(password);
				
							adminDao.update(admin);
							
							byte serial = 0;
							for(Admin a : adminDao.getData()){ serial++;
							pw.write("<tr>"+
									"<td>"+serial+"</td>"+
									"<td>"+a.getName()+"</td>"+
									"<td>"+a.getEmail()+"</td>"+
									"<td>"+a.getPassword()+"</td>"+
									"<td><img src='img/updateicon.png' style='cursor: pointer;' onclick='getUserByID("+a.getId()+")' /><img src='img/deleteicon.png' style='cursor: pointer;' onclick='deleteUser("+a.getId()+")' /></td>"+
									"</tr>");
							}
					}
			}
			else if(request.getParameter("method").equals("delete")){
				id = Integer.parseInt(request.getParameter("id"));
				admin.setId(id);
				adminDao.delete(admin);
				byte serial = 0;
				for(Admin a : adminDao.getData()){ serial++;
				pw.write("<tr>"+
						"<td>"+serial+"</td>"+
	            		"<td>"+a.getName()+"</td>"+
	            		"<td>"+a.getEmail()+"</td>"+
	            		"<td>"+a.getPassword()+"</td>"+
	            		"<td><img src='img/updateicon.png' style='cursor: pointer;' onclick='getUserByID("+a.getId()+")' /><img src='img/deleteicon.png' style='cursor: pointer;' onclick='deleteUser("+a.getId()+")' /></td>"+
            	"</tr>");
				}
			}
			else if(request.getParameter("method").equals("getDataByID")){
				id = Integer.parseInt(request.getParameter("id"));
				admin = adminDao.getDataByID(id); 
				ArrayList<AdminDTO> dto = new ArrayList<AdminDTO>();
				AdminDTO adminDTO = new AdminDTO();
				adminDTO.setId(admin.getId());
				adminDTO.setName(admin.getName());
				adminDTO.setEmail(admin.getEmail());
				adminDTO.setPassword(admin.getPassword());
				dto.add(adminDTO); 
				pw.write(gson.toJson(admin));
			}
//			else if(request.getParameter("method").equals("getData")){
//				list = adminDao.getData();
//				pw.write(gson.toJson(list));
//			}
		}

	}
}
