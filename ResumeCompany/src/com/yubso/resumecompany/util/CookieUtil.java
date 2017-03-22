package com.yubso.resumecompany.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;


public class CookieUtil {
	public static void saveStrToCookie(String keyStr,String valStr,HttpServletResponse response,int maxMinutes) {
		if(!StringUtil.checkIsNotNull(keyStr))
		{
			return;
		}
		try {
			
			if(StringUtil.checkIsNotNull(valStr))
				valStr=URLEncoder.encode(valStr, "utf-8");//cookie使用中文必须使用UIRLEncoder进行编码和URLDecoder解码
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Cookie dataCookie = new Cookie(keyStr,valStr);
		dataCookie.setMaxAge(maxMinutes* 60);
		response.addCookie(dataCookie);
		
	}
	public static Map<String,String> getStrsFromCookie(Cookie[] cookies, HttpServletResponse response) {
		Map<String,String> datas=new HashMap<String,String>();
		Cookie cookie = null;// 创建Cookie对象
		String name = "";// 当前cookie的名字
		String val="";
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];// 获取第i个cookie
				name = cookie.getName();// 为name赋值
				try {
					val=URLDecoder.decode(cookie.getValue(),"utf-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				datas.put(name, val);
			}
		}
		return datas;
	}
	public static boolean removeStrFromCookie(String keyStr,Cookie[] cookies, HttpServletResponse response) {
		Cookie cookie = null;// 创建Cookie对象
		String name = "";// 当前cookie的名字
		if (cookies != null) {
			// 循环遍历cookies，获取需要的用户名和密码
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];// 获取第i个cookie
				name = cookie.getName();// 为name赋值
				if (name.equals(keyStr)) {
					cookie.setValue("");
					cookie.setMaxAge(0);
					response.addCookie(cookie);
					break;
				}
			}
		}
		return true;
	}
}
