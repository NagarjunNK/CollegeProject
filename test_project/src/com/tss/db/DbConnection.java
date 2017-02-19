//$Id$
package com.tss.db;
import java.sql.*;

import javax.sql.*;

import com.tss.general.ApplicationConfiguration;

public class DbConnection {
	
	public Connection getConnection() {
		Connection conn = null;
		try { 
			String driverClass = ApplicationConfiguration.getInstance().getProperty("db.driver");
			String dbURL = ApplicationConfiguration.getInstance().getProperty("db.url");
			String userName = ApplicationConfiguration.getInstance().getProperty("db.username");
			
			if((driverClass == null) && (dbURL == null) && (userName==null)){
				dbURL="jdbc:mysql://localhost:3306/alumini_mgnt";
				driverClass="com.mysql.jdbc.Driver";
				userName="root";
				
			}
			String passWord = "";
			Class.forName(driverClass).newInstance(); 
			conn = DriverManager.getConnection(dbURL,userName,passWord); 
		}
		catch (Exception e) { 
			e.printStackTrace(); 
		}
		System.out.println("Database Connection obtained");
		return conn;
	}
	
	public void closeConnection(Connection conn) {
		try{
			if(conn != null){
				conn.close();
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
}
