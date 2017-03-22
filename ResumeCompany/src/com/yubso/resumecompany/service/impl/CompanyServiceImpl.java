package com.yubso.resumecompany.service.impl;

import com.yubso.resumecompany.dao.CompanyDao;
import com.yubso.resumecompany.dao.impl.CompanyDaoImpl;
import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.service.CompanyService;
import com.yubso.resumecompany.util.DivPageUtil;

public class CompanyServiceImpl implements CompanyService {
	private CompanyDao companyDao;
	public CompanyServiceImpl(){
		companyDao=new CompanyDaoImpl();
	}
	@Override
	public Company querCompanyById(int id)
	{
		return companyDao.querCompanyById(id);
	}
	@Override
	public Company querCompanyByLoginAccount(String loginAccount) {
		return companyDao.querCompanyByLoginAccount(loginAccount);
	}
	@Override
	public Company querCompanyByComName(String comName) {
		return companyDao.querCompanyByComName(comName);
	}
	@Override
	public boolean registCompany(Company company) {
		// TODO Auto-generated method stub
		return companyDao.registCompany(company);
	}
	@Override
	public DivPageUtil queryComByHrId(int hrid, int pageSize, int currentPage) {
		// TODO Auto-generated method stub
		return companyDao.queryComByHrId(hrid, pageSize, currentPage);
	}
	@Override
	public boolean updateCompanyById(Company company) {
		if(company==null||company.getId()<=0)
			return false;
		return updateCompanyById(company, company.getId());
	}
	@Override
	public boolean updateCompanyById(Company company, int comId) {
		if(company==null||comId<=0)
			return false;
		return companyDao.updateCompanyById(company,comId);
	}
}
