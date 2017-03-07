package sms.view;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.ListSelectionModel;
import javax.swing.Timer;
import sms.model.StudentModel;
import sms.tools.DrawBg;
import sms.tools.MyFontsOrOther;

public class TeacherManage extends JFrame implements ActionListener,MouseListener
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//定义菜单栏
	JMenuBar jmb;
	JMenu jm1,jm2,jm3,jm4,jm5;
	JMenuItem jm1_jmi1,jm1_jmi2,jm1_jmi3,jm1_jmi4,jm2_jmi1,jm2_jmi2,jm2_jmi3,jm2_jmi4;
	//定义中间部分
	JPanel leftall,allmain,allmain_centerjpanel,allmain_mainjpanel,mainjp_alljp1,mainjp_jp1,mainjp_jp2,mainjp_jp3;
	JTextField mainjp_jp1_jtf;
	JButton mainjp_jp1_jb,mainjp_jp2_jb1,mainjp_jp2_jb2,mainjp_jp2_jb3;
	CardLayout cl_left,cl_center,cl_main;
	DrawBg leftbg,leftbg2,leftbg3;
	JLabel leftbg_jl1,leftbg_jl2,leftbg_jl3,leftbg_jl4,leftbg2_jl1,leftbg2_jl2,leftbg2_jl3,leftbg2_jl4,centerjp_jl1,centerjp_jl2;
	JSplitPane jSplitPane;
	JTable stuInfojt;
	JScrollPane stuJsp;
	StudentModel sModel1;
	//定义状态栏
	Timer timer;
	JLabel bottomjl;
	SimpleDateFormat sdf;
	DrawBg bottom;
	AddStuScore addsore;
	//test
//	public static void main(String args[])
//	{
//		new TeacherManage(null);
//	}
	public void initMenu()
	{
		jmb=new JMenuBar();
		jm1=new JMenu("学生管理");
		jm1.setFont(MyFontsOrOther.f2);
		jm1_jmi1=new JMenuItem("查询学生信息");
		jm1_jmi1.setFont(MyFontsOrOther.f3);
		jm1_jmi1.addActionListener(this);
		jm1_jmi2=new JMenuItem("修改学生信息");
		jm1_jmi2.setFont(MyFontsOrOther.f3);
		jm1_jmi3=new JMenuItem("删除学生信息");
		jm1_jmi3.setFont(MyFontsOrOther.f3);
		jm1_jmi4=new JMenuItem("增加学生信息");
		jm1_jmi4.setFont(MyFontsOrOther.f3);
		jm2=new JMenu("登陆管理");
		jm2.setFont(MyFontsOrOther.f2);
		jm2_jmi1=new JMenuItem("切换登陆");
		jm2_jmi1.setFont(MyFontsOrOther.f3);
		jm2_jmi1.addActionListener(this);
		jm2_jmi2=new JMenuItem("注册管理员");
		jm2_jmi2.setFont(MyFontsOrOther.f3);
		jm2_jmi3=new JMenuItem("删除管理员");
		jm2_jmi3.setFont(MyFontsOrOther.f3);
		jm2_jmi4=new JMenuItem("修改登陆密码");
		jm2_jmi4.setFont(MyFontsOrOther.f3);
		
		jm3=new JMenu("教师管理");
		jm3.setFont(MyFontsOrOther.f2);
		jm4=new JMenu("课程管理");
		jm4.setFont(MyFontsOrOther.f2);
		jm5=new JMenu("帮助");
		jm5.setFont(MyFontsOrOther.f2);
		
		jm1.add(jm1_jmi1);
		jm1.add(jm1_jmi2);
		jm1.add(jm1_jmi3);
		jm1.add(jm1_jmi4);
		
		jm2.add(jm2_jmi1);
		jm2.add(jm2_jmi2);
		jm2.add(jm2_jmi3);
		jm2.add(jm2_jmi4);
		
		jmb.add(jm1);
		jmb.add(jm2);
		jmb.add(jm3);
		jmb.add(jm4);
		jmb.add(jm5);
	}
	public void initStatusBar()
	{
		bottom=new DrawBg(MyFontsOrOther.bottombg);
		bottom.setLayout(new FlowLayout(FlowLayout.RIGHT));
		sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		bottomjl=new JLabel("当前时间为:"+sdf.format(Calendar.getInstance().getTime())+"");
		bottom.add(bottomjl);
		timer=new Timer(1000,this);
		timer.start();
		
	}
	public void initCenter()
	{
		cl_left=new CardLayout();
		leftall=new JPanel(cl_left);
		//菜单一的显示
		leftbg=new DrawBg(MyFontsOrOther.mainbg2);
		leftbg.setLayout(new GridLayout(4,1));
		leftbg_jl1=new JLabel("查询学生信息",new ImageIcon("images/find.png"),0);
		leftbg_jl1.setEnabled(false);
		leftbg_jl1.addMouseListener(this);
		leftbg_jl2=new JLabel("修改学生信息",new ImageIcon("images/edit.png"),0);
		leftbg_jl2.setEnabled(false);
		leftbg_jl2.addMouseListener(this);
		leftbg_jl3=new JLabel("删除学生信息",new ImageIcon("images/del.png"),0);
		leftbg_jl3.setEnabled(false);
		leftbg_jl3.addMouseListener(this);
		leftbg_jl4=new JLabel("增加学生信息",new ImageIcon("images/add.png"),0);
		leftbg_jl4.setEnabled(false);
		leftbg_jl4.addMouseListener(this);
		leftbg.add(leftbg_jl1);
		leftbg.add(leftbg_jl2);
		leftbg.add(leftbg_jl3);
		leftbg.add(leftbg_jl4);
		leftall.add(leftbg,"学生管理");
		//菜单二的显示
		leftbg2=new DrawBg(MyFontsOrOther.mainbg2);
		leftbg2.setLayout(new GridLayout(4,1));
		leftbg2_jl1=new JLabel("切换登陆");
		leftbg2_jl2=new JLabel("注册管理员");
		leftbg2_jl3=new JLabel("删除管理员");
		leftbg2_jl4=new JLabel("修改登陆密码");
		leftbg2.add(leftbg2_jl1);
		leftbg2.add(leftbg2_jl2);
		leftbg2.add(leftbg2_jl3);
		leftbg2.add(leftbg2_jl4);
		leftall.add(leftbg2,"登陆管理");
		
		//伸缩菜单
		cl_center=new CardLayout();
		allmain_centerjpanel=new JPanel(cl_center);
		centerjp_jl1=new JLabel(new ImageIcon("images/arrl.gif"));
		centerjp_jl1.addMouseListener(this);
		centerjp_jl2=new JLabel(new ImageIcon("images/arrr.gif"));
		centerjp_jl2.addMouseListener(this);
		allmain_centerjpanel.add(centerjp_jl1,"left");
		allmain_centerjpanel.add(centerjp_jl2,"right");
		
		//显示主要功能的JPanel 
		cl_main=new CardLayout();
		allmain_mainjpanel=new JPanel(cl_main);
		mainjp_jp1=new JPanel();
		mainjp_jp1_jtf=new JTextField(20);
		mainjp_jp1_jb=new JButton("查询");
		mainjp_jp1_jb.addActionListener(this);
		mainjp_jp1.add(new JLabel("请输入要查询的学生的学号或姓名:"));
		mainjp_jp1.add(mainjp_jp1_jtf);
		mainjp_jp1.add(mainjp_jp1_jb);
		
		sModel1=new StudentModel();
		sModel1.findByIdOrName("");
		stuInfojt=new JTable(sModel1);
		stuInfojt.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		stuJsp=new JScrollPane(stuInfojt);
		
		
		mainjp_jp2=new JPanel();
		mainjp_jp2_jb1=new JButton("显示成绩");
		mainjp_jp2_jb1.addActionListener(this);
		mainjp_jp2_jb2=new JButton("删除");
		mainjp_jp2_jb2.addActionListener(this);
		mainjp_jp2_jb3=new JButton("增加成绩");
		mainjp_jp2_jb3.addActionListener(this);
		mainjp_jp2.add(mainjp_jp2_jb1);
		mainjp_jp2.add(mainjp_jp2_jb2);
		mainjp_jp2.add(mainjp_jp2_jb3);
		mainjp_alljp1=new JPanel(new BorderLayout());
		mainjp_alljp1.add(mainjp_jp1,"North");
		mainjp_alljp1.add(stuJsp,"Center");
		mainjp_alljp1.add(mainjp_jp2,"South");
		//stuInfojt.setIntercellSpacing(new Dimension(25,25));
		stuInfojt.setRowHeight(25);
		//System.out.println(stuInfojt.getRowCount());
		
		allmain_mainjpanel.add(mainjp_alljp1,"查询学生信息");
		addsore = new AddStuScore();
		allmain_mainjpanel.add(addsore,"增加学生成绩");
		allmain=new JPanel(new BorderLayout());
		allmain.add(allmain_centerjpanel,"West");
		allmain.add(allmain_mainjpanel,"Center");
		//拆分窗体
		jSplitPane=new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,true,leftall,allmain);
		jSplitPane.setDividerLocation(150);
		jSplitPane.setDividerSize(0);
	}
	public TeacherManage(String welcome)
	{   this.initMenu();
		this.initCenter();
		this.initStatusBar();
		this.add(jSplitPane,"Center");
		this.add(bottom,"South");
		this.setJMenuBar(jmb);
		this.setVisible(true);
		this.setIconImage(new ImageIcon("images/admin.png").getImage());
		this.setTitle(" 欢 迎 "+welcome+" 进 入 学 生 管 理 系 统 教 师 端");
		this.setSize(MyFontsOrOther.width,MyFontsOrOther.height-25);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	public void actionPerformed(ActionEvent e)
	{
		bottomjl.setText("当前时间为:"+sdf.format(Calendar.getInstance().getTime())+"");
		if (e.getSource()==jm1_jmi1)
		{
			cl_left.show(leftall,"学生管理");
		}else if (e.getSource()==jm2_jmi1)
		{
			cl_left.show(leftall,"登陆管理");
			new Login();
			this.dispose();
		}
		else if(e.getSource()==mainjp_jp1_jb)
		{
			sModel1=new StudentModel();
			String input=mainjp_jp1_jtf.getText().trim();
			sModel1.findByIdOrName(input);
			stuInfojt.setModel(sModel1);
			//System.out.println(stuInfojt.getColumnCount());
			if (stuInfojt.getRowCount()==0)
			{
				JOptionPane.showMessageDialog(this, "暂无该学生信息!");
			}
		}
		else if (e.getSource()==mainjp_jp2_jb1)
		{
			int idnumber=stuInfojt.getSelectedRow();
			if (idnumber==-1)
			{
				JOptionPane.showMessageDialog(this, "请选中一名学生");
			}
			else
			{
				String id=stuInfojt.getValueAt(idnumber, 0).toString();
				sModel1=new StudentModel();
				boolean result=	sModel1.getScore("", "","",id);
				if (!result)
				{
					JOptionPane.showMessageDialog(this,"暂无该学生成绩！");
					return;
				}
				stuInfojt.setModel(sModel1);
			}
			
		}
		else if(e.getSource()==mainjp_jp2_jb2)
		{
			
			int idnumber=stuInfojt.getSelectedRow();
			if (idnumber==-1)
			{
				JOptionPane.showMessageDialog(this, "请选中一名学生");
			}
			else
			{
//				ConfirmationCallback cc=new ConfirmationCallback(ConfirmationCallback.INFORMATION, ConfirmationCallback.OK_CANCEL_OPTION, ConfirmationCallback.OK);
//				cc.setSelectedIndex(ConfirmationCallback.YES);
				String id=stuInfojt.getValueAt(idnumber, 0).toString();
				String name=stuInfojt.getValueAt(idnumber,1).toString();
				sModel1=new StudentModel();
				
				int i=JOptionPane.showConfirmDialog(this,"确定删除学生   "+name+"的信息","信息", JOptionPane.OK_CANCEL_OPTION,JOptionPane.QUESTION_MESSAGE);
				//System.out.print(i);
				if(i==0)
				{
//					if(sModel1.deleteById(id))
//					{
					sModel1.deleteById(id);
						
						//JOptionPane.showMessageDialog(this, " 学 生 "+name+"删 除 成 功");
						
						sModel1=new StudentModel();
						sModel1.findByIdOrName("");
						stuInfojt.setModel(sModel1);
//					}
//					else {
//						JOptionPane.showMessageDialog(this, " 学 生"+name+"删 除 失 败");
//					}
				}
//test				else if(i==1)
//				{
//					System.out.println(i);
//				}
					
			}
		}else if (e.getSource()==mainjp_jp2_jb3)
		{
			int row=stuInfojt.getSelectedRow();
			if (row==-1)
			{
				JOptionPane.showMessageDialog(this, "请选择要增加的学生");
			}
			//处理增加学生成绩的部分
			else {
				String stuId=(String)stuInfojt.getValueAt(row, 0);
				addsore.jtf1.setText(stuId);
				cl_main.show(allmain_mainjpanel,"增加学生成绩");
			}
		}
	}
	@Override
	public void mouseClicked(MouseEvent e)
	{
		// TODO Auto-generated method stub
		if (e.getSource()==centerjp_jl1)
		{
			jSplitPane.setDividerLocation(0);
			cl_center.show(allmain_centerjpanel, "right");
		}else if(e.getSource()==centerjp_jl2)
		{
			jSplitPane.setDividerLocation(150);
			cl_center.show(allmain_centerjpanel, "left");
		}else if (e.getSource()==leftbg_jl1)
		{
			//leftbg_jl1.setEnabled(true);
			cl_main.show(allmain_mainjpanel, "查询学生信息");
		}
		
	}
	@Override
	public void mousePressed(MouseEvent e)
	{
		// TODO Auto-generated method stub
		
	}
	@Override
	public void mouseReleased(MouseEvent e)
	{
		// TODO Auto-generated method stub
		
	}
	@Override
	public void mouseEntered(MouseEvent e)
	{
		// TODO Auto-generated method stub
		if (e.getSource()==leftbg_jl1)
		{
			leftbg_jl1.setEnabled(true);
		}else if (e.getSource()==leftbg_jl2) {
			leftbg_jl2.setEnabled(true);
		}else if (e.getSource()==leftbg_jl3) {
			leftbg_jl3.setEnabled(true);
		}else if (e.getSource()==leftbg_jl4) {
			leftbg_jl4.setEnabled(true);
		}
	}
	@Override
	public void mouseExited(MouseEvent e)
	{
		// TODO Auto-generated method stub
		if (e.getSource()==leftbg_jl1)
		{
			leftbg_jl1.setEnabled(false);
		}else if (e.getSource()==leftbg_jl2) {
			leftbg_jl2.setEnabled(false);
		}else if (e.getSource()==leftbg_jl3) {
			leftbg_jl3.setEnabled(false);
		}else if (e.getSource()==leftbg_jl4) {
			leftbg_jl4.setEnabled(false);
		}
	}
}
