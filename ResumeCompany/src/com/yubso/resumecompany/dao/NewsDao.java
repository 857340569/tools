package com.yubso.resumecompany.dao;

import com.yubso.resumecompany.entity.News;
import com.yubso.resumecompany.entity.News.ComType;
import com.yubso.resumecompany.util.DivPageUtil;

public interface NewsDao {
	boolean addNews(News news);
	News queryNewsById(int id);
	DivPageUtil queryDivNewsByComIdType(int comId,ComType comType,int currentPage,int pageSize);
	boolean deleteNewsById(int id);
	public boolean updateNewsById(News news,int id,String ...ignore);
	
}
