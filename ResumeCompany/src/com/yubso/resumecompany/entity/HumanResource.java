package com.yubso.resumecompany.entity;

/**
 * HumanResource entity. 
 */

public class HumanResource implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String loginAccount;
	private String loginPassword;
	private Integer payAccount;//账户余额
	private String registTime;
	private String logo;
	private String address;
	private Double lng;
	private Double lat;
	private Integer hrType;// 1.广场，连锁， 0人力资源公司
	private Integer agentType;// 0连锁企业  1代理连锁企业

	// Constructors

	/** default constructor */
	public HumanResource() {
	}

	/** full constructor */
	public HumanResource(String name, String loginAccount,
			String loginPassword, Integer payAccount, String registTime,
			String logo, String address, Double lng, Double lat,
			Integer hrType, Integer agentType) {
		this.name = name;
		this.loginAccount = loginAccount;
		this.loginPassword = loginPassword;
		this.payAccount = payAccount;
		this.registTime = registTime;
		this.logo = logo;
		this.address = address;
		this.lng = lng;
		this.lat = lat;
		this.hrType = hrType;
		this.agentType = agentType;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLoginAccount() {
		return this.loginAccount;
	}

	public void setLoginAccount(String loginAccount) {
		this.loginAccount = loginAccount;
	}

	public String getLoginPassword() {
		return this.loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}

	public Integer getPayAccount() {
		return this.payAccount;
	}

	public void setPayAccount(Integer payAccount) {
		this.payAccount = payAccount;
	}

	public String getRegistTime() {
		return this.registTime;
	}

	public void setRegistTime(String registTime) {
		this.registTime = registTime;
	}

	public String getLogo() {
		return this.logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Double getLng() {
		return this.lng;
	}

	public void setLng(Double lng) {
		this.lng = lng;
	}

	public Double getLat() {
		return this.lat;
	}

	public void setLat(Double lat) {
		this.lat = lat;
	}

	public Integer getHrType() {
		return this.hrType;
	}

	public void setHrType(Integer hrType) {
		this.hrType = hrType;
	}

	public Integer getAgentType() {
		return this.agentType;
	}

	public void setAgentType(Integer agentType) {
		this.agentType = agentType;
	}

}