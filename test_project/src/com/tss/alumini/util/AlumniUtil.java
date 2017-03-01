//$Id$
package com.tss.alumini.util;

public class AlumniUtil {

	private static AlumniUtil util = null;

	private AlumniUtil()
	{
		
	}
	public static AlumniUtil getInstance()
	{
		if(util == null)
		{
			util = new AlumniUtil();
		}
		return util;
	}
}
