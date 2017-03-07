package com.zjp.dtdbills.db;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class Test {
	public static void main(String[] args) {
		int a=5;
		byte b=5;
//		a=b;
		byte[] a1=new byte[]{0x11,0x22,127};
		byte[] a2=a1;
		System.out.println(a1);
		System.out.println(a2[2]);
		byte[] a3=a1.clone();
		a3[2]=0x6A;
		String c=String.valueOf(a3[2])+2+3;
		System.out.println(c);
		System.out.println(Integer.parseInt("6A", 16));
		int[] datas=new int[]{0x55,0x01,0x11,0x00,0x00,0x00,0x01,0x68};
		String str="";
		for(int hex:datas)
		{
			str+=hex;
		}
		System.out.println(str);
	}
}
