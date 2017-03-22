package com.yubso.resumecompany.entity;

/**
 * BoughtLibrary entity.
 * 简历购买记录
 */

public class BoughtResume implements java.io.Serializable {

	// Fields
	public enum BuyerType
	{
		COMPANY,HR
	}
	private Integer id;
	private Integer buyerId;//yid/cid
	private Integer buyerType; //0公司直招,1人力代理公司
	private Integer resumeId;//简历库id
	private String boughtTime;

	// Constructors

	/** default constructor */
	public BoughtResume() {
	}

	/** full constructor */
	public BoughtResume(Integer buyerId, Integer buyerType, Integer resumeId,
			String boughtTime) {
		this.buyerId = buyerId;
		this.buyerType = buyerType;
		this.resumeId = resumeId;
		this.boughtTime = boughtTime;
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

	public Integer getResumeId() {
		return this.resumeId;
	}

	public void setResumeId(Integer resumeId) {
		this.resumeId = resumeId;
	}

	public String getBoughtTime() {
		return this.boughtTime;
	}

	public void setBoughtTime(String boughtTime) {
		this.boughtTime = boughtTime;
	}

}