package com.yubso.resumecompany.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yubso.push.base.PushMessageSendHandler;
import com.yubso.resumecompany.action.BaseAction.MethodType;
import com.yubso.resumecompany.entity.BoughtResume;
import com.yubso.resumecompany.entity.BoughtResume.BuyerType;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.ExpenseRecord;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.entity.Job;
import com.yubso.resumecompany.entity.Resume;
import com.yubso.resumecompany.entity.User;
import com.yubso.resumecompany.entity.WorkExperience;
import com.yubso.resumecompany.service.BoughtResumeService;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.JobService;
import com.yubso.resumecompany.service.ResumeService;
import com.yubso.resumecompany.service.impl.BoughtResumeServiceImpl;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.service.impl.JobServiceImpl;
import com.yubso.resumecompany.service.impl.ResumeServiceImpl;
import com.yubso.resumecompany.util.BaiduMapUtil;
import com.yubso.resumecompany.util.ContainerTools;
import com.yubso.resumecompany.util.CookieUtil;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.PageConfig;
import com.yubso.resumecompany.util.PushController;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.SQLHelper.ExecuteType;
import com.yubso.resumecompany.util.StringUtil;

public class ResumeAction extends BaseAction {
	private JobService jobService;
	private ResumeService resumeService;
	private CompanyService companyService;
	private BoughtResumeService boughtResumeService;
	private Company company;
	private HumanResource hr;
	private BoughtResume boughtResume;//已购买的简历
	private ExpenseRecord expenseRecord;//消费记录
	private Resume resume;
	private Job job;
	private int unitPrice;
	private String traceNo;
	private int status;
	private User user;
	private List<WorkExperience> workExperiences;
	private boolean pushResult;
	private MyHandler myHandler;
	private String selectedAddress;
	private class MyHandler implements PushMessageSendHandler{

		@Override
		public void onMessageSended(boolean isSuccess, String message) {
			ResumeAction.this.pushResult=isSuccess;
			ResumeAction.this.message=message;
			System.out.println("message "+message);
		}
	}
	public ResumeAction(){
		myHandler=new MyHandler();
		resumeService=new ResumeServiceImpl();
	}
	public String queryResumeById() throws Exception{
		if(resume==null||resume.getId()==null)
		{
			return baseTryToLogin();
		}
		ComType comType=getCompanyType();
		int comId=getComId();
		resume=resumeService.queryResumeById(resume.getId());
		user=SQLHelper.queryEntityByConditions(User.class, "id="+resume.getUid());
		workExperiences=SQLHelper.queryDivEntitysByConditions(WorkExperience.class,"uid="+user.getId());
		String poName="BoughtResume br,Resume r,User u";
		String whereHql="br.buyerId ="+comId +" and br.buyerType="+comType.ordinal()+" and br.resumeId=r.id and u.id=r.uid and u.id="+user.getId();
		int rowCount=SQLHelper.getAllRowCount(poName, whereHql);
		status=rowCount;//页面判断status大于为则已购买
		return "resumeDetail";
	}
	public String queryResumeByUserId() throws Exception{
		if(user==null||user.getId()==null)
		{
			return baseTryToLogin();
		}
		ComType comType=getCompanyType();
		int comId=getComId();
		resume=resumeService.queryResumeByUserId(user.getId());
		user=SQLHelper.queryEntityByConditions(User.class, "id="+user.getId());
		workExperiences=SQLHelper.queryDivEntitysByConditions(WorkExperience.class,"uid="+user.getId());
		String poName="BoughtResume br,Resume r,User u";
		String whereHql="br.buyerId ="+comId +" and br.buyerType="+comType.ordinal()+" and br.resumeId=r.id and u.id=r.uid and u.id="+user.getId();
		int rowCount=SQLHelper.getAllRowCount(poName, whereHql);
		status=rowCount;//页面判断status大于为则已购买
		return "resumeDetail";
	}
	
	public String queryAllResumes() throws Exception{
		pageSize=15;
		ComType comType=getCompanyType();
		BuyerType buyerType=BuyerType.values()[comType.ordinal()];
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			companyService=new CompanyServiceImpl();
			company=companyService.querCompanyById(getComId());
			jobService=new JobServiceImpl();
			int comId=getComId();
			List<Job> categoryJobs=jobService.queryJcategoryByComId(comId);
			List<String> jcategorys=new ArrayList<String>();
			for (Job job : categoryJobs) {
				jcategorys.add(job.getCategory());
			}
//			divPage=resumeService.queryDivResumes(jcategorys, currentPage, pageSize);
		}
		else if(comType.ordinal()==ComType.HR.ordinal())
		{
			hr=SQLHelper.queryEntityByConditions(HumanResource.class,"id="+getComId());
//			divPage=resumeService.queryAllDivResumes(currentPage, pageSize);
		}
		divPage=resumeService.queryAllDivResumes(currentPage, pageSize);
		queryBoughtState(buyerType);
		actionUrl="resume!queryAllResumes";
		return "allResumes";
	}
	public String queryResumeByCond() throws Exception{
		pageSize=15;
		actionUrl="resume!queryResumeByCond";
		ComType comType=getCompanyType();
		BuyerType buyerType=BuyerType.values()[comType.ordinal()];
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			companyService=new CompanyServiceImpl();
			company=companyService.querCompanyById(getComId());
		}
		else if(comType.ordinal()==ComType.HR.ordinal())
		{
			hr=SQLHelper.queryEntityByConditions(HumanResource.class,"id="+getComId());
		}
		String whereHql="";
		pageUrl="";
		if(user!=null)
		{
			if(StringUtil.checkIsNotNull(user.getBirth()))
			{
				String ages[]=user.getBirth().split(",");
				int start=0;
				int end=0;
				int currentYear=Calendar.getInstance().get(Calendar.YEAR);
				if(Integer.parseInt(ages[0])>Integer.parseInt(ages[1]))
				{
					start=currentYear-Integer.parseInt(ages[0]);
					end=currentYear-Integer.parseInt(ages[1]);
				}else {
					start=currentYear-Integer.parseInt(ages[1]);
					end=currentYear-Integer.parseInt(ages[0]);
				}
				++end;
				whereHql+="u.birth between '"+start+"' and '"+end+"' ";
				pageUrl="user.birth="+user.getBirth();
			}
			if(StringUtil.checkIsNotNull(user.getSex()))
			{
				if(StringUtil.checkIsNotNull(whereHql))
				{
					whereHql+=" and ";
				}
				whereHql+=" u.sex= '"+user.getSex()+"'";
				pageUrl=StringUtil.checkIsNotNull(pageUrl)?pageUrl+"&"+"user.sex="+user.getSex():"user.sex="+user.getSex();
			}
			if(StringUtil.checkIsNotNull(user.getEducation()))
			{
				if(StringUtil.checkIsNotNull(whereHql))
				{
					whereHql+=" and ";
				}
				whereHql+=" u.education= '"+user.getEducation()+"'";
				pageUrl=StringUtil.checkIsNotNull(pageUrl)?pageUrl+"&"+"user.education="+user.getEducation():"user.education="+user.getEducation();
			}
		}
		if(resume!=null)
		{
			if(StringUtil.checkIsNotNull(resume.getWorkExperience()))
			{
				if(StringUtil.checkIsNotNull(whereHql))
				{
					whereHql+=" and ";
				}
				whereHql+=" r.workExperience= '"+resume.getWorkExperience()+"'";
				pageUrl=StringUtil.checkIsNotNull(pageUrl)?pageUrl+"&"+"resume.workExperience="+resume.getWorkExperience():"resume.workExperience="+resume.getWorkExperience();
			}
			if(job!=null&&StringUtil.checkIsNotNull(job.getCategory()))
			{
				if(StringUtil.checkIsNotNull(whereHql))
				{
					whereHql+=" and ";
				}
				whereHql+=" r.hopeJob like '%"+job.getCategory()+"%'";
				pageUrl=StringUtil.checkIsNotNull(pageUrl)?pageUrl+"&"+"resume.hopeJob="+job.getCategory():"resume.hopeJob="+job.getCategory();
			}
		}
		if(!StringUtil.checkIsNotNull(pageUrl))
		{
			return queryAllResumes();
		}
		divPage=resumeService.queryDivResumes(whereHql, currentPage, pageSize);
		queryBoughtState(buyerType);
		
		return "allResumes";
	}
	public String nearbyResumes() throws Exception{
		pageSize=15;
		actionUrl="resume!nearbyResumes";
		ComType comType=getCompanyType();
		BuyerType buyerType=BuyerType.values()[comType.ordinal()];
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			companyService=new CompanyServiceImpl();
			company=companyService.querCompanyById(getComId());
		}
		else if(comType.ordinal()==ComType.HR.ordinal())
		{
			hr=SQLHelper.queryEntityByConditions(HumanResource.class,"id="+getComId());
		}
		
		if(StringUtil.checkIsNotNull(selectedAddress))
		{
			if(request.getMethod().equals(MethodType.GET.name()))
			{
				selectedAddress=new String(selectedAddress.getBytes("ISO-8859-1"), "utf-8");
			}
			pageUrl="selectedAddress="+selectedAddress;
			resume=new Resume();
			Map<String, String> laLnMap=BaiduMapUtil.getGeocoderLatitude(selectedAddress);
			resume.setLat(Double.parseDouble(laLnMap.get("lat")));
			resume.setLng(Double.parseDouble(laLnMap.get("lng")));
			Map<String, String> datas=CookieUtil.getStrsFromCookie(request.getCookies(), response);
			String key=getComId()+"-"+comType.ordinal();
			String addresses=datas.get(key);
			if(StringUtil.checkIsNotNull(addresses))
			{
				//如果不存在，则添加
				if(!addresses.contains(selectedAddress)){
					String histPlaces[]=addresses.split(",");
					if(histPlaces.length<=3)
					{
						addresses+=","+selectedAddress;
						CookieUtil.saveStrToCookie(key, addresses, response, 365*24*60);
					}else {
						//超过四个就把第一个移除掉，换成最新的
						addresses=addresses.substring(addresses.indexOf(",")+1);
						histPlaces=addresses.split(",");
						addresses+=","+selectedAddress;
						CookieUtil.saveStrToCookie(key, addresses, response, 365*24*60);
					}
				}
			}else {
				CookieUtil.saveStrToCookie(key, selectedAddress, response, 365*24*60);
			}
		}
		if(resume!=null){
			divPage=resumeService.queryBearbyResumes(currentPage, pageSize, resume.getLng(), resume.getLat(), PageConfig.distanceRange);
			queryBoughtState(buyerType);
		}
		
		return "allResumes";
	}
	/**
	 * 查询简历购买状态
	 */
	private void queryBoughtState(BuyerType buyerType)
	{
		if(divPage!=null&&divPage.getDataMap()!=null)
		{
			//得到匹配的简历
			Object 	resumesObj=divPage.getDataMap().get("resumes");
			if (resumesObj!=null) {
				boughtResumeService=new BoughtResumeServiceImpl();
				Map<Integer, BoughtResume> boughtResumes=new HashMap<Integer, BoughtResume>();
				List<Resume> resumes=(List<Resume>) resumesObj;
				for (int i = 0; i < resumes.size(); i++) {
					Resume resumeTemp=resumes.get(i);
					BoughtResume boughtResumeTemp=boughtResumeService.queryBoughtResume(resumeTemp.getId(), getComId(),buyerType);
					if (boughtResumeTemp==null) {
						continue;
					}
					boughtResumes.put(resumeTemp.getId(), boughtResumeTemp);
				}
				divPage.getDataMap().put("boughtResumes", boughtResumes);
			}
		}
	}
	public String queryInvitedResumes() throws Exception{
		int comId=getComId();
		ComType comType=getCompanyType();
		divPage=resumeService.queryInvitedResumes(comId,comType,currentPage,pageSize);
		return "invitedResumes";
	}
	public String buyResume() throws Exception{
		message="购买简历失败，请重试!";
		String payDateStr=DateUtil.getNowDateStr(null);
		if(boughtResume!=null){
			int comId=getComId();
			ComType comType=getCompanyType();
			int remainAccount=0;
			if(comType.ordinal()==ComType.COMPANY.ordinal())
			{
				company=SQLHelper.queryEntityByConditions(Company.class, "id="+comId);
				if(company.getAccountBalance()==null)
				{
					company.setAccountBalance(0);
				}
				remainAccount=company.getAccountBalance()-unitPrice;
			}else if(comType.ordinal()==ComType.HR.ordinal()){
				hr=SQLHelper.queryEntityByConditions(HumanResource.class,"id="+comId);
				remainAccount=hr.getPayAccount()-unitPrice;
			}else {
				return baseTryToLogin();
			}
			if(remainAccount<0)
			{
				message="账户余额不足，请到个人中心充值!";
			}else {
				BuyerType buyerType=BuyerType.values()[comType.ordinal()];
				//已购买的简历
				boughtResume.setBuyerId(comId);
				boughtResume.setBuyerType(buyerType.ordinal());
				boughtResume.setBoughtTime(payDateStr);
				//消费记录
				expenseRecord=new ExpenseRecord();
				expenseRecord.setBuyerId(comId);
				expenseRecord.setBuyerType(comType.ordinal());
				expenseRecord.setGoodsName("购买简历");
				expenseRecord.setPayNum(unitPrice);
				expenseRecord.setPayDate(payDateStr);
				boolean buyIsSuccess=false;
				if(comType.ordinal()==ComType.COMPANY.ordinal())
				{
					company.setAccountBalance(remainAccount);
					buyIsSuccess=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal(),ExecuteType.ADD.ordinal()},new String[]{"","id="+comId,""},boughtResume,company,expenseRecord);
				}else if(comType.ordinal()==ComType.HR.ordinal()){
					hr.setPayAccount(remainAccount);
					buyIsSuccess=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal(),ExecuteType.ADD.ordinal()},new String[]{"","id="+comId,""},boughtResume,hr,expenseRecord);
				}
				if(buyIsSuccess)
				{
					message="恭喜你，简历购买成功!";
				}
			}
			
		}
		return queryAllResumes();
	}
	public String queryAllBtRecords() throws Exception{
		pageSize=15;
		boughtResumeService=new BoughtResumeServiceImpl();
		BuyerType buyerType=BuyerType.values()[getCompanyType().ordinal()];
		divPage=boughtResumeService.queryAllBR(getComId(), buyerType, currentPage, pageSize);
		return "boughtResumes";
	}
	public String deleteBoughtResume() throws Exception{
		if(boughtResume==null||boughtResume.getId()==null)
		{
			return baseShowParamError();
		}
		boolean deleteResult=SQLHelper.deleteEntity(BoughtResume.class, "id="+boughtResume.getId());
		message="简历信息删除失败！";
		if(deleteResult)
		{
			message="恭喜你，所选择的简历信息删除成功！";
		}
		return baseShowResult();
		
	}
	public String suitableResume() throws Exception{
		pageSize=15;
		int comId =getComId();
		ComType comType=getCompanyType();
		BuyerType buyerType=BuyerType.values()[comType.ordinal()];
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			String whereHql="";
			if(job!=null&&StringUtil.checkIsNotNull(job.getCategory()))//说明选择了职位
			{
				String name=job.getCategory().substring(job.getCategory().lastIndexOf("-")+1);
				//patindex('%pattern%' , expression) sql中函数 比like性能好一点
				whereHql+="patindex('%"+name+"%',hopeJob)>0";
			}else {
				whereHql="comId="+comId;
				List<Job> jobs=SQLHelper.queryDivEntitysByConditions(Job.class, whereHql);//得到所有发布的职位
				List<String> releasedJobNames=new ArrayList<String>();
				for (Job jobTemp:jobs) {
					releasedJobNames.add(jobTemp.getCategory());
				}
				ContainerTools.removeDuplicateWithOrder(releasedJobNames);//去除重复元素
				whereHql="";
				for (int i=0;i<releasedJobNames.size();i++) {
					String name=releasedJobNames.get(i).substring(releasedJobNames.get(i).lastIndexOf("-")+1);
					if(i==releasedJobNames.size()-1)
					{
						whereHql+="patindex('%"+name+"%',hopeJob)>0";
						break;
					}
					whereHql+="patindex('%"+name+"%',hopeJob)>0 or ";
				}
			}
//			System.out.println("suitableResume========="+whereHql);
			divPage=resumeService.queryDivResumes(whereHql, currentPage, pageSize);
			queryBoughtState(buyerType);
		}else {
			return baseShowParamError();
		}
		
		
		return "allResumes";
	}
	public String inviteUserInterview() throws Exception
	{
		boolean pushMessageResult=PushController.sendAllAndroidMessage(myHandler, "testpush message......................");
		return queryAllResumes();
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public BoughtResume getBoughtResume() {
		return boughtResume;
	}
	public void setBoughtResume(BoughtResume boughtResume) {
		this.boughtResume = boughtResume;
	}
	public int getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}
	public ResumeService getResumeService() {
		return resumeService;
	}
	public void setResumeService(ResumeService resumeService) {
		this.resumeService = resumeService;
	}
	public String getTraceNo() {
		return traceNo;
	}
	public void setTraceNo(String traceNo) {
		this.traceNo = traceNo;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public ExpenseRecord getExpenseRecord() {
		return expenseRecord;
	}
	public void setExpenseRecord(ExpenseRecord expenseRecord) {
		this.expenseRecord = expenseRecord;
	}
	public Resume getResume() {
		return resume;
	}
	public void setResume(Resume resume) {
		this.resume = resume;
	}
	public HumanResource getHr() {
		return hr;
	}
	public void setHr(HumanResource hr) {
		this.hr = hr;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<WorkExperience> getWorkExperiences() {
		return workExperiences;
	}
	public void setWorkExperiences(List<WorkExperience> workExperiences) {
		this.workExperiences = workExperiences;
	}
	public Job getJob() {
		return job;
	}
	public void setJob(Job job) {
		this.job = job;
	}
	public String getSelectedAddress() {
		return selectedAddress;
	}
	public void setSelectedAddress(String selectedAddress) {
		this.selectedAddress = selectedAddress;
	}
	
}
