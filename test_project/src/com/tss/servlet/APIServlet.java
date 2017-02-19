package com.tss.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tss.db.*;
import com.tss.general.ApplicationConfiguration;

/**
 * Servlet implementation class APIServlet
 */
public class APIServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static Connection conn = null;
	public static DbConnection dbDconn = null;
	
	public void init(ServletConfig config) throws ServletException{
		super.init(config);
		DbConnection dbDconn = new DbConnection();
		conn = dbDconn.getConnection();
	}
       
	public void destroy(){
		super.destroy();
		dbDconn.closeConnection(conn);
	}
 
    public APIServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Statement st = null;
		ResultSet res = null;
		PrintWriter pout = null;
		String username = 	request.getParameter("username");
		String pwd = (String)request.getParameter("password");
		
		String query = "Select * from User where username='"+username+"' and password='"+pwd+"';";
		try {
			if(conn != null){
				st = conn.createStatement();
			    res = st.executeQuery(query); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		try {
			pout = response.getWriter();
			if(res.next()){
				HttpSession session = request.getSession(true);
				session.setAttribute("UserName", username);
				session.setAttribute("UserType", "Admin");
				pout.print("success"); //NO OUTPUTENCODING
			}else{
				pout.print("failure"); //NO OUTPUTENCODING
			}
			st.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pout.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
