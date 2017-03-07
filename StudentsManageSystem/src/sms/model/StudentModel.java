package sms.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.swing.table.AbstractTableModel;

import sms.db.SqlHelper;

public class StudentModel extends AbstractTableModel
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	SqlHelper sqlHelper;
	Vector<Vector<String>> rowData;
	Vector<String> columnName;
	public StudentModel()
	{
		sqlHelper=new SqlHelper();
	}
	public Students showAllInfo(String stuId)
	{
		Students students=null;
		String sql="select * from studentsInfo where stuId=?";
		String [] param={stuId};
		
		ResultSet rs=sqlHelper.findExecute(sql, param);
		try
		{
			if (rs.next())
			{
				students=new Students(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8));
			}
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			sqlHelper.close();
		}
		return students;
	}
	public int updateStuInfo(Students student)
	{
		int result=0;
		String sql="update studentsInfo set stuName=?,stuSex=?,stuBirth=?,stuGrade=?,stuDept=?,stuJob=?,stuPL=? where stuId=?";
		String param[]={student.getStuName(),student.getStuSex(),student.getStuBirth(),student.getStuGrade(),student.getStuDept(),student.getStuJob(),student.getStuPL(),student.getStuId()};
		result=sqlHelper.updateExecute(sql, param);

		return result;
	}
	public boolean deleteById(String id)
	{
		boolean result=true;
		String sql="delete from studentsInfo where studentsInfo.stuId=? delete from studentsScore where studentsScore.stuId=? delete from login where adminName=?";
		String param[]={id,id,id};
		int i=sqlHelper.updateExecute(sql, param);
		if (i==0)
		{
			result=false;
		}
		return result;
	}
	public boolean getScore(String year,String term,String isPass,String stuId)
	{
		boolean result=true;
		columnName=new Vector<String>();
		String name[]={"学号","姓名","课程编号","课程名称","学年","学期","成绩","是否通过"};
		for (int i = 0; i < name.length; i++)
		{
			columnName.add(name[i]);
		}
		String sql="";
		ResultSet rs=null;
		
		if (year.equals("")&&term.equals("")&&isPass.equals("")&&stuId.equals(""))
		{
			sql="select stuScore.stuId,stu.stuName,stuScore.subId,sub.subName,stuScore.acadYear,stuScore.term,stuScore.score,stuScore.isPass from studentsInfo as stu,studentsScore as stuScore,subjects as sub where stu.stuId=stuScore.stuId and sub.subId=stuScore.subId order by stuScore.term desc";
			String param[]={};
			rs=sqlHelper.findExecute(sql, param);
			
		}
		else if(year.equals("")&&term.equals("")&&isPass.equals(""))
		{	
			sql="select stuScore.stuId,stu.stuName,stuScore.subId,sub.subName,stuScore.acadYear,stuScore.term,stuScore.score,stuScore.isPass from studentsInfo as stu,studentsScore as stuScore,subjects as sub where (stu.stuName=? or stu.stuId=?) and stu.stuId=stuScore.stuId and sub.subId=stuScore.subId order by stuScore.term desc";
			String param[]={stuId,stuId};
			rs=sqlHelper.findExecute(sql, param);
		
		}
		else if(term.equals("")&&isPass.equals(""))
			{
			sql="select stuScore.stuId,stu.stuName,stuScore.subId,sub.subName,stuScore.acadYear,stuScore.term,stuScore.score,stuScore.isPass from studentsInfo as stu,studentsScore as stuScore,subjects as sub where stuScore.acadYear=? and stu.stuId=? and stu.stuId=stuScore.stuId and sub.subId=stuScore.subId order by stuScore.term desc";
			String param[]={year,stuId};
			rs=sqlHelper.findExecute(sql, param);
			
			}
			else if(isPass.equals(""))
			{
				
				sql="select stuScore.stuId,stu.stuName,stuScore.subId,sub.subName,stuScore.acadYear,stuScore.term,stuScore.score,stuScore.isPass from studentsInfo as stu,studentsScore as stuScore,subjects as sub where stuScore.acadYear=?  and stuScore.term=? and stu.stuId=? and stu.stuId=stuScore.stuId and sub.subId=stuScore.subId order by stuScore.term desc";
				String param[]={year,term,stuId};
				rs=sqlHelper.findExecute(sql, param);
			}else if (year.equals("")&&term.equals(""))
			{
				
				sql="select stuScore.stuId,stu.stuName,stuScore.subId,sub.subName,stuScore.acadYear,stuScore.term,stuScore.score,stuScore.isPass from studentsInfo as stu,studentsScore as stuScore,subjects as sub where stuScore.isPass=? and stu.stuId=?  and stu.stuId=stuScore.stuId and sub.subId=stuScore.subId order by stuScore.term desc";
				String param[]={isPass,stuId};
				rs=sqlHelper.findExecute(sql, param);
			}
			
				
			
		
		try
		{
			//result=rs1.next();
			rowData=new Vector<Vector<String>>();
			while(rs.next())
			{
				Vector<String> hangData=new Vector<String>();
				hangData.add(rs.getString(1));
				hangData.add(rs.getString(2));
				hangData.add(rs.getString(3));
				hangData.add(rs.getString(4));
				hangData.add(rs.getString(5));
				hangData.add(rs.getString(6));
				hangData.add(rs.getString(7));
				hangData.add(rs.getString(8));
				rowData.add(hangData);
			}
//			rs.setFetchDirection(ResultSet.FETCH_REVERSE);
			result= rs.first();
//			System.out.println(rs.isBeforeFirst());
			//result=rs1.next();
			//System.out.println(rs.getType());
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return result;
	}
	public void findByIdOrName(String input)
	{
		columnName=new Vector<String>();
		String name[]={"学号","姓名","性别","出生日期","年级","系部","职务","政治面貌"};
		for (int i = 0; i < name.length; i++)
		{
			columnName.add(name[i]);
		}
		String sql="";
		ResultSet rs=null;
		if(input.equals(""))
		{
			sql="select * from studentsInfo";
			String param[]={};
			rs=sqlHelper.findExecute(sql, param);
		}
		else {
			sql="select * from studentsInfo where stuId=? or stuName=? ";
			String param[]={input,input};
			rs=sqlHelper.findExecute(sql, param);
		}
		rowData=new Vector<Vector<String>>();
		try
		{
			while (rs.next())
			{
				Vector<String> temp=new Vector<String>();
				temp.add(rs.getString(1));
				temp.add(rs.getString(2));
				temp.add(rs.getString(3));
				temp.add(rs.getString(4).substring(0, 10));
				temp.add(rs.getString(5));
				temp.add(rs.getString(6));
				temp.add(rs.getString(7));
				temp.add(rs.getString(8));
				rowData.add(temp);
			}
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
			
		
	}
	@Override
	public int getRowCount()
	{
		// TODO Auto-generated method stub
		return this.rowData.size();
	}
	@Override
	public int getColumnCount()
	{
		// TODO Auto-generated method stub
		return columnName.size();
	}
	@Override
	public Object getValueAt(int rowIndex, int columnIndex)
	{
		// TODO Auto-generated method stub
		return ((Vector<String>)rowData.get(rowIndex)).get(columnIndex);
	}
	
	@Override
	public String getColumnName(int column)
	{
		// TODO Auto-generated method stub
		return columnName.get(column);
	}
}
