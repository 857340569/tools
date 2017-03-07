package sms.model;

import sms.db.SqlHelper;

public class StuScoreModel
{
	SqlHelper sqlHelper=null;
	public StuScoreModel()
	{
		sqlHelper=new SqlHelper();
	}
	public boolean addScore(StudentsScore stuScore)
	{
		boolean result=true;
		
		String sql="insert into studentsScore values(?,?,?,?,?,?)";
		String param[]={stuScore.getStuId(),stuScore.getSubId(),stuScore.getAcadYear(),stuScore.getTerm(),stuScore.getScore(),stuScore.getIsPass()};
		int i=sqlHelper.updateExecute(sql, param);
		if(i==0)
		{
			result=false;
		}
		return result;
	}
}
