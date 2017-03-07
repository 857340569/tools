package com.zp.test2;

import com.zp.test2.DebugPackage.LogLevel;

public class TestStatic {
	public static void main(String[] args) {
		test("12");
		test("123");
		test("12354");
	}
	public static  void test (String a)
	{
		String zero="00000";
	    String str = String.format("%5s", a);  
		System.out.println(str);
	}
}
