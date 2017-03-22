package com.yubso.resumecompany.action;

import com.yubso.resumecompany.entity.PaymentOrder;
import com.yubso.resumecompany.entity.PaymentOrder.TraceStatus;
import com.yubso.resumecompany.entity.PaymentRecord;
import com.yubso.resumecompany.entity.PaymentRecord.BuyerType;
import com.yubso.resumecompany.service.ExpenseRecordService;
import com.yubso.resumecompany.service.PaymentRecordService;
import com.yubso.resumecompany.service.impl.ExpenseRecordServiceImpl;
import com.yubso.resumecompany.service.impl.PaymentRecordServiceImpl;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.StringUtil;

public class PayAction extends BaseAction{
	private PaymentOrder paymentOrder;
	private PaymentRecord paymentRecord;
	private String traceNo;
	private int status;//0 成功 1失败
	private PaymentRecordService paymentRecordService;
	private ExpenseRecordService expenseRecordService;
	//提交订单，json
	public String saveOrder() throws Exception{
		status=1;
		traceNo=StringUtil.getUUID();
		int id=getComId();
		if(paymentOrder!=null)
		{
			paymentOrder.setBuyerId(id);
			paymentOrder.setBuyerType(getCompanyType().ordinal());
			paymentOrder.setTraceNo(traceNo);
			paymentOrder.setTraceStatus(TraceStatus.ORDER.ordinal());
			paymentOrder.setCreateDate(DateUtil.getNowDateStr(""));
			boolean saveResult=SQLHelper.addEntity(paymentOrder);
			if(saveResult) 
				status=0;
		}
		return "json";
	}
	public String cancelOrder() throws Exception{
		status=1;
		if(StringUtil.checkIsNotNull(traceNo))
		{
			
			boolean cancelResult=SQLHelper.deleteEntity(PaymentOrder.class, "traceNo='"+traceNo+"'");
			if(cancelResult) 
				status=0;
		}
		return "json";
	}
	//查看所有充值记录
	public String queryAllPayRecord() throws Exception{ 
		pageSize=15;
		paymentRecordService=new PaymentRecordServiceImpl();
		BuyerType buyerType=BuyerType.values()[getCompanyType().ordinal()];
		divPage=paymentRecordService.queryAllRecord(getComId(),buyerType, currentPage, pageSize);
		return "payRecords";
	}
	//查看所以消费记录
	public String queryAllExpenseRecord() throws Exception{
		pageSize=15;
		expenseRecordService=new ExpenseRecordServiceImpl();
		BuyerType buyerType=BuyerType.values()[getCompanyType().ordinal()];
		divPage=expenseRecordService.queryAllRecord(getComId(),buyerType, currentPage, pageSize);
		return "expenseRecords";
	}
	public PaymentOrder getPaymentOrder() {
		return paymentOrder;
	}
	public void setPaymentOrder(PaymentOrder paymentOrder) {
		this.paymentOrder = paymentOrder;
	}
	public PaymentRecord getPaymentRecord() {
		return paymentRecord;
	}
	public void setPaymentRecord(PaymentRecord paymentRecord) {
		this.paymentRecord = paymentRecord;
	}
	public String getTraceNo() {
		return traceNo;
	}
	public void setTraceNo(String traceNo) {
		this.traceNo = traceNo;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
}
