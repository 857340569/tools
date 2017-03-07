package com.zp.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class JsonTools {
	
	private static Gson gson;
	static {
		gson = new GsonBuilder().create();
	}
	/**
	 * 根据key转换json中包含的实体对象
	 * 
	 * @param t
	 *            实体对象类型
	 * @param json
	 * @param key
	 * @return
	 */
	public static <T> T getEntity(Class<T> tOfClass, String json) {
		JsonParser jsonParser = new JsonParser();
		JsonElement jsonElement = jsonParser.parse(json);
		try{
			if(jsonElement.isJsonObject())
			{
				T tInstance=tOfClass.newInstance();
			}else {
				return null;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	private static StringBuilder sBuilder=new StringBuilder();
	public static void test(String json)
	{
		JsonParser jsonParser = new JsonParser();
		JsonElement jsonElement = jsonParser.parse(json);
		if(jsonElement.isJsonPrimitive()||jsonElement.isJsonNull())
		{
			
			JsonObject jObject=jsonElement.getAsJsonObject();
//			sBuilder.append("    private String "+jObject.get+";\n");
		}
		
	}
}
