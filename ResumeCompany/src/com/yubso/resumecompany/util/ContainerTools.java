package com.yubso.resumecompany.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
/**
 * 容器工具类
 * @author Administrator
 *
 */
public class ContainerTools {
	/**
	 * 删除ArrayList中重复元素，保持顺序
	 * @param list
	 */
	public static <T> void removeDuplicateWithOrder(List<T> list) {
	     Set<T> set = new HashSet<T>();
	      List<T> newList = new ArrayList<T>();
	   for (Iterator<T> iter = list.iterator(); iter.hasNext();) {
	          T element = iter.next();
	          if (set.add(element))
	             newList.add(element);
	       } 
	      list.clear();
	      list.addAll(newList);
	}
}
