package com.yubso.resumecompany.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yubso.resumecompany.action.BaseAction.ComType;
import com.yubso.resumecompany.dao.ResumeDao;
import com.yubso.resumecompany.entity.PushMessage;
import com.yubso.resumecompany.entity.Resume;
import com.yubso.resumecompany.entity.User;
import com.yubso.resumecompany.util.DateUtil;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;
import com.yubso.resumecompany.util.StringUtil;

public class ResumeDaoImpl implements ResumeDao{
	@Override
	public DivPageUtil queryDivResumes(List<String> jcategorys,
			 int currentPage,int pageSize){
		int totalCount = 0;
		DivPageUtil dpu = new DivPageUtil(0, pageSize, 0);
		if(jcategorys!=null&&jcategorys.size()!=0)
		{
			String whereHql="";
			for (String jcategory: jcategorys) {
				whereHql+=" r.hopeJob like '%"+jcategory+"%' or";
			}
			dpu = new DivPageUtil(totalCount,pageSize, currentPage);
			whereHql=whereHql.substring(0,whereHql.lastIndexOf("or"));
			totalCount=SQLHelper.getAllRowCount(" Resume r",whereHql);
			String hql="from User u,Resume r where ( "+whereHql+" ) and r.uid=u.id order by u.updateTime desc";
			List dataList=SQLHelper.queryDivEntitysByConditions(hql,dpu.getStartIndex(),pageSize);
			setEnityData(dpu,dataList);
		}
		return dpu;
	}
	@Override
	public DivPageUtil queryDivResumes(int currentPage,int pageSize){
		int totalCount = SQLHelper.getAllRowCount(Resume.class,null);
		DivPageUtil dpu = new DivPageUtil(totalCount,pageSize, currentPage);
		String hql="from User u,Resume r where r.uid=u.id order by u.updateTime desc";
		List dataList=SQLHelper.queryDivEntitysByConditions(hql,dpu.getStartIndex(),pageSize);
		setEnityData(dpu,dataList);
		return dpu;
	}
	@Override
	public Resume queryResumeById(int id) {
		return SQLHelper.queryEntityByConditions(Resume.class, "id="+id);
	}
	public void setEnityData(DivPageUtil dpu,List dataList)
	{
		if(dpu==null||dataList==null)
		{
			return;
		}
		List<Resume> resumes=new ArrayList<Resume>();
		Map<Integer,PushMessage> pushMessages=new HashMap<Integer,PushMessage>();
		User user=null;
		Resume resume=null;
		PushMessage pushMessage=null;
		for(int j=0;j<dataList.size();j++)
		{
			 user=null;
			 resume=null;
			 pushMessage=null;
			 Object[] obj=(Object[]) dataList.get(j);
			 for(int i=0;i<obj.length;i++)
			 {	
				 if(obj[i] instanceof Resume)
				 {
					 resume=(Resume)obj[i];
				 }
				 else if(obj[i] instanceof User)
				 {
					 user=(User)obj[i];
				 }else if(obj[i] instanceof PushMessage)
				 {
					 pushMessage=(PushMessage)obj[i];
				 }
			 }
			 if(resume!=null&&user!=null)
			 {
				if(StringUtil.checkIsNotNull(user.getName(),user.getSex(),user.getBirth(),user.getBirthplace(),user.getEducation(),user.getMartialStatus()))
				{
					resumes.add(resume);
					user.setBirth(DateUtil.getAgeByBirthday(user.getBirth())+"");
					dpu.getEntitysMap().put(resume.getId(), user);
					pushMessages.put(resume.getId(), pushMessage);
				}
				
			 }
		}
		dpu.getDataMap().put("resumes", resumes);
		dpu.getDataMap().put("pushMessages", pushMessages);
	}
	@Override
	public Resume queryResumeByUserId(int id) {
		return SQLHelper.queryEntityByConditions(Resume.class, "uid="+id);
	}
	@Override
	public DivPageUtil queryDivResumes(String whereHql, int currentPage,
			int pageSize) {
		String fromStr="User u,Resume r";
		whereHql+=" and r.uid=u.id";
		return exeDivQuery(fromStr,whereHql,currentPage,pageSize);
	}
	@Override
	public DivPageUtil queryInvitedResumes(int comId, ComType comType, int currentPage, int pageSize) {
		String fromStr="User u,Resume r,PushMessage p ";
		String whereHql="p.msgFromId="+comId+" and p.fromType="+comType.ordinal()+" and p.msgTo=u.userName and u.id=r.uid order by u.updateTime desc";
		return exeDivQuery(fromStr,whereHql,currentPage,pageSize);
	}
	private DivPageUtil exeDivQuery(String fromStr,String whereHqlStr,int currentPage,int pageSize)
	{
		int totalCount = SQLHelper.getAllRowCount(fromStr,whereHqlStr);
		DivPageUtil dpu = new DivPageUtil(totalCount,pageSize, currentPage);
		String hql="from "+fromStr+" where "+whereHqlStr;
		List dataList=SQLHelper.queryDivEntitysByConditions(hql,dpu.getStartIndex(),pageSize);
		setEnityData(dpu,dataList);
		return dpu;
	}
	@Override
	public DivPageUtil queryBearbyResumes(int currentPage, int pageSize,
			Double lng, Double lat, Double distanceRange) {
		String fromStr="User u,Resume r";
		String whereHql="r.uid=u.id and dbo.Getdistance("+lat+","+lng+",r.lat,r.lng)<"+distanceRange+" order by dbo.Getdistance("+lat+","+lng+",r.lat,r.lng) asc";
		return exeDivQuery(fromStr,whereHql,currentPage,pageSize);
	}
}
