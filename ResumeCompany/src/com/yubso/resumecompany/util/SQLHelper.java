package com.yubso.resumecompany.util;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;


public class SQLHelper {
	static PreparedStatement preparedStatement;
	static ResultSet resultSet;
	static Connection conn;

	public enum ExecuteType {
		ADD, DELETE, UPDATE
	}
	public static String getwhereHql(String paraNames[], String... values) {
		String whereHql = "";
		if (paraNames != null && values != null
				&& paraNames.length == values.length) {
			for (int i = 0; i < paraNames.length; i++) {
				whereHql += paraNames[i] + " ='" + values[i] + "' and ";
			}
			whereHql += "1=1";
		} else {
			whereHql += "1=1";
		}
		return whereHql;
	}

	public static int getAllRowCount(String poName, String whereHql) {
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		Query query = null;
		int allRows = 0;
		whereHql = StringUtil.checkIsNotNull(whereHql) ? whereHql : " 1=1";
		String hql = "from " + poName + " where " + whereHql;
		try {
			tx = session.beginTransaction();
			query = session.createQuery(hql);
			allRows = query.list().size();
			tx.commit();
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}

			e.printStackTrace();
		} finally {
			session.close();
		}

		return allRows;
	}
	private static int getAllRowCount(String poName, String paraNames[],
			String... values) {

		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		Query query = null;
		int allRows = 0;
		String hql = "from " + poName + " where ";
		if (paraNames != null && values != null
				&& paraNames.length == values.length) {
			for (int i = 0; i < paraNames.length; i++) {
				hql += paraNames[i] + " =? and ";
			}
			hql += "1=1";
			query = session.createQuery(hql);
			for (int i = 0; i < values.length; i++) {
				query.setString(i, values[i]);
			}
		} else {
			hql += "1=1";
			query = session.createQuery(hql);
		}
		try {
			tx = session.beginTransaction();
			allRows = query.list().size();
			tx.commit();
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}

			e.printStackTrace();
		} finally {
			session.close();
		}

		return allRows;
	}
	/**
	 * @param poName
	 *            实体对象名
	 * @param paraNames
	 *            列名数组
	 * @param values
	 *            对应列的值
	 * @return 得到数据总记录数
	 */
	public static <T> int getAllRowCount(Class<T> claz, String paraNames[],
			String... values) {
		String poName=claz.getName().substring(claz.getName().lastIndexOf(".") + 1);
		return getAllRowCount(poName, paraNames,values);
	}
	public static <T> int getAllRowCount(Class<T> claz, String whereHql) {
		String poName=claz.getName().substring(claz.getName().lastIndexOf(".") + 1);
		return getAllRowCount(poName, whereHql);
	}
	public static <T> boolean addEntity(T... t) {
		if (t == null) {
			return false;
		}
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			for (T temp : t) {
				session.save(temp);
			}
			tx.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
		} finally {
			session.close();
		}
		return false;
	}
	public static <T extends Serializable> boolean updateByTransation(int[] executeTypes,
			String[] whereHqls, T... t) {
		if(executeTypes==null||whereHqls==null||t==null||executeTypes.length!=whereHqls.length||executeTypes.length!=t.length)
		{
			return false;
		}
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();

			for (int i = 0; i < executeTypes.length; i++) {
				switch (executeTypes[i]) {
				case 0:// save
					session.save(t[i]);
					break;
				case 1:// delete
					session.delete(t[i]);
					break;
				case 2:// update
					if(!StringUtil.checkIsNotNull(whereHqls[i]))
					{
						session.update(t[i]);
						break;
					}
					String hql = "from "
							+ t[i].getClass().getName().substring(
									t[i].getClass().getName().lastIndexOf(".") + 1);
					if(whereHqls[i].contains("where"))
					{
						hql += " " + whereHqls[i];
					}else
					{
						hql += " where " + whereHqls[i];
					}
					Query query=session.createQuery(hql);
					T temp=(T) query.uniqueResult();
					t[i] = ReflectUtils.getDataObj(temp, t[i]);
					session.update(t[i]);
					break;

				default:
					break;
				}
			}
			tx.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			if(tx!=null)
				tx.rollback();
		} finally {
			if(session!=null)
				session.close();
		}
		return false;
	}

	public static <T> boolean deleteEntity(T... t) {
		if (t == null) {
			return false;
		}
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			for (T temp : t) {
				session.delete(temp);
			}
			tx.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
		} finally {
			session.close();
		}
		return false;
	}
	/**
	 * whereHql为空会删除所有数据,请注意
	 * @param tClass
	 * @param whereHql
	 * @return
	 */
	public static <T> boolean deleteEntity(Class<T> tClass,String whereHql) {
		if(tClass==null)
			return false;
		String poName=tClass.getName().substring(tClass.getName().lastIndexOf(".") + 1);
		String hql="delete "+poName;
		if(StringUtil.checkIsNotNull(whereHql))
		{
			
			if(!whereHql.contains(" where "))
				hql+=" where "+whereHql;
			else {
				hql+=whereHql;
			}
		}
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			Query query=session.createQuery(hql);
			int result=query.executeUpdate();
			tx.commit();
			if(result>0)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
		} finally {
			session.close();
		}
		return false;
	}

	public static <T> boolean updateEntityById(T t, int id) {
		return updateEntityById(t, id, null);
	}
	public static <T> boolean updateEntityById(T t, int id,String ...ignoreFieldNames) {
		if (t == null) {
			return false;
		}
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			T temp = (T) session.get(t.getClass(), id);
			t = ReflectUtils.getDataObj(temp, t,ignoreFieldNames);
			session.update(t);
			tx.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return false;
	}
	public static <T> boolean deleteEntitys(String hql) {
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			Query query=session.createQuery(hql);
			int result=query.executeUpdate();
			tx.commit();
			if(result>0)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return false;
	}
	public static <T> boolean updateEntity(String hql) {
		
		return updateEntity(null, hql, null);
	}
	public static <T> boolean updateEntity(Class<T> claz, String setHql) {
		
		return updateEntity(claz, setHql, null);
	}
	public static <T> boolean updateEntity(Class<T> claz, String setHql,String whereHql) {
		if(!StringUtil.checkIsNotNull(setHql))
			return false;
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		String hql="";
		
		if(!setHql.contains("update ")&&!setHql.contains("delete "))
		{
			String poName=claz.getName().substring(claz.getName().lastIndexOf(".") + 1);
			hql+="update "+poName;
		}
		if(!setHql.contains(" set ")&&!setHql.contains("delete "))
			hql+=" set "+setHql;
		else {
			hql+=setHql;
		}
		if(StringUtil.checkIsNotNull(whereHql))
		{
			if(!whereHql.contains(" where "))
				hql+=" where "+whereHql;
			else {
				hql+=whereHql;
			}
		}
		if(claz==null&&whereHql==null)
		{
			hql=setHql;
		}
		try {
			tx = session.beginTransaction();
			Query query=session.createQuery(hql);
			int result=query.executeUpdate();
			tx.commit();
			if(result>0)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return false;
	}
	public static <T> boolean updateEntityByConditions(T t, String whereHql) {
		if (t == null) {
			return false;
		}
		T temp = (T) queryEntityByConditions(t.getClass(), whereHql);
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			t = ReflectUtils.getDataObj(temp, t);
			session.update(t);
			tx.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return false;
	}

	public static <T> T queryEntityByConditions(Class<T> clasz, String whereHql) {
		if (clasz == null || !StringUtil.checkIsNotNull(whereHql)) {
			return null;
		}
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		T t = null;
		try {
			tx = session.beginTransaction();
			String hql = "from "
					+ clasz.getName().substring(
							clasz.getName().lastIndexOf(".") + 1) + " where "
					+ whereHql;
			System.out.println("hql abc:" + hql);
			Query query = session.createQuery(hql);
			if(query.list().size()>1)
			{
				t=(T) query.list().get(0);
			}else{
				t = (T) query.uniqueResult();
			}
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return t;
	}

	public static <T> List<T> queryDivEntitysByConditions(Class<T> clasz,
			String whereHql){
		return queryDivEntitysByConditions(clasz, whereHql, -1, -1);
	}
	public static <T> List<T> queryDivEntitysByConditions(Class<T> clasz,
			String whereHql, int startIndex, int pageSize) {
		if (clasz == null) {
			return null;
		}
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		List<T> tList = null;
		try {
			tx = session.beginTransaction();
			String hql = "from "
					+ clasz.getName().substring(
							clasz.getName().lastIndexOf(".") + 1);
			if (StringUtil.checkIsNotNull(whereHql)) {
				boolean a = whereHql.contains("where");
				if (a) {
					hql += " " + whereHql;
				} else {
					hql += " where " + whereHql;
				}
			}
			if (startIndex < 0 || pageSize <= 0) {
				Query query = session.createQuery(hql);
				tList = query.list();
			} else {
				Query query = session.createQuery(hql)
						.setFirstResult(startIndex - 1).setMaxResults(pageSize);
				tList = query.list();
			}
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return tList;
	}
	public static List queryDivEntitysByConditions(String hql, int startIndex, int pageSize) {
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
	//		String hql="from User u,Resume r where (r.hopeJob like '%操作工%' or r.hopeJob like '%服务员%' or r.hopeJob like '%快递员%') and r.uid=u.id order by u.updateTime desc";
			Query query=session.createQuery(hql).setFirstResult(startIndex - 1).setMaxResults(pageSize);;
			List list=query.list();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

}
