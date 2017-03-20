package cenmengqi.model;


import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.swing.plaf.basic.BasicSliderUI.ScrollListener;

import org.omg.CORBA.PRIVATE_MEMBER;

import cenmengqi.bean.User;
import cenmengqi.db.SqlHelper;
import cenmengqi.utils.StringUtils;

public class UserDao {
	
	public final static boolean DEBUG=true;
	
	public static List<User> getAllUsers()
	{
		List<User> users=new ArrayList<>();
		try {
			String sql="select * from user";
			SqlHelper helper=new SqlHelper();
			ResultSet set=helper.findExecute(sql, null);
			while(set.next())
			{
				User user=new User();
//				user.setName(set.getString("name"));
//				user.setDepartment(set.getString("department"));
//				user.setEducation(set.getString("education"));
//				user.setNativePlace(set.getString("nativePlace"));
//				user.setNumber(set.getString("number"));
//				user.setSex(set.getString("sex"));
				SqlHelper.getBeanFromDb(user,set);
				users.add(user);
			}
		} catch (Exception e) {
		}
		return users;
	}
	public static List<User> queryUsers(String name)
	{
		if(StringUtils.isEmpty(name))
		{
			return getAllUsers();
		}
		List<User> users=new ArrayList<>();
		try {
			String sql="select * from user where name like ?";
			SqlHelper helper=new SqlHelper();
			ResultSet set=helper.findExecute(sql,new String[]{"%"+name+"%"});//自动添加单引号 （包装后的参数） 
			while(set.next())
			{
				User user=new User();
				SqlHelper.getBeanFromDb(user,set);
				users.add(user);
			}
		} catch (Exception e) {
		}
		return users;
	}
	/**
	 * 根据编号查询员工信息
	 * @param number
	 * @return
	 */
	public static User queryUserByNumber(String number)
	{
		if(StringUtils.isEmpty(number))
		{
			return null;
		}
		try {
			String sql="select * from user where number=?";
			SqlHelper helper=new SqlHelper();
			ResultSet set=helper.findExecute(sql,new String[]{number});//自动添加单引号 （包装后的参数） 
			if(set.next())
			{
				User user=new User();
				SqlHelper.getBeanFromDb(user,set);
				return user;
			}
		} catch (Exception e) {
		}
		return null;
	}
	
	public static boolean deleteUser(User user)
	{
		if(user==null)return false;
		try {
			String sql="delete from user where id=?";
			SqlHelper helper=new SqlHelper();
			//result　表示执行成功的条数，大于零说明执行成功
			int result=helper.updateExecute(sql,new String[]{user.getId()+""});
			return result>0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static boolean addUser(User user)
	{
		if(user==null)return false;
		try {
			String sql="insert into user(number,pwd,name,sex,department,education,nativePlace,userType) values(?,?,?,?,?,?,?,?)";
			SqlHelper helper=new SqlHelper();
			String[] values=new String[]{user.getNumber(),user.getPwd(),user.getName(),user.getSex(),user.getDepartment(),user.getEducation(),user.getNativePlace(),user.getUserType()};
			//result　表示执行成功的条数，大于零说明执行成功
			int result=helper.updateExecute(sql,values);
			return result>0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public static boolean updateUser(User user)
	{
		if(user==null)return false;
		try {
			String sql="update user set pwd=?,name=?,sex=?,department=?,education=?,nativePlace=? where id=?";
			SqlHelper helper=new SqlHelper();
			String[] values=new String[]{user.getPwd(),user.getName(),user.getSex(),user.getDepartment(),user.getEducation(),user.getNativePlace(),user.getId()+""};
			//result　表示执行成功的条数，大于零说明执行成功
			int result=helper.updateExecute(sql,values);
			return result>0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
