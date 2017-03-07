package com.zp.tools;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.zp.tools.JsonCheck.JSON_TYPE;
/**
 * 自动生成entity 文件，只支持jsonobject
 * @author zhang
 * @date 2015-7-13
 */
public class AutoEntityFile {
	public static void createFileFromJson(String json,String className)
	{
		createFileFromJson(json, className,null);
	}
	public static void createFileFromJson(String json,String className,String packName)
	{
		System.out.println(json);
		if(StringUtils.isEmpty(json))return;
		JSON_TYPE jsonType= JsonCheck.getJSONType(json);
		System.out.println(jsonType);
		String entityContent="";
		if(!StringUtils.isEmpty(packName))
		{
			entityContent+=packName.startsWith("package")?packName:"package "+packName;
			entityContent+=";\n";
		}
		className=StringUtils.isEmpty(className)?"EntityClass":className;
		entityContent+="public class "+className+"{\n";
		List<String> keys=new ArrayList<String>();
		if(jsonType==JSON_TYPE.JSON_TYPE_OBJECT)
		{
			JsonObject jsonObject=new JsonParser().parse(json).getAsJsonObject();
			Set<Entry<String, JsonElement>>	fieldSet=jsonObject.entrySet();
			Iterator<Entry<String, JsonElement>> iterator= fieldSet.iterator();
			while (iterator.hasNext()) {
				Entry<String, JsonElement> entry = iterator.next();
				String key=entry.getKey();
				JsonElement element=entry.getValue();
				if(element.isJsonPrimitive()||element.isJsonNull())
				{
					keys.add(key);
					entityContent+="    private String "+key+";\n";
				}
			}
		}
		entityContent+="\n";
		for(String fieldName:keys)
		{
			entityContent+="    public void set"+(fieldName.charAt(0)+"").toUpperCase()+fieldName.substring(1)+"(String "+fieldName+"){\n";
			entityContent+="        this."+fieldName+"="+fieldName+";\n    }\n";
			entityContent+="\n";
			entityContent+="    public String get"+(fieldName.charAt(0)+"").toUpperCase()+fieldName.substring(1)+"(){\n";
			entityContent+="        return "+fieldName+";\n    }\n";
		}
		entityContent+="}";
		File file=new File(className+".java");
		try {
			if(!file.exists())
			{
				file.createNewFile();
			}
			FileOutputStream fileOutputStream=new FileOutputStream(file);
			fileOutputStream.write(entityContent.getBytes());
			fileOutputStream.flush();
			fileOutputStream.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
