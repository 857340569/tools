package com.yubso.resumecompany.entity;

/**
 * ExpenseRecord entity.
 * 消费记录表
 */

public class ExpenseRecord implements java.io.Serializable {

	// Fields
	public enum BuyerType
	{
		COMPANY,HR
	}
	private Integer id;
	private Integer buyerId;
	private Integer buyerType;
	private Integer payNum;
	private String goodsName;
	private String payDate;

	// Constructors

	/** default constructor */
	public ExpenseRecord() {
	}

	/** full constructor */
	public ExpenseRecord(Integer buyerId, Integer buyerType, Integer payNum,
			String goodsName, String payDate) {
		this.buyerId = buyerId;
		this.buyerType = buyerType;
		this.payNum = payNum;
		this.goodsName = goodsName;
		this.payDate = payDate;
	}

	// Property accessors

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
		return this.buyerType;
	}

	public void setBuyerType(Integer buyerType) {
		this.buyerType = buyerType;
	}

	public Integer getPayNum() {
		return this.payNum;
	}

	public void setPayNum(Integer payNum) {
		this.payNum = payNum;
	}

	public String getGoodsName() {
		return this.goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getPayDate() {
		return this.payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

}