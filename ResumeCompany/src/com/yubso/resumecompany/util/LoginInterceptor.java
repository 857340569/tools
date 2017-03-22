package com.yubso.resumecompany.util;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.yubso.resumecompany.action.AjaxAction;
import com.yubso.resumecompany.action.CodeAction;
import com.yubso.resumecompany.action.LoginAction;
import com.yubso.resumecompany.action.RegisterAction;

public class LoginInterceptor extends AbstractInterceptor {
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		Object action = invocation.getAction();
		
		if (action instanceof LoginAction || action instanceof RegisterAction ||action instanceof AjaxAction||action instanceof CodeAction) {
			return invocation.invoke();
		}else
		
		{
			Map<String, Object> sessionMap = WebUtil.getSession();
			if(sessionMap.get(LoginAction.USER_NAME) !=null && !sessionMap.get(LoginAction.USER_NAME).toString().trim().equals(""))
			{
				return invocation.invoke();
			}
			return "login";
			}
		}
	}
		
	
