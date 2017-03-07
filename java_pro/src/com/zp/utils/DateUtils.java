package com.zp.utils;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class DateUtils {
	private static String dateReg = "^\\d{4}(\\-|\\/|\\.)\\d{1,2}(\\-|\\/|\\.)\\d{1,2}(\\s\\d{1,2}:\\d{1,2}(:\\d{1,2})?)?$";

	/**
	 * 判断是否是有效的日期
	 * @param dateStr
	 * @return
	 */
	public static boolean isDateValid(String dateStr) {
		return StringUtils.matches(dateReg, dateStr);
	}
	public static String getFormatStr(String dateStr)
	{
		String reg1="^\\d{4}\\-\\d{1,2}\\-\\d{1,2}$";
		String reg2="^\\d{4}\\-\\d{1,2}\\-\\d{1,2}\\s\\d{1,2}:\\d{1,2}$";
		if(StringUtils.matches(reg1, dateStr))
		{
			return "yyyy-MM-dd";
		}
		if(StringUtils.matches(reg2, dateStr))
		{
			return "yyyy-MM-dd HH:mm";
		}
		return "yyyy-MM-dd HH:mm:ss";
		
	}
	public static long parseToTimeMillis(String dateStr)
	{
		if(!isDateValid(dateStr))
			return -1;
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat(getFormatStr(dateStr));
		try {
			return simpleDateFormat.parse(dateStr).getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return -1;
	}
	/**
	 * 新增将日期字符串转换成Calendar 对象
	 */
	public static Calendar parseToDate(String dateStr)
	{
		Calendar calendar=Calendar.getInstance();
		if(!isDateValid(dateStr))
			return calendar;
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat(getFormatStr(dateStr));
		try {
			
			calendar.setTime(simpleDateFormat.parse(dateStr));
			return calendar;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return calendar;
	}
	
	/**
	 * 根据时间取出周几
	 * @param dateStr
	 * @return
	 */
	public static int getDayOfWeek(String dateStr)
	{
		Calendar date = parseToDate(dateStr);
		//一周第一天是否为星期天
		boolean isFirstSunday = (date.getFirstDayOfWeek() == Calendar.SUNDAY);
		//获取周几
		int weekDay = date.get(Calendar.DAY_OF_WEEK);
		//若一周第一天为星期天，则-1
		if(isFirstSunday){
			weekDay = weekDay - 1;
		    if(weekDay == 0){
			    weekDay = 7;
			}
		}
		//打印周几
		System.out.println(weekDay);
		return weekDay;
	}
	
	
	
	/**
	 * 得到系统时间格式yyyy-MM-dd hh:mm:ss"
	 * @return
	 */
	public static String getNowTimeStr()
	{
		return getNowTimeStr("yyyy-MM-dd HH:mm:ss");
	}
	public static String getNowTimeStr(String format)
	{
		Calendar calendar=Calendar.getInstance();
		
		calendar.setTimeInMillis(System.currentTimeMillis());
		SimpleDateFormat sdf=new SimpleDateFormat(format);
		return sdf.format(calendar.getTime());
	}
	/**
	 * 判断日期dateStr1是否晚于dateStr2
	 * @param dateStr1
	 * @param dateStr2
	 * @return
	 */
	public static boolean compareDateStrGreater(String dateStr1,String dateStr2)
	{
		if(StringUtils.isEmpty(dateStr1,dateStr2))
		{
			return false;
		}
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date1=simpleDateFormat.parse(dateStr1);
			Date date2=simpleDateFormat.parse(dateStr2);
			return date1.after(date2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	/**
	 * 判断是否闰年
	 * @param year
	 * @return
	 */
	public static boolean isLeapYear(int year)
	{
		return year%400==0||(year%4==0&&year%100!=0);
	}
	/**
	 * 根据年和月得到当月天数
	 * @param year
	 * @param month
	 * @return
	 */
	public static int getDays(int year,int month)
	{
		if(month==2)
		{
			return isLeapYear(year)?29:28;
		}else
		{
			return (month==4||month==6||month==9||month==11)?30:31;
		}
	}
}
