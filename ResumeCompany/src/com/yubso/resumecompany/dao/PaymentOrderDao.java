package com.yubso.resumecompany.dao;

import com.yubso.resumecompany.entity.BoughtResume.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface PaymentOrderDao {
	DivPageUtil queryAllOrder(int buyerId,BuyerType buyerType,int currentPage,int pageSize);
}
