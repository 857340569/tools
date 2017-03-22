package com.yubso.resumecompany.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.util.BaiduMapUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.StringUtil;
import com.yubso.resumecompany.util.WebUtil;

public class MyInfoAction extends BaseAction{
	private Company company;
	private HumanResource hr;
	private CompanyService companyService;
	private String oldPassword;
	private String newPassword;
	private List<String> descImgs;
	private String authTypeName;
	private String discountName;
	public MyInfoAction(){
		companyService=new CompanyServiceImpl();
	}
	public String hrInfo()throws Exception{
		int comId=getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			return baseTryToLogin();
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
			if(hr.getPayAccount()==null)
			{
				hr.setPayAccount(0);
			}
		}
		if(hr!=null)
		{
			if(StringUtil.checkIsNotNull(hr.getLogo()))
			{
				hr.setLogo(WebUtil.IMG_SERVER_PATH+hr.getLogo());
			}else{
				hr.setLogo("./images/no_logo.png");
			}
		}
		if("queryInfo".equals(type))
		{
			return "hrInfo";
		}
		else if("queryEdit".equals(type)){
			
			return "queryToHrEdit";
		}
		return baseShowParamError();
	}
	public String myInfo() throws Exception{
		int comId=getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			company=companyService.querCompanyById(comId);
			if(company!=null)
			{
				if(company.getAuthType()!=null)
				{
					int authType=company.getAuthType();
					double discount=company.getDiscount()==null?1.0:company.getDiscount();
					discountName=StringUtil.translateDiscountToCN(discount);
					if(authType>0)
					{
						switch (authType) {
						case 0:
							break;
						case 1://百家大咖联盟
							authTypeName="百家大咖联盟";
							break;
						default:
							break;
						}
					}
				}
			}
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
			if(company!=null&&company.getId()!=null){
				company=companyService.querCompanyById(company.getId());
			}
			if(hr.getPayAccount()==null)
			{
				hr.setPayAccount(0);
			}
		}else {
			return baseTryToLogin();
		}
		if(company!=null)
		{
			if(company.getAccountBalance()==null)
			{
				company.setAccountBalance(0);
			}
			if(StringUtil.checkIsNotNull(company.getLogo()))
			{
				company.setLogo(WebUtil.IMG_SERVER_PATH+company.getLogo());
			}else{
				company.setLogo("./images/no_logo.png");
			}
			descImgs=new ArrayList<String>();
			if(StringUtil.checkIsNotNull(company.getDescrImage1()))
			{
				
				descImgs.add(WebUtil.IMG_SERVER_PATH+company.getDescrImage1());
			}
			if(StringUtil.checkIsNotNull(company.getDescrImage2()))
			{
				
				descImgs.add(WebUtil.IMG_SERVER_PATH+company.getDescrImage2());
			}
			if(StringUtil.checkIsNotNull(company.getDescrImage3()))
			{
				
				descImgs.add(WebUtil.IMG_SERVER_PATH+company.getDescrImage3());
			}
		}
		if("queryInfo".equals(type)) //前往个人资料的页面
		{
			return "myInfo";
		}
		else if("queryAccount".equals(type))//前往充值页面
		{
			return "queryToRechage";
		}else if("queryEdit".equals(type)){//前往编辑页面
			
			return "queryToEdit";
		}else if("queryHrInfo".equals(type))//连锁企业查看下属企业资料
		{
			return "hrComs";
		}
		else if("toUpdateAuth".equals(type))//连锁企业查看下属企业资料
		{
			return "toUpdateAuth";
		}
		else{
			return baseTryToLogin();
		}
		
	}
	public String updatePassword() throws Exception{
		setOnlySupportedMethod(MethodType.POST);
		ComType comType=getCompanyType();
		message="密码修改失败，请重试!";
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			if(StringUtil.checkIsNotNull(oldPassword))
			{
				int comId=getComId();
				company=companyService.querCompanyById(comId);
				if(company.getLoginPassword().equals(oldPassword))
				{
					company.setLoginPassword(newPassword);
					boolean updateResult=companyService.updateCompanyById(company);
					if(updateResult)
					{
						message="恭喜你,密码修改成功!";
					}
				}else {
					message="原密码错误,请核对后重试!";
				}
			}
				
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+getComId());
			if(hr.getLoginPassword().equals(oldPassword))
			{
				hr.setLoginPassword(newPassword);
				boolean updateResult=SQLHelper.updateEntityById(hr,hr.getId());
				if(updateResult)
				{
					message="恭喜你,密码修改成功!";
				}
			}else {
				message="原密码错误,请核对后重试!";
			}
		}else {
			return baseTryToLogin();
		}
		return baseShowResult();
	}
	public String updateInfo() throws Exception{
		setOnlySupportedMethod(MethodType.POST);
		ComType comType=getCompanyType();
		int comId=getComId();
		//如果是人力资源公司，暂时没有修改资料,修改其它企业资料
		if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(company!=null&&company.getId()!=null)
			{
				company.setHrId(comId);
				comId=company.getId();
			}else{
				return baseTryToLogin();
			}
		}
		message="公司信息修改失败，请重试!";
		if(type!=null&&type.equals("addCom"))
		{
			message="公司信息添加失败，请重试!";
		}
		if(company!=null)
		{
			company.setId(comId);
//			boolean updateResult=companyService.updateCompanyById(company);
			String address=company.getAddress();
			if(StringUtil.checkIsNotNull(address))
			{
				Map<String,String> lngAndLat=BaiduMapUtil.getGeocoderLatitude(address);
				company.setLng(Double.parseDouble(lngAndLat.get("lng")));
				company.setLat(Double.parseDouble(lngAndLat.get("lat")));
			}
			boolean updateResult=SQLHelper.updateEntityById(company, comId, "descrImage2","descrImage3");
			if(updateResult)
			{
				
				message="恭喜你,公司信息修改成功!";
				if("addCom".equals(type))
				{
					message="恭喜你,公司信息添加成功!";
				}else if("toReleaseJob".equals(type)){
					return "toAddPage";//上传企业图片完成
				}else if ("updateAuth".equals(type)) {
					message="企业认证申请已提交，请耐心等待我们工作人品的审核!";
				}
			}
		}
		return baseShowResult();
	}
	public String updateHrInfo() throws Exception{
		int comId=getComId();
		message="公司信息修改失败，请重试!";
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(hr!=null)
			{
				boolean updateResult=SQLHelper.updateEntityById(hr, comId);
				if(updateResult)
				{
					message="恭喜你,公司信息修改成功!";
				}
				return baseShowResult();
			}
			return baseShowParamError();
		}
		return baseTryToLogin();
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	public List<String> getDescImgs() {
		return descImgs;
	}
	public void setDescImgs(List<String> descImgs) {
		this.descImgs = descImgs;
	}
	public HumanResource getHr() {
		return hr;
	}
	public void setHr(HumanResource hr) {
		this.hr = hr;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	public String getAuthTypeName() {
		return authTypeName;
	}
	public void setAuthTypeName(String authTypeName) {
		this.authTypeName = authTypeName;
	}
	public String getDiscountName() {
		return discountName;
	}
	public void setDiscountName(String discountName) {
		this.discountName = discountName;
	}
	
}
