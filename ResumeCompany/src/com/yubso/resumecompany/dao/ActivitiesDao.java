package com.yubso.resumecompany.dao;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.entity.Activities;
import com.yubso.resumecompany.entity.Activities.AuditStatus;
import com.yubso.resumecompany.util.DivPageUtil;

public interface ActivitiesDao {
	/**
	 * 发布活动信息
	 */
	public boolean addActivities(Activities activities);
	
	public DivPageUtil queryAllActivities(int comId,ComType comType,AuditStatus auditStatus,int currentPage,int pageSize);
	/**
	 * 根据id进行查看
	 * @param id
	 * @return
	 */
	public Activities queryActivitiesById(int id);
	/**
	 * 根据id 进行删除
	 * @param selectFlag
	 * @return
	 */
	public boolean deleteActivitiesByIds(int[] ids);
	/**
	 * 修改动态
	 * @param Activities
	 * @return
	 */
	public boolean updateActivitiesById(Activities activities);
}
