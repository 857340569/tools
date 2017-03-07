package sms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import sms.db.SqlHelper;

public class LoginModel
{
	SqlHelper sqlHelper;
	ResultSet rs;
	public LoginModel()
	{
		sqlHelper=new SqlHelper();
	}
	public String editPsw(String id,String beforePsw,String afterPsw)
	{
		String result="";
		String sql1="select adminPsw from login where adminName=?";
		String [] param1={id};
		rs=sqlHelper.findExecute(sql1, param1);
		try
		{
			rs.next();
			if (rs.getString(1).trim().equals(beforePsw))
			{
				String sql2="update login set adminPsw=? where adminName=?";
				String param2[]={afterPsw,id};
				int i=sqlHelper.updateExecute(sql2, param2);
				if(i==0)
				{
					result="";
				}
				else {
					result="success";
				}
			}
			
		} catch (Exception e)
		{
			// TODO: handle exception
			e.printStackTrace();
		}
		finally
		{
			sqlHelper.close();
		}
		
		return result;
	}
	public String check(String name,String psw)
	{
		
		String job="";
		String sql="select stuId,stuJob ,adminPsw from login,studentsInfo where stuId=? and stuId=adminName";
		String sql2="select teachId,teachJob,adminPsw from login,teachersInfo where teachId=? and teachId=adminName";
		String  param[]={name};
		rs=sqlHelper.findExecute(sql, param);
		
		try
		{
			//从学生信息表中和登陆表中查询，若存在该用户名，则继续，
			if(rs.next())
			{
				
				if (rs.getString(3).trim().equals(psw))
				{
					//rs=sqlHelper.findExecute(sql, param);
					//rs.next();
					rs.first();
					job=rs.getString(2);
					
					return job;
				}
				else {
					job="pswError";
				}
			}
			//否则查询教师表和登陆表，
			else {
					rs=sqlHelper.findExecute(sql2, param);
					try
					{
						if(rs.next())
						{
							if (rs.getString(3).trim().equals(psw))
							{
	//							rs=sqlHelper.findExecute(sql2, param);
	//							rs.next();
								rs.first();
								job=rs.getString(2);
								return job;
							}
							else {
								job="pswError";
							}
						}
						else {
							job="";
					}
				} catch (SQLException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			sqlHelper.close();
		}
		
		return job;
	}
}
