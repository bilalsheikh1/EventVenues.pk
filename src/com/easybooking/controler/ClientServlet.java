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

import com.easybooking.dao.ClientDao;
import com.easybooking.daoImp.ClientDaoImp;
import com.easybooking.model.Client;
import com.google.gson.Gson;

/**
 * Servlet implementation class ClientServlet
 */
@WebServlet("/ClientServlet")
public class ClientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClientServlet() {
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
		
		String name , email , password , contact , createdAt , updatedAt,cnic;
		
		Client client = new Client();
		ClientDao clientDao = new ClientDaoImp();
		SimpleDateFormat sdf = new SimpleDateFormat("");
		Date date = new Date();
		PrintWriter pw = response.getWriter();
		Gson gson = new Gson();
		
		if(request.getParameter("")!=null){
			
		}
		
	}

}
