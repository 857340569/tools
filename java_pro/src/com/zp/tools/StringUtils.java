package com.zp.tools;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Locale;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class StringUtils {
	public static void main(String[] args) {
		long start=System.currentTimeMillis();
		for (int i = 0; i < 10000000; i++) {
			test(i);
		}
		System.out.println(System.currentTimeMillis()-start);
	}
	public static void test(int i)
	{
		if(i%2==1&&i%3==0&&i%4==1&&i%5==4&&i%6==3&&i%7==0&&i%8==1&&i%9==0)
		{
			System.out.println(i);
		}
	}
	/**
	 * 判断字符是否为空 当str="   "时,TextUtils.isEmpty(str) return false;
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.trim().equals("");
	}

	/**
	 * 判断字符多个字符串是否为空,若有一个为空返回false
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String... str) {
		if (str == null || str.length == 0) {
			return true;
		}
		for (int i = 0; i < str.length; i++) {
			if (isEmpty(str[i])) {
				return true;
			}
		}
		return false;
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

	/**
	 * 解决TextView排版问题
	 * 
	 * @param str
	 * @return
	 */
	public static String toDBC(String str) {
		char[] c = str.toCharArray();
		for (int i = 0; i < c.length; i++) {
			if (c[i] == 12288) {
				c[i] = (char) 32;
				continue;
			}
			if (c[i] > 65280 && c[i] < 65375)
				c[i] = (char) (c[i] - 65248);
		}
		return new String(c);
	}

	/**
	 * 功能：判断字符串是否为数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		return matches("[0-9]+", str);
	}
	/**
	 * 功能：判断字符串是否为数字 
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumericInclueFloat(String str) {
		return matches("[0-9]+\\.?[0-9]+", str);
	}

	/**
	 * md5加密
	 * 
	 * @param string
	 * @return
	 */
	public static String getMd5(String string) {
		byte[] hash;

		try {
			hash = MessageDigest.getInstance("MD5").digest(
					string.getBytes("UTF-8"));
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("Huh, MD5 should be supported?", e);
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("Huh, UTF-8 should be supported?", e);
		}

		StringBuilder hex = new StringBuilder(hash.length * 2);

		for (byte b : hash) {
			int i = (b & 0xFF);
			if (i < 0x10)
				hex.append('0');
			hex.append(Integer.toHexString(i));
		}

		return hex.toString();
	}


	/**
	 * 
	 * @param str
	 * @param isEndecrypt
	 *            是否加密
	 * @return
	 */
	public static String digest(String str, boolean isEndecrypt) {
		StringBuilder sBuilder = new StringBuilder();
		try {
			char[] valCodeArr = { '1', '0', 'x', '9', '2', '7', '6', '5', '8',
					'3', 'n' };
			int factor = 0;
			if (isEndecrypt) {
				char[] cs = str.toCharArray();
				for (int i = 0; i < cs.length; i++) {
					factor = valCodeArr[i % valCodeArr.length];
					sBuilder.append(cs[i] + factor + "%");
				}
			} else {
				StringTokenizer st = new StringTokenizer(str, "%");
				int count = 0;
				while (st.hasMoreElements()) {
					factor = valCodeArr[count % valCodeArr.length];
					int asc = Integer.parseInt((String) st.nextElement())
							- factor;
					sBuilder.append((char) asc);
					count++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sBuilder.toString();
	}



	/**
	 * 功能：判断字符串是否为日期格式
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isDate(String strDate) {
		Pattern pattern = Pattern
				.compile("^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-3]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$");
		Matcher m = pattern.matcher(strDate);
		if (m.matches()) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 去除字符串尾部字符
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
	 * 将字符串转成unicode
	 * 
	 * @param str 待转字符串
	 * @return unicode字符串
	 */

	public static String utf8ToUnicode(String str) {
		if(isEmpty(str))return "";
		String tmp;
		StringBuffer sb = new StringBuffer(1000);
		
		sb.setLength(0);
		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);
//			sb.append("\\u");
//			int j = (c >>> 8); // 取出高8位
//			tmp = Integer.toHexString(j);
//			if (tmp.length() == 1)
//			{
//				sb.append("0");
//			}
//			sb.append(tmp);
//			j = (c & 0xFF); // 取出低8位
//			tmp = Integer.toHexString(j);
//			if (tmp.length() == 1)
//			{
//				sb.append("0");
//			}
			String zeros="0000";//一共四位
			tmp=Integer.toHexString((int)c);
			tmp=zeros.substring(0,4-tmp.length())+tmp;
			sb.append(tmp);

		}
		return new String(sb).toUpperCase(Locale.getDefault());
	}
	
	
	/**
	 * 将unicode字符串  还原
	 * 
	 * @param str 待转字符串
	 * @return 普通字符串
	 */
	public static String unicodeToUtf8(String str) {
		if(isEmpty(str))return "";
//		if (str.indexOf("\\u") == -1)// 如果不是unicode码则原样返回
//			return str;
		str=str.toLowerCase(Locale.getDefault());
		StringBuffer sb = new StringBuffer(1000);

		for (int i = 0; i < str.length();i+=4) {
			String strTemp = str.substring(i,i+4);
			int c = 0;
//			for (int j = 0; j < strTemp.length(); j++) {
//				char tempChar = strTemp.charAt(j);
//				int t = Integer.parseInt(String.valueOf(tempChar), 16);
//
//				c += t * ((int) Math.pow(16, (strTemp.length() - j - 1)));
//			}
			c=Integer.parseInt(strTemp, 16);
			sb.append((char) c);
		}
		return sb.toString();
	}

//	/**
//	 * 将unicode字符串  还原
//	 * 
//	 * @param str 待转字符串
//	 * @return 普通字符串
//	 */
//	public static String unicodeToUtf8(String str) {
//		if(isEmpty(str))return "";
////		if (str.indexOf("\\u") == -1)// 如果不是unicode码则原样返回
////			return str;
//		str=str.toLowerCase(Locale.getDefault());
//		StringBuffer sb = new StringBuffer(1000);
//
//		for (int i = 0; i < str.length();i+=4) {
//			String strTemp = str.substring(i,i+4);
//			String value = strTemp;//.substring(2);
//			System.out.println(value);
//			int c = 0;
//			for (int j = 0; j < value.length(); j++) {
//				char tempChar = value.charAt(j);
//				int t = Integer.parseInt(String.valueOf(tempChar), 16);
////				switch (tempChar) {
////				case 'a':
////					t = 10;
////					break;
////				case 'b':
////					t = 11;
////					break;
////				case 'c':
////					t = 12;
////					break;
////				case 'd':
////					t = 13;
////					break;
////				case 'e':
////					t = 14;
////					break;
////				case 'f':
////					t = 15;
////					break;
////				default:
////					t = tempChar - 48;
////					break;
////				}
//
//				c += t * ((int) Math.pow(16, (value.length() - j - 1)));
//			}
//			sb.append((char) c);
//		}
//		return sb.toString();
//	}
	
}
