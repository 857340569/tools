package com.yubso.resumecompany.action;

import java.io.Serializable;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.entity.ExpenseRecord;
import com.yubso.resumecompany.entity.HumanResource;
import com.yubso.resumecompany.entity.News;
import com.yubso.resumecompany.entity.News.AuditStatus;
import com.yubso.resumecompany.entity.News.SrcType;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.service.NewsService;
import com.yubso.resumecompany.service.impl.CompanyServiceImpl;
import com.yubso.resumecompany.service.impl.NewsServiceImpl;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.SQLHelper.ExecuteType;

public class NewsAction extends BaseAction {
	private NewsService newsService;
	private News news;
	private CompanyService companyService;
	private Company company;
	private HumanResource hr;
	private ExpenseRecord expenseRecord;
	public NewsAction()
	{
		newsService=new NewsServiceImpl();
	}
	public String toAddPage() throws Exception
	{
		return "toAddPage";
	}
	public String addNews() throws Exception{
		message="动态信息添加失败,请稍后重试!";
		int comId=getComId();
		ComType comType=getCompanyType();
		String exeTime=DateUtil.getNowDateStr(null);
		/*
		Serializable saveObj;
		int price=priceConfig.getNewsPrice();
		int countRel=0;
		int idTemp=0;
		if(comType.ordinal()==ComType.COMPANY.ordinal())
		{
			companyService=new CompanyServiceImpl();
			company=companyService.querCompanyById(comId);
			countRel=company.getAccountBalance()-price;
			company.setAccountBalance(countRel);
			saveObj=company;
			idTemp=company.getId();
		}else if(comType.ordinal()==ComType.HR.ordinal())
		{
			hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+getComId());
			countRel=hr.getPayAccount()-price;
			hr.setPayAccount(countRel);
			saveObj=hr;
			idTemp=hr.getId();
		}else {
			return baseTryToLogin();
		}
		if(countRel<0)
		{
			message="账户余额不足，动态信息发布失败,请充值后重试!";
			return baseShowResult();
		}
		if(news!=null)
		{
			//消费记录
			ExpenseRecord expenseRecord=new ExpenseRecord();
			expenseRecord.setBuyerId(comId);
			expenseRecord.setBuyerType(comType.ordinal());
			expenseRecord.setGoodsName("发布动态信息");
			expenseRecord.setPayNum(price);
			expenseRecord.setPayDate(exeTime);
			news.setSrcType(SrcType.TEXT.ordinal());
			news.setAuditStatus(AuditStatus.AUDITING.ordinal());
			news.setComId(comId);
			news.setComType(comType.ordinal());
			news.setPublishTime(exeTime);
			news.setRefreshTime(exeTime);
			if(news.getSrcType()==SrcType.URL.ordinal())
			{
				String urlContent=news.getContent1();
				if(!urlContent.startsWith("http://"))
				{
					urlContent="http://"+urlContent;
					news.setContent1(urlContent);
				}
			}
			boolean addResult=SQLHelper.updateByTransation(new int[]{ExecuteType.ADD.ordinal(),ExecuteType.ADD.ordinal(),ExecuteType.UPDATE.ordinal()},new String[]{"","","id="+idTemp},expenseRecord,news,saveObj);
			if(addResult)
			{
				message="恭喜你，动态信息发布成功,请耐心等待系统申核!";
			}
		}*/
		news.setSrcType(SrcType.TEXT.ordinal());
		news.setAuditStatus(AuditStatus.AUDITING.ordinal());
		news.setComId(comId);
		news.setComType(comType.ordinal());
		news.setPublishTime(exeTime);
		news.setRefreshTime(exeTime);
		if(news.getSrcType()==SrcType.URL.ordinal())
		{
			String urlContent=news.getContent1();
			if(!urlContent.startsWith("http://"))
			{
				urlContent="http://"+urlContent;
				news.setContent1(urlContent);
			}
		}
		boolean addResult=SQLHelper.addEntity(news);
		if(addResult)
		{
			message="恭喜你，动态信息发布成功,请耐心等待系统申核!";
		}
		return baseShowResult();
	}
	public String deleteNewsById() throws Exception{
		message="动态信息删除失败,请稍后重试!";
		if(news!=null&&news.getId()!=null)
		{
			boolean delResult=newsService.deleteNewsById(news.getId());
			if(delResult)
			{
				message="恭喜你，动态信息删除成功!";
			}
			return baseShowResult();
		}
		return baseShowParamError();
	}
	public String updateNews() throws Exception{
		message="动态信息更新失败,请稍后重试!";
		if(news!=null&&news.getId()!=null)
		{
			boolean delResult=newsService.updateNewsById(news, news.getId(),"image1","image2","image3");
			if(delResult)
			{
				message="恭喜你，动态信息更新成功!";
			}
			return baseShowResult();
		}
		return baseShowParamError();
	}
	public String queryAllNews() throws Exception{
		pageSize=15;
		divPage=newsService.queryDivNewsByComIdType(getComId(), com.yubso.resumecompany.entity.News.ComType.values()[getCompanyType().ordinal()], currentPage, pageSize);
		return "allNews";
	}
	public String queryNewsById() throws Exception{
		if(news!=null&&news.getId()!=null)
		{
			news=newsService.queryNewsById(news.getId());
			if("find".equals(type))
			{
				return "newsDetail";
			}else if("toEdit".equals(type))
			{
				return "editNews";
			}
		}
		return baseShowParamError();
	}
	public News getNews() {
		return news;
	}
	public void setNews(News news) {
		this.news = news;
	}
	
}
