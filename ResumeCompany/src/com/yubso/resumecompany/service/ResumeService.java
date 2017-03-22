package com.yubso.resumecompany.service;

import java.util.List;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.entity.Resume;
import com.yubso.resumecompany.util.DivPageUtil;

public interface ResumeService {
	public DivPageUtil queryDivResumes(List<String> jcategorys,
			 int currentPage,int pageSize);
	public DivPageUtil queryAllDivResumes(int currentPage,int pageSize);

	public Resume queryResumeById(int id);
	public Resume queryResumeByUserId(int id);
	/**
	 * 多条件查询简历信息
	 * @param whereHql
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public DivPageUtil queryDivResumes(String whereHql, int currentPage,
			int pageSize);
	/**
	 * 
	 * @param comId 企业id即推送者id
	 * @param comType 企业类型即推送者类型
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public DivPageUtil queryInvitedResumes(int comId, ComType comType,int currentPage, int pageSize);
	
	/**
	 * 找附近的简历信息
	 * @param currentPage
	 * @param pageSize
	 * @param lng  经度
	 * @param lat  维度
	 * @param distanceRange
	 * @return
	 */
	public DivPageUtil queryBearbyResumes(int currentPage, int pageSize,Double lng,Double lat,Double distanceRange);

}
