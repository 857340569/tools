package com.yubso.resumecompany.util;

import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.math.NumberUtils;

public class StringUtil {

	/**
	 * 防止注入，过滤一些特殊字符串
	 * @param str
	 * @return
	 */
    public static String transactSQLInjection(String str)
    {
        if(checkIsNotNull(str))
     	    return str.replaceAll(".*([';]+|(--)+).*", "");
        return str;
    }
	public static boolean checkIsNotNull(String ...str)
	{
		if(str==null||str.length==0)
		{
			return false;
		}
		for (int i = 0; i < str.length; i++) {
			if(!checkIsNotNull(str[i]))
			{
				return false;
			}
		}
		return true;
	}
	public static boolean regMaches(String regEx,String matchStr){
		if(!checkIsNotNull(matchStr))
			return false;
		Pattern pat = Pattern.compile(regEx);  
		Matcher mat = pat.matcher(matchStr);  
		return mat.find(); 
	}
	//判断字付串是否为数字
	public static boolean isNumber(String str)
	{
		return NumberUtils.isNumber(str);
	}
	public static String strFirstCharToUpCase(String oldStr)
	{
		return oldStr.substring(0, 1).toUpperCase()+oldStr.substring(1);
	}
	public static String getUUID()
	{
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	public static boolean checkIsNotNull(String str)
	{
		if(str==null||str.trim().equals(""))
			return false;
		return true;
	}
	public static int getStrCount(String str,String subStr)
	{
		if(checkIsNotNull(str,subStr))
		{
			int index = 0;  
	        int count = 0;  
	        while((index=str.indexOf(subStr))!=-1)  
	        {  
	            str = str.substring(index+subStr.length());  
	            count++;  
	        }  
	        return count;  
		}
		return 0;
	}
	/**
	 * 把折扣转化为中文
	 * @param discount
	 * @return
	 */
	public static String translateDiscountToCN(double discount)
	{
		String discountName="";
		int temp=(int) (discount*100);
		if(temp<0||temp>=100)
		{
			return "";
		}
		String disCountArray[]={"","一","二","三","四","五","六","七","八","九"};
		char disCharArray[]=(temp+"").toCharArray();
		System.out.println(disCharArray);
		if(temp<10)
		{
			discountName=disCountArray[Integer.parseInt(disCharArray[0]+"")];
			discountName="零点"+discountName+"折";
		}else {
			for (int i = 0; i < disCharArray.length; i++) {
				discountName+=disCountArray[Integer.parseInt(disCharArray[i]+"")];
			}
			discountName+="折";
		}
		return discountName;
	}
	
}
