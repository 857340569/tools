package com.zp.utils;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class EntityReflectUtils {
	/**
	 * 把实体对象属性及其值组装成参数map
	 * @param baseParamMap
	 * @param t
	 * @return
	 */
	public static <T> Map<String, String> setupParamsMapFromEntity(Map<String, String> baseParamMap,T t)
	{
		if(baseParamMap==null)
			baseParamMap=new HashMap<String, String>();
		Class<?> claz=t.getClass();
		Field[] fields=claz.getDeclaredFields();
		for(Field field:fields)
		{
			field.setAccessible(true);
			try{
				String fielName=field.getName();
				Object valObj=field.get(t);
				if(valObj!=null)
				{
					baseParamMap.put(fielName, valObj.toString());
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return baseParamMap;
	}
	public static void main(String[] args)  throws Exception{
		Student student=new Student("zs", 21);
		System.out.println(student);
		System.out.println(student.clone());
		Map<String, String> test=new HashMap<>();
		setupParamsMapFromEntity(test, student);
		System.out.println(test);
	}
	/**
	 * 实现了浅复制
	 * @author zjp
	 * @date 2016年9月6日
	 */
	static class Student implements Cloneable
	{
		@Override
		public Object clone() throws CloneNotSupportedException {
			return super.clone();
		}
		private String name;
		private int age;
		private String sex="man";
		private int money;
		
		public Student(String name, int age) {
			this.name = name;
			this.age = age;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}
		
	}
}
