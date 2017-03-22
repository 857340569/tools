package com.yubso.resumecompany.entity;

/**
 * ComHrVip entity.
 * 企业vip表  已经不用了
 */
@Deprecated
public class ComHrVip implements java.io.Serializable {

	public enum VipType{
		JOB
	}
	private Integer id;
	private Integer comId;
	private Integer comType;
	private String endTime;
	private Integer vipType=VipType.JOB.ordinal();

	// Constructors
	
	/** default constructor */
	public ComHrVip() {
	}

	/** full constructor */
	public ComHrVip(Integer comId, Integer comType, String endTime,
			Integer vipType) {
		this.comId = comId;
		this.comType = comType;
		this.endTime = endTime;
		this.vipType = vipType;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getComId() {
		return this.comId;
	}

	public void setComId(Integer comId) {
		this.comId = comId;
	}

	public Integer getComType() {
		return this.comType;
	}

	public void setComType(Integer comType) {
		this.comType = comType;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Integer getVipType() {
		return this.vipType;
	}

	public void setVipType(Integer vipType) {
		this.vipType = vipType;
	}

}