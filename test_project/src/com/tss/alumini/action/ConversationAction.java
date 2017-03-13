//$Id$
package com.tss.alumini.action;

import java.sql.ResultSet;
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
    			return mapping.findForward("conversation");
    		}
    		if(action.equalsIgnoreCase("getconversationlist")){
    			String userName1 = (String)request.getSession().getAttribute("UserName");
    			int id = getUserId(userName1);
    			ArrayList<HashMap> convlist = getConversationList(id);
    			request.setAttribute("conversationList", convlist);
    		}
    	}
		return mapping.findForward("conv");

    }

    private int getUserId(String name){
    	int id = 0;
    	String query = "select * from User where name='"+name+"';";
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}
    		while(res.next()){
    			 id = res.getInt("id");
    		}
    	}catch(Exception ex){
    		
    	}
    	return id;
    }
    
    private String getUserName(int id){
    	String name = null;
    	String query = "select * from User where id='"+id+"';";
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}
    		while(res.next()){
    			 name = res.getString("name");
    		}
    	}catch(Exception ex){
    		
    	}
    	return name;
    }
    
    private ArrayList<HashMap> getConversationList(int id){
    	ArrayList<HashMap> userList = new ArrayList<HashMap>();
    	String query1 = "select DISTINCT conv.user2id, us.name,us.role  from Conversation as conv left join User as us on conv.user2id=us.id where user1id="+id+";";
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query1); 
    		}
    		while(res.next()){
    			int userid = res.getInt("user2id");
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
    	}
    	String query2 = "select DISTINCT conv.user1id, us.name,us.role  from Conversation as conv left join User as us on conv.user1id=us.id where user2id="+id+";";
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query2); 
    		}
    		while(res.next()){
    			int userid = res.getInt("user1id");
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
    			if(user1 != currentUser){
    				name = getUserName(user1);
    			}else if(user2 != currentUser){
    				name = getUserName(user2);
    			}
    			String message = res.getString("message");
    			int time = res.getInt("time");
    			Date itemDate = new Date(time);
    			String itemDateStr = new SimpleDateFormat("yyyy-MM-dd").format(itemDate);
    			HashMap msg = new HashMap();
    			msg.put("username", name);
    			msg.put("message", message);
    			msg.put("time", itemDateStr);
    			conv.add(msg);
    		}
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    	return conv;
    }
}
