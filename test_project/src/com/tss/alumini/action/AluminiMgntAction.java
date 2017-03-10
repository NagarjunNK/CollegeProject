package com.tss.alumini.action;

import java.util.Date;
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

       			String alumniQuery ="SELECT * FROM Alumni";
    			ArrayList<HashMap> birthday = getTodayBirthDayAlumniList(alumniQuery);
    			
    			String eventQuery = "SELECT * FROM Events";
    			ArrayList<HashMap> event = getTodayEvents(eventQuery);

    			request.setAttribute("birthday", birthday);
    			request.setAttribute("event", event);
       	        return mapping.findForward("home"); // No I18N
       			
       		}
    		if("getevents".equalsIgnoreCase(action)){
        		String query = "select * from Events order by time desc";
    			ArrayList<HashMap> events = getEvents(query);
    			request.setAttribute("events", events);
        		return mapping.findForward("eventList");

    		}
    		if("geteventdetail".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String query = "select * from Events where eventid="+id;
    			ArrayList<HashMap> events = getEvents(query);
    			request.setAttribute("event", events);
        		return mapping.findForward("eventDetail");
    		}
    		if("addNewEvent".equalsIgnoreCase(action)){
        		return mapping.findForward("addNewEvent");
    		}
    		if("saveEvent".equalsIgnoreCase(action)){
    			saveEvents(request);
        		String query = "select * from Events order by time desc";
    			ArrayList<HashMap> events = getEvents(query);
    			request.setAttribute("events", events);
        		return mapping.findForward("eventList");
    		}
    		if("editEvent".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String query = "select * from Events where eventid="+id;
    			ArrayList<HashMap> events = getEvents(query);
    			request.setAttribute("event", events);
        		return mapping.findForward("addNewEvent");
    		}
    		if("deleteEvent".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String deleteQuery = "delete from Events where eventid='"+id+"';";
    			deleteEntity(deleteQuery);
    			String query = "select * from Events order by time desc";
    			ArrayList<HashMap> events = getEvents(query);
    			request.setAttribute("events", events);
        		return mapping.findForward("eventList");
    		}
    		if("getalumnilist".equalsIgnoreCase(action)){
        		String query = "select * from Alumni";
    			ArrayList<HashMap> alumniList = getAlumniList(query);
    			request.setAttribute("alumniList", alumniList);
        		return mapping.findForward("alumniList");
    		}
    		if("getalumnidetail".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String query = "select * from Alumni where id="+id;
    			ArrayList<HashMap> events = getAlumniList(query);
    			request.setAttribute("alumni", events);
        		return mapping.findForward("alumniDetail");
    		}
    		if("addNewAlumni".equalsIgnoreCase(action)){
        		return mapping.findForward("addNewAlumni");
    		}
    		if("saveAlumni".equalsIgnoreCase(action)){
    			saveAlumni(request);
        		String query = "select * from Alumni";
    			ArrayList<HashMap> alumniList = getAlumniList(query);
    			request.setAttribute("alumniList", alumniList);
        		return mapping.findForward("alumniList");
    		}
    		if("editAlumni".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String query = "select * from Alumni where id="+id;
    			ArrayList<HashMap> events = getAlumniList(query);
    			request.setAttribute("alumni", events);
        		return mapping.findForward("addNewAlumni");
    		}
    		if("deleteAlumni".equalsIgnoreCase(action)){
    			String id = (String) request.getParameter("id");
    			String deleteQuery = "delete from Alumni where id='"+id+"';";
    			deleteEntity(deleteQuery);
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
			System.out.println("query:"+query);
    		while(res.next()){
    			HashMap row = new HashMap();
    			int id  = res.getInt("eventid");
    			String title = res.getString("title");
    			String description = res.getString("description");
    			String place = res.getString("place");
    			long time = res.getLong("time");
    			Date itemDate = new Date(time);
    			String itemDateStr = new SimpleDateFormat("yyyy-MM-dd").format(itemDate);
    			row.put("id", id);
    			row.put("title", title);
    			row.put("description", description);
    			row.put("place", place);
    			row.put("time", itemDateStr);

    			events.add(row);
    		}
    	}catch(Exception ex){
    		ex.printStackTrace();
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
			System.out.println("query:"+query);

    		while(res.next()){
    			HashMap row = new HashMap();
    			int id  = res.getInt("id");
    			String name = res.getString("name");
    			long dob = res.getLong("dob");
    			Date dobDate = new Date(dob);
    			String dobStr = new SimpleDateFormat("yyyy-MM-dd").format(dobDate);
    			
    			long batchyear = res.getLong("batchyear");
    			Date batchyearDate = new Date(batchyear);
    			String batchyearStr = new SimpleDateFormat("yyyy").format(batchyearDate);
    			
    			long passoutyear = res.getLong("passoutyear");
    			Date passoutyearDate = new Date(passoutyear);
    			String passoutyearStr = new SimpleDateFormat("yyyy").format(passoutyearDate);
    			
       			String degree = res.getString("degree");
    			String currentposition = res.getString("currentposition");
    			long mobilenumber = res.getLong("mobilenumber");
    			String email = res.getString("email");

    			row.put("id", id);
    			row.put("name", name);
    			row.put("dobStr", dobStr);
    			row.put("batchyear", batchyearStr);
    			row.put("passoutyear", passoutyearStr);
    			row.put("degree", degree);
    			row.put("currentposition", currentposition);
    			row.put("mobilenumber", mobilenumber);
    			row.put("email", email);

    			alumniList.add(row);
    			System.out.println("AlumniList:"+alumniList);
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
    
    private ArrayList<HashMap> getTodayBirthDayAlumniList(String query){
    	ArrayList<HashMap> alumniList = new ArrayList<HashMap>();
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}

    		while(res.next()){
    			
    			Calendar todayCal = Calendar.getInstance();
    			int tmonth = todayCal.get(Calendar.MONTH);
    		    int tday = todayCal.get(Calendar.DAY_OF_MONTH);
    			
    			long dob = res.getLong("dob");
    			Date dobDate = new Date(dob);
    			Calendar cal = Calendar.getInstance();
    		    cal.setTime(dobDate);
    		    int month = cal.get(Calendar.MONTH);
    		    int day = cal.get(Calendar.DAY_OF_MONTH);
    			String dobStr = new SimpleDateFormat("yyyy-MM-dd").format(dobDate);
    			
    			if(tmonth == month && tday == day){
    				HashMap row = new HashMap();
        			int id  = res.getInt("id");
        			String name = res.getString("name");
        			long batchyear = res.getLong("batchyear");
        			Date batchyearDate = new Date(batchyear);
        			String batchyearStr = new SimpleDateFormat("yyyy").format(batchyearDate);
        			
        			long passoutyear = res.getLong("passoutyear");
        			Date passoutyearDate = new Date(passoutyear);
        			String passoutyearStr = new SimpleDateFormat("yyyy").format(passoutyearDate);
        			
           			String degree = res.getString("degree");
        			String currentposition = res.getString("currentposition");
        			long mobilenumber = res.getLong("mobilenumber");
        			String email = res.getString("email");

        			row.put("id", id);
        			row.put("name", name);
        			row.put("dobStr", dobStr);
        			row.put("batchyear", batchyearStr);
        			row.put("passoutyear", passoutyearStr);
        			row.put("degree", degree);
        			row.put("currentposition", currentposition);
        			row.put("mobilenumber", mobilenumber);
        			row.put("email", email);

        			alumniList.add(row);
    			}
      		}
    	}catch(Exception ex){

    	}finally{
    		
    	}
    	return alumniList;
    }
    
    private ArrayList<HashMap> getTodayEvents(String query){
    	ArrayList<HashMap> eventList = new ArrayList<HashMap>();
    	try{
    		if(conn != null){
    			st = conn.createStatement();
    			res = st.executeQuery(query); 
    		}

    		while(res.next()){
    			
    			Calendar todayCal = Calendar.getInstance();
    			int tmonth = todayCal.get(Calendar.MONTH);
    		    int tday = todayCal.get(Calendar.DAY_OF_MONTH);
    			
    			long time = res.getLong("time");
    			Date date = new Date(time);
    			Calendar cal = Calendar.getInstance();
    		    cal.setTime(date);
    		    int month = cal.get(Calendar.MONTH);
    		    int day = cal.get(Calendar.DAY_OF_MONTH);
    			String timeStr = new SimpleDateFormat("yyyy-MM-dd").format(date);
    			
    			if(tmonth == month && tday == day){
    				HashMap row = new HashMap();
        			int id  = res.getInt("eventid");
        			String title = res.getString("title");
        			long desc = res.getLong("description");
        			

        			row.put("id", id);
        			row.put("title", title);
        			row.put("desc", desc);

        			eventList.add(row);
    			}
      		}
    	}catch(Exception ex){

    	}finally{
    		
    	}
    	return eventList;
    }
    
    
    private void saveEvents(HttpServletRequest request) throws Exception{
    	String eventid = (String)request.getParameter("eventid");
    	String eventName = (String)request.getParameter("name");
		String desc = (String)request.getParameter("desc");
		String place = (String)request.getParameter("place");
		String date = (String)request.getParameter("date");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date dateLong = (Date)formatter.parse(date);
		long mills = dateLong.getTime();
		String query = null;
		if(eventid.equalsIgnoreCase("") || eventid ==null){
			query = "insert into Events values(default,'"+eventName+"','"+desc+"','"+place+"',"+mills+");";
		}else{
			query = "update Events set title='"+eventName+"',description='"+desc+"',place='"+place+"',time='"+mills+"' where eventid='"+eventid+"';";

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
    private void saveAlumni(HttpServletRequest request) throws Exception{
    	String alumniid = (String)request.getParameter("alumniid");
    	String name = (String)request.getParameter("name");
		SimpleDateFormat yearFormatter = new SimpleDateFormat("yyyy");
		String batch = (String)request.getParameter("batch");
		Date batchDate = (Date)yearFormatter.parse(batch);
		long millsBatch = batchDate.getTime();
		String yearofpassout = (String)request.getParameter("yearofpassout");
		Date passDate = (Date)yearFormatter.parse(batch);
		long millsPass = passDate.getTime();
		String dob = (String)request.getParameter("dob");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date dateLong = (Date)formatter.parse(dob);
		long mills = dateLong.getTime();
		String currentposition = (String)request.getParameter("currentposition");
		String degree = (String)request.getParameter("degree");
		String mobile = request.getParameter("mobile");
		long mobileNum = Long.parseLong(mobile);
		String email = (String)request.getParameter("email");
		String query = null;
		if(alumniid.equalsIgnoreCase("") || alumniid ==null){
	   		query = "insert into Alumni values(default,'"+name+"',"+mills+","+millsBatch+","+millsPass+",'"+degree+"','"+currentposition+"','"+email+"',"+mobileNum+");";
		}else{
			query = "update Alumni set name='"+name+"',dob='"+mills+"',batchyear='"+millsBatch+"',passoutyear='"+millsPass+"',degree='"+degree+"',currentposition='"+currentposition+"',mobilenumber='"+mobileNum+"', email='"+email+"' where id='"+alumniid+"';";

		}
		System.out.println(query);
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
