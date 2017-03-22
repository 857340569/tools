package com.yubso.resumecompany.dao.impl;

import java.util.List;

import com.yubso.resumecompany.dao.CompanyDao;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.util.DivPageUtil;
import com.yubso.resumecompany.util.SQLHelper;

public class CompanyDaoImpl implements CompanyDao {

	@Override
	public Company querCompanyById(int id) {
		return SQLHelper.queryEntityByConditions(Company.class, "id="+id);
	}

	@Override
	public Company querCompanyByLoginAccount(String loginAccount) {
		return SQLHelper.queryEntityByConditions(Company.class,"loginAccount='"+loginAccount+"'");
	}

	@Override
	public Company querCompanyByComName(String comName) {
		return SQLHelper.queryEntityByConditions(Company.class,"name='"+comName+"'");
	}

	@Override
	public boolean registCompany(Company company) {
		return SQLHelper.addEntity(company);
	}

	@Override
	public DivPageUtil queryComByHrId(int hrid,int pageSize,int currentPage) {
		// TODO Auto-generated method stub
		int totalCount=0;
		totalCount = SQLHelper.getAllRowCount(Company.class, "hrId="+hrid);
		DivPageUtil divPageUtil=new DivPageUtil(totalCount, pageSize, currentPage);
		List<Company> companies=SQLHelper.queryDivEntitysByConditions(Company.class, "hrId="+hrid,divPageUtil.getStartIndex(),pageSize);
		divPageUtil.getDataMap().put("companies",companies);
		return divPageUtil;
	}

	@Override
	public boolean updateCompanyById(Company company, int comId) {
		return SQLHelper.updateEntityById(company, comId);
	}

}
