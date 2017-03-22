package com.yubso.resumecompany.service;

import com.yubso.resumecompany.entity.Company;
import com.yubso.resumecompany.util.DivPageUtil;

public interface CompanyService {
	/**
	 * 根据公司id查找公司信息
	 * 
	 * @param id
	 * @return
	 */
	public Company querCompanyById(int id);

	/**
	 * 根据登录名查找公司
	 * 
	 * @param loginAccount
	 * @return
	 */
	public Company querCompanyByLoginAccount(String loginAccount);

	/**
	 * 根据公司名查找公司
	 * 
	 * @param comName
	 * @return
	 */
	public Company querCompanyByComName(String comName);

	/**
	 * 注册公司
	 * 
	 * @param company
	 * @return
	 */
	public boolean registCompany(Company company);

	// 查询代理企业
	public DivPageUtil queryComByHrId(int hrid, int pageSize, int currentPage);
	
	public boolean updateCompanyById(Company company);
	
	public boolean updateCompanyById(Company company, int comId);
}
