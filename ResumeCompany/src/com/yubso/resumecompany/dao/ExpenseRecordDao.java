package com.yubso.resumecompany.dao;

import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface ExpenseRecordDao {
	DivPageUtil queryAllRecord(int buyerId,BuyerType buyerType,int currentPage,int pageSize);
}
