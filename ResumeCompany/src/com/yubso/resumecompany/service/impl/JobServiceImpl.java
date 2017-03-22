package com.yubso.resumecompany.service.impl;

import java.util.List;

import com.yubso.resumecompany.dao.JobDao;
import com.yubso.resumecompany.dao.impl.JobDaoImpl;
import com.yubso.resumecompany.entity.Job;
import com.yubso.resumecompany.service.JobService;
import com.yubso.resumecompany.util.DivPageUtil;

public class JobServiceImpl implements JobService {
	JobDao jobDao;
	public JobServiceImpl(){
		jobDao=new JobDaoImpl();
	}
	@Override
	public boolean addJob(Job job)
	{
		return jobDao.addJob(job);
	}
	
	@Override
	public boolean deleteJob(Job job)
	{
		return jobDao.deleteJob(job);
	}
	@Override
	public boolean deleteJobById(int id) {
		Job job=new Job();
		job.setId(id);
		return deleteJob(job);
	}
	@Override
	public DivPageUtil queryDivJobsByComId(int comId,int currentPage,int pageSize){
		return jobDao.queryDivJobsByComId(comId,currentPage, pageSize);
	}
	@Override
	public DivPageUtil queryDivJobsByHrId(int hrId,int currentPage,int pageSize){
		return jobDao.queryDivJobsByHrId(hrId,currentPage, pageSize);
	}
	@Override
	public List<Job> queryDivJobsByComId(int comId) {
		
		return jobDao.queryDivJobsByComId(comId);
	}
	@Override
	public Job querJobById(int id) {
		return jobDao.querJobById(id);
	}
	@Override
	public boolean updateJob(Job job) {
		return jobDao.updateJob(job);
	}
	public List<Job> queryJcategoryByComId(int comId){
		return jobDao.queryJcategoryByComId(comId);
	}
	@Override
	public DivPageUtil queryDivJobsByCondtion(String selectTime, Integer comId,int hrId,
			int currentPage, int pageSize) {
		return jobDao.queryDivJobsByCondtion(selectTime,comId,hrId,currentPage,pageSize);
	}
	@Override
	public boolean deleteJobByIds(String[] ids) {
		return jobDao.deleteJobByIds(ids);
	}
	@Override
	public DivPageUtil queryDivJobsByComId(int comId, int currentPage,
			int pageSize, int deleteStatus) {
		return jobDao.queryDivJobsByComId(comId, currentPage, pageSize,deleteStatus);
	}
	@Override
	public DivPageUtil queryDivJobsByHrId(int hrId, int currentPage,
			int pageSize, int deleteStatus) {
		// TODO Auto-generated method stub
		return jobDao.queryDivJobsByHrId(hrId, currentPage, pageSize,deleteStatus);
	}

	
}
