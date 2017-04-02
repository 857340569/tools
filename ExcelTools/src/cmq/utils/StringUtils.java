package cmq.utils;

import java.util.regex.Pattern;

public class StringUtils {
	public static boolean isEmpty(String str)
	{
		if(str==null||str.trim().equals(""))
		{
			return true;
		}
		return false;
	}
	
	public static boolean isEmpty(String ... strs)
	{
		if(strs.length==0)
		{
			return true;
		}
		for(int i=0;i<strs.length;i++)
		{
			if (isEmpty(strs[i])) {
				return true;
			}
		}
		
		return false;
	}
	/**
	 * 去除字符串尾部指定字符串
	 * @param str
	 * @param prefix
	 * @return
	 */
	public static String trimEnd(String str,String prefix)
	{
		if(isEmpty(str))
			return "";
		try {
			return str.substring(0,str.lastIndexOf(prefix));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	/**
	 * 功能：判断字符串是否为数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		return matches("\\-?[0-9]+", str);
	}
	/**
	 * 是否比配正则
	 * 
	 * @param patternStr 规则
	 * @param str 
	 * @return
	 */
	public static boolean matches(String patternStr, String str) {
		if (isEmpty(patternStr, str))
			return false;
//		Pattern pattern = Pattern.compile(patternStr);
//		Matcher matcher = pattern.matcher(str);
//		return matcher.matches(); // 当条件满足时，将返回true，否则返回false
		return Pattern.matches(patternStr, str);
	}
}
