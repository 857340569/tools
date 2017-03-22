package com.yubso.resumecompany.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.ActivitiesDao;
import com.yubso.resumecompany.entity.Activities;
import com.yubso.resumecompany.entity.Activities.AuditStatus;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class ActivitiesDaoImpl implements ActivitiesDao {
	
	public boolean addActivities(Activities Activities) {
		if (Activities == null) {
			return false;
		}
		return SQLHelper.addEntity(Activities);
	}
	@Override
	public DivPageUtil queryAllActivities(int comId, ComType comType, AuditStatus auditStatus, int currentPage, int pageSize) {
		String whereSql=" comId="+comId+" and comType="+comType.ordinal();
		if(auditStatus!=null&&auditStatus.ordinal()!=AuditStatus.ALL.ordinal())
		{
			whereSql+=" and auditStatus="+auditStatus.ordinal();
		}
		int totalCount = SQLHelper.getAllRowCount(Activities.class,whereSql);
		DivPageUtil dpu = new DivPageUtil(totalCount,pageSize, currentPage);
		List<Activities> dataList = SQLHelper.queryDivEntitysByConditions(Activities.class,whereSql+ " order by refreshTime desc",dpu.getStartIndex(),pageSize);
		dpu.getDataMap().put("activities",dataList);
		return dpu;
	}
	public DivPageUtil queryAllActivities(int currentPage, int pageSize,int auditStatus) {
		int totalCount = SQLHelper.getAllRowCount(Activities.class,"auditStatus="+auditStatus);
		DivPageUtil dpu = new DivPageUtil(totalCount,pageSize, currentPage);
		List<Activities> dataList = SQLHelper.queryDivEntitysByConditions(Activities.class," auditStatus="+auditStatus+ " order by refreshTime desc",dpu.getStartIndex(),pageSize);
		//比较刷新与当前的时间
		Map<Integer, Integer>  sizeComparison =new HashMap<Integer, Integer>();
		if (dataList != null) {
			for (Activities activities:dataList) {
				String refreshTime = activities.getRefreshTime();
				String nowTime = DateUtil.getNowDateStr("");
				int compare = (int)DateUtil.getDifferDays(refreshTime,nowTime);
				 sizeComparison.put(activities.getId(), compare);
			}
		}
		dpu.getDataMap().put("activities",dataList);
		dpu.getDataMap().put("sizeComparison", sizeComparison);
		return dpu;
	}

	public Activities queryActivitiesById(int id) {
		if (id <= 0) {
			return null;
		}
		Activities Activities = SQLHelper.queryEntityByConditions(Activities.class, "id="+id);
		return Activities;
	}

	public boolean deleteActivitiesByIds(int[] ids) {
			if (ids == null || ids.length == 0) {
				System.out.println("ids---"+ids);
				return false;
			} else {
				String sql = "id in(0";
				for (int i = 0; i < ids.length; i++) {
					sql += "," + ids[i];
				}
				sql += ")";
				System.out.println(sql+"-----");
				return SQLHelper.deleteEntity(Activities.class, sql);
			}
	}
	public boolean updateActivitiesById(Activities activities) {
		if (activities == null) {
			return false;
		}
		return SQLHelper.updateEntityById(activities, activities.getId());
	}

	
}
