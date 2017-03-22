package com.yubso.resumecompany.entity;

/**
 * Activities entity. 活动表
 */

public class Activities implements java.io.Serializable {

	/**
	 * 
	 * 审核状态 PASSED：通过 AUDITING:审核中 FAILED:未通过
	 */
	public enum AuditStatus {
		PASSED, AUDITING, FAILED, ALL
	}

	public enum ComType {
		COMPANY, HR, ADMIN
	}

	// 等你来 状态 (活动 activity ，创业 venture
	public enum Status {
		ACTIVITY, VENTURE
	}

	// 集结号
	public enum Send {
		JIJIEHAO
	}

	private Integer id;
	private String title;
	private String holdTime;
	private String endTime;
	private String activitiesPlace;
	private String organizers;
	private String image1;
	private String image2;
	private String image3;
	private String content1;
	private String content2;
	private String content3;
	private Integer auditStatus;
	private String remarks;
	private String refreshTime;
	private Integer comId;
	private Integer comType;
	private String label;
	private String phone;
	private String qq;
	private String status;// 等你来 状态（活动 activity ，创业 venture ）
	private Integer praise;// 点赞数
	private String send;// 集结号
	private Double lng;
	private Double lat;

	public Activities() {
	}

	/** full constructor */
	public Activities(String title, String holdTime, String endTime,
			String activitiesPlace, String organizers, String image1,
			String image2, String image3, String content1, String content2,
			String content3, Integer auditStatus, String remarks,
			String refreshTime, Integer comId, Integer comType, String label,
			String phone, String qq, String status, Integer praise,
			String send, Double lng, Double lat) {
		this.title = title;
		this.holdTime = holdTime;
		this.endTime = endTime;
		this.activitiesPlace = activitiesPlace;
		this.organizers = organizers;
		this.image1 = image1;
		this.image2 = image2;
		this.image3 = image3;
		this.content1 = content1;
		this.content2 = content2;
		this.content3 = content3;
		this.auditStatus = auditStatus;
		this.remarks = remarks;
		this.refreshTime = refreshTime;
		this.comId = comId;
		this.comType = comType;
		this.label = label;
		this.phone = phone;
		this.qq = qq;
		this.status = status;
		this.praise = praise;
		this.send = send;
		this.lng = lng;
		this.lat = lat;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getHoldTime() {
		return this.holdTime;
	}

	public void setHoldTime(String holdTime) {
		this.holdTime = holdTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getActivitiesPlace() {
		return this.activitiesPlace;
	}

	public void setActivitiesPlace(String activitiesPlace) {
		this.activitiesPlace = activitiesPlace;
	}

	public String getOrganizers() {
		return this.organizers;
	}

	public void setOrganizers(String organizers) {
		this.organizers = organizers;
	}

	public String getImage1() {
		return this.image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return this.image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return this.image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getContent1() {
		return this.content1;
	}

	public void setContent1(String content1) {
		this.content1 = content1;
	}

	public String getContent2() {
		return this.content2;
	}

	public void setContent2(String content2) {
		this.content2 = content2;
	}

	public String getContent3() {
		return this.content3;
	}

	public void setContent3(String content3) {
		this.content3 = content3;
	}

	public Integer getAuditStatus() {
		return this.auditStatus;
	}

	public void setAuditStatus(Integer auditStatus) {
		this.auditStatus = auditStatus;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getRefreshTime() {
		return this.refreshTime;
	}

	public void setRefreshTime(String refreshTime) {
		this.refreshTime = refreshTime;
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

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getPraise() {
		return praise;
	}

	public void setPraise(Integer praise) {
		this.praise = praise;
	}

	public String getSend() {
		return send;
	}

	public void setSend(String send) {
		this.send = send;
	}

	public Double getLng() {
		return lng;
	}

	public void setLng(Double lng) {
		this.lng = lng;
	}

	public Double getLat() {
		return lat;
	}

	public void setLat(Double lat) {
		this.lat = lat;
	}
}