package com.yubso.resumecompany.entity;

/**
 * WorkExperience entity. @author MyEclipse Persistence Tools
 */

public class WorkExperience implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private String companyName;
	private String startTime;
	private String endTime;
	private String job;

	// Constructors

	/** default constructor */
	public WorkExperience() {
	}

	/** minimal constructor */
	public WorkExperience(Integer uid) {
		this.uid = uid;
	}

	/** full constructor */
	public WorkExperience(Integer uid, String companyName, String startTime,
			String endTime, String job) {
		this.uid = uid;
		this.companyName = companyName;
		this.startTime = startTime;
		this.endTime = endTime;
		this.job = job;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getCompanyName() {
		return this.companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getJob() {
		return this.job;
	}

	public void setJob(String job) {
		this.job = job;
	}

}