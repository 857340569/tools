package com.yubso.resumecompany.dao;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface PaymentRecordDao {
	DivPageUtil queryAllRecord(int buyerId,BuyerType buyerType,int currentPage,int pageSize);
	public double queryMoneyByYear(int year,int comId,ComType comType);
}
