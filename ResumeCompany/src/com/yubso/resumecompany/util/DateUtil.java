package com.yubso.resumecompany.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	/** 
	 * 根据用户生日计算年龄 
	 */
	public static int getAgeByBirthday(Date birthday) 
	{	
		if(birthday==null)
			return 0;
		Calendar cal = Calendar.getInstance();	
		if (cal.before(birthday)) {		
			return 0;
		}	
		int yearNow = cal.get(Calendar.YEAR);	
		int monthNow = cal.get(Calendar.MONTH) + 1;	
		int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);
		cal.setTime(birthday);	
		int yearBirth = cal.get(Calendar.YEAR);	
		int monthBirth = cal.get(Calendar.MONTH) + 1;	
		int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);	
		int age = yearNow - yearBirth;
			if (monthNow <= monthBirth) {		
				if (monthNow == monthBirth) {
					// monthNow==monthBirth 		
					if (dayOfMonthNow < dayOfMonthBirth) {			
						age--;			
					}
				}else {			
					// monthNow>monthBirth 		
					age--;		
				}	
			}
		return age;
				
	}
	/** 
	 * 根据用户生日计算年龄 
	 */
	public static int getAgeByBirthday(String birth) {
		if(!StringUtil.checkIsNotNull(birth))
			return 0;
		String datePattern=getDatePattern(birth);
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat(datePattern);
		
		Date date=null;
		try {
			date=simpleDateFormat.parse(birth);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return getAgeByBirthday(date);
	}
	/**
	 * 得到现在时间并进行格式化，默认格式为yyyy-MM-dd HH:mm:ss
	 * @param formatStr 时间格式表达式
	 * @return
	 */
	
	public static String getNowDateStr(String formatStr)
	{
		return formatDate(null, formatStr);
	}
	/**
	 * 采用默认格式(yyyy-MM-dd HH:mm:ss对日期进行格式化)
	 * @param date
	 * @return
	 */
	public static String formatDate(Date date)
	{
		return formatDate(date,null);
	}
	public static String formatDate(Date date,String formatStr)
	{
		if(!StringUtil.checkIsNotNull(formatStr))
		{
			formatStr="yyyy-MM-dd HH:mm:ss";
		}
		Calendar calendar=Calendar.getInstance();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat(formatStr);
		if(date==null)
		{
			date=calendar.getTime();
		}
		String dateStr=simpleDateFormat.format(date);
		return dateStr;
	}
	
	/**
	 * 得到两个日期相差的天数
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static double getDifferDays(String date1, String date2) {
		if(!StringUtil.checkIsNotNull(date1,date2))
		{
			return 0;
		}
		long date1Time=getDateTime(date1);
		long date2Time=getDateTime(date2);
		long c=date1Time-date2Time;
		double d = ((double)c) / 1000 / 60 / 60 / 24;// 天
		return Math.abs(d);
	}
	/**
	 * 得到时间的毫秒数
	 * @param dateStr
	 * @return
	 */
	public static long getDateTime(String dateStr)
	{
		
		String datePattern=getDatePattern(dateStr);
		SimpleDateFormat sf = new SimpleDateFormat(datePattern);
		long c=0;
		try {
			c = sf.parse(dateStr).getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return c;
	}
	/**
	 * 得到时间的格式 ---简单判断
	 * @param dateStr
	 * @return
	 */
	public static String getDatePattern(String dateStr)
	{
		int yearSplitCount=StringUtil.getStrCount(dateStr, "-");
		if(yearSplitCount>0)
		{
			int detailTimeSplitCount=StringUtil.getStrCount(dateStr, ":");
			if(detailTimeSplitCount==2)
			{
				return "yyyy-MM-dd HH:mm:ss";
			}else if(detailTimeSplitCount==1)
			{
				return "yyyy-MM-dd HH:mm";
			}
		}
		return "yyyy-MM-dd";
	}
	/**
	 * 检查日期是否过期 
	 * 
	 * @param date 时间格式为yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static boolean checkDateExpired(String date)
	{
		if(!StringUtil.checkIsNotNull(date))
		{
			return true;
		}
		try {
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date endTime=sdf.parse(date);
			if(endTime.getTime()>Calendar.getInstance().getTimeInMillis())
			{
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return true;
	}
}
