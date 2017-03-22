package com.yubso.resumecompany.action;

import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.inject.util.Function;
import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.action.BaseAction.MethodType;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.JobService;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.service.impl.JobServiceImpl;
import com.yubso.resumecompany.util.BaiduMapUtil;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class CompanyAction extends BaseAction {
	private CompanyService companyService;
	private Company company;
	private JobService jobService;
	private String provCity;
	private List<Company> companies;
	private int totalPageCount;
	public CompanyAction(){
		companyService= new CompanyServiceImpl();
		jobService = new JobServiceImpl();
	}
	
	public String queryAllHrCompany() throws Exception{
		pageSize=5;
		int comId=getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(getAgentType()==1)//官方代理的连锁企业
			{
				comId=-comId;
			}
			divPage = companyService.queryComByHrId(comId, pageSize, currentPage);
		}else {
			return baseTryToLogin();
		}
		return "hrCom";
	}
	public String addCom() throws Exception{
		message="添加公司信息失败，请重试!";
		int comId=getComId();
		if(company==null)
		{
			return baseTryToLogin();
		}else {
			String address=provCity+company.getAddress();
			Map<String,String> lngAndLat=BaiduMapUtil.getGeocoderLatitude(address);
			company.setAddress(address);
			company.setRegistTime(DateUtil.getNowDateStr(null));
			company.setLng(Double.parseDouble(lngAndLat.get("lng")));
			company.setLat(Double.parseDouble(lngAndLat.get("lat")));
			if(getCompanyType().ordinal()==ComType.HR.ordinal())
			{
				if(getAgentType()==1)//官方代理的连锁企业
				{
					comId=-comId;
				}
				company.setHrId(comId);
			}
			boolean registeResult=companyService.registCompany(company);
			if(registeResult)
			{
//				message="恭喜你,公司信息添加成功!";
				return "saveBaseCom";
			}
		}
		return baseShowResult();
	}
	public String queryMyCompanies() throws Exception{
		pageSize=10;
		int comId=getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			return baseTryToLogin();
		}
		else if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(getAgentType()==1)//官方代理的连锁企业
			{
				comId=-comId;
			}
			int totalCount=SQLHelper.getAllRowCount(Company.class, "hrId="+comId);
			divPage=new DivPageUtil(totalCount, pageSize, currentPage);
			totalPageCount=(int) divPage.getTotalPageCount();
			companies=SQLHelper.queryDivEntitysByConditions(Company.class, "hrId="+comId, divPage.getStartIndex(), pageSize);
		}
		return "json";
	}
	public String deleteCompany() throws Exception{
		
		if(company!=null&&company.getId()!=null){
			boolean updateResult=SQLHelper.deleteEntity(company);
			message="企业信息删除失败，请重试!";
			if(updateResult)
				message="恭喜你,企业信息删除成功!";
			return baseShowResult();
		}else{
			return baseShowParamError();
		}
	}
	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public String getProvCity() {
		return provCity;
	}

	public void setProvCity(String provCity) {
		this.provCity = provCity;
	}

	public List<Company> getCompanies() {
		return companies;
	}

	public void setCompanies(List<Company> companies) {
		this.companies = companies;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}
	
	
}
