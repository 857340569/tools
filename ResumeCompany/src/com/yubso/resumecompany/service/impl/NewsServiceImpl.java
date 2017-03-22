package com.yubso.resumecompany.service.impl;

import com.yubso.resumecompany.dao.NewsDao;
import com.yubso.resumecompany.dao.impl.NewsDaoImpl;
import com.yubso.resumecompany.entity.News;
import com.yubso.resumecompany.entity.News.ComType;
import com.yubso.resumecompany.service.NewsService;
import com.yubso.resumecompany.util.DivPageUtil;

public class NewsServiceImpl implements NewsService {
	private NewsDao newsDao;
	public NewsServiceImpl()
	{
		newsDao=new NewsDaoImpl();
	}
	@Override
	public boolean addNews(News news) {
		return newsDao.addNews(news);
	}

	@Override
	public News queryNewsById(int id) {
		return newsDao.queryNewsById(id);
	}

	@Override
	public DivPageUtil queryDivNewsByComIdType(int comId, ComType comType,
			int currentPage, int pageSize) {
		return newsDao.queryDivNewsByComIdType(comId, comType, currentPage, pageSize);
	}
	@Override
	public boolean deleteNewsById(int id) {
		return newsDao.deleteNewsById(id);
	}
	@Override
	public boolean updateNewsById(News news,int id,String ...ignore) {
		return newsDao.updateNewsById(news,id,ignore);
	}

}
