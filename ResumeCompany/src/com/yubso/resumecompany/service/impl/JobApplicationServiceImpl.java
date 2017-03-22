package com.yubso.resumecompany.service.impl;

import java.util.List;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.JobApplicationDao;
import com.yubso.resumecompany.dao.impl.JobApplicationDaoImpl;
import com.yubso.resumecompany.service.JobApplicationService;
import com.yubso.resumecompany.util.DivPageUtil;

public class JobApplicationServiceImpl implements JobApplicationService {
	private JobApplicationDao jobApplicationDao;
	public JobApplicationServiceImpl(){
		jobApplicationDao=new JobApplicationDaoImpl();
	}
	@Override
	public DivPageUtil queryJobApplicationsByJobId(int jobId,int currentPage,int pageSize)
	{
		return jobApplicationDao.queryJobApplicationsByJobId(jobId, currentPage, pageSize);
	}

	@Override
	public DivPageUtil queryJobApplicationsByJobIds(List<Integer> jobIds,int currentPage,int pageSize) {
		return jobApplicationDao.queryJobApplicationsByJobIds(jobIds, currentPage, pageSize);
	}
	@Override
	public DivPageUtil queryJobApplicationsByComId(int comId, int currentPage,
			int pageSize) {
		return jobApplicationDao.queryJobApplicationsByComId(comId, currentPage, pageSize);
	}
	@Override
	public DivPageUtil queryJobApplicationsByComId(int comId,ComType comType, String applyTime,
			int currentPage, int pageSize) {
		return jobApplicationDao.queryJobApplicationsByComId(comId,comType,applyTime, currentPage, pageSize);
	}
	@Override
	public DivPageUtil queryJobApplicationsByJobIdAppTime(int jobId,String selectTime, int currentPage, int pageSize) {
		return jobApplicationDao.queryJobApplicationsByJobIdAppTime(jobId, selectTime, currentPage, pageSize);
	}
}
