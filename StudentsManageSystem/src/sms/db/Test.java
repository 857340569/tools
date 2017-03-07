package sms.db;

public class Test
{

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		// TODO Auto-generated method stub
		
		String name="888";
		String password="666";
		SqlHelper sqlHelper=new SqlHelper();
		String sql="insert into login values('"+name+"','"+password+"')";
		String[] param = {};
		sqlHelper.updateExecute(sql, param);
		System.out.println("ok");
		
		String o="";
		new Test().test(o);
	}
	public void test(Object o)
	{
		System.out.println(o);
	}
	public void test(String a)
	{
		
	}
}
