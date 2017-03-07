package com.zjp.dtdbills.db;

import java.lang.reflect.Field;

import com.zjp.dtdbills.db.SqlFieldType.FieldType;

import zp.baseandroid.common.utils.StringUtils;

public class SqlHelper {
	/**
	 * 
	 * @param clasz
	 * @param tableName
	 * @return
	 */
	public static <T> String createTableSqlFromEntity(Class<T> clasz,String tableName)
	{
		String sql="";
		if(StringUtils.isEmpty(tableName))
		{
			tableName=clasz.getSimpleName();
		}
		sql="create table if not exists "+tableName+"(";
		Field[] fields=clasz.getDeclaredFields();
		for (Field field:fields) {
			field.setAccessible(true);
			SqlFieldType sqlFieldType=field.getAnnotation(SqlFieldType.class);
			if(sqlFieldType!=null)
			{
				FieldType fieldType=sqlFieldType.value();
				int length=sqlFieldType.length();
				boolean isPrimaryKey=sqlFieldType.isPrimaryKey();
				
				sql+=field.getName()+" "+fieldType.name().toLowerCase();
				if(length>0)
				{
					sql+="("+length+")";
				}
				if(isPrimaryKey)
				{
					sql+=" primary key autoincrement";
				}
				sql+=",";
			}
		}
		
		return StringUtils.trimEnd(sql, ",")+")";
	}
}
