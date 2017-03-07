package com.zp.interfac;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class Test implements SuccessPeople {

	@Override
	public void say() {
		String chinese="最好的我们！";
		char chars[]=chinese.toCharArray();
		System.out.println(chars);
	}

	@Override
	public void song() {
	}
	public static void main(String[] args) {
		new Test().say();
		Integer integer1=Integer.valueOf(129);
		Integer integer2=Integer.valueOf(129);
//		System.out.println(getHexAddress(integer1));
//		System.out.println(getHexAddress(integer2));
		
//		ArrayList<String> strings=new ArrayList<>();
//		for (int i = 0; i < 20; i++) {
//			strings.add("test"+i);
//		}
//		ArrayList<String> temp=(ArrayList<String>) strings.clone();
//		strings.clear();
//		System.out.println(temp);
		System.out.println(CHARS);
		System.out.println(getHexAddress(new Student("zs")));
		
	}
	
	
	private static final StringBuilder S_BUILDER=new StringBuilder();
	private static final char[] CHARS;
	static
	{
		for (char c = 'a'; c <= 'z'; c++) {
			S_BUILDER.append(c);
		}
		S_BUILDER.append(S_BUILDER.toString().toUpperCase(Locale.getDefault()));
		for (int i = 0; i < 10; i++) {
			S_BUILDER.append(i);
		}
		CHARS=S_BUILDER.toString().toCharArray();
	}
	
	public static String getHexAddress(Object obj)
	{

		return obj.getClass().getName() + "@" + Integer.toHexString(obj.hashCode());
	}
}

interface Talker{
	void say();
}
interface Singer{
	void song();
	
}
interface SuccessPeople extends Talker,Singer{
	
}
class Student{
	public Student(String name)
	{
		this.name=name;
	}
	private String name;
	@Override
	public boolean equals(Object obj) {
		if(!(obj instanceof Student))
		{
			return false;
		}
		Student stu=(Student)obj;
		
		return false;
	}
	
}