package cenmengqi.utils;

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
}
