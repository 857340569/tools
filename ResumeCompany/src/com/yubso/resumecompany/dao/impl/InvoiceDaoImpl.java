package com.yubso.resumecompany.dao.impl;

import java.util.List;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.InvoiceDao;
import com.yubso.resumecompany.entity.Invoice;
import com.yubso.resumecompany.entity.Invoice.InvoiceStatus;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class InvoiceDaoImpl implements InvoiceDao {

	@Override
	public boolean saveInvoice(Invoice invoice) {
		return SQLHelper.addEntity(invoice);
	}

	@Override
	public DivPageUtil queryInvoiceByIdType(int comId, ComType comType,
			InvoiceStatus invoiceStatus, int currentPage, int pageSize) {
		String whereHql="comId="+comId +"and comType="+comType.ordinal();
		if(invoiceStatus.ordinal()!=InvoiceStatus.ALL.ordinal())
		{
			whereHql+=" and status="+invoiceStatus.ordinal();
		}
		int rowCount=SQLHelper.getAllRowCount(Invoice.class, whereHql);
		DivPageUtil dpu=new DivPageUtil(rowCount, pageSize, currentPage);
		List<Invoice> invoices=SQLHelper.queryDivEntitysByConditions(Invoice.class, whereHql,dpu.getStartIndex(),pageSize);
		dpu.getDataMap().put("invoices", invoices);
		return dpu;
	}

	@Override
	public double queryMoneyByYear(int year, InvoiceStatus invoiceStatus,
			int comId, ComType comType) {
		String hql="select sum(pay) from Invoice where comId ="+comId +" and comType="+comType.ordinal()+" and year(applyTime)="+year;
		if(invoiceStatus.ordinal()!=InvoiceStatus.ALL.ordinal())
		{
			hql+=" and status="+invoiceStatus.ordinal();
		}
		List list=SQLHelper.queryDivEntitysByConditions(hql, 1, 1);
		if(list==null||list.size()==0||list.get(0)==null)
			return 0;
		double money=Double.parseDouble(list.get(0).toString());
		return money;
	}

}
