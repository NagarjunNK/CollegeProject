//$Id$
package com.tss.alumini.action;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.mysql.jdbc.Connection;
import com.tss.db.DbConnection;

public class UserMgntAction extends Action {
	private Connection conn = null;
	private DbConnection dbDconn = null;
	private Statement st = null;
	private ResultSet res = null;

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String action = request.getParameter("action");
       	if(action != null){
       		try{
       			dbDconn = new DbConnection();
        		conn = (Connection)dbDconn.getConnection();
       		}catch(Exception ex){
       			ex.printStackTrace();
       		}
       		if(action.equalsIgnoreCase("userList")){
       			String query = "select * from User";
    			ArrayList<HashMap> users = getUsers(query);
    			request.setAttribute("users", users);
    			closeConnection();
        		return mapping.findForward("userList");
       		}
       		if("getuserdetail".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String query = "select * from User where id="+id;
    			ArrayList<HashMap> users = getUsers(query);
    			request.setAttribute("user", users);
    			closeConnection();
        		return mapping.findForward("userDetail");
    		}
       		if("addNewUser".equalsIgnoreCase(action)){
        		return mapping.findForward("addNewUser");
    		}
       		if("saveUser".equalsIgnoreCase(action)){
       			saveUser(request);
        		String query = "select * from User";
    			ArrayList<HashMap> users = getUsers(query);
    			request.setAttribute("users", users);
    			closeConnection();
        		return mapping.findForward("userList");
    		}
       		if("deleteUser".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String deleteQuery = "delete from User where id='"+id+"';";
    			deleteEntity(deleteQuery);
    			String query = "select * from User ";
    			ArrayList<HashMap> users = getUsers(query);
    			request.setAttribute("users", users);
    			closeConnection();
        		return mapping.findForward("userList");
    		}
       		if("editUser".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String query = "select * from User where id="+id;
    			ArrayList<HashMap> user = getUsers(query);
    			request.setAttribute("user", user);
    			closeConnection();
        		return mapping.findForward("addNewUser");
    		}
       	}
		return null;
	}
	
	private ArrayList<HashMap> getUsers(String query) throws Exception{
    	ArrayList<HashMap> users = new ArrayList<HashMap>();
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}
			System.out.println("query:"+query);
    		while(res.next()){
    			HashMap row = new HashMap();
    			int id  = res.getInt("id");
    			String name = res.getString("name");
    			String role = res.getString("role");
    			row.put("id", id);
    			row.put("name", name);
    			row.put("role", role);

    			users.add(row);
    		}
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}finally{
    		try {
    			res.close();
    			st.close();
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    	}
    	return users;
    }
	 private void closeConnection() throws Exception{
	    	try{
	    		conn.close();
	    	}catch(Exception ex){
	    		ex.printStackTrace();
	    	}
	    }
	 
	 private void saveUser(HttpServletRequest request) throws Exception{
	    	String id = (String)request.getParameter("id");
	    	String name = (String)request.getParameter("name");
			String role = (String)request.getParameter("role");
			String password = (String)request.getParameter("password");
			
			String query = null;
			if("".equalsIgnoreCase(id) || id ==null){
				query = "insert into User values(default,'"+name+"','"+password+"','"+role+"');";
			}else{
				query = "update User set name='"+name+"',role='"+role+"',password='"+password+"'' where id='"+id+"';";

			}
			try{
	    		if(conn != null){
	    			st = conn.createStatement();
	    			int result = st.executeUpdate(query);
	    		}
	    	}catch(Exception ex){

	    	}finally{
	    		try {
	    			st.close();
	    		} catch (SQLException e) {
	    			// TODO Auto-generated catch block
	    			e.printStackTrace();
	    		}
	    	}
	    }
	 private void deleteEntity(String query) throws Exception{
	    	try{
	    		if(conn != null){
	    			st = conn.createStatement();
	    			int result = st.executeUpdate(query);
	    		}
	    	}catch(Exception ex){

	    	}finally{
	    		try {
	    			st.close();
	    		} catch (SQLException e) {
	    			// TODO Auto-generated catch block
	    			e.printStackTrace();
	    		}
	    	}
	    }
}
