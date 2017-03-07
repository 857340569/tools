package sms.view;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

import sms.model.StuScoreModel;
import sms.model.StudentsScore;
import sms.model.SubjectModel;

public class AddStuScore extends JPanel
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JLabel jl1,jl2,jl3,jl4,jl5,jl6;
	JPanel jp1,jp2;
	JButton jb1,jb2;
	JTextField jtf1,jtf2;
	JComboBox jBox1,jBox2,jBox3,jBox4;
	SubjectModel subjectModel;
	
	public AddStuScore()
	{
		jl1=new JLabel("学号",JLabel.CENTER);
		
		jl2=new JLabel("课程",JLabel.CENTER);
		jl3=new JLabel("学年",JLabel.CENTER);
		jl4=new JLabel("学期",JLabel.CENTER);
		jl5=new JLabel("成绩",JLabel.CENTER);
		jl6=new JLabel("是否通过",JLabel.CENTER);
		jp1=new JPanel(new GridLayout(6,2));
		jtf1=new JTextField();
		jtf1.setEditable(false);
		
		
		subjectModel=new SubjectModel();
		Vector<String> subjects=subjectModel.findSubjectName();
		jBox1=new JComboBox(subjects);
		
		
		String year[]={"2010-2011","2011-2012","2012-2013"};
		jBox2=new JComboBox(year);
		
		String term[]={"第一学期","第二学期"};
		jBox3=new JComboBox(term);
		jtf2=new JTextField();
		//jtf6=new JTextField();
		
	
		Vector<String> items=new Vector<String>();
		items.add("是");
		items.add("否");
		jBox4=new JComboBox(items);
		jp1.add(jl1);
		jp1.add(jtf1);
		
		jp1.add(jl2);
		jp1.add(jBox1);
		
		jp1.add(jl3);
		jp1.add(jBox2);
		
		jp1.add(jl4);
		jp1.add(jBox3);
		
		jp1.add(jl5);
		jp1.add(jtf2);
		
		jp1.add(jl6);
		jp1.add(jBox4);
		jp1.setBackground(new Color(185,150,197));
		
		
		jp2=new JPanel();
		jp2.setBackground(new Color(185,150,197));
		jb1=new JButton("添加");
		jb1.addActionListener(new ActionListener()
		{
			
			@Override
			public void actionPerformed(ActionEvent e)
			{
				// TODO Auto-generated method stub
				
				String id=jtf1.getText().trim();
				String subId=subjectModel.findSubIdByName(jBox1.getSelectedItem().toString());
				String year=jBox2.getSelectedItem().toString();
				String term=jBox3.getSelectedItem().toString();
				String score=jtf2.getText();
				String isPass=jBox4.getSelectedItem().toString();
				if (score.equals(""))
				{
					JOptionPane.showMessageDialog(null,"成绩不能为空");
					return;
				}
				else {
					StudentsScore stuScore=new StudentsScore();
					stuScore.setStuId(id);
					stuScore.setSubId(subId);
					stuScore.setAcadYear(year);
					stuScore.setTerm(term);
					stuScore.setScore(score);
					stuScore.setIsPass(isPass);
					
					StuScoreModel scoreModel=new StuScoreModel();
					boolean result=scoreModel.addScore(stuScore);
					if (result)
					{
						JOptionPane.showMessageDialog(null, "学生成绩添加成功！");
					}
					else {
						JOptionPane.showMessageDialog(null, "该成绩己存在","添加失败",JOptionPane.INFORMATION_MESSAGE);
					}
				
				}
				
				//System.out.println(id);
			}
		});
		jb2=new JButton("重置");
		jb2.addActionListener(new ActionListener()
		{
			
			@Override
			public void actionPerformed(ActionEvent e)
			{
				// TODO Auto-generated method stub
				jBox1.setSelectedIndex(0);
				jBox2.setSelectedIndex(0);
				jBox3.setSelectedIndex(0);
				jBox4.setSelectedIndex(0);
				jtf2.setText("");
			}
		});
		jp2.add(jb1);
		jp2.add(jb2);
		this.setLayout(new BorderLayout());
		this.add(jp1);
		this.add(jp2,"South");
		
		
	}

	
}
