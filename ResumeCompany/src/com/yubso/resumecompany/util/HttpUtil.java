package com.yubso.resumecompany.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import com.yubso.org.json.JSONObject;
public class HttpUtil {
	public static final String REQ_METHOD_GET="GET";
	public static final String REQ_METHOD_POST="POST";
	public static String requestData(String reqMethod,String urlStr) {
		try {
			URL url = new URL(urlStr);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod(reqMethod);
			conn.setRequestProperty("Content-Type", "text/html");
			conn.setRequestProperty("Cache-Control", "no-cache");
			conn.setRequestProperty("Charset", "UTF-8");
			conn.connect();
			conn.setConnectTimeout(10000);
			return readStrFromIo(conn.getInputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public static boolean sendData(String reqMethod,String urlStr,String StrData) {
		try {
			URL url = new URL(urlStr);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod(reqMethod);
			conn.setRequestProperty("Content-Type", "text/html");
			conn.setRequestProperty("Cache-Control", "no-cache");
			conn.setRequestProperty("Charset", "UTF-8");
			conn.connect();
			conn.setConnectTimeout(10000);
			PrintWriter pw=new PrintWriter(conn.getOutputStream());
			pw.print(StrData);
			pw.flush();
			String result=readStrFromIo(conn.getInputStream());//{"errcode":0,"errmsg":"ok"}
			conn.disconnect();
			JSONObject jsonObject=new JSONObject(result);
			if(jsonObject.getInt("errorCode")==0)
			{
				return true;
			}
			return false;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public static String readStrFromIo(InputStream inputStream)throws Exception
	{
		BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
		String line = null;
		StringBuffer strBuff = new StringBuffer();
		while ((line = br.readLine()) != null) {
			strBuff.append(line);
		}
		return new String(strBuff.toString().getBytes("gbk"), "utf-8");
	}
}
