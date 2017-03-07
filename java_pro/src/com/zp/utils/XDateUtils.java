package com.zp.utils;

import zp.baseandroid.common.utils.DateUtils;
import zp.baseandroid.common.utils.StringUtils;

public class XDateUtils extends DateUtils {
	public static enum DateType{
		Year_Month,Month_Day,Year_Month_Day
	}
	/**
	 * 有些日期中间还有空格，需要特殊处理
	 * @param dateStr
	 * @param dateType
	 * @return
	 */
	public static String getDateStr(String dateStr,DateType dateType)
	{
		if(!StringUtils.isEmpty(dateStr))
		{
			String splitChar="";
			if(dateStr.contains("-"))
			{
				splitChar="-";
			}else if(dateStr.contains("/"))
			{
				splitChar="/";
			}
			int firLocation=dateStr.indexOf(splitChar);
			
			String year=dateStr.substring(0,firLocation).trim();
			
			dateStr=dateStr.substring(firLocation+1);
			firLocation=dateStr.indexOf(splitChar);
			
			String month=dateStr.substring(0,firLocation).trim();
			
			dateStr=dateStr.substring(firLocation+1);
			firLocation=dateStr.indexOf(splitChar);
			String day=dateStr;
			//格式不对进行特殊处理
			if(firLocation!=-1)
			{
				day=dateStr.substring(0,firLocation).trim();
			}
			
			switch (dateType) {
				case Year_Month:
					return year+splitChar+month;
				case Month_Day:
					return month+splitChar+day;
				case Year_Month_Day:
					return year+splitChar+month+splitChar+day;
				default:
					break;
			}
			
			return dateStr.substring(0,dateStr.lastIndexOf("-"));
		}
		return "";
	}
}
