package com.yubso.resumecompany.service.impl;

import java.util.List;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.ResumeDao;
import com.yubso.resumecompany.dao.impl.ResumeDaoImpl;
import com.yubso.resumecompany.entity.Resume;
import com.yubso.resumecompany.service.ResumeService;
import com.yubso.resumecompany.util.DivPageUtil;


public class ResumeServiceImpl implements ResumeService {
	private ResumeDao resumeDao;
	public ResumeServiceImpl(){
		resumeDao=new ResumeDaoImpl();
	}
	@Override
	public DivPageUtil queryDivResumes(List<String> jcategorys,
			int currentPage, int pageSize) {
		if(jcategorys==null)
			return resumeDao.queryDivResumes(currentPage, pageSize);
		return resumeDao.queryDivResumes(jcategorys, currentPage, pageSize);
	}
	@Override
	public Resume queryResumeById(int id) {
		return resumeDao.queryResumeById(id);
	}
	@Override
	public DivPageUtil queryAllDivResumes(int currentPage, int pageSize) {
		return resumeDao.queryDivResumes(currentPage,pageSize);
	}
	@Override
	public Resume queryResumeByUserId(int id) {
		return resumeDao.queryResumeByUserId(id);
	}
	@Override
	public DivPageUtil queryDivResumes(String whereHql, int currentPage,
			int pageSize) {
		return resumeDao.queryDivResumes(whereHql, currentPage, pageSize);
	}
	@Override
	public DivPageUtil queryInvitedResumes(int comId, ComType comType,
			int currentPage, int pageSize) {
		return resumeDao.queryInvitedResumes(comId, comType, currentPage, pageSize);
	}
	@Override
	public DivPageUtil queryBearbyResumes(int currentPage, int pageSize,
			Double lng, Double lat, Double distanceRange) {
		
		return resumeDao.queryBearbyResumes(currentPage,pageSize,lng,lat,distanceRange);
	}

}
