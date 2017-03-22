package com.yubso.resumecompany.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yubso.resumecompany.dao.JobDao;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.Job;
import com.yubso.resumecompany.entity.JobApplication;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.StringUtil;

public class JobDaoImpl implements JobDao {
	
	@Override
	public boolean addJob(Job job)
	{
		return SQLHelper.addEntity(job);
	}
	
	@Override
	public boolean deleteJob(Job job)
	{
		return SQLHelper.deleteEntity(job);
	}
	
	@Override
	public List<Job> queryDivJobsByComId(int comId)
	{
		return SQLHelper.queryDivEntitysByConditions(Job.class, "comId="+comId);
	}
	@Override
	public DivPageUtil queryDivJobsByComId(int comId,int currentPage,int pageSize){
		String whereHql=" j.comId="+comId+" and j.comId=c.id order by j.id desc";
		int recordCounts=SQLHelper.getAllRowCount("Job j,Company c", whereHql);
		DivPageUtil divPageUtil=new DivPageUtil(recordCounts, pageSize, currentPage);
		String hql="from Job j,Company c where "+whereHql;
		List dataList=SQLHelper.queryDivEntitysByConditions(hql, divPageUtil.getStartIndex(), pageSize);
		setEnityData(divPageUtil,dataList);
		return divPageUtil;
	}
	@Override
	public DivPageUtil queryDivJobsByComId(int comId, int currentPage,
			int pageSize, int deleteStatus) {
		String whereHql=" j.comId="+comId+" and j.comId=c.id and j.deleteStatus="+deleteStatus+" order by j.id desc";
		int recordCounts=SQLHelper.getAllRowCount("Job j,Company c", whereHql);
		DivPageUtil divPageUtil=new DivPageUtil(recordCounts, pageSize, currentPage);
		String hql="from Job j,Company c where "+whereHql;
		List dataList=SQLHelper.queryDivEntitysByConditions(hql, divPageUtil.getStartIndex(), pageSize);
		setEnityData(divPageUtil,dataList);
		return divPageUtil;
	}
	@Override
	public DivPageUtil queryDivJobsByHrId(int hrId,int currentPage,int pageSize){
		String whereHql=" j.hrId="+hrId+" and j.comId=c.id order by j.id desc";
		int recordCounts=SQLHelper.getAllRowCount(" Job j,Company c ", whereHql);
		DivPageUtil divPageUtil=new DivPageUtil(recordCounts, pageSize, currentPage);
		String hql="from Job j,Company c where "+whereHql;
//		List<Job> jobs=SQLHelper.queryDivEntitysByConditions(Job.class, "hrId="+hrId, divPageUtil.getStartIndex(), pageSize);
//		divPageUtil.getDataMap().put("jobs", jobs);
//		for(Job job:jobs){
//			int appNumber=SQLHelper.getAllRowCount(JobApplication.class, "jobId="+job.getId());
//			divPageUtil.getEntitysMap().put(job.getId(), appNumber);
//		}
		List dataList=SQLHelper.queryDivEntitysByConditions(hql,divPageUtil.getStartIndex(),pageSize);
		setEnityData(divPageUtil,dataList);
		return divPageUtil;
	}
	@Override
	public DivPageUtil queryDivJobsByHrId(int hrId, int currentPage,
			int pageSize, int deleteStatus) {
		String whereHql=" j.hrId="+hrId+" and j.comId=c.id and j.deleteStatus="+deleteStatus+" order by j.id desc";
		int recordCounts=SQLHelper.getAllRowCount(" Job j,Company c ", whereHql);
		DivPageUtil divPageUtil=new DivPageUtil(recordCounts, pageSize, currentPage);
		String hql="from Job j,Company c where "+whereHql;
		List dataList=SQLHelper.queryDivEntitysByConditions(hql,divPageUtil.getStartIndex(),pageSize);
		setEnityData(divPageUtil,dataList);
		return divPageUtil;
	}
	@Override
	public Job querJobById(int id) {
		return SQLHelper.queryEntityByConditions(Job.class, "id="+id);
	}

	@Override
	public boolean updateJob(Job job) {
		return SQLHelper.updateEntityById(job, job.getId());
	}

	@Override
	public List<Job> queryJcategoryByComId(int comId) {
		String whereSql="a where id=(select max(id) from Job where category=a.category and comId="+comId+")";
		List<Job> list =SQLHelper.queryDivEntitysByConditions(Job.class, whereSql,-1,-1);
		return list;
	}
	public void setEnityData(DivPageUtil dpu,List dataList)
	{
		if(dpu==null||dataList==null)
		{
			return;
		}
		List<Job> jobs=new ArrayList<Job>();
		Map<Integer, Company> companies=new HashMap<Integer, Company>();
		Job job=null;
		Company company=null;
		for(int j=0;j<dataList.size();j++)
		{
			 job=null;
			 company=null;
			 Object[] obj=(Object[]) dataList.get(j);
			 for(int i=0;i<obj.length;i++)
			 {	
				 if(obj[i] instanceof Job)
				 {
					 job=(Job)obj[i];
				 }
				 else if(obj[i] instanceof Company)
				 {
					 company=(Company)obj[i];
				 }
			 }
			 if(job!=null)
			 {
				 jobs.add(job);
				 int appNumber=SQLHelper.getAllRowCount("JobApplication ja,Job j,User u,Resume r", "ja.jobId="+job.getId()+" and ja.userId=u.id and ja.jobId= j.id and u.id=r.uid");
				 dpu.getEntitysMap().put(job.getId(), appNumber);
				if(company!=null)
				{
					companies.put(job.getId(), company);
				}
			 }
		}
		dpu.getDataMap().put("jobs", jobs);
		dpu.getDataMap().put("companies", companies);
	}

	@Override
	public DivPageUtil queryDivJobsByCondtion(String selectTime, Integer comId,int hrId,
			int currentPage, int pageSize) {
		String whereSql="";
		if(StringUtil.checkIsNotNull(selectTime))
		{
			whereSql+=" c.registTime like '%"+selectTime+"%' ";
		}
		if(comId!=null&&comId>=0)
		{
			if(StringUtil.checkIsNotNull(whereSql))
			{
				whereSql+=" and ";
			}
			whereSql+=" j.comId="+comId;
		}
		if(StringUtil.checkIsNotNull(whereSql))
		{
			whereSql+=" and j.hrId="+hrId;
		}else {
			whereSql+=" j.hrId="+hrId;
		}
		whereSql+=" and c.id=j.comId";
		int recordCounts=SQLHelper.getAllRowCount(" Job j,Company c ", whereSql);
		DivPageUtil divPageUtil=new DivPageUtil(recordCounts, pageSize, currentPage);
		String hql="from Job j,Company c where "+whereSql;
		List dataList=SQLHelper.queryDivEntitysByConditions(hql,divPageUtil.getStartIndex(),pageSize);
		setEnityData(divPageUtil,dataList);
		return divPageUtil;
	}

	@Override
	public boolean deleteJobByIds(String[] ids) {
		if(ids==null||ids.length==0)
		{
			return false;
		}
		String hql="delete from Job where id in(";
		for (int i = 0; i < ids.length; i++) {
			if(i==0)
			{
				hql+=ids[i];
			}else{
				hql+=","+ids[i];
			}
		}
		hql+=") ";
		return SQLHelper.deleteEntitys(hql);
	}
}
