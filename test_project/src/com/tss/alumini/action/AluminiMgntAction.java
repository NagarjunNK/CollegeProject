package com.tss.alumini.action;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.mysql.jdbc.Connection;
import com.tss.db.DbConnection;

public class AluminiMgntAction extends Action {
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
       		
       		if(action.equalsIgnoreCase("home")){
       			Calendar c = new GregorianCalendar();
       			c.set(Calendar.HOUR_OF_DAY, 0);
       			c.set(Calendar.MINUTE, 0);
       			c.set(Calendar.SECOND, 0);
       			Long d1 = c.getTimeInMillis();

       			Calendar c1 = new GregorianCalendar(); 
       			c1.add(Calendar.DATE, 1);
       			c.set(Calendar.HOUR_OF_DAY, 0);
       			c.set(Calendar.MINUTE, 0);
       			c.set(Calendar.SECOND, 0);
       			Long d2 = c1.getTimeInMillis();

       			String eventQuery ="SELECT * FROM Events WHERE time BETWEEN "+d1+" AND "+d2;
    			ArrayList<HashMap> events = getEvents(eventQuery);
    			
    			String announcementQuery = "SELECT * FROM Announcement";
    			ArrayList<HashMap> announcement = getAnnouncement(announcementQuery);

    			request.setAttribute("events", events);
    			request.setAttribute("announcements", announcement);
       	        return mapping.findForward("home"); // No I18N
       			
       		}
    		if("getevents".equalsIgnoreCase(action)){
        		String query = "select * from Events order by time desc";
    			ArrayList<HashMap> events = getEvents(query);
    			request.setAttribute("events", events);
        		return mapping.findForward("eventList");

    		}
    		if("addNewEvent".equalsIgnoreCase(action)){
        		return mapping.findForward("addNewEvent");
    		}
    		if("saveEvent".equalsIgnoreCase(action)){
        		String query = "select * from Events order by time desc";
    			ArrayList<HashMap> events = getEvents(query);
    			request.setAttribute("events", events);
        		return mapping.findForward("eventList");
    		}
    		if("addNewAlumni".equalsIgnoreCase(action)){
        		return mapping.findForward("addNewAlumni");
    		}
    		if("saveAlumni".equalsIgnoreCase(action)){
        		String query = "select * from Alumni";
    			ArrayList<HashMap> alumniList = getEvents(query);
    			request.setAttribute("alumniList", alumniList);
        		return mapping.findForward("alumniList");
    		}
    		
    		if("getalumnilist".equalsIgnoreCase(action)){
        		String query = "select * from Alumni";
    			ArrayList<HashMap> alumniList = getAlumniList(query);
    			request.setAttribute("alumniList", alumniList);
        		return mapping.findForward("alumniList");

    		}
    	}
        return mapping.findForward("login"); // No I18N
    	
    }
    
    private ArrayList<HashMap> getEvents(String query){

    	ArrayList<HashMap> events = new ArrayList<HashMap>();

    	try{
    		

    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}
    		while(res.next()){
    			HashMap row = new HashMap();
    			int id  = res.getInt("eventid");
    			String title = res.getString("title");
    			String description = res.getString("description");
    			String place = res.getString("place");
    			long time = res.getLong("time");
    			Date itemDate = new Date(time);
    			String itemDateStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SS").format(itemDate);
    			row.put("id", id);
    			row.put("title", title);
    			row.put("description", description);
    			row.put("place", place);
    			row.put("time", itemDateStr);

    			events.add(row);
    		}
    	}catch(Exception ex){

    	}finally{
    		try {
    			res.close();
    			st.close();
    			conn.close();
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    	}
    	return events;
    }
    
    private ArrayList<HashMap> getAnnouncement(String query){
    	
    	ArrayList<HashMap> announcement = new ArrayList<HashMap>();
    	try{
    		
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}
    		while(res.next()){
    			HashMap row = new HashMap();
    			Long id  = res.getLong("id");
    			String title = res.getString("message");
    			
    			row.put("id", id);
    			row.put("title", title);
    			
    			announcement.add(row);
    		}
    	}catch(Exception ex){

    	}finally{
    		try {
    			res.close();
    			st.close();
    			conn.close();
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    	}
    	return announcement;
    	
    }
    private ArrayList<HashMap> getAlumniList(String query){

    	
    	ArrayList<HashMap> alumniList = new ArrayList<HashMap>();
    	try{

    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}
    		while(res.next()){
    			HashMap row = new HashMap();
    			int id  = res.getInt("id");
    			String name = res.getString("name");
    			long dob = res.getLong("dob");
    			Date dobDate = new Date(dob);
    			String dobStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SS").format(dobDate);
    			long batchyear = res.getLong("batchyear");
    			long passoutyear = res.getLong("passoutyear");
    			String degree = res.getString("degree");
    			String currentposition = res.getString("currentposition");
    			long mobilenumber = res.getLong("mobilenumber");
    			String email = res.getString("email");


    			row.put("id", id);
    			row.put("name", name);
    			row.put("dobStr", dobStr);
    			row.put("batchyear", batchyear);
    			row.put("passoutyear", passoutyear);
    			row.put("degree", degree);
    			row.put("currentposition", currentposition);
    			row.put("mobilenumber", mobilenumber);
    			row.put("email", email);
    			
    			alumniList.add(row);
    			System.out.println("AlumniList"+alumniList);
    		}
    	}catch(Exception ex){

    	}finally{
    		try {
    			res.close();
    			st.close();
    			conn.close();
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    	}
    	return alumniList;
    	
    
    }
}
