package com.zjp.dtdbills.db;

import com.zjp.dtdbills.db.SqlFieldType;
import com.zjp.dtdbills.db.SqlFieldType.FieldType;

public class BillRecord {
	@SqlFieldType(value=FieldType.INTEGER,isPrimaryKey=true)
	private int id;
	
	@SqlFieldType(FieldType.INTEGER)
	private int type;
	
	@SqlFieldType(value=FieldType.NVARCHAR,length=200)
	private String typeName;
	
	@SqlFieldType(value=FieldType.NVARCHAR,length=200)
	private String title;
	
	@SqlFieldType(value=FieldType.NVARCHAR,length=2000)
	private String info;
	
	@SqlFieldType(FieldType.DOUBLE)
	private double money;
	
	@SqlFieldType(value=FieldType.NVARCHAR,length=50)
	private String date;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
}
