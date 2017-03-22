package com.yubso.resumecompany.entity;

import com.yubso.resumecompany.util.PriceConfig;

/**
 * Company entity. @author MyEclipse Persistence Tools
 */

public class Company implements java.io.Serializable {
	//认证类型     -authType 表示该认证正在申请中，等待审核
	public enum AuthType{
		未认证,百家大咖联盟
	}

	private Integer id;
	private String loginAccount;//公司登录帐户名
	private String loginPassword;//登录密码
	private Integer accountBalance;//帐户余额
	private String vipExpirationTime;//会员到期时间
	private String logo;//公司logo
	private String name;//公司名
	private String nature;//性质
	private String industry;//行业
	private String scale;//规模
	private Integer hrId;//人力资源id 0为自己注册，>0为hr的id,<0的为管理员的id的相反数
	private String contactWay;//联系方式
	private String email;
	private String address;//公司地址
	private String descrImage1;
	private String descrImage2;
	private String descrImage3;
	private String description;//公司简介
	private String registTime;
	private Double lng;//经度
	private Double lat;//纬度
	private Integer authType;//认证类型 <0 为申请中 abs(authType)为认证类型
	private String license;//营业执照
	private Double discount;//折扣
	private String linkman;
	
	// Constructors

	/** default constructor */
	public Company() {
	}

	/** minimal constructor */
	public Company(String name) {
		this.name = name;
	}

	/** full constructor */
	public Company(String loginAccount, String loginPassword,
			Integer accountBalance, String vipExpirationTime, String logo,
			String name, String nature, String industry, String scale,
			Integer hrId, String contactWay, String email, String address,
			String descrImage1, String descrImage2, String descrImage3,
			String description, String registTime, Double lng, Double lat,
			Integer authType, String license, Double discount,String linkman) {
		this.loginAccount = loginAccount;
		this.loginPassword = loginPassword;
		this.accountBalance = accountBalance;
		this.vipExpirationTime = vipExpirationTime;
		this.logo = logo;
		this.name = name;
		this.nature = nature;
		this.industry = industry;
		this.scale = scale;
		this.hrId = hrId;
		this.contactWay = contactWay;
		this.email = email;
		this.address = address;
		this.descrImage1 = descrImage1;
		this.descrImage2 = descrImage2;
		this.descrImage3 = descrImage3;
		this.description = description;
		this.registTime = registTime;
		this.lng = lng;
		this.lat = lat;
		this.authType = authType;
		this.license = license;
		this.discount = discount;
		this.linkman=linkman;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public Integer getAccountBalance() {
		return this.accountBalance;
	}

	public void setAccountBalance(Integer accountBalance) {
		this.accountBalance = accountBalance;
	}

	public String getVipExpirationTime() {
		return this.vipExpirationTime;
	}

	public void setVipExpirationTime(String vipExpirationTime) {
		this.vipExpirationTime = vipExpirationTime;
	}

	public String getLogo() {
		return this.logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNature() {
		return this.nature;
	}

	public void setNature(String nature) {
		this.nature = nature;
	}

	public String getIndustry() {
		return this.industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getScale() {
		return this.scale;
	}

	public void setScale(String scale) {
		this.scale = scale;
	}

	public Integer getHrId() {
		return this.hrId;
	}

	public void setHrId(Integer hrId) {
		this.hrId = hrId;
	}

	public String getContactWay() {
		return this.contactWay;
	}

	public void setContactWay(String contactWay) {
		this.contactWay = contactWay;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDescrImage1() {
		return this.descrImage1;
	}

	public void setDescrImage1(String descrImage1) {
		this.descrImage1 = descrImage1;
	}

	public String getDescrImage2() {
		return this.descrImage2;
	}

	public void setDescrImage2(String descrImage2) {
		this.descrImage2 = descrImage2;
	}

	public String getDescrImage3() {
		return this.descrImage3;
	}

	public void setDescrImage3(String descrImage3) {
		this.descrImage3 = descrImage3;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRegistTime() {
		return this.registTime;
	}

	public void setRegistTime(String registTime) {
		this.registTime = registTime;
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

	public Integer getAuthType() {
		return this.authType;
	}

	public void setAuthType(Integer authType) {
		this.authType = authType;
	}

	public String getLicense() {
		return this.license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public Double getDiscount() {
		return this.discount;
	}

	public void setDiscount(Double discount) {
		this.discount = discount;
	}

	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

}