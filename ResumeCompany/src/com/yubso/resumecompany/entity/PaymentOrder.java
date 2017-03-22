package com.yubso.resumecompany.entity;

/**
 * BoughtOrder entity.
 * 账户订单表
 */

public class PaymentOrder implements java.io.Serializable {

	// Fields
	public enum TraceStatus{
		OK,ORDER
	}
	private Integer id;
	private Integer buyerId;//买家id
	private Integer buyerType; //0公司直招,1人力代理公司
	private String traceNo;//订单号
	private String createDate;//下单日期
	private Double totalMoney;//总金额
	private Integer totalNum;//米粒数量
	private Integer traceStatus;//订单状态 0（ok）:交易完成，1为下单 TraceStatus
	private String goodsName;//商品名

	// Constructors

	/** default constructor */
	public PaymentOrder() {
	}
	// Property accessors
	public PaymentOrder(Integer id, Integer buyerId, Integer buyerType,
			String traceNo, String createDate, Double totalMoney,
			Integer totalNum, Integer traceStatus, String goodsName) {
		super();
		this.id = id;
		this.buyerId = buyerId;
		this.buyerType = buyerType;
		this.traceNo = traceNo;
		this.createDate = createDate;
		this.totalMoney = totalMoney;
		this.totalNum = totalNum;
		this.traceStatus = traceStatus;
		this.goodsName = goodsName;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getBuyerId() {
		return this.buyerId;
	}

	public void setBuyerId(Integer buyerId) {
		this.buyerId = buyerId;
	}
	
	public Integer getBuyerType() {
		return buyerType;
	}

	public void setBuyerType(Integer buyerType) {
		this.buyerType = buyerType;
	}

	public String getTraceNo() {
		return this.traceNo;
	}

	public void setTraceNo(String traceNo) {
		this.traceNo = traceNo;
	}

	public String getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public Double getTotalMoney() {
		return this.totalMoney;
	}

	public void setTotalMoney(Double totalMoney) {
		this.totalMoney = totalMoney;
	}

	public Integer getTotalNum() {
		return this.totalNum;
	}

	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}

	public Integer getTraceStatus() {
		return this.traceStatus;
	}

	public void setTraceStatus(Integer traceStatus) {
		this.traceStatus = traceStatus;
	}

	public String getGoodsName() {
		return this.goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

}