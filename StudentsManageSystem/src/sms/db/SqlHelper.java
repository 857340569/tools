package sms.db;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class SqlHelper
{
	Connection cc;
	PreparedStatement ps;
	ResultSet rs;
	public SqlHelper()
	{
		try
		{
//			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//			cc=DriverManager.getConnection("jdbc:odbc:studentsMs","sa","123456");
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			cc=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=studentsMs","sa","123456");
		} catch (Exception e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	public void close()
	{
		try
		{
			if (rs!=null)
			{
				rs.close();
			}
			if (ps!=null)
			{
				ps.close();
			}
			if (cc!=null)
			{
				cc.close();
			}
		} catch (Exception e)
		{
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public ResultSet findExecute(String sql,String [] param)
	{
		if (param.length==0)
		{
			try
			{
				ps=cc.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
				rs=ps.executeQuery();
			} catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		else {
			try
			{
				ps=cc.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
				for (int i = 0; i < param.length; i++)
				{
					ps.setString(i+1, param[i]);
				}
				rs=ps.executeQuery();
			
			} catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return  rs;
	}
	public int updateExecute(String sql,String [] param)
	{
		int result=0;
		if (param.length==0)
		{
			try
			{
				ps=cc.prepareStatement(sql);
				result=ps.executeUpdate();
			} catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally
			{
				this.close();
			}
		}
		else {
			try
			{
				ps=cc.prepareStatement(sql);
				for (int i = 0; i < param.length; i++)
				{
					ps.setString(i+1, param[i]);
				}
				result=ps.executeUpdate();
			} catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally
			{
				this.close();
			}
		}
		return result;
	}
}
