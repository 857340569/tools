package com.yubso.resumecompany.dao.impl;

import java.util.List;

import com.yubso.resumecompany.dao.ExpenseRecordDao;
import com.yubso.resumecompany.entity.ExpenseRecord;
import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class ExpenseRecordDaoImpl implements ExpenseRecordDao{

	@Override
	public DivPageUtil queryAllRecord(int buyerId, BuyerType buyerType,
			int currentPage, int pageSize) {
		String whereSql="buyerId ="+buyerId +" and buyerType="+buyerType.ordinal()+" order by payDate desc";
		int allRowCount=SQLHelper.getAllRowCount(ExpenseRecord.class, whereSql);
		DivPageUtil divPageUtil=new DivPageUtil(allRowCount, pageSize, currentPage);
		List<ExpenseRecord> expenseRecords=SQLHelper.queryDivEntitysByConditions(ExpenseRecord.class, whereSql,divPageUtil.getStartIndex(),pageSize);
		divPageUtil.getDataMap().put("expenseRecords", expenseRecords);
		return divPageUtil;
	}

}
