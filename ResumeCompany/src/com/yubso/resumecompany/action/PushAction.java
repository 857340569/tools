package com.yubso.resumecompany.action;

import java.io.Serializable;

import com.yubso.push.base.PushMessageSendHandler;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.ExpenseRecord;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.entity.Job;
import com.yubso.resumecompany.entity.JobApplication;
import com.yubso.resumecompany.entity.PushMessage;
import com.yubso.resumecompany.entity.PushMessage.FromType;
import com.yubso.resumecompany.entity.PushMessage.MsgType;
import com.yubso.resumecompany.entity.PushMessage.ReceiveStatus;
import com.yubso.resumecompany.entity.PushMessage.ToType;
import com.yubso.resumecompany.entity.User;
import com.yubso.resumecompany.entity.User.DeviceType;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.PushController;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.SQLHelper.ExecuteType;
import com.yubso.resumecompany.util.StringUtil;

public class PushAction extends BaseAction {
	private boolean pushResult;
	private PushMessage pushMessage;
	private Company company;
	private HumanResource hr;
	private MyHandler myHandler;
	private String type;
	private String message;
	private User user;
	private Job job;
	private JobApplication jobApplication;
	private String messageTemp;
	private CompanyService companyService;
	private int status;
	public PushAction(){
		myHandler=new MyHandler();
	}
	private class MyHandler implements PushMessageSendHandler{

		@Override
		public void onMessageSended(boolean isSuccess, String message) {
			PushAction.this.pushResult=isSuccess;
			PushAction.this.messageTemp=message;
		}
	}
	public String  notifyUser() throws Exception{
		String notifyType="";
		String titleType="";
		int price=priceConfig.getPersonalPrice();
		int countRel=0;
		if(status==1||status==-1){//通知 -1第二次推送
			notifyType="面试";
			titleType="邀请您来面试了！";
		}else if(status==2)//录用
		{
			notifyType="录用";
			titleType="通知您来上班了！";
		}
		String pushNo=StringUtil.getUUID();
		String actionParam="pushNo="+pushNo;
		int comId=getComId();
		ComType comType=getCompanyType();
		String comName=session.get(LoginAction.CNAME).toString();
		Serializable saveObj=null;
		type="n";
		message="缺少参数，发送"+notifyType+"消息失败，请刷新重试";
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			if(status==1)
			{
				companyService=new CompanyServiceImpl();
				company=companyService.querCompanyById(comId);
				countRel=company.getAccountBalance()-price;
				company.setAccountBalance(countRel);
				saveObj=company;
			}
			
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(status==1)
			{
				hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
				countRel=hr.getPayAccount()-price;
				hr.setPayAccount(countRel);
				saveObj=hr;
			}
			if(company!=null&&company.getId()!=null)
			{
				comName=company.getName();
			}else {
				return "json";
			}
		}
		if(jobApplication==null||jobApplication.getId()==null||job==null||job.getId()==null||user==null||!StringUtil.checkIsNotNull(user.getUserName()))
		{
			return "json";
		}
		if(pushMessage!=null)
		{
			jobApplication =SQLHelper.queryEntityByConditions(JobApplication.class,"id="+jobApplication.getId());
//			if(status==1&&jobApplication.getApplyStatus()==1)
//			{
//				message="您的通知邀请消息已经发送给用户，无需重复发送，请刷新后再进行后续操作！";
//				return "json";
//			}else 
			if(status==2&&jobApplication.getApplyStatus()==2){
				message="您的录用消息已经发送给用户，无需重复发送，请刷新后再进行后续操作！";
				return "json";
			}
			if(status==1&&countRel<0)
			{
				message="账户余额不足，录用信息发送失败,请充值后重试!";
				return "json";
			}
			String msgTo=user.getUserName();
			String pushTime=DateUtil.getNowDateStr(null);
			jobApplication.setApplyStatus(status);
			jobApplication.setEmployTime(pushTime);
			if(comType.ordinal()==ComType.HR.ordinal())
			{
				pushMessage.setMsgContent(pushMessage.getMsgContent()+"|&&--此消息经过职米官方认证的"+session.get(LoginAction.CNAME).toString()+"代发");
			}
			pushMessage.setMsgType(MsgType.JOB.ordinal());
			pushMessage.setContentId(job.getId());
			pushMessage.setAction(actionParam);
			pushMessage.setPushNo(pushNo);
			pushMessage.setMsgFromId(comId);
			pushMessage.setMsgTo(msgTo);
			pushMessage.setToType(ToType.SINGLE.ordinal());
			pushMessage.setFromType(FromType.values()[comType.ordinal()].ordinal());
			pushMessage.setMsgTitile("亲，"+comName+titleType);
			pushMessage.setPushTime(pushTime);
			pushMessage.setReceiveStatus(ReceiveStatus.SENDING.ordinal());
			boolean pushResult2=false;
			if(user.getDeviceType()==DeviceType.ANDROID.ordinal())
			{
				pushResult2=PushController.sendSimpleAndroidMessageWithAlias(myHandler,msgTo, actionParam);
			}else if(user.getDeviceType()==DeviceType.IOS.ordinal()){
				message="您的"+notifyType+"消息未发送成功，原因：ios用户暂时无法推送信息！";
			}else {
				message="您的"+notifyType+"消息未发送成功，原因：其它平台用户暂时无法推送信息！";
			}
			if(pushResult&&pushResult2)
			{
//				boolean saveMsg=SQLHelper.addEntity(pushMessage);
				boolean saveMsg=false;
				if(status==1)
				{
					//消费记录
					ExpenseRecord expenseRecord=new ExpenseRecord();
					expenseRecord.setBuyerId(comId);
					expenseRecord.setBuyerType(comType.ordinal());
					expenseRecord.setGoodsName("聘用人才");
					expenseRecord.setPayNum(price);
					expenseRecord.setPayDate(pushTime);
					saveMsg=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal(),ExecuteType.UPDATE.ordinal(),ExecuteType.ADD.ordinal()},new String[]{"","id="+jobApplication.getId(),"id="+comId,""},pushMessage,jobApplication,saveObj,expenseRecord);
				}else {
					saveMsg=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal()},new String[]{"","id="+jobApplication.getId()},pushMessage,jobApplication);
				}
				if(saveMsg)
				{
					type="y";
					message="您的"+notifyType+"消息已经成功发送给用户，请耐心等待用户回应！";
				}
				else{
					message="您的"+notifyType+"消息未发送成功，请刷新后重试！";
				}
						
			}else{
				message=messageTemp;
			}
		}
		return "json";
	}
	public String  notifyResumeUser() throws Exception{
		String pushNo=StringUtil.getUUID();
		String actionParam="pushNo="+pushNo;
		int comId=getComId();
		ComType comType=getCompanyType();
		String comName=session.get(LoginAction.CNAME).toString();
		type="n";
		message="缺少参数，发送邀请面试消息失败，请刷新重试";
		if(comType.ordinal()==ComType.HR.ordinal())
		{
			if(company!=null&&company.getId()!=null)
			{
				comName=company.getName();
			}else {
				return "json";
			}
		}
		if(job==null||job.getId()==null||user==null||!StringUtil.checkIsNotNull(user.getUserName()))
		{
			return "json";
		}
		if(pushMessage!=null)
		{
			String msgTo=user.getUserName();
			String pushTime=DateUtil.getNowDateStr(null);
			pushMessage.setMsgType(MsgType.JOB.ordinal());
			pushMessage.setContentId(job.getId());
			pushMessage.setAction(actionParam);
			pushMessage.setPushNo(pushNo);
			pushMessage.setMsgFromId(comId);
			pushMessage.setMsgTo(msgTo);
			pushMessage.setToType(ToType.SINGLE.ordinal());
			pushMessage.setFromType(FromType.values()[comType.ordinal()].ordinal());
			pushMessage.setMsgTitile("亲，"+comName+"邀请您来面试了！");
			pushMessage.setPushTime(pushTime);
			pushMessage.setReceiveStatus(ReceiveStatus.SENDING.ordinal());
			if(comType.ordinal()==ComType.HR.ordinal())
			{
				pushMessage.setMsgContent(pushMessage.getMsgContent()+"|&&--此消息经过职米官方认证的"+session.get(LoginAction.CNAME).toString()+"代发");
			}
			boolean pushResult2=false;
			if(user.getDeviceType()==DeviceType.ANDROID.ordinal())
			{
				pushResult2=PushController.sendSimpleAndroidMessageWithAlias(myHandler, msgTo, actionParam);
			}
			else if(user.getDeviceType()==DeviceType.IOS.ordinal()){
				message="您的邀请面试消息消息未发送成功，原因：ios用户暂时无法推送信息！";
			}else {
				message="您的邀请面试消息消息未发送成功，原因：其它平台用户暂时无法推送信息！";
			}
			if(pushResult&&pushResult2)
			{
				boolean saveMsg=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal()},new String[]{""},pushMessage);
				if(saveMsg)
				{
					type="y";
					message="您的邀请面试消息消息已经成功发送给用户，请耐心等待用户回应！";
				}
				else{
					message="您的邀请面试消息消息未发送成功，请刷新后重试！";
				}
						
			}else{
				message=messageTemp;
			}
		}
		return "json";
	}
	public boolean isPushResult() {
		return pushResult;
	}
	public void setPushResult(boolean pushResult) {
		this.pushResult = pushResult;
	}
	public PushMessage getPushMessage() {
		return pushMessage;
	}
	public void setPushMessage(PushMessage pushMessage) {
		this.pushMessage = pushMessage;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Job getJob() {
		return job;
	}
	public void setJob(Job job) {
		this.job = job;
	}
	public JobApplication getJobApplication() {
		return jobApplication;
	}
	public void setJobApplication(JobApplication jobApplication) {
		this.jobApplication = jobApplication;
	}
	public HumanResource getHr() {
		return hr;
	}
	public void setHr(HumanResource hr) {
		this.hr = hr;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
