package com.yubso.resumecompany.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 分页类，参考自JavaEye及SpringSide
 */
public class DivPageUtil {
	public final static int PAGESIZE = 10;

	private int pageSize = PAGESIZE;

	private List items = new ArrayList();
	Map<String, Object> dataMap=new HashMap<String, Object>();
	Map<Integer, Object> entitysMap=new HashMap<Integer, Object>();
	private int totalCount = 0;

	private long totalPageCount = 0;
	private long currentPageNo = 0;
	private int nextPageNo = 0;
	private int previousPageNo;
	private int[] indexes = new int[0];

	private int startIndex = 0;
	private int endIndex=0;

	public DivPageUtil(int totalCount, int pageSize, int currentPage) {
		this.currentPageNo=currentPage > 0 ? currentPage : 1;
		setPageSize(pageSize);
		setTotalCount(totalCount);
		setStartIndex((int)currentPageNo);
		setTotalPageCount(getTotalPageCount());
		getPreviousPageNo();
		getNextPageNo();
	}
	/**
	 * 将页码转换为列表的startIndex，页大小为默认大小
	 */
	public static int convertFromPageToStartIndex(int pageNo) {
		return (pageNo - 1) * PAGESIZE;
	}

	/**
	 * 将页码转换为列表的startIndex
	 */
	public static int convertFromPageToStartIndex(int pageNo, int pageSize) {
		return (pageNo - 1) * pageSize;
	}

	public List getItems() {
		return items;
	}

	public void setItems(List items) {
		this.items = items;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	/**
	 * 设置数据总数，并计算各页起始位置
	 */
	public void setTotalCount(int totalCount) {
		if (totalCount > 0) {
			this.totalCount = totalCount;
			int count = totalCount / pageSize;
			if (totalCount % pageSize > 0)
				count++;
			indexes = new int[count];
			for (int i = 0; i < count; i++) {
				indexes[i] = pageSize * i+1;
			}
		} else {
			this.totalCount = 0;
		}
	}

	public int[] getIndexes() {
		return indexes;
	}

	public void setIndexes(int[] indexes) {
		this.indexes = indexes;
	}

	public int getStartIndex() {
		return startIndex;
	}

	/**
	 * 设置当前起始位置
	 */
	public void setStartIndex(int currentPage) {
		if (totalCount <= 0)
			this.startIndex = 1;
		else if (startIndex >= totalCount)
			this.startIndex = indexes[indexes.length - 1];
		else if (startIndex < 0)
			this.startIndex = 1;
		else {
			if(indexes.length<currentPage)
				this.startIndex=indexes.length>0?1:indexes[indexes.length-1];
			else {
				this.startIndex = indexes[currentPage-1];
			}
		}
	}
	/**
	 * 设置当前结束位置
	 */
	public int getEndIndex() {
		int endTemp=(int)getCurrentPageNo()*pageSize;
		endIndex=endTemp>totalCount?totalCount:endTemp;
		return endIndex;
	}

	/**
	 * 获得下页起始位置
	 */
	public int getNextIndex() {
		int nextIndex = getStartIndex() + pageSize;
		if (nextIndex >= totalCount)
			return getStartIndex();
		else
			return nextIndex;
	}

	/**
	 * 获得上页起始位置
	 */
	public int getPreviousIndex() {
		int previousIndex = getStartIndex() - pageSize;
		if (previousIndex < 0)
			return 1;
		else
			return previousIndex;
	}

	/**
	 * 取总页数.
	 */
	public long getTotalPageCount() {
		long totalPage = 1l;
		if (totalCount % pageSize == 0) {
			if (totalCount == 0) {
				return totalPage;
			} else {
				return totalCount / pageSize;
			}
		} else
			return totalCount / pageSize + 1;
	}

	/* 取得最后一页的index */
	public int getEndPageIndex() {
		int yushu = totalCount % pageSize;
		int endPageIndex = 0;
		if (yushu == 0) {
			endPageIndex = totalCount - pageSize;
		} else {
			endPageIndex = totalCount - yushu;
		}
		return endPageIndex;
	}

	/**
	 * 取该页当前页码,页码从1开始.
	 */
	public long getCurrentPageNo() {
		return currentPageNo;
	}

	/**
	 * 该页是否有下一页.
	 */
	public boolean hasNextPage() {
		return this.getCurrentPageNo() < this.getTotalPageCount() - 1;
	}

	/**
	 * 该页是否有上一页.
	 */
	public boolean hasPreviousPage() {
		return this.getCurrentPageNo() > 1;
	}

	public int getNextPageNo() {
		int pageTemp=(int) (currentPageNo+1);
		pageTemp=pageTemp<1?1:pageTemp;
		nextPageNo=(int) (pageTemp>totalPageCount?totalPageCount:pageTemp);
		return nextPageNo;
	}

	public void setNextPageNo(int nextPageNo) {
		
		this.nextPageNo = nextPageNo;
	}

	public int getPreviousPageNo() {
		int pageTemp=(int) (currentPageNo-1);
		pageTemp=pageTemp<1?1:pageTemp;
		previousPageNo=(int) (pageTemp>totalPageCount?totalPageCount:pageTemp);
		return previousPageNo;
	}

	public void setPreviousPageNo(int previousPageNo) {
		this.previousPageNo = previousPageNo;
	}

	public void setTotalPageCount(long totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public Map<Integer, Object> getEntitysMap() {
		return entitysMap;
	}

	public void setEntitysMap(Map<Integer, Object> entitysMap) {
		this.entitysMap = entitysMap;
	}
	
}