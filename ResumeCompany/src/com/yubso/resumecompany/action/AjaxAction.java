package com.yubso.resumecompany.action;

import java.io.File;
import java.util.Map;
import java.util.Vector;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.entity.Job.PhoneStatus;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.util.CookieUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.StringUtil;

public class AjaxAction extends BaseAction{
	
	private String param;//input的值
	private String info;//验证结果显示的信息
	private String status;//验证结果
	private String fileName;
	private String savePath;
	private int id;
	private String [] histPlaces;
	private String selectedAddress;	
	private CompanyService companyService;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * 检测公司名是否已经注册
	 * @return
	 */
	public String checkCompanyName() {
		companyService=new CompanyServiceImpl();
		Company company=companyService.querCompanyByComName(param);
		if(company!=null)
		{
			info="该公司名已经注册！";
			status="n";
		}else {
			info="";
			status="y";
		}
		return "json";
	}
	
	/**
	 * 检测公司用户名是否已经注册
	 * @return
	 */
	public String checkComUserName() {
		companyService=new CompanyServiceImpl();
		Company company=companyService.querCompanyByLoginAccount(param);
		if(company!=null)
		{
			info="该用户名已经注册！";
			status="n";
		}else {
			info="";
			status="y";
		}
		return "json";
	}
	public String deleteUnusedImg()throws Exception{
		String path = ServletActionContext.getServletContext().getRealPath(
				"/"+savePath+"/"+fileName);
				System.out.println(path);
		File file=new File(path);
		if(file.exists()&&file.isFile())
		{
			status=file.delete()?"y":"n";
		}
		return "json";
	}
	public String checkVipTime()throws Exception{
		if(NumberUtils.isNumber(param))
		{
			int pHoneStatus=Integer.parseInt(param);
			//电话联系就要查询vip时间
			if(pHoneStatus==PhoneStatus.PHONE.ordinal())
			{
				int comId=getComId();
				ComType comType=getCompanyType();
				//账户余额
				int accountRe=0;
				if(comType.ordinal()==ComType.COMPANY.ordinal())
				{
					Company company=SQLHelper.queryEntityByConditions(Company.class, "id="+comId);
					accountRe=company.getAccountBalance()==null?0:company.getAccountBalance();
				}else if(comType.ordinal()==ComType.HR.ordinal())
				{
					HumanResource hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
					accountRe=hr.getPayAccount()==null?0:hr.getPayAccount();
				}
				info="您的账户余额为："+accountRe+"米粒";
				if(accountRe<priceConfig.getJobMonthPrice())
				{
					info+="，不足以支付电话招骋包月服务费，<a href='myInfo!myInfo?type=queryAccount' style='color:blue;' target='mainFrame'>立即充值</a>!";
					status="n";
				}else
				{
					info+="。";
					status="y";
				}
			
			}else if(pHoneStatus==PhoneStatus.APK.ordinal()){
				int comId=getComId();
				ComType comType=getCompanyType();
				//账户余额
				int accountRe=0;
				if(comType.ordinal()==ComType.COMPANY.ordinal())
				{
					Company company=SQLHelper.queryEntityByConditions(Company.class, "id="+comId);
					accountRe=company.getAccountBalance()==null?0:company.getAccountBalance();
				}else if(comType.ordinal()==ComType.HR.ordinal())
				{
					HumanResource hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
					accountRe=hr.getPayAccount()==null?0:hr.getPayAccount();
				}
				status="y";
				info="您的账户余额为："+accountRe+"米粒。";
			}else {
				info="系统内部错误，请刷新后重试！";
				status="n";
			}
		}else {
			info="系统内部错误，请刷新后重试！";
			status="n";
		}
		return "json";
	}
	public String checkJijiehaoAccount() throws Exception{
		int comId=getComId();
		ComType comType=getCompanyType();
		//账户余额
		int accountRe=0;
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			Company company=SQLHelper.queryEntityByConditions(Company.class, "id="+comId);
			accountRe=company.getAccountBalance()==null?0:company.getAccountBalance();
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			HumanResource hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
			accountRe=hr.getPayAccount()==null?0:hr.getPayAccount();
		}
		info="您的账户余额为："+accountRe+"米粒";
		if(accountRe<priceConfig.getJoinJijiehao())
		{
			info+="，不足以支付加入集结号服务费，<a href='myInfo!myInfo?type=queryAccount' style='color:blue;' target='mainFrame'>立即充值</a>!";
			status="n";
		}else
		{
			info+="。";
			status="y";
		}
		return "json";
	}
	public String loadHistPlace() throws Exception
	{
		Map<String, String> datas=CookieUtil.getStrsFromCookie(request.getCookies(), response);
		String key=getComId()+"-"+getCompanyType().ordinal();
		String addresses=datas.get(key);
		if(StringUtil.checkIsNotNull(addresses))
		{
			histPlaces=addresses.split(",");
		}  
		return "json";
	}
	//删除附近简历浏览历史
	public String deleteHistPlace() throws Exception
	{
		Map<String, String> datas=CookieUtil.getStrsFromCookie(request.getCookies(), response);
		String key=getComId()+"-"+getCompanyType().ordinal();
		String addresses=datas.get(key);
		if(StringUtil.checkIsNotNull(selectedAddress,addresses))
		{
			Object addres[]=getRemoveArry(addresses.split(","), selectedAddress);
			if(addres!=null)
			{
				addresses="";
				for (int i = 0; i < addres.length; i++) {
					if(i==0)
					{
						addresses+=addres[i];
						continue;
					}
					addresses+=","+addres[i];
				}
			}
			CookieUtil.saveStrToCookie(key, addresses, response, 365*24*60);
		}
		return "json";
	}
	public Object[] getRemoveArry(String[] strs,String removeStr)
	{
		
		if(strs!=null&&StringUtil.checkIsNotNull(removeStr))
		{
			Vector<String> vr=new Vector<String>();
			for (int i = 0; i < strs.length; i++) {
				if(!StringUtil.checkIsNotNull(strs[i])||removeStr.equals(strs[i]))
				{
					continue;
				}
				vr.add(strs[i]);
			}
			return vr.toArray();
		}
		return null;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public String[] getHistPlaces() {
		return histPlaces;
	}
	public void setHistPlaces(String[] histPlaces) {
		this.histPlaces = histPlaces;
	}
	public String getSelectedAddress() {
		return selectedAddress;
	}
	public void setSelectedAddress(String selectedAddress) {
		this.selectedAddress = selectedAddress;
	}
	
}
