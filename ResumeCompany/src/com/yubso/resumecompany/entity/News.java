package com.yubso.resumecompany.entity;

/**
 * News entity.
 * 新闻动态表
 */

public class News implements java.io.Serializable {

	/**
	 * 
	 *审核状态
	 *PASSED：通过
	 *AUDITING:审核中
	 *FAILED:未通过
	 */
	public enum AuditStatus{
		PASSED,AUDITING,FAILED
	}
	// Fields
	public enum SrcType{
		TEXT,URL
	}
	public enum ComType{
		COMPANY,HR,ADMIN
	}
	private Integer id;
	private Integer comId;//企业id
	private Integer comType;//企业类型
	private String title;//动态标题
	private Integer srcType;//资源类型
	private String content1;//动态内容1，2，3
	private String content2;
	private String content3;
	private String image1;//描述图片1，2，3
	private String image2;
	private String image3;
	private String publishTime;//发表时间
	private Integer auditStatus;//审核状态
	private Integer praise=0;//点赞
	private String remarks;//备注，如审核失败原因
	private String refreshTime;//刷新时间
	private String address;
	private String label;
	private String phone;
	private String qq;

	/** default constructor */
	public News() {
	}

	public News(Integer id, Integer comId, Integer comType, String title,
			Integer srcType, String content1, String content2, String content3,
			String image1, String image2, String image3, String publishTime,
			Integer auditStatus, Integer praise, String remarks,
			String refreshTime,String address,String label,String phone,String qq) {
		super();
		this.id = id;
		this.comId = comId;
		this.comType = comType;
		this.title = title;
		this.srcType = srcType;
		this.content1 = content1;
		this.content2 = content2;
		this.content3 = content3;
		this.image1 = image1;
		this.image2 = image2;
		this.image3 = image3;
		this.publishTime = publishTime;
		this.auditStatus = auditStatus;
		this.praise = praise;
		this.remarks = remarks;
		this.refreshTime = refreshTime;
		this.address=address;
		this.label=label;
		this.phone=phone;
		this.qq=qq;
	}

	public String getRefreshTime() {
		return refreshTime;
	}

	public void setRefreshTime(String refreshTime) {
		this.refreshTime = refreshTime;
	}

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

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getSrcType() {
		return this.srcType;
	}

	public void setSrcType(Integer srcType) {
		this.srcType = srcType;
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

	public String getPublishTime() {
		return this.publishTime;
	}

	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}

	public Integer getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(Integer auditStatus) {
		this.auditStatus = auditStatus;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


	public Integer getPraise() {
		return praise;
	}


	public void setPraise(Integer praise) {
		this.praise = praise;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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
	
}