package com.yubso.resumecompany.action;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.StringUtil;


public class LoginAction extends BaseAction {
	private CompanyService companyService;
	private Company company;
	private HumanResource hr;
	private String toLogin;
	private String userName;
	private String password;
	private int comType;
	public static final String COM_ID="id";
	public static final String USER_NAME="adminName";
	public static final String USER_PASSWORD="adminPassword";
	public static final String CNAME="name";
	public static final String COM_TIPE="comType";
	public static final String AGENT_TIPE="agentType";
	public static final String DIRECT_REGIST="direct_regist";//注册跳转
	private String remPswBox;//获取自动登录框是否选中，选中为“on”，没有选中为“null”
	public LoginAction() {
		companyService = new CompanyServiceImpl();
	}

	public String login() {
		if("toLogin".equals(toLogin)||"autoLogin".equals(toLogin))
		{
			String result="failed";
			if(!StringUtil.checkIsNotNull(userName,password))
			{
				result="login";
				return result;
			}
			if(comType==ComType.COMPANY.ordinal())
			{
				userName=StringUtil.transactSQLInjection(userName);
				company=companyService.querCompanyByLoginAccount(userName);
				if(company!=null)
				{
					password=StringUtil.transactSQLInjection(password);
					if(company.getLoginPassword().trim().equals(password))
					{
						result="success"+comType;
						session.put(COM_ID, company.getId());
						session.put(USER_NAME, company.getLoginAccount());
						session.put(USER_PASSWORD, company.getLoginPassword());
						session.put(CNAME, company.getName());
						session.put(COM_TIPE, comType);
////						if("on".equals(remPswBox))
////						{
////							yubsoService.saveUserToCookie(yubso, response, 7*24*60);
////						}else{
////							if("toLogin".equals(toLogin))//说明是取消了自动登录
////							{
////								yubsoService.removeUserFromCookie(request.getCookies(), response);
////							}
//						}
					}
				}
			}else if(comType==ComType.HR.ordinal()){
				hr=SQLHelper.queryEntityByConditions(HumanResource.class, "loginAccount='"+userName+"'");
				if(hr!=null)
				{
					if(hr.getLoginPassword().trim().equals(password))
					{
						result="success"+comType;
						int hrId=hr.getId();
						session.put(COM_ID,hrId);
						session.put(USER_NAME, hr.getLoginAccount());
						session.put(USER_PASSWORD, hr.getLoginPassword());
						session.put(CNAME, hr.getName());
						session.put(COM_TIPE, comType);
						session.put(AGENT_TIPE, hr.getAgentType());
					}
				}
			}
			return result;
		}else {
			if(isLogined())
			{
				return "success"+session.get(COM_TIPE);
			}
			return "login";
		}
		
	}
	public String logout()
	{
		if(session!=null)
			session.clear();
		toLogin="logout";
		return "logout";
	}
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	public boolean isLogined()
	{
		if(session.get(USER_NAME)!=null&&!session.get(USER_NAME).toString().trim().equals(""))
		{
			return true;
		}
		return false;
	}

	public String getToLogin() {
		return toLogin;
	}

	public void setToLogin(String toLogin) {
		this.toLogin = toLogin;
	}

	public String getRemPswBox() {
		return remPswBox;
	}

	public void setRemPswBox(String remPswBox) {
		this.remPswBox = remPswBox;
	}

	public int getComType() {
		return comType;
	}

	public void setComType(int comType) {
		this.comType = comType;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public HumanResource getHr() {
		return hr;
	}

	public void setHr(HumanResource hr) {
		this.hr = hr;
	}
	
	
}
