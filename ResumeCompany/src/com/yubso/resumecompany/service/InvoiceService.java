package com.yubso.resumecompany.service;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.entity.Invoice;
import com.yubso.resumecompany.entity.Invoice.InvoiceStatus;
import com.yubso.resumecompany.util.DivPageUtil;

public interface InvoiceService {
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
	/**
	 * 根据年份，公司id,公司类型查询费总金额数
	 * @param year
	 * @param invoiceStatus
	 * @param comId
	 * @param comType
	 * @return
	 */
	public double queryMoneyByYear(int year,InvoiceStatus invoiceStatus,int comId,ComType comType);
}
