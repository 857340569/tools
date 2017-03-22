package com.yubso.resumecompany.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yubso.resumecompany.dao.BoughtResumeDao;
import com.yubso.resumecompany.entity.BoughtResume;
import com.yubso.resumecompany.entity.BoughtResume.BuyerType;
import com.yubso.resumecompany.entity.Resume;
import com.yubso.resumecompany.entity.User;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class BoughtResumeDaoImpl implements BoughtResumeDao{
	@Override
	public DivPageUtil queryAllBR(int buyerId, BuyerType buyerType, int currentPage,
			int pageSize) {
		String whereSql="buyerId ="+buyerId +" and buyerType="+buyerType.ordinal();
		int allRowCount=SQLHelper.getAllRowCount(BoughtResume.class, whereSql);
		DivPageUtil divPageUtil=new DivPageUtil(allRowCount, pageSize, currentPage);
		List<BoughtResume> boughtResumes=SQLHelper.queryDivEntitysByConditions(BoughtResume.class, whereSql,divPageUtil.getStartIndex(),pageSize);
		divPageUtil.getDataMap().put("boughtResumes", boughtResumes);
		Map<Integer, User> users=new HashMap<Integer, User>();
		for (BoughtResume boughtResume : boughtResumes) {
			Resume resume=SQLHelper.queryEntityByConditions(Resume.class, "id= "+boughtResume.getResumeId());
			if(resume==null)
				continue;
			divPageUtil.getEntitysMap().put(boughtResume.getId(), resume);
			User user=SQLHelper.queryEntityByConditions(User.class, "id="+resume.getUid());
			if(user==null)
				continue;
//			user.setBirth(DateUtil.getAgeByBirthday(user.getBirth())+"");
			users.put(boughtResume.getResumeId(), user);
		}
		divPageUtil.getDataMap().put("users", users);
		return divPageUtil;
	}

	@Override
	public BoughtResume queryBoughtResume(int resumeId, int buyerId,
			BuyerType buyerType) {
		String whereHql="resumeId="+resumeId+" and buyerId="+buyerId+" and buyerType="+buyerType.ordinal();
		return SQLHelper.queryEntityByConditions(BoughtResume.class, whereHql);
	}

}
