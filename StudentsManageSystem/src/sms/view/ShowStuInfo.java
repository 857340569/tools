package sms.view;

import java.awt.GridLayout;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import sms.model.StudentModel;
import sms.model.Students;
import sms.tools.MyFontsOrOther;

public class ShowStuInfo extends JPanel
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Students students;
	JLabel jl1,jl2,jl3,jl4,jl5,jl6,jl7,jl8;
	JTextField jtf1,jtf2,jtf3,jtf4,jtf5,jtf6,jtf7,jtf8;
	
	public final int w=MyFontsOrOther.width;
	public final int h=MyFontsOrOther.height;
	public ShowStuInfo(String stuId,boolean edit)
	{	
		this.setLayout(new GridLayout(4,2));
		StudentModel studentModel=new StudentModel();
		students=studentModel.showAllInfo(stuId);
		
		jl1=new JLabel("学号:",JLabel.CENTER);
		jtf1=new JTextField(10);
		
		jtf1.setEditable(false);
		jtf1.setText(students.getStuId());
		jl2=new JLabel("姓名:",JLabel.CENTER);
		jtf2=new JTextField(10);
		jtf2.setText(students.getStuName());
		jtf2.setEditable(edit);
		jl3=new JLabel("性别:",JLabel.CENTER);
		jtf3=new JTextField(10);
		jtf3.setText(students.getStuSex());
		jtf3.setEditable(edit);
		jl4=new JLabel("出生日期:",JLabel.CENTER);
		jtf4=new JTextField(10);
		jtf4.setText(students.getStuBirth().substring(0, 10));
		jtf4.setEditable(edit);
		jl5=new JLabel("年级:",JLabel.CENTER);
		jtf5=new JTextField(10);
		jtf5.setText(students.getStuGrade());
		jtf5.setEditable(edit);
		jl6=new JLabel("系部:",JLabel.CENTER);
		jtf6=new JTextField(10);
		jtf6.setText(students.getStuDept());
		jtf6.setEditable(false);
		jl7=new JLabel("职务:",JLabel.CENTER);
		jtf7=new JTextField(10);
		jtf7.setText(students.getStuJob());
		jtf7.setEditable(false);
		jl8=new JLabel("政治面貌:",JLabel.CENTER);
		jtf8=new JTextField(10);
		jtf8.setText(students.getStuPL());
		jtf8.setEditable(edit);
		this.add(jl1);
		this.add(jtf1);
		this.add(jl2);
		this.add(jtf2);
		this.add(jl7);
		this.add(jtf7);
		
		this.add(jl4);
		this.add(jtf4);
		
		this.add(jl6);
		this.add(jtf6);
		
		this.add(jl3);
		this.add(jtf3);
		
		this.add(jl5);
		this.add(jtf5);
		
		this.add(jl8);
		this.add(jtf8);
		
	}

}
