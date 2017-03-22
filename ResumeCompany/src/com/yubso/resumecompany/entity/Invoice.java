package com.yubso.resumecompany.entity;

/**
 * Invoice entity. 
 * 发票表
 * @author Administrator
 */

public class Invoice implements java.io.Serializable {

	// Fields
	public enum InvoiceStatus{
		ALL,APPLYING,COMPLETE
	}
	private Integer id;
	private String type;//发票类型
	private String headName;//发票抬头
	private Double pay;//金额
	private String content;//发票内容
	private String address;//邮寄地址
	private String postCode;//邮编
	private String recipient;//收件人
	private String contactPhone;//联系电话
	private String postWay;//邮寄方式
	private Double postPay;//邮寄费用
	private String applyTime;//申请时间
	private String makeTime;//开具时间
	private Integer comId;//申请公司的id
	private Integer comType;//申请公司类型  BaseAction.ComType
	private Integer status;//状态
	private String remark;//备注

	// Constructors

	/** default constructor */
	public Invoice() {
	}

	/** full constructor */
	public Invoice(String type,String headName, Double pay, String content, String address,
			String postCode, String recipient, String contactPhone,
			String postWay, Double postPay, String applyTime, String makeTime,
			Integer comId, Integer comType, Integer status, String remark) {
		this.type=type;
		this.headName = headName;
		this.pay = pay;
		this.content = content;
		this.address = address;
		this.postCode = postCode;
		this.recipient = recipient;
		this.contactPhone = contactPhone;
		this.postWay = postWay;
		this.postPay = postPay;
		this.applyTime = applyTime;
		this.makeTime = makeTime;
		this.comId = comId;
		this.comType = comType;
		this.status = status;
		this.remark = remark;
	}

	// Property accessors
	
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getHeadName() {
		return this.headName;
	}

	public void setHeadName(String headName) {
		this.headName = headName;
	}

	public Double getPay() {
		return this.pay;
	}

	public void setPay(Double pay) {
		this.pay = pay;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostCode() {
		return this.postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getRecipient() {
		return this.recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public String getContactPhone() {
		return this.contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	public String getPostWay() {
		return this.postWay;
	}

	public void setPostWay(String postWay) {
		this.postWay = postWay;
	}

	public Double getPostPay() {
		return this.postPay;
	}

	public void setPostPay(Double postPay) {
		this.postPay = postPay;
	}

	public String getApplyTime() {
		return this.applyTime;
	}

	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

	public String getMakeTime() {
		return this.makeTime;
	}

	public void setMakeTime(String makeTime) {
		this.makeTime = makeTime;
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

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}