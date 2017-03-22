package com.yubso.resumecompany.service;

import java.util.List;

import com.yubso.resumecompany.entity.Job;
import com.yubso.resumecompany.util.DivPageUtil;

public interface JobService {

	public boolean addJob(Job job);

	public boolean deleteJob(Job job);
	public boolean deleteJobById(int id);
	//查询企业发布的职位
	public DivPageUtil queryDivJobsByComId(int comId,int currentPage,
				int pageSize);
	//查询企业发布的职位  
	/**
	 * 
	 * @param comId
	 * @param currentPage
	 * @param pageSize
	 * @param deleteStatus 上、下线
	 * @return
	 */
	public DivPageUtil queryDivJobsByComId(int comId,int currentPage,
					int pageSize,int deleteStatus);
	//查询代理企业发布的职位
	public DivPageUtil queryDivJobsByHrId(int hrId, int currentPage,
			int pageSize);
	//查询代理企业发布的职位
	public DivPageUtil queryDivJobsByHrId(int hrId, int currentPage,
				int pageSize,int deleteStatus);
	public List<Job> queryDivJobsByComId(int comId);
	public Job querJobById(int id);

	public boolean updateJob(Job job);
	
	public List<Job> queryJcategoryByComId(int comId);

	public DivPageUtil queryDivJobsByCondtion(String selectTime, Integer comId,int hrId,
			int currentPage, int pageSize);

	public boolean deleteJobByIds(String[] ids);
}