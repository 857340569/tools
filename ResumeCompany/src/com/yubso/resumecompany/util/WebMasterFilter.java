package com.yubso.resumecompany.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.action.LoginAction;

public class WebMasterFilter implements Filter{

	public void destroy() {
		
	}
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		HttpSession session = request.getSession();
		String uri = request.getRequestURI();
		int startTime=20000;
		int endTime=40000;
		//不过滤登录,验证码等页面
		if((!uri.endsWith("/index.jsp")) 
				&& (!uri.contains("/systemMaintenance.jsp")) 
				&& (!uri.contains("/index_main.jsp")) 
				&& (!uri.contains("/index_login.jsp")) 
				&& (!uri.contains("/index_league.jsp")) 
				&& (!uri.contains("/index_contactus.jsp")) 
				&& (!uri.contains("/login")) 
				&& (!uri.contains("/code"))
				&& (!uri.contains("/ajax"))
				&& (!uri.contains("/register!register")) 
				&& (!uri.endsWith("/default_error.jsp")) 
				&& (!uri.endsWith("/code.jsp") 
				&& (!uri.endsWith("/checkCode.jsp")) 
				&& (!uri.endsWith("/serchadd.jsp"))
				&& (!uri.endsWith("/404page.jsp"))
				&& (!uri.contains("/images/"))  
				&& (!uri.contains("/upload/"))  
				&& (!uri.contains("/css/"))
				&& (!uri.endsWith("/register.jsp"))
				&& (!uri.endsWith("/login_failed.jsp"))
				&& (!uri.contains("/js/"))
				&& (!uri.endsWith("/register_success.jsp"))
				&& (!uri.endsWith("/register_failed.jsp")))
				&&(!uri.endsWith(".swf"))){
			if(uri.endsWith("/"))
			{
//				response.sendRedirect(request.getContextPath()+"/index.jsp");//首页
				try{
					chain.doFilter(req, res);
				}catch(IllegalStateException e){
				}
				return;
			}
			int nowTime=Integer.parseInt(DateUtil.getNowDateStr("HH:mm:ss").replaceAll(":", ""));
			if(nowTime>=startTime&&nowTime<=endTime)//系统维护时间
			{
				response.sendRedirect(request.getContextPath()+"/systemMaintenance.jsp");
				return;
			}
			if(session.getAttribute(LoginAction.COM_ID) == null)
			{
				response.sendRedirect(request.getContextPath()+"/login!login");//登录页面
				return;
			}else {
				Object comTypeObject=session.getAttribute(LoginAction.COM_TIPE);
				if(comTypeObject==null||!StringUtil.isNumber(comTypeObject.toString()))
				{
					response.sendRedirect(request.getContextPath()+"/login!login");//登录页面
					return;
				}else{
					int comType=Integer.parseInt(comTypeObject.toString());
					if(comType==ComType.COMPANY.ordinal())
					{
						if(uri.contains("/hr/"))
						{
							System.out.println("com no permission access hr");
							response.sendRedirect(request.getContextPath()+"/login!login");//登录页面
							return;
						}
					}else if(comType==ComType.HR.ordinal())
					{
						if(uri.contains(request.getContextPath()+"/admin/guidepage.jsp")||uri.contains("/myInfo.jsp"))
						{
							System.out.println("hr no permission access com");
							response.sendRedirect(request.getContextPath()+"/login!login");//登录页面
							return;
						}
					}else {
						response.sendRedirect(request.getContextPath()+"/admin/default_error.jsp");//登录页面
						return;
					}
					
				}
				
			}
		}
		if(uri.contains("/login")||uri.contains("/ajax")||uri.contains("/register!register"))
		{
			if(!uri.contains("/images/"))
			{
				int nowTime=Integer.parseInt(DateUtil.getNowDateStr("HH:mm:ss").replaceAll(":", ""));
				if(nowTime>=startTime&&nowTime<=endTime)//系统维护时间
				{
					response.sendRedirect(request.getContextPath()+"/systemMaintenance.jsp");
					return;
				}
			}
		}
		try{
			chain.doFilter(req, res);
		}catch(IllegalStateException e){
//			e.printStackTrace();
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
		
	}

}

