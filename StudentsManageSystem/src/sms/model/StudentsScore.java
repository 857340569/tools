package sms.model;

public class StudentsScore
{
	private String stuId;
	private String subId;
	private String acadYear;
	private String term;
	private String score;
	private String isPass;
	public StudentsScore()
	{
		
	}
	public StudentsScore(String stuId, String subId, String acadYear,
			String term, String score, String isPass)
	{
		
		this.stuId = stuId;
		this.subId = subId;
		this.acadYear = acadYear;
		this.term = term;
		this.score = score;
		this.isPass = isPass;
	}
	
	public String getStuId()
	{
		return stuId;
	}
	public void setStuId(String stuId)
	{
		this.stuId = stuId;
	}
	public String getSubId()
	{
		return subId;
	}
	public void setSubId(String subId)
	{
		this.subId = subId;
	}
	public String getAcadYear()
	{
		return acadYear;
	}
	public void setAcadYear(String acadYear)
	{
		this.acadYear = acadYear;
	}
	public String getTerm()
	{
		return term;
	}
	public void setTerm(String term)
	{
		this.term = term;
	}
	public String getScore()
	{
		return score;
	}
	public void setScore(String score)
	{
		this.score = score;
	}
	public String getIsPass()
	{
		return isPass;
	}
	public void setIsPass(String isPass)
	{
		this.isPass = isPass;
	}
	
	
	
	
}
