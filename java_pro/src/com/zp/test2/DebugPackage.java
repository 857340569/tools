package com.zp.test2;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.Expose;

import zp.baseandroid.common.utils.DateUtils;

/**
 * 日志内容包
 * @author zjp
 * @date 2016年6月28日
 */
public class DebugPackage {
	static
	{
		System.out.println("DebugPackage.LogLevel.enclosing_method()");
	}
	public static String getStr(){return "";};
	public enum LogLevel {
		LOG_TRACE, LOG_INFO, LOG_DEBUG, LOG_ERROR;
	}
	//注意，没有被 @Expose 标注的字段会被排除
	private static int index;
	private String dateFormatPattern="HH:mm:ss SSS";
	
	@Expose
	private String LogIndex;//索引，每次调用自身加1
	@Expose
	private String LogDateTime;//日期 HH:mm:ss zzz
	@Expose
	private String LogInfo;//日志内容
	@Expose
	private String LogSource;//日志来源:[ip]+softName
	@Expose
	private String LogLevel;//日志类型
	public DebugPackage(String logInfo, String logSource, LogLevel logLevel) {
		index++;
		LogIndex=String.valueOf(index);
		LogDateTime = DateUtils.getNowTimeStr(dateFormatPattern);
		LogInfo = logInfo;
		LogSource = logSource;
		LogLevel = String.valueOf(logLevel.ordinal());
	}
	@Override
	public String toString() {
		Gson gson=new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
		String result=gson.toJson(this);
		return result;
	}
	
}
