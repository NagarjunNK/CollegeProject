//$Id$
package com.tss.general;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ApplicationConfiguration {
	private Properties prop = new Properties();
	private static ApplicationConfiguration appConfig = null;

	private ApplicationConfiguration(){
		if(prop.isEmpty()){
			loadProperties();
		}
	}

	public static ApplicationConfiguration getInstance(){
		if(appConfig == null)
		{
			appConfig = new ApplicationConfiguration();
		}
		return appConfig;
	}
	
	public void loadProperties(){
		InputStream input = null;
		try {
			String filename = System.getProperty( "catalina.base" )+File.separator+"webapps"+File.separator+"AluminiMgnt"+File.separator+"WEB-INF"+File.separator+"conf"+File.separator+"conf.properties";
			input =  new FileInputStream(filename);
			prop.load(input);
		} catch (IOException ex) {
			System.out.println("Sorry, unable to find the file");
			ex.printStackTrace();
		} finally{
			if(input!=null){
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public String getProperty(String key){
		String property = null;
		if(!prop.isEmpty()){
			property = prop.getProperty(key);
		}
		return property;
	}

	public Properties getAllProperties(){
		return prop;
	}
}
