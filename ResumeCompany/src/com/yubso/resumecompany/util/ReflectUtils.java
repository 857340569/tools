package com.yubso.resumecompany.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.sql.ResultSet;
import java.util.Map;

public class ReflectUtils {

	/**
	 * 
	 * @param datas 以object 属性名字key,及其值为value的map
	 */
	public static  Object setField(Map<String, Object> datas,Object object) {
		try {
			object=Class.forName(object.getClass().getName()).newInstance();
			Class<?> clasz = object.getClass();
			
			Field[] allFields = clasz.getDeclaredFields();
			for (int i = 0; i < allFields.length; i++) {
				Field field = allFields[i];
				String fieldName = field.getName();
				//System.out.println("name "+fieldName +" value "+value);
				if(!datas.containsKey(fieldName))
				{
					continue;
				}
				Object value=datas.get(fieldName);
				field.setAccessible(true);
				field.set(object, value);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return object;
	}
	/**
	 * 通过sql 结果集对对象进行赋值
	 * @param rs 结果集
	 */
	public static Object setField(ResultSet rs,Object object)
	{
		try {
			object=Class.forName(object.getClass().getName()).newInstance();
			Class<?> clasz = object.getClass();
			
			Field[] allFields = clasz.getDeclaredFields();
			for (int i = 0; i < allFields.length; i++) {
				Field field = allFields[i];
				String fieldName = field.getName();
				Object value=rs.getString(fieldName);
//				Pattern p = Pattern.compile("^[-?|\\d+](.?[\\d+]|\\d?)$");
//				Matcher m = p.matcher("12431234");
//				boolean isNull = m.find();
//				System.out.println("value........."+value);
				if(value==null)
				{
					continue;
				}
				Type type=field.getGenericType();
				if(type.toString().equals("int"))
				{
					value=Integer.parseInt(value.toString());
				}
				field.setAccessible(true);
				field.set(object, value);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return object;
	}
	/**
	 *  得到object 不带包名的类名
	 * @param object
	 * @return
	 */
	public static String getOjectName(Object object)
	{
		Class<?> clasz = object.getClass();
		String classPack_name=clasz.getName();
		int lastDotIndex=classPack_name.lastIndexOf('.');
		return classPack_name.substring(lastDotIndex+1);
	}
	public static String getPartOfUpdateSql(Object object)
	{
		String partSql="";
		Class<?> clasz = object.getClass();
		try {
		Field[] allFields = clasz.getDeclaredFields();
		for (int i = 0; i < allFields.length; i++) {
			Field field = allFields[i];
			field.setAccessible(true); 
			String fieldName = field.getName();
			if(fieldName.equals("id")||fieldName.equals("deleteState"))
			{
				continue;
			}
			Object value=field.get(object);
			if(value==null||value.toString().equals(""))
			{
				continue;
			}
			partSql+=fieldName+" = '"+value+"',";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	return partSql.substring(0, partSql.lastIndexOf(','));
	}
	
	/**
	 * 获取更新后的持久化对象
	 * @param dataBefore 更新之前的数据
	 * @param dataAfter 更新之后的数据
	 * @return 最新数据
	 */
	public static <T> T getDataObj(T dataBefore,T dataAfter,String ...ignoreFieldNames){
		try{
			Field[] allFields = dataAfter.getClass().getDeclaredFields();
			for (Field field:allFields) {
				field.setAccessible(true); 
				String fieldName = field.getName();
				Object value=field.get(dataAfter);
				Method method=dataBefore.getClass().getMethod("set"+StringUtil.strFirstCharToUpCase(fieldName), field.getType());
				if(ignoreFieldNames!=null){
					boolean isIgnore=false; 
					for (int i = 0; i < ignoreFieldNames.length; i++) {
						String ignoreFieldName=ignoreFieldNames[i];
						if(fieldName.equals(ignoreFieldName))
						{
							method.invoke(dataBefore, value);
							isIgnore=true;
							break;
						}
					}
					if(isIgnore)
					{
						continue;
					}
				}
				if(value==null||value.toString().trim().equals(""))
				{
					continue;
				}
				method.invoke(dataBefore, value);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dataBefore;
		
	}
}