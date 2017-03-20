package cenmengqi.model;


import java.util.List;

import javax.swing.table.AbstractTableModel;
////姓名

import cenmengqi.bean.User;
import cenmengqi.db.SqlHelper;
import cenmengqi.utils.StringUtils;
public class UserTableModel extends AbstractTableModel {
	private String[] titles={"序号","编号","姓名","性别","部门","学历","出生地"}; 
	private String[] fieldNames={"id","number","name","sex","department","education","nativePlace"}; 
	private List<User> users;
	public UserTableModel(List<User> users) {
		this.users=users;
	}

	public String[] getTitles() {
		return titles;
	}
	@Override
	public int getColumnCount() {
		return titles.length;
	}

	@Override
	public String getColumnName(int col) {
		return titles[col];
	}
	
	@Override
	public int getRowCount() {
		return users.size();
	}
	
	
	@Override
	public Object getValueAt(int row, int col) {
		User user=users.get(row);
		String val=SqlHelper.getFieldVal(user, fieldNames[col]);
		if(StringUtils.isEmpty(val)||val.equals("null"))
		{
			val="未填写";
		}
		return val;
	}

}
