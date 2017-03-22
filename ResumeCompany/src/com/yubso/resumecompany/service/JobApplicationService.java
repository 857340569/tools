package com.yubso.resumecompany.service;

import java.util.List;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface JobApplicationService {

	/**
	 * 根据职位id查询申请记录
	 * @param jobId
	 * @return
	 */
	public DivPageUtil queryJobApplicationsByJobId(int jobId,int currentPage,int pageSize);
	public DivPageUtil queryJobApplicationsByJobIds(List<Integer> jobIds,int currentPage,int pageSize);
	public DivPageUtil queryJobApplicationsByComId(int comId,int currentPage,int pageSize);
	public DivPageUtil queryJobApplicationsByComId(int comId,ComType comType,String applyTime,int currentPage,int pageSize);
	//根据职位id查找所有申请人的信息，当jobId<0时 Math.abs(jobId) 为company.id即查找该公司下面所有的申请信息
	public DivPageUtil queryJobApplicationsByJobIdAppTime(int jobId,String selectTime, int currentPage, int pageSize);

}