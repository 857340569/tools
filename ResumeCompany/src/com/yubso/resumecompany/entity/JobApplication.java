package com.yubso.resumecompany.entity;

/**
 * JobApplication entity. 
 * 职位申请表
 */

public class JobApplication implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;//用户id
	private Integer jobId;//职位id
	private Integer applyStatus;//申请状态 0用户申请，1发出面试，2录用
	private String applyTime;//申请时间
	private String employTime;//通知/雇佣时间

	// Constructors

	/** default constructor */
	public JobApplication() {
		
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getJobId() {
		return this.jobId;
	}

	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}

	public Integer getApplyStatus() {
		return this.applyStatus;
	}

	public void setApplyStatus(Integer applyStatus) {
		this.applyStatus = applyStatus;
	}

	public String getApplyTime() {
		return this.applyTime;
	}

	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

	public String getEmployTime() {
		return employTime;
	}

	public void setEmployTime(String employTime) {
		this.employTime = employTime;
	}

}