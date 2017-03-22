package com.yubso.resumecompany.service.impl;

import com.yubso.resumecompany.dao.BoughtResumeDao;
import com.yubso.resumecompany.dao.impl.BoughtResumeDaoImpl;
import com.yubso.resumecompany.entity.BoughtResume;
import com.yubso.resumecompany.entity.BoughtResume.BuyerType;
import com.yubso.resumecompany.service.BoughtResumeService;
import com.yubso.resumecompany.util.DivPageUtil;

public class BoughtResumeServiceImpl implements BoughtResumeService {
	private BoughtResumeDao boughtResumeDao;
	public BoughtResumeServiceImpl()
	{
		boughtResumeDao=new BoughtResumeDaoImpl();
	}
	@Override
	public DivPageUtil queryAllBR(int buyerId, BuyerType buyerType, int currentPage,
			int pageSize) {
		return boughtResumeDao.queryAllBR(buyerId,buyerType,currentPage,pageSize);
	}
	@Override
	public BoughtResume queryBoughtResume(int resumeId, int buyerId,
			BuyerType buyerType) {
		return boughtResumeDao.queryBoughtResume(resumeId, buyerId, buyerType);
	}

}
