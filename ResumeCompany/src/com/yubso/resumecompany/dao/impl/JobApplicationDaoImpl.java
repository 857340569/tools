package com.yubso.resumecompany.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.JobApplicationDao;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.Job;
import com.yubso.resumecompany.entity.JobApplication;
import com.yubso.resumecompany.entity.Resume;
import com.yubso.resumecompany.entity.User;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.StringUtil;

public class JobApplicationDaoImpl implements JobApplicationDao {

	@Override
	public DivPageUtil queryJobApplicationsByJobId(int jobId, int currentPage,
			int pageSize) {
		String whereSql="ja.jobId="+jobId+" and ja.userId=u.id and ja.jobId= j.id and u.id=r.uid and j.comId=c.id order by ja.applyTime desc";
		int rowCount=SQLHelper.getAllRowCount("JobApplication ja,Job j,User u,Resume r,Company c", whereSql);
		DivPageUtil divPageUtil=new DivPageUtil(rowCount, pageSize, currentPage);
		String hql="from JobApplication ja,Job j,User u,Resume r,Company c where "+whereSql;
		List dataList=SQLHelper.queryDivEntitysByConditions(hql,divPageUtil.getStartIndex(),pageSize);
		setResumeData(divPageUtil,dataList);
		return divPageUtil;
	}

	@Override
	public DivPageUtil queryJobApplicationsByJobIds(List<Integer> jobIds,
			int currentPage, int pageSize) {
		if(jobIds!=null)
		{
			String whereSql="";
			for (int i = 0; i < jobIds.size(); i++) {
				int jobId=jobIds.get(i);
				if(i==jobIds.size()-1)
				{
					whereSql+=" jobId="+jobId+"";
				}else {
					whereSql+=" jobId="+jobId+" or ";
				}
			}
			int rowCount=SQLHelper.getAllRowCount(JobApplication.class, whereSql);
			DivPageUtil divPageUtil=new DivPageUtil(rowCount, pageSize, currentPage);
			List<JobApplication> jobApplications=SQLHelper.queryDivEntitysByConditions(JobApplication.class, whereSql,divPageUtil.getStartIndex(),pageSize);
			divPageUtil.getDataMap().put("jobApplications", jobApplications);
			Map<Integer, Resume> resumeMap=new HashMap<Integer, Resume>();
			Map<Integer, Job> jobMap=new HashMap<Integer, Job>();
			for (JobApplication jobApplication : jobApplications) {
				Resume resume=SQLHelper.queryEntityByConditions(Resume.class, "uid="+jobApplication.getUserId());
				Job job=SQLHelper.queryEntityByConditions(Job.class, "id="+jobApplication.getJobId());
				if(resume!=null)
				{
					resumeMap.put(jobApplication.getUserId(), resume);
				}
				if(job!=null)
				{
					jobMap.put(jobApplication.getJobId(), job);
				}
			}
			divPageUtil.getDataMap().put("resumes",resumeMap);
			divPageUtil.getDataMap().put("jobs",jobMap);
			return divPageUtil;
		}
		return null;
	}

	@Override
	public DivPageUtil queryJobApplicationsByComId(int comId, int currentPage,
			int pageSize) {
		
		return null;
	}
	public void setResumeData(DivPageUtil dpu,List dataList)
	{
		if(dpu==null||dataList==null)
		{
			return;
		}
		List<JobApplication> jobApplications=new ArrayList<JobApplication>();
		Map<Integer, User> users=new HashMap<Integer, User>();
		Map<Integer, Resume> resumes=new HashMap<Integer, Resume>();
		Map<Integer, Job> jobs=new HashMap<Integer, Job>();
		Map<Integer, Company> companies=new HashMap<Integer, Company>();
		JobApplication jobApplication=null;
		User user=null;
		Resume resume=null;
		Job job=null;
		Company company=null;
		for(int j=0;j<dataList.size();j++)
		{
			 jobApplication=null; 
			 user=null;
			 resume=null;
			 job=null;
			 company=null;
			 Object[] obj=(Object[]) dataList.get(j);
			
			 for(int i=0;i<obj.length;i++)
			 {	
				 if(obj[i] instanceof JobApplication)
				 {
					 jobApplication=(JobApplication)obj[i];
				 }
				 else if(obj[i] instanceof Resume)
				 {
					 resume=(Resume)obj[i];
				 }
				 else if(obj[i] instanceof User)
				 {
					 user=(User)obj[i];
				 }
				 else if(obj[i] instanceof Job)
				 {
					 job=(Job)obj[i];
				 }else if(obj[i] instanceof Company)
				 {
					 company=(Company)obj[i];
				 }
			 }
			 if(jobApplication!=null)
			 {
				 jobApplications.add(jobApplication);
				 if(user!=null)
				 {
//					user.setBirth(DateUtil.getAgeByBirthday(user.getBirth())+"");
					users.put(jobApplication.getId(), user);
				 }
				 if(resume!=null)
				 {
					resumes.put(jobApplication.getId(), resume);
				 }
				 if(job!=null)
				 {
					jobs.put(jobApplication.getId(), job);
				 }
				 if(company!=null)
				 {
					 companies.put(jobApplication.getId(), company);
				 }
			 }
		}
		dpu.getDataMap().put("jobApplications", jobApplications);
		dpu.getDataMap().put("resumes", resumes);
		dpu.getDataMap().put("users", users);
		dpu.getDataMap().put("jobs", jobs);
		dpu.getDataMap().put("companies", companies);
	}
	/**
	 * comType 为hr时，comId<0时math.abs(comId)为hrId,否则为下属公司id
	 */
	@Override
	public DivPageUtil queryJobApplicationsByComId(int comId,ComType comType, String applyTime, int currentPage, int pageSize) {
		String fromHql="JobApplication ja,Job j,User u,Company c,Resume r";
		String whereHql="";
		if(comType!=null)
		{
			if(comType.ordinal()==ComType.HR.ordinal())
			{
				if(comId<0)
				{
					whereHql="ja.jobId in(select jobTemp.id from Job jobTemp where jobTemp.hrId="+Math.abs(comId)+") and ja.jobId=j.id and ja.userId=u.id and c.id=j.comId and r.uid=u.id";
				}else {
					whereHql="ja.jobId in(select jobTemp.id from Job jobTemp where jobTemp.comId="+comId+") and ja.jobId=j.id and ja.userId=u.id and c.id=j.comId and r.uid=u.id";
				}
			}else if(comType.ordinal()==ComType.COMPANY.ordinal())
			{
				whereHql="ja.jobId in(select jobTemp.id from Job jobTemp where jobTemp.comId="+comId+") and ja.jobId=j.id and ja.userId=u.id and c.id=j.comId and r.uid=u.id";
			}else {
				return null;
			}
			if(StringUtil.checkIsNotNull(applyTime))
			{
				whereHql+=" and ja.applyTime like '%"+applyTime+"%'";
			}
			int rowCount=SQLHelper.getAllRowCount(fromHql, whereHql);
			DivPageUtil divPageUtil=new DivPageUtil(rowCount, pageSize, currentPage);
			String hql="from "+fromHql+" where "+whereHql;
			List dataList=SQLHelper.queryDivEntitysByConditions(hql,divPageUtil.getStartIndex(),pageSize);
			setResumeData(divPageUtil,dataList);
			return divPageUtil;
		}
			
		return null;
	}
	//查询company申请人信息
	//jobId<0时math.abs(jobId)为comid,否则为jobid
	@Override
	public DivPageUtil queryJobApplicationsByJobIdAppTime(int jobId, String selectTime, int currentPage, int pageSize) {
		String fromHql="JobApplication ja,Job j,User u,Company c,Resume r";
		String whereHql="";
		if(jobId<0)
		{
			whereHql="ja.jobId in(select jobTemp.id from Job jobTemp where jobTemp.comId="+Math.abs(jobId)+")";
		}else {
			whereHql="ja.jobId ="+jobId;
		}
		whereHql+=" and ja.jobId=j.id and ja.userId=u.id and c.id=j.comId and r.uid=u.id ";
		if(StringUtil.checkIsNotNull(selectTime))
		{
			whereHql+=" and ja.applyTime like '%"+selectTime+"%'";
		}
		int rowCount=SQLHelper.getAllRowCount(fromHql, whereHql);
		DivPageUtil divPageUtil=new DivPageUtil(rowCount, pageSize, currentPage);
		String hql="from "+fromHql+" where "+whereHql;
		List dataList=SQLHelper.queryDivEntitysByConditions(hql,divPageUtil.getStartIndex(),pageSize);
		setResumeData(divPageUtil,dataList);
		return divPageUtil;
	}

}
