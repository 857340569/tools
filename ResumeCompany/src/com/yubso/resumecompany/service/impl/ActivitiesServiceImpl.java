package com.yubso.resumecompany.service.impl;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.ActivitiesDao;
import com.yubso.resumecompany.dao.impl.ActivitiesDaoImpl;
import com.yubso.resumecompany.entity.Activities;
import com.yubso.resumecompany.entity.Activities.AuditStatus;
import com.yubso.resumecompany.service.ActivitiesService;
import com.yubso.resumecompany.util.DivPageUtil;

public class ActivitiesServiceImpl implements ActivitiesService {
	private ActivitiesDao activitiesDao;
	public ActivitiesServiceImpl() {
		activitiesDao = new ActivitiesDaoImpl();
	}
	public boolean addActivities(Activities activities) {
		return activitiesDao.addActivities(activities);
	}
	
	@Override
	public DivPageUtil queryAllActivities(int comId, ComType comType,
			AuditStatus auditStatus, int currentPage, int pageSize) {
		return activitiesDao.queryAllActivities(comId, comType,auditStatus,currentPage,pageSize);
	}

	public Activities queryActivitiesById(int id) {
		return activitiesDao.queryActivitiesById(id);
	}

	public boolean deleteActivitiesByIds(int[] ids) {
		return activitiesDao.deleteActivitiesByIds(ids);
	}

	public boolean updateActivitiesById(Activities activities) {
		return activitiesDao.updateActivitiesById(activities);
	}
}
