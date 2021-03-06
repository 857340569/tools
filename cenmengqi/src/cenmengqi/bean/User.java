package cenmengqi.bean;

public class User {
	//用户信息
	private int id;
	private String name;//姓名
	private String number;//编号
	private String pwd;//密码
	private String department;//部门
	private String sex;//性别
	private String education;//学历
	private String nativePlace;//出生地
	private String userType;//用户类型
	public enum UserType{
		ADMIN,COMMON
	}
	public User(){}
	public User(String name, String number, String pwd, String department, String sex, String education,
			String nativePlace) {
		super();
		this.name = name;
		this.number = number;
		this.pwd = pwd;
		this.department = department;
		this.sex = sex;
		this.education = education;
		this.nativePlace = nativePlace;
		userType=UserType.COMMON.name();
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getNumber() {
		return number;
	}


	public void setNumber(String number) {
		this.number = number;
	}


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getDepartment() {
		return department;
	}


	public void setDepartment(String department) {
		this.department = department;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}


	public String getEducation() {
		return education;
	}


	public void setEducation(String education) {
		this.education = education;
	}


	public String getNativePlace() {
		return nativePlace;
	}


	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}


	public String getUserType() {
		return userType;
	}


	public void setUserType(String userType) {
		this.userType = userType;
	}


}
