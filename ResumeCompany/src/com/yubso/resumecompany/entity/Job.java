package com.yubso.resumecompany.entity;

/**
 * Job entity. @author MyEclipse Persistence Tools
 */

public class Job implements java.io.Serializable {
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
	 /* 
	 *打电话状态
	 *APK：客户端发送申请消息
	 *PHONE:直接打电话
	 */
	public enum PhoneStatus{
		APK,PHONE
	}
	/**
	 * 职位上下线
	 * ONLINE:上线
	 * OUTLINE:下线
	 */
	public enum DeleteStatus{
		ONLINE,OUTLINE
	}
	// Fields
	private Integer id;
	private String name;//标题/职位名称
	private String category;//职位类别
	private String releaseTime;//发布时间
	private Integer comId;//公司id
	private String workplace;//工作地点
	private String contactPhone;//联系电话
	private String interviewTime;//面试时段（e.g 上午8点到下午6点）
	private String workPay;//薪资
	private String welfare;//福利
	private String requreEducation;//要求的学历
	private String requreExperience;//要求经验
	private String recruitingNumbers;//需求人数
	private String requirements;//职位需求
	private Double lng;
	private Double lat;
	private Integer auditStatus;//审核状态
	private String remarks;//备注，如审核失败原因
	private Integer hrId;////直招为0 ，连锁为连锁企业id，官方发布为-id(连锁企业id的相反数)
	private String orderTime;//排序刷新时间
	private Integer phoneStatus;
	private Integer deleteStatus;//职位上下线
	private String vipTime;//电话招聘包月时间
	private String requirementsCondition;//性别/年龄范围
	private String send;
	private String sendendtime;

	// Constructors

	/** default constructor */
	public Job() {
	}

	/** full constructor */
	public Job(String category, String releaseTime, Integer comId,
			String workplace, String contactPhone, String interviewTime,
			String workPay, String welfare, String requreEducation,
			String requreExperience, String recruitingNumbers,
			String requirements, Double lng, Double lat, Integer auditStatus,
			Integer hrId, String remarks, String orderTime,
			Integer phoneStatus, Integer deleteStatus, String vipTime,
			String requirementsCondition, String send, String sendendtime) {
		this.category = category;
		this.releaseTime = releaseTime;
		this.comId = comId;
		this.workplace = workplace;
		this.contactPhone = contactPhone;
		this.interviewTime = interviewTime;
		this.workPay = workPay;
		this.welfare = welfare;
		this.requreEducation = requreEducation;
		this.requreExperience = requreExperience;
		this.recruitingNumbers = recruitingNumbers;
		this.requirements = requirements;
		this.lng = lng;
		this.lat = lat;
		this.auditStatus = auditStatus;
		this.hrId = hrId;
		this.remarks = remarks;
		this.orderTime = orderTime;
		this.phoneStatus = phoneStatus;
		this.deleteStatus = deleteStatus;
		this.vipTime = vipTime;
		this.requirementsCondition = requirementsCondition;
		this.send = send;
		this.sendendtime = sendendtime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCategory() {
		return this.category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getReleaseTime() {
		return this.releaseTime;
	}

	public void setReleaseTime(String releaseTime) {
		this.releaseTime = releaseTime;
	}

	public Integer getComId() {
		return this.comId;
	}

	public void setComId(Integer comId) {
		this.comId = comId;
	}

	public String getWorkplace() {
		return this.workplace;
	}

	public void setWorkplace(String workplace) {
		this.workplace = workplace;
	}

	public String getContactPhone() {
		return this.contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	public String getInterviewTime() {
		return this.interviewTime;
	}

	public void setInterviewTime(String interviewTime) {
		this.interviewTime = interviewTime;
	}

	public String getWorkPay() {
		return this.workPay;
	}

	public void setWorkPay(String workPay) {
		this.workPay = workPay;
	}

	public String getWelfare() {
		return this.welfare;
	}

	public void setWelfare(String welfare) {
		this.welfare = welfare;
	}

	public String getRequreEducation() {
		return this.requreEducation;
	}

	public void setRequreEducation(String requreEducation) {
		this.requreEducation = requreEducation;
	}

	public String getRequreExperience() {
		return this.requreExperience;
	}

	public void setRequreExperience(String requreExperience) {
		this.requreExperience = requreExperience;
	}

	public String getRecruitingNumbers() {
		return this.recruitingNumbers;
	}

	public void setRecruitingNumbers(String recruitingNumbers) {
		this.recruitingNumbers = recruitingNumbers;
	}

	public String getRequirements() {
		return this.requirements;
	}

	public void setRequirements(String requirements) {
		this.requirements = requirements;
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

	public Integer getAuditStatus() {
		return this.auditStatus;
	}

	public void setAuditStatus(Integer auditStatus) {
		this.auditStatus = auditStatus;
	}

	public Integer getHrId() {
		return this.hrId;
	}

	public void setHrId(Integer hrId) {
		this.hrId = hrId;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getOrderTime() {
		return this.orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public Integer getPhoneStatus() {
		return this.phoneStatus;
	}

	public void setPhoneStatus(Integer phoneStatus) {
		this.phoneStatus = phoneStatus;
	}

	public Integer getDeleteStatus() {
		return this.deleteStatus;
	}

	public void setDeleteStatus(Integer deleteStatus) {
		this.deleteStatus = deleteStatus;
	}

	public String getVipTime() {
		return this.vipTime;
	}

	public void setVipTime(String vipTime) {
		this.vipTime = vipTime;
	}

	public String getRequirementsCondition() {
		return this.requirementsCondition;
	}

	public void setRequirementsCondition(String requirementsCondition) {
		this.requirementsCondition = requirementsCondition;
	}

	public String getSend() {
		return this.send;
	}

	public void setSend(String send) {
		this.send = send;
	}

	public String getSendendtime() {
		return this.sendendtime;
	}

	public void setSendendtime(String sendendtime) {
		this.sendendtime = sendendtime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}