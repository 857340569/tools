package com.yubso.resumecompany.dao;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.util.DivPageUtil;

public interface CompanyDao {
	public Company querCompanyById(int id);

	public Company querCompanyByLoginAccount(String loginAccount);

	public Company querCompanyByComName(String comName);

	public boolean registCompany(Company company);
	
	//查询代理企业
	public DivPageUtil queryComByHrId(int hrid,int pageSize,int currentPage);

	public boolean updateCompanyById(Company company, int comId);
}
