package com.zp.utils;


public class DigestUtils {
	/**
	 * 加密
	 * @param iStr 前缀 用来作为加密标示
	 * @param str
	 * @param keys
	 * @return
	 */
	public static String getXORCodeX(String iStr,String str,int[] keys) {

		return getXORCodeX(iStr+str, keys);
	}
	/**
	 *  加密
	 * @param str
	 * @param keys
	 * @return
	 */
	public static String getXORCodeX(String str, int[] keys) {

		StringBuffer sb=new StringBuffer();
		String iStr = str.substring(0, 2);
		str = StringUtils.utf8ToUnicode(str);
		int iStrIndex = str_16_int(iStr);
		char[] strArr = str.toCharArray();
		int iStrLen = strArr.length;
		
		for (int i = 0; i < iStrLen; i++) {
			// tmpStr+=Format('%.02X', [ord(strArr[i]) xor QRXorKey[(iStrIndex +
			// i) mod 256]]);
			//xor 异或运算
			int casci = (int) strArr[i];
			int key = keys[(iStrIndex + i + 1) % 256];
			String tem = Integer.toHexString(casci ^ key);
			if (tem.length() < 2) {
				tem = "0" + tem;
			}
			sb.append(tem);
		}
		sb.insert(0, iStr);
		return sb.toString().toUpperCase();
	}
	
	/**
	 * 解密
	 * @param str
	 * @param keys
	 * @return
	 */
	public static String getXORDeCode(String str, int[] keys) {
		StringBuffer sb=new StringBuffer();
		String iDentifier = str.substring(0, 2);
		int i, iStrLen;
		int iDecIndex;
		iStrLen = str.length() / 2;
		iDecIndex = str_16_int(iDentifier);
		for (i = 2; i <= iStrLen; i++) {// strArr[(i-1)*2] +""+
										// strArr[(i-1)*2+1]
			int strParHex = str_16_int(str.substring((i - 1) * 2, (i - 1) * 2 + 2));
			int keyHex = keys[(i + iDecIndex - 1) % 256];
			int bc = strParHex ^ keyHex;
			sb.append((char) bc);
		}
		return StringUtils.unicodeToUtf8(sb.toString()).substring(2);
	}

	/**
	 * 将16进制字符串转成10进制的数
	 * @param hexStr
	 * @return
	 */
	public static int str_16_int(String hexStr) {
//		int x = 0;
//		char[] hexArr = hexStr.toCharArray();
//		for (int i = 0; i < hexStr.length(); i++) {
//			x = x * 16 + Integer.parseInt(String.valueOf(hexArr[i]), 16);
//		}
//		return x;
		return Integer.parseInt(hexStr, 16);
	}
}
