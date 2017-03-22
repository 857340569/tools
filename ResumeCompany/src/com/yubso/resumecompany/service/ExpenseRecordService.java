package com.yubso.resumecompany.service;

import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface ExpenseRecordService {
	DivPageUtil queryAllRecord(int buyerId,BuyerType buyerType,int currentPage,int pageSize);
}
