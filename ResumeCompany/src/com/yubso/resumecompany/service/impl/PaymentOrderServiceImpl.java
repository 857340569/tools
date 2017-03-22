package com.yubso.resumecompany.service.impl;

import com.yubso.resumecompany.dao.PaymentOrderDao;
import com.yubso.resumecompany.dao.impl.PaymentOrderDaoImpl;
import com.yubso.resumecompany.entity.BoughtResume.BuyerType;
import com.yubso.resumecompany.service.PaymentOrderService;
import com.yubso.resumecompany.util.DivPageUtil;

public class PaymentOrderServiceImpl implements PaymentOrderService {
	private PaymentOrderDao paymentOrderDao;
	public PaymentOrderServiceImpl(){
		paymentOrderDao=new PaymentOrderDaoImpl();
	}
	@Override
	public DivPageUtil queryAllOrder(int buyerId, BuyerType buyerType,
			int currentPage, int pageSize) {
		return paymentOrderDao.queryAllOrder(buyerId, buyerType, currentPage, pageSize);
	}

}
