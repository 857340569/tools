package com.yubso.resumecompany.service.impl;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.InvoiceDao;
import com.yubso.resumecompany.dao.impl.InvoiceDaoImpl;
import com.yubso.resumecompany.entity.Invoice;
import com.yubso.resumecompany.entity.Invoice.InvoiceStatus;
import com.yubso.resumecompany.service.InvoiceService;
import com.yubso.resumecompany.util.DivPageUtil;

public class InvoiceServiceImpl implements InvoiceService {
	private InvoiceDao invoiceDao;
	public InvoiceServiceImpl()
	{
		invoiceDao=new InvoiceDaoImpl();
	}
	@Override
	public boolean saveInvoice(Invoice invoice) {
		return invoiceDao.saveInvoice(invoice);
	}

	@Override
	public DivPageUtil queryInvoiceByIdType(int comId, ComType comType,
			InvoiceStatus invoiceStatus, int currentPage, int pageSize) {
		return invoiceDao.queryInvoiceByIdType(comId, comType, invoiceStatus, currentPage, pageSize);
	}
	@Override
	public double queryMoneyByYear(int year,InvoiceStatus invoiceStatus,int comId,ComType comType){
		return invoiceDao.queryMoneyByYear(year, invoiceStatus, comId, comType);
	}

}
