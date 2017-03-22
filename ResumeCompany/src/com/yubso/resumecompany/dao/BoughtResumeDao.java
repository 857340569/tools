package com.yubso.resumecompany.dao;

import com.yubso.resumecompany.entity.BoughtResume;
import com.yubso.resumecompany.entity.BoughtResume.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface BoughtResumeDao {

	DivPageUtil queryAllBR(int buyerId, BuyerType buyerType, int currentPage,
			int pageSize);
	BoughtResume queryBoughtResume(int resumeId,int buyerId,BuyerType buyerType);
}
