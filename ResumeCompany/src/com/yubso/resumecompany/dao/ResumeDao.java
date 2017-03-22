package com.yubso.resumecompany.dao;

import java.util.List;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.entity.Resume;
import com.yubso.resumecompany.util.DivPageUtil;

public interface ResumeDao {
	public DivPageUtil queryDivResumes(List<String> jcategorys,
			 int currentPage,int pageSize);

	public DivPageUtil queryDivResumes(int currentPage, int pageSize);
	public Resume queryResumeById(int id);
	public Resume queryResumeByUserId(int id);
	public DivPageUtil queryDivResumes(String whereHql, int currentPage,
			int pageSize);
	public DivPageUtil queryInvitedResumes(int comId, ComType comType,int currentPage, int pageSize);

	public DivPageUtil queryBearbyResumes(int currentPage, int pageSize,
			Double lng, Double lat, Double distanceRange);
}
