package com.yubso.resumecompany.dao.impl;

import java.util.List;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.PaymentRecordDao;
import com.yubso.resumecompany.entity.PaymentRecord;
import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class PaymentRecordDaoImpl implements PaymentRecordDao{

	@Override
	public DivPageUtil queryAllRecord(int buyerId, BuyerType buyerType,
			int currentPage, int pageSize) {
		String whereSql="buyerId ="+buyerId +" and buyerType="+buyerType.ordinal()+" order by boughtDate desc";
		int allRowCount=SQLHelper.getAllRowCount(PaymentRecord.class, whereSql);
		DivPageUtil divPageUtil=new DivPageUtil(allRowCount, pageSize, currentPage);
		List<PaymentRecord> paymentRecords=SQLHelper.queryDivEntitysByConditions(PaymentRecord.class, whereSql,divPageUtil.getStartIndex(),pageSize);
		divPageUtil.getDataMap().put("paymentRecords", paymentRecords);
		return divPageUtil;
	}

	@Override
	public double queryMoneyByYear(int year, int comId, ComType comType) {
		String hql="select sum(money) from PaymentRecord where buyerId ="+comId +" and buyerType="+comType.ordinal()+" and year(boughtDate)="+year;
		List list=SQLHelper.queryDivEntitysByConditions(hql, 1, 1);
		if(list==null||list.size()==0||list.get(0)==null)
			return 0;
		double money=Double.parseDouble(list.get(0).toString());
		return money;
	}

}
