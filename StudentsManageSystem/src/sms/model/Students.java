package sms.model;

public class Students
{
	private String stuId,stuName,stuSex,stuBirth,stuGrade,stuDept,stuJob,stuPL;
	public Students(String stuId,String stuName,String stuSex,String stuBirth,String stuGrade,String stuDept,String stuJob,String stuPL )
	{
		this.stuId=stuId;
		this.stuName=stuName;
		this.stuSex=stuSex;
		this.stuBirth=stuBirth;
		this.stuGrade=stuGrade;
		this.stuDept=stuDept;
		this.stuJob=stuJob;
		this.stuPL=stuPL;
	}
	public String getStuId()
	{
		return stuId;
	}
	public void setStuId(String stuId)
	{
		this.stuId = stuId;
	}
	public String getStuName()
	{
		return stuName;
	}
	public void setStuName(String stuName)
	{
		this.stuName = stuName;
	}
	public String getStuSex()
	{
		return stuSex;
	}
	public void setStuSex(String stuSex)
	{
		this.stuSex = stuSex;
	}
	public String getStuBirth()
	{
		return stuBirth;
	}
	public void setStuBirth(String stuBirth)
	{
		this.stuBirth = stuBirth;
	}
	public String getStuGrade()
	{
		return stuGrade;
	}
	public void setStuGrade(String stuGrade)
	{
		this.stuGrade = stuGrade;
	}
	public String getStuDept()
	{
		return stuDept;
	}
	public void setStuDept(String stuDept)
	{
		this.stuDept = stuDept;
	}
	public String getStuJob()
	{
		return stuJob;
	}
	public void setStuJob(String stuJob)
	{
		this.stuJob = stuJob;
	}
	public String getStuPL()
	{
		return stuPL;
	}
	public void setStuPL(String stuPL)
	{
		this.stuPL = stuPL;
	}
	
}
