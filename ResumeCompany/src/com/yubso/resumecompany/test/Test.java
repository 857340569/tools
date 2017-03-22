package com.yubso.resumecompany.test;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Random;

import junit.framework.TestCase;

import com.yubso.push.android.AndroidGroupcast;
import com.yubso.resumecompany.dao.impl.JobDaoImpl;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.Job;
import com.yubso.resumecompany.entity.PaymentOrder;
import com.yubso.resumecompany.entity.PaymentRecord;
import com.yubso.resumecompany.util.BaiduMapUtil;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.SQLHelper.ExecuteType;
import com.yubso.resumecompany.util.StringUtil;

public class Test extends TestCase{
	public void add(){
		
		String out_trade_no="4455550";
		PaymentOrder paymentOrder=SQLHelper.queryEntityByConditions(PaymentOrder.class, "traceNo='"+out_trade_no+"'");
		if(paymentOrder!=null)
		{
			//创建购买记录
			PaymentRecord paymentRecord=new PaymentRecord();
			paymentRecord.setBuyerId(paymentOrder.getBuyerId());
			paymentRecord.setBuyerType(1);
			paymentRecord.setGoodsName(paymentOrder.getGoodsName());
			paymentRecord.setMoney(paymentOrder.getTotalMoney());
			paymentRecord.setPayNum(paymentOrder.getTotalNum());
			paymentRecord.setBoughtDate(DateUtil.getNowDateStr(""));
			paymentRecord.setTraceNo(out_trade_no);
			//改变订单状态
			paymentOrder.setTraceStatus(1);
			//更新买家账户
			Company company=SQLHelper.queryEntityByConditions(Company.class, "id="+paymentOrder.getBuyerId()+"");
			int accout=company.getAccountBalance()+paymentOrder.getTotalNum();
			company.setAccountBalance(accout);
			SQLHelper.updateByTransation(new int[]{ExecuteType.UPDATE.ordinal(),ExecuteType.UPDATE.ordinal(),ExecuteType.ADD.ordinal()}, new String[]{"","",""},paymentOrder,company,paymentRecord);
		
		}
	}
	
	public void test(){
//		String dateStr="2014-08-11";
////		System.out.println(DateUtil.getAgeByBirthday(dateStr));
//		System.out.println(new Date().getTime());
//		String path = ServletActionContext.getServletContext().getRealPath(
//				"abc.png");
//		System.out.println(path);
		new JobDaoImpl().deleteJobByIds(new String[]{"1"});
	}
	public void test2() throws Exception{
		
//		test3(null);
//		System.out.println(DigestUtils.md5Hex("zjp123"));
//		Session session = HibernateSessionFactory.getSession();
//		Transaction tx = null;
//		tx = session.beginTransaction();
//		String hql="from User u,Resume r where (r.hopeJob like '%操作工%' or r.hopeJob like '%服务员%' or r.hopeJob like '%快递员%') and r.uid=u.id order by u.updateTime desc";
//		Query query=session.createQuery(hql);
//		List list=query.list();
//		for(int j=0;j<list.size();j++)
//		{
//			 Object[] obj=(Object[]) list.get(j);
//			 for(int i=0;i<obj.length;i++)
//			 {	
//				 System.out.println(obj[i].getClass().getName());
//			 }
//		}
		String whereSql="  sddsdssd   ";
		System.out.println("aaaa"+whereSql+"abbbb");
		StringUtil.checkIsNotNull(whereSql);
		System.out.println("aaaa"+whereSql+"abbbb");
		
	}
	public void test3() throws Exception
	{
//		for(String str:strs)
//		{
//			System.out.println("str:"+str);
		
//		}
		for (int i = 0; i < 1000000000; i++) {
			String code=getCode(6);
			System.out.println(code);
			if(code.equals("000000"))
			{
				System.out.println("over"+i);
				break;
			}
		
			try {
//				Thread.sleep(300);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		
	}
	public String getCode(int count)
	{
		String code="";
		for(int i=1;i<=count;i++)
		{
			code+=new Random().nextInt(10);
		}
		return code;
	}
	public void test5(){
//		News news=new News();
//		System.out.println(news.getSrcType());
//		news.setSrcType(1);
//		System.out.println(news.getSrcType());
		String startTime=DateUtil.getNowDateStr("HH:mm:ss");
		System.out.println(startTime.replaceAll(":", ""));
	}
	public void testCalendar()
	{
		Calendar calendar=Calendar.getInstance();
		System.out.println(DateUtil.formatDate(calendar.getTime()));
		System.out.println(calendar.get(Calendar.MONTH));
		calendar.set(Calendar.MONTH,calendar.get(Calendar.MONTH));
		System.out.println(DateUtil.formatDate(calendar.getTime()));
		calendar=Calendar.getInstance();
		System.out.println(DateUtil.formatDate(calendar.getTime()));
	}
	public void testStrIsNumber()
	{
		String isNumberTest="-1";
//		boolean isNumber=StringUtil.isNumber(isNumberTest);
		boolean isNumber=org.apache.commons.lang.math.NumberUtils.isNumber(null);
		//org.apache.commons.lang.math.NumberUtils.isNumber(isNumberTest);NumberUtils.isNumber(isNumberTest);//StringUtil.regMaches(StringUtil.NUM_REGEX, isNumberTest);
		System.out.println(isNumber);
	}
	public void testIntegerNull()
	{
		System.out.println(StringUtil.translateDiscountToCN(0.85));
	}
	public void testPush()
	{
		new AndroidGroupcast("zhang","test","123");
	}
	public void testGetLatLng()
	{
		Map<String, String> point=BaiduMapUtil.getGeocoderLatitude("郑州市");
		System.out.println(point);
		System.out.println(point.get("lat"));
		System.out.println(point.get("lng"));
		
	}
	public void testLink(){
		List<Job> jobs=new ArrayList<Job>();
		Job job=new Job();
		job.setCategory("操作员");
		jobs.add(job);
		job=new Job();
		job.setCategory("技工");
		jobs.add(job);
		System.out.println("beforeChangeData");
		for (int i = 0; i < jobs.size(); i++) {
			System.out.println(jobs.get(i).getCategory());
		}
		System.out.println("startChangeData");
		for (int i = 0; i < jobs.size(); i++) {
			Job jobtempJob=jobs.get(i);
			jobtempJob.setCategory("其它职位"+i);
		}
		System.out.println("afterChangeData");
		for (int i = 0; i < jobs.size(); i++) {
			System.out.println(jobs.get(i).getCategory());
		}
	}
	
}
