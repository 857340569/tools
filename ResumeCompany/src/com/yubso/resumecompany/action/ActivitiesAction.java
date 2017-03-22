package com.yubso.resumecompany.action;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.yubso.resumecompany.entity.Activities;
import com.yubso.resumecompany.entity.Activities.AuditStatus;
import com.yubso.resumecompany.entity.Activities.Status;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.ExpenseRecord;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.service.ActivitiesService;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.impl.ActivitiesServiceImpl;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.util.BaiduMapUtil;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.SQLHelper.ExecuteType;
/**
 * 活动信息处理
 * @author Administrator
 *
 */
public class ActivitiesAction extends BaseAction {
	private Company company;
	private HumanResource hr;
	private CompanyService companyService;
	private Activities activities;
	private ActivitiesService activitiesService;
	private int[] selectFlag; // 多选
	private List<String> descImgs;
	private int refreshStatus;
	private String provCity;
	private ExpenseRecord expenseRecord;//消费记录
	public ActivitiesAction() {
		activitiesService = new ActivitiesServiceImpl();
	}
	public String toAddPage() throws Exception
	{
		return "toAddPage";
	}
	//发布动态
	public String addActivities()throws Exception{
		message = "活动信息发布失败,请稍后重试!";
		int comId=getComId();
		ComType comType=getCompanyType();
		//限时免费
		/*
		Serializable saveObj;
		int countRel=0;
		int price=priceConfig.getActivityPrice();
		int idTemp=0;
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			companyService=new CompanyServiceImpl();
			company=companyService.querCompanyById(comId);
			countRel=company.getAccountBalance()-price;
			company.setAccountBalance(countRel);
			saveObj=company;
			idTemp=company.getId();
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+getComId());
			countRel=hr.getPayAccount()-price;
			hr.setPayAccount(countRel);
			saveObj=hr;
			idTemp=hr.getId();
		}else {
			return baseTryToLogin();
		}
		if(countRel<0)
		{
			message="账户余额不足，活动信息发布失败,请充值后重试!";
			return baseShowResult();
		}
		//消费记录
		expenseRecord=new ExpenseRecord();
		expenseRecord.setBuyerId(comId);
		expenseRecord.setBuyerType(comType.ordinal());
		expenseRecord.setGoodsName("发布活动信息");
		expenseRecord.setPayNum(price);
		expenseRecord.setPayDate(DateUtil.getNowDateStr(null));
		
		//活动信息
		activities.setComId(comId);
		activities.setComType(comType.ordinal());
		activities.setAuditStatus(AuditStatus.AUDITING.ordinal());
		activities.setRefreshTime(DateUtil.getNowDateStr(""));
		String area = provCity+activities.getActivitiesPlace();
		activities.setActivitiesPlace(area);
		boolean bool=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal(),ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal()},new String[]{"","","id="+idTemp},expenseRecord,activities,saveObj);
		*/
		//活动信息
		activities.setComId(comId);
		activities.setComType(comType.ordinal());
		activities.setAuditStatus(AuditStatus.AUDITING.ordinal());
		activities.setRefreshTime(DateUtil.getNowDateStr(""));
		activities.setPraise(0);//点赞数
		String area = provCity+activities.getActivitiesPlace();
		Map<String,String> lngAndLat=BaiduMapUtil.getGeocoderLatitude(area);
		activities.setActivitiesPlace(area);
		activities.setLng(Double.parseDouble(lngAndLat.get("lng")));
		activities.setLat(Double.parseDouble(lngAndLat.get("lat")));
		activities.setStatus(Status.ACTIVITY.name().toLowerCase());
		boolean bool=SQLHelper.addEntity(activities);
		if (bool) {
			message = "恭喜你，活动信息发布成功添加成功,请耐心等待系统申核！";
		}
		return baseShowResult();
	}
	//查询所有
	public String queryAllActivities()throws Exception{
		pageSize=18;
		int comId=getComId();
		ComType comType=getCompanyType();
		divPage = activitiesService.queryAllActivities(comId,comType,AuditStatus.ALL,currentPage,pageSize);
		return "showActivities";
		
	}
	public String queryActsById() throws Exception{
		if(activities!=null&&activities.getId()!=null)
		{
			activities=activitiesService.queryActivitiesById(activities.getId());
			if("find".equals(type))
			{
				return "activitiesDetail";
			}else if("toEdit".equals(type))
			{
				return "editActivities";
			}
		}
		return baseShowParamError();
	}
	public String deleteActById() throws Exception{
		message="活动信息删除失败,请稍后再试！";
		if(activities!=null&&activities.getId()!=null)
		{
			boolean delResult=activitiesService.deleteActivitiesByIds(new int[]{activities.getId()});
			if(delResult)
			{
				message="恭喜你,活动信息删除成功！";
			}
			return baseShowResult();
		}
		return baseShowParamError();
	}
	//修改
	public String updateActivitiesById()throws Exception{
		message="活动信息更新失败,请稍后再试！";
		if(activities!=null&&activities.getId()!=null)
		{
			boolean updateResult=SQLHelper.updateEntityById(activities, activities.getId(), "image1","image2","image3","send");
			if(updateResult)
			{
				message="恭喜你,活动信息更新成功！";
			}
			return baseShowResult();
		}
		return baseShowParamError();
	}

	public DivPageUtil getDivPage() {
		return divPage;
	}

	public void setDivPage(DivPageUtil divPage) {
		this.divPage = divPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int[] getSelectFlag() {
		return selectFlag;
	}

	public void setSelectFlag(int[] selectFlag) {
		this.selectFlag = selectFlag;
	}
	public List<String> getDescImgs() {
		return descImgs;
	}

	public void setDescImgs(List<String> descImgs) {
		this.descImgs = descImgs;
	}

	public Activities getActivities() {
		return activities;
	}

	public void setActivities(Activities activities) {
		this.activities = activities;
	}

	public int getRefreshStatus() {
		return refreshStatus;
	}

	public void setRefreshStatus(int refreshStatus) {
		this.refreshStatus = refreshStatus;
	}

	public String getProvCity() {
		return provCity;
	}

	public void setProvCity(String provCity) {
		this.provCity = provCity;
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

	public ExpenseRecord getExpenseRecord() {
		return expenseRecord;
	}

	public void setExpenseRecord(ExpenseRecord expenseRecord) {
		this.expenseRecord = expenseRecord;
	}
	
	
}
