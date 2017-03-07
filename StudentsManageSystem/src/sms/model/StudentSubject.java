package sms.model;
/**
 * 
 *
 *@author Beautiful Sky
 *不同的学生选的课程也不同，只能根据学生选课程的Id进行管理,并根据学生的Id来确定
 */
public class StudentSubject
{
	
	private String subName,sub1Id,sub2Id,sub3Id,sub4Id,sub5Id,sub6Id;
	public StudentSubject()
	{
		
	}
	public StudentSubject(String subName, String sub1Id, String sub2Id,
			String sub3Id, String sub4Id, String sub5Id, String sub6Id)
	{
		this.subName = subName;
		this.sub1Id = sub1Id;
		this.sub2Id = sub2Id;
		this.sub3Id = sub3Id;
		this.sub4Id = sub4Id;
		this.sub5Id = sub5Id;
		this.sub6Id = sub6Id;
	}



	public String getSubName()
	{
		return subName;
	}



	public void setSubName(String subName)
	{
		this.subName = subName;
	}



	public String getSub1Id()
	{
		return sub1Id;
	}



	public void setSub1Id(String sub1Id)
	{
		this.sub1Id = sub1Id;
	}



	public String getSub2Id()
	{
		return sub2Id;
	}



	public void setSub2Id(String sub2Id)
	{
		this.sub2Id = sub2Id;
	}



	public String getSub3Id()
	{
		return sub3Id;
	}



	public void setSub3Id(String sub3Id)
	{
		this.sub3Id = sub3Id;
	}



	public String getSub4Id()
	{
		return sub4Id;
	}



	public void setSub4Id(String sub4Id)
	{
		this.sub4Id = sub4Id;
	}



	public String getSub5Id()
	{
		return sub5Id;
	}



	public void setSub5Id(String sub5Id)
	{
		this.sub5Id = sub5Id;
	}



	public String getSub6Id()
	{
		return sub6Id;
	}



	public void setSub6Id(String sub6Id)
	{
		this.sub6Id = sub6Id;
	}
	
	
}
