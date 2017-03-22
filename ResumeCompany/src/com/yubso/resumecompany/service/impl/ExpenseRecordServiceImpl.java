package com.yubso.resumecompany.service.impl;

import com.yubso.resumecompany.dao.ExpenseRecordDao;
import com.yubso.resumecompany.dao.impl.ExpenseRecordDaoImpl;
import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.service.ExpenseRecordService;
import com.yubso.resumecompany.util.DivPageUtil;

public class ExpenseRecordServiceImpl implements ExpenseRecordService {
	private ExpenseRecordDao expenseRecordDao;
	public ExpenseRecordServiceImpl(){
		expenseRecordDao=new ExpenseRecordDaoImpl();
	}
	@Override
	public DivPageUtil queryAllRecord(int buyerId, BuyerType buyerType,
			int currentPage, int pageSize) {
		return expenseRecordDao.queryAllRecord(buyerId, buyerType, currentPage, pageSize);
	}

}
