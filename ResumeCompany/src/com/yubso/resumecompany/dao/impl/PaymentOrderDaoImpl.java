package com.yubso.resumecompany.dao.impl;

import java.util.List;

import com.yubso.resumecompany.dao.PaymentOrderDao;
import com.yubso.resumecompany.entity.BoughtResume.BuyerType;
import com.yubso.resumecompany.entity.PaymentOrder;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class PaymentOrderDaoImpl implements PaymentOrderDao {

	@Override
	public DivPageUtil queryAllOrder(int buyerId, BuyerType buyerType,
			int currentPage, int pageSize) {
		String whereSql="buyerId ="+buyerId +" and buyerType="+buyerType.ordinal();
		int allRowCount=SQLHelper.getAllRowCount(PaymentOrder.class, whereSql);
		DivPageUtil divPageUtil=new DivPageUtil(allRowCount, pageSize, currentPage);
		List<PaymentOrder> paymentOrders=SQLHelper.queryDivEntitysByConditions(PaymentOrder.class, whereSql,divPageUtil.getStartIndex(),pageSize);
		divPageUtil.getDataMap().put("paymentOrders", paymentOrders);
		return divPageUtil;
	}

}
