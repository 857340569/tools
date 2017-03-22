package com.yubso.resumecompany.dao;

import java.util.List;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface JobApplicationDao {

	/**
	 * 根据职位id查询申请记录
	 * @param jobId
	 * @return
	 */
	public DivPageUtil queryJobApplicationsByJobId(int jobId,int currentPage,int pageSize);
	/**
	 * 
	 * @return
	 */
	public DivPageUtil queryJobApplicationsByJobIds(List<Integer> jobIds,int currentPage,int pageSize);
	public DivPageUtil queryJobApplicationsByComId(int comId, int currentPage,int pageSize);
	public DivPageUtil queryJobApplicationsByComId(int comId, ComType comType,String applyTime,int currentPage, int pageSize);
	public DivPageUtil queryJobApplicationsByJobIdAppTime(int jobId,String selectTime, int currentPage, int pageSize);

}