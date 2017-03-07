package com.zjp.dtdbills.db;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface SqlFieldType {
	
	//数据库常用类型
	public enum FieldType
	{
		INTEGER,DOUBLE,FLOAT,VARCHAR,NVARCHAR
	}
	FieldType value();
	int length() default -1;
	boolean isPrimaryKey() default false;
}
