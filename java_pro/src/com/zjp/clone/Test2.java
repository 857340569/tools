package com.zjp.clone;

import zp.baseandroid.common.utils.StringUtils;

public class Test2 {
	static int a=1;
	static int b=1;
	static {
		System.out.println("Test2.enclosing_method()");
		A.print("1:"+a);
		A.print("1:"+a);
	}
	static class A{
		static void print(String number)
		{
//			System.out.println(number);
		}
		static {
			a=a+b;
			System.out.println("Test2.A.enclosing_method()");
			print("2:"+a);
		}
	}
	public static void main(String[] args) {
//		System.out.println("Test2.main()");
//		A.print("3:"+b);
		//必须以字母开头，6-20位，可以是字母、数字、下划线的组合
		String userNameEx="^[A-Za-z][A-Za-z\\d_]{5,19}$";
		//请输入6-18个字符，可使用字母、数字和符号的组合。
		String pwd="^[^\\s\\u4e00-\\u9fa5]{6,18}$";
		String userName="zjp12";
		System.out.println(StringUtils.matches(userNameEx, userName));
		System.out.println(StringUtils.matches(pwd, "a!@##@$sda123"));
	}
}
