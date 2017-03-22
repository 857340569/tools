package com.yubso.resumecompany.entity;

import com.yubso.resumecompany.model.MyEntity;

/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User implements java.io.Serializable,MyEntity {

	// Fields
	public enum DeviceType
	{
		ANDROID,IOS
	}
	private Integer id;
	private String userName;
	private String userPsw;
	private String registTime;
	private String recommended;
	private String updateTime;
	private String useDays;
	private String name;
	private String sex;
	private String birthplace;
	private String education;
	private String birth;
	private String phone;
	private String martialStatus;
	private String photo;
	private Integer deviceType;

	// Constructors

	/** default constructor */
	public User() {
	}

	public User(Integer id, String userName, String userPsw, String registTime,
			String recommended, String updateTime, String useDays, String name,
			String sex, String birthplace, String education, String birth,
			String phone, String martialStatus, String photo,Integer deviceType) {
		this.id = id;
		this.userName = userName;
		this.userPsw = userPsw;
		this.registTime = registTime;
		this.recommended = recommended;
		this.updateTime = updateTime;
		this.useDays = useDays;
		this.name = name;
		this.sex = sex;
		this.birthplace = birthplace;
		this.education = education;
		this.birth = birth;
		this.phone = phone;
		this.martialStatus = martialStatus;
		this.photo = photo;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPsw() {
		return this.userPsw;
	}

	public void setUserPsw(String userPsw) {
		this.userPsw = userPsw;
	}

	public String getRegistTime() {
		return registTime;
	}

	public void setRegistTime(String registTime) {
		this.registTime = registTime;
	}

	public String getRecommended() {
		return this.recommended;
	}

	public void setRecommended(String recommended) {
		this.recommended = recommended;
	}

	public String getUseDays() {
		return this.useDays;
	}

	public void setUseDays(String useDays) {
		this.useDays = useDays;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirthplace() {
		return this.birthplace;
	}

	public void setBirthplace(String birthplace) {
		this.birthplace = birthplace;
	}

	public String getEducation() {
		return this.education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getBirth() {
		return this.birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMartialStatus() {
		return this.martialStatus;
	}

	public void setMartialStatus(String martialStatus) {
		this.martialStatus = martialStatus;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(Integer deviceType) {
		this.deviceType = deviceType;
	}
	
}