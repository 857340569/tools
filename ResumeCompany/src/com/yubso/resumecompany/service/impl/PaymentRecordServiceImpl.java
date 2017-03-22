package com.yubso.resumecompany.service.impl;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.PaymentRecordDao;
import com.yubso.resumecompany.dao.impl.PaymentRecordDaoImpl;
import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.service.PaymentRecordService;
import com.yubso.resumecompany.util.DivPageUtil;

public class PaymentRecordServiceImpl implements PaymentRecordService {
	private PaymentRecordDao paymentRecordDao;
	public PaymentRecordServiceImpl(){
		paymentRecordDao=new PaymentRecordDaoImpl();
	}
	@Override
	public DivPageUtil queryAllRecord(int buyerId, BuyerType buyerType,
			int currentPage, int pageSize) {
		// TODO Auto-generated method stub
		return paymentRecordDao.queryAllRecord(buyerId, buyerType, currentPage, pageSize);
	}
	@Override
	public double queryMoneyByYear(int year, int comId, ComType comType) {
		return paymentRecordDao.queryMoneyByYear(year, comId, comType);
	}

}
