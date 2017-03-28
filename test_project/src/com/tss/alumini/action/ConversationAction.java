//$Id$
package com.tss.alumini.action;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.mysql.jdbc.Connection;
import com.tss.db.DbConnection;

public class ConversationAction extends Action{
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
    		if(action.equalsIgnoreCase("getconversation")){
    			String userName1 = (String)request.getSession().getAttribute("UserName");
    			int user1id = getUserId(userName1);
    			String user2idStr = request.getParameter("id");
    			int user2id = Integer.parseInt(user2idStr);
    			ArrayList<HashMap> conv = getConversation(user1id,user2id,user1id);
    			request.setAttribute("conversation", conv);
    			request.setAttribute("id", user2idStr);
    			return mapping.findForward("conversation");
    		}
    		if(action.equalsIgnoreCase("getconversationlist")){
    			String userName1 = (String)request.getSession().getAttribute("UserName");
    			int id = getUserId(userName1);
    			ArrayList<HashMap> convlist = getConversationList(id);
    			request.setAttribute("conversationList", convlist);
    		}else if(action.equalsIgnoreCase("postComment")){
    			String userName1 = (String)request.getSession().getAttribute("UserName");
    			int user1id = getUserId(userName1);
    			String user2idStr = request.getParameter("id");
    			int user2id = Integer.parseInt(user2idStr);
    			String message = request.getParameter("message");
    			boolean status = postComment(user1id,user2id,message);
    			ArrayList<HashMap> conv = getConversation(user1id,user2id,user1id);
    			request.setAttribute("conversation", conv);
    			request.setAttribute("id", user2idStr);
    			return mapping.findForward("conversation");
    		}
    	}
		return mapping.findForward("conv");
    }

    private int getUserId(String name){
    	Connection connection = null;
    	DbConnection dbDconnection = null;
    	Statement statement = null;
    	ResultSet resultSet = null;
    	int id = 0;
    	String query = "select * from User where name='"+name+"';";
    	try{
    		try{
    			dbDconnection = new DbConnection();
    			connection = (Connection)dbDconnection.getConnection();
    		}catch(Exception ex){
    			ex.printStackTrace();
    		}
    		if(connection != null){
    			statement = connection.createStatement();
    			resultSet = statement.executeQuery(query); 
    		}
    		while(resultSet.next()){
    			 id = resultSet.getInt("id");
    		}
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}finally{
    		try {
				closeConnection(connection);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	return id;
    }
    
    private String getUserName(int id){
    	Connection connection = null;
    	DbConnection dbDconnection = null;
    	Statement statement = null;
    	ResultSet resultSet = null;
    	String name = null;
    	String query = "select * from User where id='"+id+"';";
    	try{
    		try{
    			dbDconnection = new DbConnection();
    			connection = (Connection)dbDconnection.getConnection();
    		}catch(Exception ex){
    			ex.printStackTrace();
    		}
    		if(connection != null){
    			statement = connection.createStatement();
    			resultSet = statement.executeQuery(query); 
    		}
    		while(resultSet.next()){
    			 name = resultSet.getString("name");
    		}
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}finally{
    		try {
				closeConnection(connection);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	return name;
    }
    
    private ArrayList<HashMap> getConversationList(int id){
    	ArrayList<HashMap> userList = new ArrayList<HashMap>();
    	String query1 = "select * from User where NOT id="+id+";";
    	System.out.println(query1);
    	//String query1 = "select DISTINCT conv.user2id, us.name,us.role  from Conversation as conv left join User as us on conv.user2id=us.id where user1id="+id+";";
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query1); 
    		}
    		while(res.next()){
    			int userid = res.getInt("id");
    			String name = res.getString("name");
    			String role = res.getString("role");
    			HashMap user = new HashMap();
    			user.put("username", name);
    			user.put("role", role);
    			user.put("id", userid);
    			userList.add(user);
    		}
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}finally{
    		try {
				closeConnection(conn);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	return userList;
    }
    
    private ArrayList<HashMap> getConversation(int user1id, int user2id, int currentUser){
    	ArrayList<HashMap> conv = new ArrayList<HashMap>();
    	String query  = "select * from Conversation where user1id="+user1id+" and user2id="+user2id+" or user1id="+user2id+" and user2id="+user1id+" order by time asc;";
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}
    		while(res.next()){
    			String name = null;
    			int user1 = res.getInt("user1id");
    			int user2 = res.getInt("user2id");
    			String message = res.getString("message");
    			Long time = res.getLong("time");
    			Date itemDate = new Date(time);
    			String itemDateStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(itemDate);
				name = getUserName(user1);
				if(user1 == currentUser){
    				name = "me";
				}
    			
    			HashMap msg = new HashMap();
    			msg.put("username", name);
    			msg.put("message", message);
    			msg.put("time", itemDateStr);
    			conv.add(msg);
    		}
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}finally{
    		try {
				closeConnection(conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}
    	return conv;
    }
    
    private boolean postComment(int user1id, int user2id, String message) throws Exception {
    	Date dateLong = new Date();
		long mills = dateLong.getTime();
    	String query ="insert into Conversation values(default,"+user1id+","+user2id+",'"+message+"',"+mills+");";
    	System.out.println(query);
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			int result = st.executeUpdate(query);
    		}
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}finally{
    		try {
    			st.close();
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
    	}
    	return false;
    }
    private void closeConnection(Connection connection) throws Exception{
    	try{
    		connection.close();
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    }
}
