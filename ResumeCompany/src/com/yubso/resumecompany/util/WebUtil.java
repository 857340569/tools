package com.yubso.resumecompany.util;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

public class WebUtil {

//	public static final String IMG_SERVER_PATH="http://192.168.1.98/badou_upload/";
	public static final String IMG_SERVER_PATH="http://img.91zhimi.com/";
	public static final String PAY_SERVER_PATH="http://www.91zhimi.com/";//必须以http开头
	public static Map<String, Object> getSession()
	{
		return getActionContext().getSession();
	}
	public static ActionContext getActionContext()
	{
		return ActionContext.getContext(); 
	}
	public static HttpServletRequest getRequest()
	{
		return (HttpServletRequest)getActionContext().get(ServletActionContext.HTTP_REQUEST);
	}
	public static HttpServletResponse getResponse()
	{
		return (HttpServletResponse)getActionContext().get(ServletActionContext.HTTP_RESPONSE);
	}
	/**
	 * http://localhost:80/lanling/xxxx
	 * @param serverContentPath e.g. lanling if null 则为当前项目的路径
	 * @param serverDir e.g xxxx
	 * @return
	 */
	public static String getServerPath(String serverContentPath,String serverDir)
	{
		HttpServletRequest request = WebUtil.getRequest();
		if(serverContentPath==null||serverContentPath.trim().equals(""))
		{
			String path=ServletActionContext.getServletContext().getRealPath("");
			serverContentPath=path.substring(path.lastIndexOf("\\")+1);//request.getContextPath();
		}
		String serverPath = request.getScheme() + "://"
				+ request.getLocalAddr() + ":" + request.getServerPort()+"/"+serverContentPath;
		if(serverDir==null)
			return serverPath+"/";
		return serverPath+"/"+serverDir+"/";
	}
	/**
	 * 在java 中进行控制跳转
	 * @param urlStr 跳转地址
	 */
	public static void sendRedirect(String urlStr)
	{
		try {
			getResponse().sendRedirect(urlStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	* 检测网络资源是否存在　
	* 
	* @param strUrl
	* @return
	*/
	public static boolean isNetFileAvailable(String strUrl) {
		InputStream netFileInputStream = null;
		try {
			URL url = new URL(strUrl);
			URLConnection urlConn = url.openConnection();
			netFileInputStream = urlConn.getInputStream();
			if (null != netFileInputStream) {
				return true;
			} else {
				return false;
			}
		} catch (IOException e) {
			return false;
		} finally {
			try {
				if (netFileInputStream != null)
					netFileInputStream.close();
			} catch (IOException e) {
			}
		}
	}
	//得到session中的值
	public static Object getSessionValue(String key)
	{
		return getSession().get(key);
	}
	public static void clearSession()
	{
		getSession().clear();
	}
}
