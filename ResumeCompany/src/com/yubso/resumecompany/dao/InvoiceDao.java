package com.yubso.resumecompany.dao;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.entity.Invoice;
import com.yubso.resumecompany.entity.Invoice.InvoiceStatus;
import com.yubso.resumecompany.util.DivPageUtil;

public interface InvoiceDao {
	public boolean saveInvoice(Invoice invoice);
	/**
	 * 
	 * @param comId 申请企业的id
	 * @param comType 申请企业的类型
	 * @param invoiceStatus 申请的状态
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public DivPageUtil queryInvoiceByIdType(int comId,ComType comType,InvoiceStatus invoiceStatus,int currentPage,int pageSize);
	public double queryMoneyByYear(int year,InvoiceStatus invoiceStatus,int comId,ComType comType);
}
