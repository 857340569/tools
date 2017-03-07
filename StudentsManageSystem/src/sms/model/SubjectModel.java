package sms.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import sms.db.SqlHelper;

public class SubjectModel
{
	SqlHelper sqlHelper;
	
	public SubjectModel()
	{
		sqlHelper=new SqlHelper();
	}
	public Vector<String> findSubjectName()
	{
		ResultSet rSet;
		Vector<String> subName=new Vector<String>();
		String sql="select subName from subjects  ";
		String param[]=new String[]{};
		rSet=sqlHelper.findExecute(sql, param);
		try
		{
			
			while(rSet.next())
			{	
				subName.add(rSet.getString(1));
			}
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return subName;
	}
	public String findSubIdByName(String subName)
	{
		String id = null;
		String sql="select subId from subjects where subName=?";
		String param[]={subName};
		ResultSet rs=sqlHelper.findExecute(sql, param);
		try
		{
			while(rs.next())
			{
				id=rs.getString(1);
			}
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}
	/*
	public boolean addSubject(StudentSubject subject)
	{
		boolean result=true;
		String stuId=subject.getSub1Id();
		
		String sql="insert into subjects values(?,?,?,?) ";
		return result;
	}*/
	

}
