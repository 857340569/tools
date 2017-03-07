package com.zp.test2;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.zp.utils.DateUtils;


public class Test {

	public static void main(String[] args) {
//		Student stu1=new Student("张三", "nan");
//		Student stu2=new Student("ss", "");
//		System.out.println(stu1);
//		System.out.println(stu2);
//		System.out.println(ObjUtils.getFieldValCopy(stu1, stu2));
		System.out.println(UUID.randomUUID().toString());
		String str1="2015-6-12",str2="2015-5-14";
		System.out.println(compareStrGreater(str1, str2));
		for(char c='a';c<='z';c++)
		{
			System.out.print(c);
		}
//		String[] tem=getArry("AABBAABBAA","AA");
//		System.out.println(tem);
		List<Integer> integers=new ArrayList<Integer>();
		integers.add(1);
		integers.add(1);
		integers.add(1);
		integers.add(1);
		integers.add(1);
		Integer[] arr=  integers.toArray(new Integer[]{});
		
		System.out.println(arr);
		float total=872.42f;
		int startMonth=6;
		DecimalFormat decimalFormat=new DecimalFormat(".00");
		while(total>=0)
		{
			if(startMonth>12)
			{
				System.out.println("2017年"+(startMonth-12)+"月份余额:"+decimalFormat.format(total)+"元");
			}else
			{
				System.out.println("2016年"+startMonth+"月份余额:"+decimalFormat.format(total)+"元");
			}
			total-=58;
			startMonth++;
			
		}
		System.out.println(DateUtils.getDayOfWeek("2016-9-11"));
		System.out.println( String.format("%02d",7));
	}
	
	public static String[] getArry(String strs,String prix)
	{
		List<String> strings=new ArrayList<>();
		String[] arr=strs.split(prix);
		for(int i=0;i<arr.length;i++)
		{
			strings.add(arr[i]);
			if(i<arr.length-1||(i==arr.length-1&&strs.endsWith(prix)))
				strings.add(prix);
		}
		return strings.toArray(new String[]{});
	}
	
	private static void newStu(Student stu)
	{
		stu=new Student("henanan", "woman");
	}
	private static void changeStu(Student stu)
	{
		stu.setName("nannan");
	}
	private static String getHexStr(String cardId)
	{
		
		int len=cardId.length();
		String out="";
		for (int i = len-2; i >= 0; i-=2) {
			out+=cardId.substring(i, i+2);
			System.out.println(out);
		}
		return out;
	}
	public static boolean compareStrGreater(String str1,String str2)
	{
		int length=str1.length()<str2.length()?str1.length():str2.length();
		for (int i = 0; i < length; i++) {
			if(str1.charAt(i)>str2.charAt(i))
			{
				return true;
			}
		}
		return false;
	}
}
 class Student extends MyCloneable{
	String name;
	String sex;
	
	public Student(String name, String sex) {
		super();
		this.name = name;
		this.sex = sex;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	@Override
	public String toString() {
		return "Student [name=" + name + ", sex=" + sex + "]";
	}
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
	
}