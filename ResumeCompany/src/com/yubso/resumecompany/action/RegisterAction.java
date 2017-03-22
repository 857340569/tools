package com.yubso.resumecompany.action;

import java.util.Map;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.util.BaiduMapUtil;
import com.yubso.resumecompany.util.DateUtil;


public class RegisterAction extends BaseAction {
	private Company company;
	private CompanyService companyService;
	private String provCity;//选择的省市区
	private String addrDetail;
	public RegisterAction() {
		companyService=new CompanyServiceImpl();
	}
	
	public String register() throws Exception{
		String address=provCity+addrDetail;
		String registerTime=DateUtil.getNowDateStr(null);
		Map<String,String> lngAndLat=BaiduMapUtil.getGeocoderLatitude(address);
		if(company==null)
		{
			return "loginAlogin";
		}
		company.setAddress(address);
		company.setLng(Double.parseDouble(lngAndLat.get("lng")));
		company.setLat(Double.parseDouble(lngAndLat.get("lat")));
		company.setRegistTime(registerTime);
		company.setHrId(0);//自己注册为0
		company.setDiscount(1.0);
		//活动未过期，设置默认增大赠送米粒
		if(!DateUtil.checkDateExpired(priceConfig.getActiveExpiredDate()))
		{
			company.setAccountBalance(priceConfig.getComAccountDefault());
		}else {
			company.setAccountBalance(0);
		}
		boolean result=companyService.registCompany(company);
		if(result)
			return "success";
		return "failed";
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

	public String getAddrDetail() {
		return addrDetail;
	}

	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}
	
	
}
