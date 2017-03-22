package com.yubso.resumecompany.service;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface PaymentRecordService {
	DivPageUtil queryAllRecord(int buyerId,BuyerType buyerType,int currentPage,int pageSize);
	/**
	 * 根据年份，公司id,公司类型查询费总金额数
	 * @param year
	 * @param comId
	 * @param comType
	 * @return
	 */
	public double queryMoneyByYear(int year,int comId,ComType comType);
}
