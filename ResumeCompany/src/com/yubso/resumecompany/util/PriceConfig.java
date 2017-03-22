package com.yubso.resumecompany.util;

public class PriceConfig {
	private static PriceConfig priceConfig;
	private PriceConfig()
	{
		
	}
	public static PriceConfig newInstance(){
		if(priceConfig==null)
		{
			priceConfig=new PriceConfig();
		}
		return priceConfig;
	}
	/**
	 * 简历、个人
	 */
	private final int personalPrice=3;
	/**
	 * 动态
	 */
	private final int newsPrice=10;
	/**
	 * 活动
	 */
	private final int activityPrice=80;
	//电话招骋包月服务费
	private final int jobMonthPrice=30;
	
	private final int joinJijiehao=10;
	//直招企业默认增送米粒数量
	private final int comAccountDefault=100;
	//连锁企业默认增送米粒数量
	private final int hrRAccountDefault=100;
	
	//账户赠送到期时间
	private String activeExpiredDate="2015-04-01 23:59:59";
	
	public int getPersonalPrice() {
		return personalPrice;
	}
	public int getNewsPrice() {
		return newsPrice;
	}
	public int getActivityPrice() {
		return activityPrice;
	}
	public int getJobMonthPrice() {
		return jobMonthPrice;
	}
	public int getComAccountDefault() {
		return comAccountDefault;
	}
	public int getHrRAccountDefault() {
		return hrRAccountDefault;
	}
	//得到账户赠送到期时间
	public String getActiveExpiredDate() {
		return activeExpiredDate;
	}
	public void setActiveExpiredDate(String activeExpiredDate) {
		this.activeExpiredDate = activeExpiredDate;
	}
	public int getJoinJijiehao() {
		return joinJijiehao;
	}
	
}
