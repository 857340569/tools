package com.yubso.resumecompany.entity;

import com.yubso.resumecompany.model.MyEntity;

/**
 * Resume entity.
 */

public class Resume implements java.io.Serializable, MyEntity {

	/**
	 * 
	 *简历开关
	 *ON  开
	 *OFF  关
	 */
	public enum SwitchStatus{
		ON,OFF
	}

	private Integer id;
	private Integer uid;
	private String hopeJob;
	private String hopePlace;
	private Integer currentState;
	private String jobRequirement;
	private String locationPlace;
	private Integer switchStatus;//简历开关 0 开，1关
	private String workExperience;
	private Double lng;
	private Double lat;

	// Constructors

	/** default constructor */
	public Resume() {
	}

	/** minimal constructor */
	public Resume(Integer uid) {
		this.uid = uid;
	}

	/** full constructor */
	public Resume(Integer uid, String hopeJob, String hopePlace,
			Integer currentState, String jobRequirement, String locationPlace,
			Integer switchStatus, String workExperience, Double lng, Double lat) {
		this.uid = uid;
		this.hopeJob = hopeJob;
		this.hopePlace = hopePlace;
		this.currentState = currentState;
		this.jobRequirement = jobRequirement;
		this.locationPlace = locationPlace;
		this.switchStatus = switchStatus;
		this.workExperience = workExperience;
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

	public String getHopeJob() {
		return this.hopeJob;
	}

	public void setHopeJob(String hopeJob) {
		this.hopeJob = hopeJob;
	}

	public String getHopePlace() {
		return this.hopePlace;
	}

	public void setHopePlace(String hopePlace) {
		this.hopePlace = hopePlace;
	}

	public Integer getCurrentState() {
		return this.currentState;
	}

	public void setCurrentState(Integer currentState) {
		this.currentState = currentState;
	}

	public String getJobRequirement() {
		return this.jobRequirement;
	}

	public void setJobRequirement(String jobRequirement) {
		this.jobRequirement = jobRequirement;
	}

	public String getLocationPlace() {
		return this.locationPlace;
	}

	public void setLocationPlace(String locationPlace) {
		this.locationPlace = locationPlace;
	}

	public Integer getSwitchStatus() {
		return switchStatus;
	}

	public void setSwitchStatus(Integer switchStatus) {
		this.switchStatus = switchStatus;
	}

	public String getWorkExperience() {
		return this.workExperience;
	}

	public void setWorkExperience(String workExperience) {
		this.workExperience = workExperience;
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