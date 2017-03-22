package com.yubso.resumecompany.action;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.ExpenseRecord;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.entity.Job;
import com.yubso.resumecompany.entity.Job.AuditStatus;
import com.yubso.resumecompany.entity.Job.DeleteStatus;
import com.yubso.resumecompany.entity.Job.PhoneStatus;
import com.yubso.resumecompany.entity.JobApplication;
import com.yubso.resumecompany.entity.PushMessage;
import com.yubso.resumecompany.entity.PushMessage.MsgType;
import com.yubso.resumecompany.entity.User;
import com.yubso.resumecompany.service.JobApplicationService;
import com.yubso.resumecompany.service.JobService;
import com.yubso.resumecompany.service.impl.JobApplicationServiceImpl;
import com.yubso.resumecompany.service.impl.JobServiceImpl;
import com.yubso.resumecompany.util.BaiduMapUtil;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.SQLHelper.ExecuteType;
import com.yubso.resumecompany.util.StringUtil;

public class JobAction extends BaseAction {
	private JobService jobService;
	private JobApplicationService jobApplicationService;
	private String provCity;
	private String addrDetail;
	private Job job;
	private Company company;
	private HumanResource hr;
	private String selectTime;
	private String selectFlag[];
	private List<String> addKeyWords;
	private List<Job> jobs;
	private int totalPageCount;
	private String applyTime;
	private String info;//验证结果显示的信息
	private String status;//验证结果
	private String ageStart;//年龄范围开始
	private String ageEnd;//年龄范围结束
	private String sexLimite; 
	private String jobAddress;
	public JobAction(){
		jobService=new JobServiceImpl();
		
	}
	public String toAddPage() throws Exception{
		int comId =getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.COMPANY.ordinal()){
			company=SQLHelper.queryEntityByConditions(Company.class, "id="+comId);
			if(!StringUtil.checkIsNotNull(company.getLogo(),company.getDescrImage1()))
			{
				return "toUploadLogo";
			}
			jobAddress=company.getAddress();
		}
		return "toAddPage";
	}
	public String queryJobs() throws Exception{
		pageSize=15;
		int comId =getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.COMPANY.ordinal()){
			divPage=jobService.queryDivJobsByComId(comId,currentPage, pageSize);
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(getAgentType()==1)//官方代理
			{
				comId=-comId;
			}
			divPage=jobService.queryDivJobsByHrId(comId,currentPage, pageSize);
		}
		return "jobManager";
	}
	public String queryOutlineJobs() throws Exception
	{
		pageSize=15;
		int comId =getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.COMPANY.ordinal()){
			divPage=jobService.queryDivJobsByComId(comId,currentPage, pageSize,DeleteStatus.OUTLINE.ordinal());
		}
		else if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(getAgentType()==1)//官方代理
			{
				comId=-comId;
			}
			divPage=jobService.queryDivJobsByHrId(comId,currentPage, pageSize,DeleteStatus.OUTLINE.ordinal());
		}
		return "outlineJobManager";
	}
	public String jobVipExtension() throws Exception
	{
		int comId=getComId();
		if(job==null&&job.getId()!=null)
		{
			status="n";
			info="服务器异常，请刷新后重试!";
			return "json";
		}
		String nowTime=DateUtil.getNowDateStr("");
		ComType comType=getCompanyType();
		int monthDefault=1;//默认续费一个月
		//账户余额
		int accountRe=0;
		Serializable saveObj;
		if(comType.ordinal()==ComType.HR.ordinal())
		{	
			HumanResource hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
			if(hr.getPayAccount()==null)
			{
				hr.setPayAccount(0);
			}
			accountRe=hr.getPayAccount();
			hr.setPayAccount(accountRe-monthDefault*priceConfig.getJobMonthPrice());
			saveObj=hr;
		}else if (comType.ordinal()==ComType.COMPANY.ordinal()) {
			Company company=SQLHelper.queryEntityByConditions(Company.class, "id="+comId);
			if(company.getAccountBalance()==null)
			{
				company.setAccountBalance(0);
			}
			accountRe=company.getAccountBalance();
			company.setAccountBalance(accountRe-monthDefault*priceConfig.getJobMonthPrice());
			job.setComId(comId);
			saveObj=company;
		}else {
			status="n";
			info="服务器异常，请刷新后重试!";
			return "json";
		}
		//消费记录
		ExpenseRecord expenseRecord=null;
		if(accountRe<priceConfig.getJobMonthPrice())
		{
			status="n";
			info="账户余额不足，请到个人中心充值!";
			return "json";
		}
		expenseRecord=new ExpenseRecord();
		expenseRecord.setBuyerId(comId);
		expenseRecord.setBuyerType(comType.ordinal());
		expenseRecord.setGoodsName("电话招聘包月服务费,续费时长为"+monthDefault+"个月");
		expenseRecord.setPayNum(priceConfig.getJobMonthPrice());
		expenseRecord.setPayDate(nowTime);
		Calendar calendar=Calendar.getInstance();
		int month=calendar.get(Calendar.MONTH);
		calendar.set(Calendar.MONTH, month+monthDefault);
		String vipNewEndTime=DateUtil.formatDate(calendar.getTime());
		job.setVipTime(vipNewEndTime);
		job.setDeleteStatus(DeleteStatus.ONLINE.ordinal());
		boolean updateResult=SQLHelper.updateByTransation(new int[]{ExecuteType.UPDATE.ordinal(),ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal()}, new String[]{"id="+job.getId(),"","id="+comId},job,expenseRecord,saveObj);
		if(updateResult)
		{
			status="y";
			info="电话招聘续费成功!";
		}else {
			status="n";
			info+="电话招聘续费失败,请稍后重试!";
		}
		return "json";
	}
	//职位上/下线
	public String changeDeleteStatus() throws Exception
	{
		if(job==null&&job.getId()!=null&&job.getDeleteStatus()!=null&&job.getPhoneStatus()!=null)
		{
			status="n";
			info="服务器异常，请刷新后重试!";
			return "json";
		}
		int deleteStatus=job.getDeleteStatus();
		if(job.getPhoneStatus()==PhoneStatus.PHONE.ordinal()&&deleteStatus==DeleteStatus.ONLINE.ordinal())
		{
			Job jobTemp=jobService.querJobById(job.getId());
			if(DateUtil.checkDateExpired(jobTemp.getVipTime()))
			{
				status="expired";
				return "json";
			}
		}
		boolean updateResult=jobService.updateJob(job);
		if(deleteStatus==DeleteStatus.ONLINE.ordinal())
		{
			info="职位上线";
		}else {
			info="职位下线";
		}
		if(updateResult)
		{
			status="y";
			info+="成功!";
		}else {
			status="n";
			info+="失败,请稍后重试!";
		}
		return "json";
//		ComType comType=getCompanyType();
//		if(comType.ordinal()==ComType.COMPANY.ordinal()){
//		
//			return queryJobs();
//		}else if(comType.ordinal()==ComType.HR.ordinal())
//		{
//			if("job!queryHrJobs".equals(actionUrl))
//			{
//				return queryHrJobs();
//			}else if("job!queryJobByComId".equals(actionUrl))
//			{
//				return queryJobByComId();
//			}
//		}
//		return baseShowParamError();
	}
	public String queryComJobs() throws Exception{
		int comId =getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(company!=null&&company.getId()!=null)
			{
				comId=company.getId();
			}
		}
		String whereHql="comId="+comId;
		int totalCount=SQLHelper.getAllRowCount(Job.class, whereHql);
		divPage=new DivPageUtil(totalCount, pageSize, currentPage);
		totalPageCount=(int) divPage.getTotalPageCount();
		jobs=SQLHelper.queryDivEntitysByConditions(Job.class, whereHql, divPage.getStartIndex(), pageSize);
		return "json";
	}
	//查找人力资源下面的所有职位
	public String queryHrJobs() throws Exception{
		actionUrl="job!queryHrJobs";
		pageSize=15;
		int comId =getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(getAgentType()==1)//官方代理的连锁企业
			{
				comId=-comId;
			}
			divPage=jobService.queryDivJobsByHrId(comId,currentPage, pageSize);
		}
		else{
			return baseTryToLogin();
		}
		return "hrJobs";
	}
	//人力资源管理根据公司信息查找下面发布的职位
	public String queryJobByComId() throws Exception{
		actionUrl="job!queryJobByComId";
		pageSize=15;
		int comId=getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.HR.ordinal())
		{

			if(company==null||company.getId()==null)
			{
				return baseShowParamError();
			}else {
				
				if(company.getId()==-1) //查找连锁企业下面的所有职位（即 选择所有公司 进行查询）
				{
					if(getAgentType()==1)//官方代理
					{
						comId=-comId;
					}
					divPage=jobService.queryDivJobsByHrId(comId,currentPage, pageSize);
				}else {
					comId=company.getId();
					divPage=jobService.queryDivJobsByComId(comId, currentPage, pageSize);
				}
				pageUrl="company.id="+company.getId();
			}
		}
		else{
			return baseTryToLogin();
		}
		return "hrJobs";
	}
	//人力资源管理根据企业id获取企业信息
	public String queryHrApplyByCondtion() throws Exception{
		pageSize=15;
		ComType comType=getCompanyType();
		int comId=0;
		if(company!=null&&company.getId()!=null)
		{
			comId=company.getId();
		}
		if(comType.ordinal()==ComType.HR.ordinal())
		{
			jobApplicationService=new JobApplicationServiceImpl();
			divPage=jobApplicationService.queryJobApplicationsByComId(comId, comType, selectTime, currentPage, pageSize);
			checkPushData(getComId(),comType);
			checkIsBount(comId, comType, (List<JobApplication>) divPage.getDataMap().get("jobApplications"));
			return "hrApplys";
		}
		return baseTryToLogin();
	}
	//判断是否购买过
	public void checkIsBount(int comId,ComType comType,List<JobApplication> jobApplicationsTemp)
	{
		Map<Integer, String> isBoughts=new HashMap<Integer, String>();//是否购买
		for(JobApplication jobApplicationTemp:jobApplicationsTemp)
		{
			//buyerType 跟comType其实是一致的
			//BuyerType buyerType=BuyerType.values()[comType.ordinal()];
			//BoughtResume br,Resume r,User u
			String poName="BoughtResume br,Resume r,User u";
			String whereHql="br.buyerId ="+comId +" and br.buyerType="+comType.ordinal()+" and br.resumeId=r.id and u.id=r.uid and u.id="+jobApplicationTemp.getUserId();
			int rowCount=SQLHelper.getAllRowCount(poName, whereHql);
			if(rowCount>0)
			{
				isBoughts.put(jobApplicationTemp.getId(), "ok");
			}
			divPage.getDataMap().put("isBoughts", isBoughts);
		}
	}
	// 判断是否推送过
	public void checkPushData(int comId,ComType comType)
	{
		List<JobApplication> jobApplicationsTemp=(List<JobApplication>) divPage.getDataMap().get("jobApplications");
		//null 为默认，可以进行推送,value:0 发送一次，并且可用，1发送一次，时间之前没有到三天，不可用，2发送两次，不可用
		Map<Integer, Integer> isValid=new HashMap<Integer, Integer>();
		Map<Integer, Integer> remainDays=new HashMap<Integer, Integer>();
		
		for(JobApplication jobApplicationTemp:jobApplicationsTemp)
		{
			if(jobApplicationTemp.getApplyStatus()==0)//处于申请状态的肯定要进行推送
			{
				continue;
			}
			int jobIdTemp=jobApplicationTemp.getJobId();
			int userId=jobApplicationTemp.getUserId();
			User user=SQLHelper.queryEntityByConditions(User.class, "id="+userId);
			String msgTo=user.getUserName();
			String whereHql="msgFromId="+getComId()+" and fromType="+comType.ordinal()+" and msgTo='"+msgTo+"'" +"and contentId="+jobIdTemp+" and msgType="+MsgType.JOB.ordinal(); 
			List<PushMessage> pushMessages=SQLHelper.queryDivEntitysByConditions(PushMessage.class, whereHql);
			if(pushMessages==null||pushMessages.size()==0)//推送消息被删除(管理员删除)了，可视为没有推送
			{
				continue;
			}
			if(pushMessages.size()==1)
			{
				try {
					int dif=(int)DateUtil.getDifferDays(DateUtil.getNowDateStr(null), pushMessages.get(0).getPushTime());
					if(dif<3)
					{
						isValid.put(jobApplicationTemp.getId(),1);
						remainDays.put(jobApplicationTemp.getId(), 3-dif);
					}else {
						isValid.put(jobApplicationTemp.getId(),0);
					}
				} catch (Exception e) {
					continue;
				}
			}else {
				isValid.put(jobApplicationTemp.getId(),2);
			}
		}
		divPage.getDataMap().put("limitPush", isValid);
		divPage.getDataMap().put("pushDays", remainDays);
	}
	public String queryComApplyByCondtion() throws Exception{
		pageSize=15;
		ComType comType=getCompanyType();
		int comId=getComId();
		int jobId=-1;
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			if(job!=null&&job.getId()!=null)
			{
				jobId=job.getId();
			}
			if(jobId<0)
			{
				jobId=-comId;//如果jobid 小于0，就是查找所有的职位
			}
			jobApplicationService=new JobApplicationServiceImpl();
			divPage=jobApplicationService.queryJobApplicationsByJobIdAppTime(jobId, selectTime, currentPage, pageSize);
			checkPushData(comId,comType);
			checkIsBount(comId, comType, (List<JobApplication>) divPage.getDataMap().get("jobApplications"));
			return "comApplys";
		}
		return baseTryToLogin();
		
	}
	public String queryHrJobByCondtion() throws Exception{
		pageSize=15;
		int hrId =getComId();
		ComType comType=getCompanyType();
		if(comType.ordinal()==ComType.HR.ordinal())
		{
			int comId=-1;
			if(company!=null&&company.getId()!=null)
			{
				comId=company.getId();
			}
			pageUrl="selectTime="+selectTime+"&company.id="+comId;
			divPage=jobService.queryDivJobsByCondtion(selectTime,comId,hrId,currentPage, pageSize);
		}
		else{
			return baseTryToLogin();
		}
		return "hrJobs";
	}
	public String releaseJob() throws Exception{
		
		String address=provCity+addrDetail;
		Map<String,String> lngAndLat=BaiduMapUtil.getGeocoderLatitude(address);
		String releaseTime=DateUtil.getNowDateStr("");
		int monthDefault=1;//默认开通电话招骋包月服务时长（月）
		if(job==null)
		{
			return baseTryToLogin();
		}
		int comId=getComId();
		ComType comType=getCompanyType();
		boolean isTrans=false;//电话招骋包月
		//账户余额
		int accountRe=0;
		Serializable saveObj=null;
		if(comType.ordinal()==ComType.HR.ordinal())
		{	
			if(company==null||company.getId()==null)
			{
				return baseShowParamError();
			}
			//需要选择公司id
			job.setComId(company.getId());
			if(getAgentType()==1)//官方代理的连锁企业
			{
				job.setHrId(-comId);
			}else {
				job.setHrId(comId);
			}
			HumanResource hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
			if(hr.getPayAccount()==null)
			{
				hr.setPayAccount(0);
			}
			accountRe=hr.getPayAccount();
		}else if (comType.ordinal()==ComType.COMPANY.ordinal()) {
			Company company=SQLHelper.queryEntityByConditions(Company.class, "id="+comId);
			if(company.getAccountBalance()==null)
			{
				company.setAccountBalance(0);
			}
			accountRe=company.getAccountBalance();
			job.setComId(comId);
			job.setHrId(0);//直招企业
		}else {
			return baseTryToLogin();
		}
		//消费记录
		ExpenseRecord expenseRecord=null;
		if(job.getPhoneStatus()==PhoneStatus.PHONE.ordinal())//电话招骋包月
		{
			if(accountRe<priceConfig.getJobMonthPrice())
			{
				message="账户余额不足，请到个人中心充值!";
				return baseShowResult();
			}
			if(comType.ordinal()==ComType.HR.ordinal())
			{	
				hr.setPayAccount(accountRe-monthDefault*priceConfig.getJobMonthPrice());
				saveObj=hr;
			}else if (comType.ordinal()==ComType.COMPANY.ordinal()) {
				company.setAccountBalance(accountRe-monthDefault*priceConfig.getJobMonthPrice());
				saveObj=company;
			}
			isTrans=true;
			expenseRecord=new ExpenseRecord();
			expenseRecord.setBuyerId(comId);
			expenseRecord.setBuyerType(comType.ordinal());
			expenseRecord.setGoodsName("电话招聘包月服务费,支付时长为"+monthDefault+"个月");
			expenseRecord.setPayNum(priceConfig.getJobMonthPrice());
			expenseRecord.setPayDate(releaseTime);
			Calendar calendar=Calendar.getInstance();
			int month=calendar.get(Calendar.MONTH);
			calendar.set(Calendar.MONTH, month+monthDefault);
			String vipNewEndTime=DateUtil.formatDate(calendar.getTime());
			job.setVipTime(vipNewEndTime);
		}
		//加入集结号
		if(job.getPhoneStatus()==PhoneStatus.APK.ordinal()&&"jijiehao".equals(job.getSend()))
		{
			if(accountRe<priceConfig.getJoinJijiehao())
			{
				message="账户余额不足，请到个人中心充值!";
				return baseShowResult();
			}
			if(comType.ordinal()==ComType.HR.ordinal())
			{	
				hr.setPayAccount(accountRe-monthDefault*priceConfig.getJoinJijiehao());
				saveObj=hr;
			}else if (comType.ordinal()==ComType.COMPANY.ordinal()) {
				company.setAccountBalance(accountRe-monthDefault*priceConfig.getJoinJijiehao());
				saveObj=company;
			}
			isTrans=true;
			//消费记录
			expenseRecord=new ExpenseRecord();
			expenseRecord.setBuyerId(comId);
			expenseRecord.setBuyerType(comType.ordinal());
			expenseRecord.setGoodsName("加入集结号，职位名称为"+job.getCategory());
			expenseRecord.setPayNum(priceConfig.getJoinJijiehao());
			expenseRecord.setPayDate(releaseTime);
		}
		job.setAuditStatus(AuditStatus.AUDITING.ordinal());
		job.setDeleteStatus(DeleteStatus.ONLINE.ordinal());
		job.setRequirementsCondition(sexLimite+"/"+ageStart);
		job.setWorkplace(address);
		job.setReleaseTime(releaseTime);
		job.setOrderTime(releaseTime);
		job.setLng(Double.parseDouble(lngAndLat.get("lng")));
		job.setLat(Double.parseDouble(lngAndLat.get("lat")));
		message="职位信息添加失败，请重试!";
		if(isTrans)
		{
			boolean releaseResult=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal(),ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal()}, new String[]{"","","id="+comId},job,expenseRecord,saveObj);
			if(releaseResult)
				message="恭喜你,职位信息添加成功!";
			return baseShowResult();
		}
		boolean releaseResult=jobService.addJob(job);
		if(releaseResult)
			message="恭喜你,职位信息添加成功!";	
		return baseShowResult();
	}
	public String queryApplyByJobId() throws Exception{
		int comId=getComId();
		ComType comType=getCompanyType();
		if(job==null||job.getId()==null)
		{
			return baseShowParamError();
		}
		jobApplicationService=new JobApplicationServiceImpl();
		divPage=jobApplicationService.queryJobApplicationsByJobId(job.getId(), currentPage, pageSize);
		checkPushData(comId,comType);
		checkIsBount(comId, comType, (List<JobApplication>) divPage.getDataMap().get("jobApplications"));
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			return "comApplys";
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			return "hrApplys";
		}
		return baseTryToLogin();
	}
	public String lookApply() throws Exception{
		pageSize=15;
		int comId =getComId();
		ComType comType=getCompanyType();
		jobApplicationService=new JobApplicationServiceImpl();
		if("byJobId".equals(type))
		{
			if(job!=null)
			{
				if(job.getId()==null)
					job.setId(-1);
				divPage=jobApplicationService.queryJobApplicationsByJobId(job.getId(), currentPage, pageSize);
				pageUrl="type=byJobId&job.id="+job.getId();
			}
			
		}else if("byTime".equals(type)){
			divPage=jobApplicationService.queryJobApplicationsByComId(comId, comType, applyTime, currentPage, pageSize);
			pageUrl="type=byTime&applyTime="+applyTime;
		}else {
			return baseShowParamError();
		}
//		List<Integer> jobIds=new ArrayList<Integer>();
//		int comId=getComId();
//		ComType comType=getCompanyType();
//		List<Job> jobs=jobService.queryDivJobsByComId(comId);
//		for (Job job : jobs) {
//			jobIds.add(job.getId());
//		}
//		if(comType.ordinal()==ComType.COMPANY.ordinal())
//		{
//			divPage=jobApplicationService.queryJobApplicationsByComId(comId,currentPage, pageSize);
//		}
		return "lookApply";
	}
	public String queryJobById() throws Exception{
		if(job!=null&&job.getId()!=null){
			job=jobService.querJobById(job.getId());
			job.setWelfare(job.getWelfare().replaceAll(",", "/"));
			String ageAndSex=job.getRequirementsCondition();
			if(StringUtil.checkIsNotNull(ageAndSex)&&ageAndSex.contains("/"))
			{
				int splitIndex=ageAndSex.indexOf("/");
				String ageStr=ageAndSex.substring(splitIndex+1);
				if(ageStr.contains("-"))
				{
					int ageIndex=ageStr.indexOf("-");
					ageStart=ageStr.substring(0,ageIndex);
					ageEnd=ageStr.substring(ageIndex+1);
				}else {
					ageStart="不限";
				}
				sexLimite=ageAndSex.substring(0, splitIndex);;
			}else {
				ageStart="不限";
				sexLimite="不限";
			}
		}else{
			return baseShowParamError();
		}
		return "jobDetail";
	}
	public String editJob() throws Exception{
		if(job!=null&&job.getId()!=null){
			job=jobService.querJobById(job.getId());
			addKeyWords = new ArrayList<String>();
			String keyWord = job.getWelfare();
			if (keyWord != null && keyWord.length() >0) {
				if (keyWord.contains(",")) {
					job.setWelfare(keyWord.substring(0,keyWord.indexOf(",")));
					String addKeys =  keyWord.substring(keyWord.indexOf(",")+1);
					if (addKeys != null && addKeys.length() >0) {
						String sss[] = keyWord.split(",");
				    	String[] ss = sss[1].split("/");
				    	for (int i = 0; i < ss.length; i++) {
				    		addKeyWords.add(ss[i]);
						}
					}
				}
			}
			String ageAndSex=job.getRequirementsCondition();
			if(StringUtil.checkIsNotNull(ageAndSex)&&ageAndSex.contains("/"))
			{
				int splitIndex=ageAndSex.indexOf("/");
				String ageStr=ageAndSex.substring(splitIndex+1);
				if(ageStr.contains("-"))
				{
					int ageIndex=ageStr.indexOf("-");
					ageStart=ageStr.substring(0,ageIndex);
					ageEnd=ageStr.substring(ageIndex+1);
				}else {
					ageStart="不限";
				}
				sexLimite=ageAndSex.substring(0,splitIndex);
			}else {
				ageStart="不限";
				sexLimite="不限";
			}
		}else{
			return baseShowParamError();
		}
		return "editJob";
	}
	public String updateJob() throws Exception{
		if(job!=null&&job.getId()!=null){
			String workPlace=job.getWorkplace();
			if(StringUtil.checkIsNotNull(workPlace))
			{
				Map<String,String> lngAndLat=BaiduMapUtil.getGeocoderLatitude(workPlace);
				job.setLng(Double.parseDouble(lngAndLat.get("lng")));
				job.setLat(Double.parseDouble(lngAndLat.get("lat")));
			}
			job.setRequirementsCondition(sexLimite+"/"+ageStart);
		//	boolean updateResult=jobService.updateJob(job);//不能更新是否加放集结号
			if(!StringUtil.checkIsNotNull(job.getSend()))//没加入集结号要把时间清空
			{
				job.setSendendtime("");
			}
			boolean updateResult=SQLHelper.updateEntityById(job, job.getId(), "send","sendendtime");
			message="职位信息修改失败，请重试!";
			if(updateResult)
				message="恭喜你,职位信息修改成功!";	
			return baseShowResult();
		}else{
			return baseShowParamError();
		}
	}
	public String deletejob() throws Exception{
		if(job!=null&&job.getId()!=null){
			message="职位信息删除失败，请重试!";
			boolean updateResult=jobService.deleteJob(job);
			if(updateResult)
				message="恭喜你,职位信息删除成功!";
			return baseShowResult();
		}else{
			return baseShowParamError();
		}
	}
	public String deleteSelectJobs() throws Exception{
		if(selectFlag==null||selectFlag.length==0)
		{
			message="未选择要删除的职位，职位信息删除失败!";
		}else {
			message="职位信息删除失败，请重试!";
			boolean updateResult=jobService.deleteJobByIds(selectFlag);
			if(updateResult)
				message="恭喜你,职位信息删除成功!";
		}
		return baseShowResult();
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
	public Job getJob() {
		return job;
	}
	public void setJob(Job job) {
		this.job = job;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public String getSelectTime() {
		return selectTime;
	}
	public void setSelectTime(String selectTime) {
		this.selectTime = selectTime;
	}
	public String[] getSelectFlag() {
		return selectFlag;
	}
	public void setSelectFlag(String[] selectFlag) {
		this.selectFlag = selectFlag;
	}
	public List<String> getAddKeyWords() {
		return addKeyWords;
	}
	public void setAddKeyWords(List<String> addKeyWords) {
		this.addKeyWords = addKeyWords;
	}
	public String getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}
	public List<Job> getJobs() {
		return jobs;
	}
	public void setJobs(List<Job> jobs) {
		this.jobs = jobs;
	}
	public int getTotalPageCount() {
		return totalPageCount;
	}
	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}
	public HumanResource getHr() {
		return hr;
	}
	public void setHr(HumanResource hr) {
		this.hr = hr;
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
	public String getAgeStart() {
		return ageStart;
	}
	public void setAgeStart(String ageStart) {
		this.ageStart = ageStart;
	}
	public String getAgeEnd() {
		return ageEnd;
	}
	public void setAgeEnd(String ageEnd) {
		this.ageEnd = ageEnd;
	}
	public String getSexLimite() {
		return sexLimite;
	}
	public void setSexLimite(String sexLimite) {
		this.sexLimite = sexLimite;
	}
	public String getJobAddress() {
		return jobAddress;
	}
	public void setJobAddress(String jobAddress) {
		this.jobAddress = jobAddress;
	}
	
}
