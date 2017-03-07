package com.zp.test2;

import java.lang.Character.UnicodeBlock;

import com.zp.test2.DebugPackage.LogLevel;

public class TestDebugPackage {

	public static void main(String[] args) {
		DebugPackage packg = new DebugPackage("http://www.baidu.com", "账上", LogLevel.LOG_INFO);
		try {
			System.out.println(revert(convert(packg.toString())));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 将字符串转成unicode
	 * 
	 * @paramstr 待转字符串
	 * @return unicode字符串
	 */

	public static String convert(String str) {
		str = (str == null ? "" : str);
		String tmp;
		StringBuffer sb = new StringBuffer(1000);
		char c;
		int i, j;
		sb.setLength(0);
		for (i = 0; i < str.length(); i++) {
			c = str.charAt(i);
//			sb.append("\\u");
			j = (c >>> 8); // 取出高8位
			tmp = Integer.toHexString(j);
			if (tmp.length() == 1)
				sb.append("0");
			sb.append(tmp);
			j = (c & 0xFF); // 取出低8位
			tmp = Integer.toHexString(j);
			if (tmp.length() == 1)
				sb.append("0");
			sb.append(tmp);

		}
		return new String(sb).toUpperCase();
	}

	/**
	 * 将unicode 字符串
	 * 
	 * @param str
	 *            待转字符串
	 * @return 普通字符串
	 */
	public static String revert(String str) {
		str = (str == null ? "" : str);
//		if (str.indexOf("\\u") == -1)// 如果不是unicode码则原样返回
//			return str;
		str=str.toLowerCase();
		StringBuffer sb = new StringBuffer(1000);

		for (int i = 0; i < str.length();i+=4) {
			String strTemp = str.substring(i,i+4);
			String value = strTemp;//.substring(2);
			System.out.println(value);
			int c = 0;
			for (int j = 0; j < value.length(); j++) {
				char tempChar = value.charAt(j);
				int t = 0;
				switch (tempChar) {
				case 'a':
					t = 10;
					break;
				case 'b':
					t = 11;
					break;
				case 'c':
					t = 12;
					break;
				case 'd':
					t = 13;
					break;
				case 'e':
					t = 14;
					break;
				case 'f':
					t = 15;
					break;
				default:
					t = tempChar - 48;
					break;
				}

				c += t * ((int) Math.pow(16, (value.length() - j - 1)));
			}
			sb.append((char) c);
		}
		return sb.toString();
	}
	public static String revert2(String str)
	{
		str=str.replaceAll("\\u", "");
		int c = 0;
		StringBuffer sb = new StringBuffer(1000);
		for(int i=0;i<str.length();i++)
		{
			char tempChar = str.charAt(i);
			int t = 0;
			switch (tempChar) {
			case 'a':
				t = 10;
				break;
			case 'b':
				t = 11;
				break;
			case 'c':
				t = 12;
				break;
			case 'd':
				t = 13;
				break;
			case 'e':
				t = 14;
				break;
			case 'f':
				t = 15;
				break;
			default:
				t = tempChar - 48;
				break;
			}
			c += t * ((int) Math.pow(16, (str.length() - i- 1)));
			sb.append((char) c);
		}
		return sb.toString();
	}
}
