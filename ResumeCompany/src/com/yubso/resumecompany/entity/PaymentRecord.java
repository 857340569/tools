package com.yubso.resumecompany.entity;

/**
 * BoughtRecords entity. 
 * 账户充值记录表
 */

public class PaymentRecord implements java.io.Serializable {

	// Fields
	public enum BuyerType
	{
		COMPANY,HR,ADMIN
	}
	private Integer id;
	private String traceNo;//订单号/如果<32位且为数字的话，则为yid
	private Integer buyerId;//买家id
	private Integer buyerType;//买家类型  0为直招的企业 1人力资源
	private Double money;//付款总金额
	private String boughtDate;//购买日期
	private String goodsName;//商品名
	private Integer payNum;//购买米粒数量

	// Constructors

	/** default constructor */
	public PaymentRecord() {
	}

	/** full constructor */
	public PaymentRecord(String traceNo, Integer buyerId, Integer buyerType,
			Double money, String boughtDate, String goodsName, Integer payNum) {
		this.traceNo = traceNo;
		this.buyerId = buyerId;
		this.buyerType = buyerType;
		this.money = money;
		this.boughtDate = boughtDate;
		this.goodsName = goodsName;
		this.payNum = payNum;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTraceNo() {
		return this.traceNo;
	}

	public void setTraceNo(String traceNo) {
		this.traceNo = traceNo;
	}

	public Integer getBuyerId() {
		return this.buyerId;
	}

	public void setBuyerId(Integer buyerId) {
		this.buyerId = buyerId;
	}

	public Integer getBuyerType() {
		return this.buyerType;
	}

	public void setBuyerType(Integer buyerType) {
		this.buyerType = buyerType;
	}

	public Double getMoney() {
		return this.money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public String getBoughtDate() {
		return this.boughtDate;
	}

	public void setBoughtDate(String boughtDate) {
		this.boughtDate = boughtDate;
	}

	public String getGoodsName() {
		return this.goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public Integer getPayNum() {
		return this.payNum;
	}

	public void setPayNum(Integer payNum) {
		this.payNum = payNum;
	}

}