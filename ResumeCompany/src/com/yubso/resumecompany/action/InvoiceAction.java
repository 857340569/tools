package com.yubso.resumecompany.action;

import java.util.Calendar;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.entity.Invoice;
import com.yubso.resumecompany.entity.Invoice.InvoiceStatus;
import com.yubso.resumecompany.service.InvoiceService;
import com.yubso.resumecompany.service.PaymentRecordService;
import com.yubso.resumecompany.service.impl.InvoiceServiceImpl;
import com.yubso.resumecompany.service.impl.PaymentRecordServiceImpl;
import com.yubso.resumecompany.util.DateUtil;

public class InvoiceAction extends BaseAction {
	private InvoiceService invoiceService;
	private PaymentRecordService paymentRecordService;
	public Invoice invoice;
	public String selectedAddress;
	public double cyPayMoney;//今年总消费金额
	public double cyInvoicedMoney;//今年已开发票金额
	public Company company;
	public HumanResource hr;
	private String param;//input的值
	private String info;//验证结果显示的信息
	private String status;//验证结果
	private int currentYear;//当前年份
	public InvoiceAction()
	{
		invoiceService=new InvoiceServiceImpl();
	}
	public String toAddPage() throws Exception{
		int comId=getComId();
		ComType comType=getCompanyType();
		currentYear=Calendar.getInstance().get(Calendar.YEAR);
		paymentRecordService=new PaymentRecordServiceImpl();
		cyPayMoney=paymentRecordService.queryMoneyByYear(currentYear,comId,comType);
		cyInvoicedMoney=invoiceService.queryMoneyByYear(currentYear,InvoiceStatus.ALL,comId,comType);
		return "toAddPage";
	}
	public String addInvoice() throws Exception{
		message="对不起，发票申请失败，请稍后再试！";
		int comId=getComId();
		ComType comType=getCompanyType();
		String exeTime=DateUtil.getNowDateStr("");
		if(invoice!=null)
		{
			invoice.setAddress(selectedAddress+invoice.getAddress());
			invoice.setApplyTime(exeTime);
			invoice.setComId(comId);
			invoice.setComType(comType.ordinal());
			invoice.setStatus(InvoiceStatus.APPLYING.ordinal());
			/**
			 * 已通过实时验证金额了，不用重新获取
			 */
//			int currentYear=Calendar.getInstance().get(Calendar.YEAR);
//			paymentRecordService=new PaymentRecordServiceImpl();
//			cyPayMoney=paymentRecordService.queryMoneyByYear(currentYear,comId,comType);
//			cyInvoicedMoney=invoiceService.queryMoneyByYear(currentYear,InvoiceStatus.ALL,comId,comType);
//			double unInvoicedPay=cyPayMoney-cyInvoicedMoney;
//			if(unInvoicedPay<=0)
//			{
//				message="本年度未开发票金额为0.0元，不能申请发票！";
//				return baseShowResult();
//			}
//			invoice.setPay(unInvoicedPay);
			
			//快递费用货到付款
			/*
			Serializable saveObj=null;
			double countRel=0;
			double postPay=invoice.getPostPay();//快递费用
			if(postPay>0)
			{
				if(comType.ordinal()==ComType.COMPANY.ordinal())
				{
					company=SQLHelper.queryEntityByConditions(Company.class, "id="+comId);
					countRel=company.getAccountBalance()-postPay;
					company.setAccountBalance((int)countRel);
					saveObj=company;
					
				}else if(comType.ordinal()==ComType.HR.ordinal())
				{
					hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+comId);
					countRel=hr.getPayAccount()-postPay;
					hr.setPayAccount((int)countRel);
					saveObj=hr;
				}
				if(countRel<0)
				{
					message="账户余额不足，发票申请失败,请充值后重试!";
					return  baseShowResult();
				}
				//消费记录
				ExpenseRecord expenseRecord=new ExpenseRecord();
				expenseRecord.setBuyerId(comId);
				expenseRecord.setBuyerType(comType.ordinal());
				expenseRecord.setGoodsName("申请发票快递费用(所选快递："+invoice.getPostWay()+")");
				expenseRecord.setPayNum((int)postPay);
				expenseRecord.setPayDate(exeTime);
				boolean addResult=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal(),ExecuteType.ADD.ordinal()},new String[]{"","id="+comId,""},invoice,saveObj,expenseRecord);
				if(addResult)
				{
					message="恭喜您，发票已申请成功，请耐心等待工作人员根据您所填写的邮寄地址进行派送！";
				}
				return  baseShowResult();
			}*/
			boolean addResult=invoiceService.saveInvoice(invoice);
			if(addResult)
			{
				message="恭喜您，发票已申请成功，请耐心等待工作人员根据您所填写的邮寄地址进行派送！";
			}
		}
		return  baseShowResult();
	}
	/**
	 * 检测发票金额是正确(小于等于未开出的发票金额）
	 * @return
	 * @throws Exception
	 */
	public String checkInvoicePay() throws Exception{
		int comId=getComId();
		ComType comType=getCompanyType();
		int currentYear=Calendar.getInstance().get(Calendar.YEAR);
		paymentRecordService=new PaymentRecordServiceImpl();
		cyPayMoney=paymentRecordService.queryMoneyByYear(currentYear,comId,comType);
		cyInvoicedMoney=invoiceService.queryMoneyByYear(currentYear,InvoiceStatus.ALL,comId,comType);
		double unInvoicedPay=cyPayMoney-cyInvoicedMoney;
		if(unInvoicedPay<100)
		{
			info="本年度未开发票金额为小于100.0元，不能申请发票！";
			status="n";
			return "json";
		}
		if(Double.parseDouble(param)<100)
		{
			info="输入的发票金额小于100元，不能申请发票！";
			status="n";
			return "json";
		}
		if(Double.parseDouble(param)>unInvoicedPay)
		{
			info="输入的值已经大于本年度未开发票金额"+unInvoicedPay+"元！";
			status="n";
		}else {
			info="";
			status="y";
		}
		return "json";
	}
	public String queryAllInvoices() throws Exception{
		pageSize=18;
		int comId=getComId();
		ComType comType=getCompanyType();
		divPage=invoiceService.queryInvoiceByIdType(comId, comType, InvoiceStatus.ALL, currentPage, pageSize);
		return "allInvoices";
	}
	public Invoice getInvoice() {
		return invoice;
	}
	public void setInvoice(Invoice invoice) {
		this.invoice = invoice;
	}
	public String getSelectedAddress() {
		return selectedAddress;
	}
	public void setSelectedAddress(String selectedAddress) {
		this.selectedAddress = selectedAddress;
	}
	public double getCyPayMoney() {
		return cyPayMoney;
	}
	public void setCyPayMoney(double cyPayMoney) {
		this.cyPayMoney = cyPayMoney;
	}
	public double getCyInvoicedMoney() {
		return cyInvoicedMoney;
	}
	public void setCyInvoicedMoney(double cyInvoicedMoney) {
		this.cyInvoicedMoney = cyInvoicedMoney;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public HumanResource getHr() {
		return hr;
	}
	public void setHr(HumanResource hr) {
		this.hr = hr;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getCurrentYear() {
		return currentYear;
	}
	public void setCurrentYear(int currentYear) {
		this.currentYear = currentYear;
	}
	
}
