package com.yubso.resumecompany.dao.impl;

import java.util.List;

import com.yubso.resumecompany.dao.NewsDao;
import com.yubso.resumecompany.entity.News;
import com.yubso.resumecompany.entity.News.ComType;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class NewsDaoImpl implements NewsDao {

	@Override
	public boolean addNews(News news) {
		return SQLHelper.addEntity(news);
	}

	@Override
	public News queryNewsById(int id) {
		return SQLHelper.queryEntityByConditions(News.class, "id="+id);
	}

	@Override
	public DivPageUtil queryDivNewsByComIdType(int comId, ComType comType,
			int currentPage, int pageSize) {
		String whereHql="comId="+comId+" and comType="+comType.ordinal();
		int totalCount=SQLHelper.getAllRowCount(News.class, whereHql);
		DivPageUtil dpu=new DivPageUtil(totalCount, pageSize, currentPage);
		List<News> news=SQLHelper.queryDivEntitysByConditions(News.class, whereHql+" order by id desc ", dpu.getStartIndex(), pageSize);
		dpu.getDataMap().put("news", news);
		return dpu;
	}

	@Override
	public boolean deleteNewsById(int id) {
		News news=new News();
		news.setId(id);
		return SQLHelper.deleteEntity(news);
	}

	@Override
	public boolean updateNewsById(News news,int id,String ...ignore) {
		return SQLHelper.updateEntityById(news, id,ignore);
	}

}
