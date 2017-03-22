package com.yubso.resumecompany.service;

import com.yubso.resumecompany.entity.BoughtResume.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface PaymentOrderService {
	DivPageUtil queryAllOrder(int buyerId,BuyerType buyerType,int currentPage,int pageSize);
}
