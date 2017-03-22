package com.yubso.resumecompany.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.PriceConfig;
import com.yubso.resumecompany.util.StringUtil;

public class BaseAction extends ActionSupport implements SessionAware,
		ServletRequestAware, ServletResponseAware {
	protected DivPageUtil divPage; // 分页类
	protected int pageSize=10;//页面大小
	protected int currentPage=1;//当前页数
	protected String actionUrl="";
	protected String pageUrl="";//分页条件参数
	
	protected String message;// 显示处理结果信息
	protected Map<String, Object> session;
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected String type;
	private int methodOrd;
	protected final PriceConfig priceConfig=PriceConfig.newInstance();
	public enum MethodType{
		ALL,GET,POST
	}
	public enum ComType{
		COMPANY,HR,ADMIN
	}
	/**
	 * 处理出错信息
	 * 
	 * @param exception
	 * @return
	 */
	public String showError(Exception exception) {
		if (exception == null || exception.getMessage() == null
				|| exception.getMessage().trim().equals("")) {
			message = "操作有误！";
		} else {
			message = exception.getMessage();
		}
		return "error";
	}

	public String showError() {
		if (!StringUtil.checkIsNotNull(message))
			this.message = "操作有误！";
		return "error";
	}
	/**
	 * 显示一些处理结果（成功/失败）的页面
	 * @param message
	 * @return
	 */
	public String baseShowResult() throws Exception{
		if (!StringUtil.checkIsNotNull(message))
			this.message = "操作有误！";
		switch (methodOrd) {
		case 1:
			if(request.getMethod().equals(MethodType.POST.name()))
			{
				message="请通过系统进行正常操作,只支持get请求!";
			}
			break;
		case 2:
			if(request.getMethod().equals(MethodType.GET.name()))
			{
				message="请通过系统进行正常操作,只支持post请求!";
			}
			break;	
		}
		return "dealResult";
	}
	public String baseShowParamError()
	{
		message="缺少参数，访问请求地址失败，请刷新后重试!";
		return "dealResult";
	}
	public void setOnlySupportedMethod(MethodType methodType)
	{
		methodOrd=methodType.ordinal();
	}
	/**
	 * 非法调用，跳转首页
	 * @return
	 * @throws Exception
	 */
	public String baseTryToLogin() throws Exception
	{
		return "loginAlogin";
	}
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setSession(Map<String, Object> map) {
//		ActionContext ctx = ActionContext.getContext();
//		System.out.println("setting session "+map +"ctx.getSession() "+ctx.getSession());
//		Map sessionMap = ctx.getSession();
		this.session = map;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public DivPageUtil getDivPage() {
		return divPage;
	}

	public void setDivPage(DivPageUtil divPage) {
		this.divPage = divPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getPageUrl() {
		return pageUrl;
	}

	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	public int getComId()
	{
		Object comIdObj=session.get(LoginAction.COM_ID);
		if(comIdObj==null)
			return -1;
		String comIdStr=comIdObj.toString().trim();
		if(StringUtil.isNumber(comIdStr))
			return Integer.parseInt(comIdStr);
		return -2;
	}
	public int getAgentType()
	{
		Object agentTypeObj=session.get(LoginAction.AGENT_TIPE);
		if(agentTypeObj==null)
			return -1;
		String agentTypeStr=agentTypeObj.toString().trim();
		if(StringUtil.isNumber(agentTypeStr))
			return Integer.parseInt(agentTypeStr);
		return -2;
	}
	public ComType getCompanyType() throws Exception {
		Object comTypeObj=session.get(LoginAction.COM_TIPE);
		if(comTypeObj==null)
			throw new Exception();
		String comTypeStr=comTypeObj.toString().trim();
		if(StringUtil.isNumber(comTypeStr))
			return ComType.values()[Integer.parseInt(comTypeStr)];
		throw new Exception();
	}
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getActionUrl() {
		return actionUrl;
	}

	public void setActionUrl(String actionUrl) {
		this.actionUrl = actionUrl;
	}
	public PriceConfig getPriceConfig() {
		return priceConfig;
	}
	
	
}