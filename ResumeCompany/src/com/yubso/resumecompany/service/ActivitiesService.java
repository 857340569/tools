package com.yubso.resumecompany.service;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.entity.Activities;
import com.yubso.resumecompany.entity.Activities.AuditStatus;
import com.yubso.resumecompany.util.DivPageUtil;

public interface ActivitiesService {
	/**
	 * 发布活动信息
	 */
	public boolean addActivities(Activities activities);
	/**
	 * 分页查看活动
	 * @param comId 企业id（包括直招、人力资源)
	 * @param comType 企业类型
	 * @param auditStatus 审核状态
	 * @param currentPage 
	 * @param pageSize
	 * @return
	 */
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
	 * 修改活动
	 * @param Activities
	 * @return
	 */
	public boolean updateActivitiesById(Activities activities);
}
