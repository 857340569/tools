package com.zjp.clone;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

public class TestRefect {
	public static void main(String[] args) throws NoSuchMethodException, SecurityException, InstantiationException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		try {
			Constructor<Student> student=Student.class.getConstructor(String.class);
			//student.setAccessible(true);
			student.newInstance("123").show();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
