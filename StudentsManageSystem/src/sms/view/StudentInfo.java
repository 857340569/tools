package sms.view;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.Color;
import java.awt.Cursor;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.Timer;

import sms.model.LoginModel;
import sms.model.StudentModel;
import sms.model.Students;
import sms.tools.DrawBg;
import sms.tools.MyFontsOrOther;

public class StudentInfo extends JFrame implements ActionListener,MouseListener
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String id;
	//����˵�
	JMenuBar jmb;
	JMenu jm1,jm2,jm3,jm4,jm5,jm6;
	JMenuItem jm1_jmi1,jm1_jmi2,jm1_jmi3,jm2_jmi1,jm2_jmi2,jm2_jmi3,jm5_jmi1,jm5_jmi2,jm6_jmi1,jm6_jmi2;
	//�����м䲿��
	JPanel center_jp1,center_jp2,center_jp3,center_jp3_jp1,center_jp3_jp2,center_jp4,all_jp;
	CardLayout cl1,cl2,cl3;
	DrawBg dBg;
	JLabel center_jp1_jl1,center_jp1_jl2, center_jp1_jl3,center_jp2_jl1,center_jp2_jl2,center_jp3_jp2_jl1,center_jp3_jp2_jl2,center_jp3_jp2_jl3,center_jp3_jp2_jl4,dbg3_jl1,dbg3_jl2,dbg3_jl3;
	JPasswordField center_jp3_jp2_jpf1,center_jp3_jp2_jpf2,center_jp3_jp2_jpf3;
	JSplitPane jsp;
	Cursor cursor,testCursor;
	JButton center_jp3_jb1,center_jp3_jp2_jb1,center_jp3_jp2_jb2;
	Image imagebg,bottombg;
	ShowStuInfo ssiInfo,ssiEdit;
	JComboBox jcb,jcb2,jcb3,jcb4;
	JButton jcb_jb1,jcb2_jb1,jcb4_jb1;
	JTable jt,jt1,jt2;
	JScrollPane jt_jspane,jt1_jspane,jt2_jspane;
	StudentModel stuModel,stuModel2,stuModel3;
	//����״̬��
	
	JLabel jp3_jl1,jp3_jl2;
	Timer timer;
	SimpleDateFormat sdf;
	
	public StudentInfo(String welcome)
	{
		id=welcome;
		//�����˵� 
		jmb=new JMenuBar();
		//����һ���˵�
		jm1=new JMenu("��Ϣ����(M)");
		jm1.addSeparator();
		jm1.setMnemonic('M');
		jm1.setFont(MyFontsOrOther.f2);
		//���������˵�
		
		 jm1_jmi1=new JMenuItem("������Ϣ");
		 jm1_jmi1.setFont(MyFontsOrOther.f3);
		 jm1_jmi1.addActionListener(this);
		 
		 jm1_jmi2=new JMenuItem("��Ϣ�޸�");
		 jm1_jmi2.setFont(MyFontsOrOther.f3);
		 jm1_jmi2.addActionListener(this);
		 jm1_jmi3=new JMenuItem("�����޸�");
		 jm1_jmi3.setFont(MyFontsOrOther.f3);
		 jm1_jmi3.addActionListener(this);
		 
		jm2=new JMenu("�ɼ���ѯ(S)");
		jm2.setMnemonic('S');
		jm2.setFont(MyFontsOrOther.f2);
		jm2_jmi1=new JMenuItem("��ѧ��");
		jm2_jmi1.addActionListener(this);
		jm2_jmi1.setFont(MyFontsOrOther.f3);
		jm2_jmi2=new JMenuItem("��ѧ��");
		jm2_jmi2.setFont(MyFontsOrOther.f3);
		jm2_jmi2.addActionListener(this);
		jm2_jmi3=new JMenuItem("�ҿ����");
		jm2_jmi3.setFont(MyFontsOrOther.f3);
		jm2_jmi3.addActionListener(this);
		jm3=new JMenu("��������(N)");
		jm3.setMnemonic('N');
		jm3.setFont(MyFontsOrOther.f2);
		jm4=new JMenu("�γ�Ԥѡ(C)");
		jm4.setMnemonic('C');
		jm4.setFont(MyFontsOrOther.f2);
		jm5=new JMenu("��½����(L)");
		jm5.setMnemonic('L');
		jm5.setFont(MyFontsOrOther.f2);
		jm5_jmi1=new JMenuItem("�л���½(C)");
		jm5_jmi1.setMnemonic('C');
		jm5_jmi1.setFont(MyFontsOrOther.f3);
		jm5_jmi1.addActionListener(this);
		jm5_jmi2=new JMenuItem("�˳�ϵͳ(E)");
		jm5_jmi2.setMnemonic('E');
		jm5_jmi2.setFont(MyFontsOrOther.f3);
		jm5_jmi2.addActionListener(this);
		jm6=new JMenu("����(H)");		
		jm6.setMnemonic('H');
		
		jm6.setFont(MyFontsOrOther.f2);
		jm6_jmi1=new JMenuItem("help(H)");
		jm6_jmi1.setFont(MyFontsOrOther.f3);
		jm6_jmi1.setMnemonic('H');
		jm6_jmi1.addActionListener(this);
		jm6_jmi2=new JMenuItem("����(A)");
		jm6_jmi2.setMnemonic('A');
		jm6_jmi2.setFont(MyFontsOrOther.f3);
		jm6_jmi2.addActionListener(this);
		
		//�Ѷ����˵��ӵ�һ���˵� ��
		jm1.add(jm1_jmi1);
		jm1.add(jm1_jmi2);
		jm1.add(jm1_jmi3);
		
		jm2.add(jm2_jmi1);
		jm2.add(jm2_jmi2);
		jm2.add(jm2_jmi3);
		
		jm5.add(jm5_jmi1);
		jm5.add(jm5_jmi2);
		
		jm6.add(jm6_jmi1);
		jm6.add(jm6_jmi2);
		//��һ���˵��ӵ�JMenuBar��
		jmb.add(jm1);
		jmb.add(jm2);
		jmb.add(jm3);
		jmb.add(jm4);
		jmb.add(jm5);
		jmb.add(jm6);
		
		//�����м䲿��
		//������Ϣ����˵�ģ��
		imagebg=Toolkit.getDefaultToolkit().getImage("images/admin_login_bg.gif");
		dBg=new DrawBg(imagebg);
		cursor=new Cursor(Cursor.HAND_CURSOR);
		//testCursor=Toolkit.getDefaultToolkit().createCustomCursor(new ImageIcon("images/login.png").getImage(),new Point(0, 0), "Test");
		//����Ϣ����������˵�
		center_jp1=new JPanel(new BorderLayout());
		dBg.setLayout(new GridLayout(3,1));
		center_jp1_jl1=new JLabel("������Ϣ",JLabel.CENTER);
		center_jp1_jl1.setForeground(new Color(31,66,40));
		center_jp1_jl1.setFont(MyFontsOrOther.f4);
		center_jp1_jl1.addMouseListener(this);
		
		center_jp1_jl1.setEnabled(false);
		center_jp1_jl2=new JLabel("��Ϣ�޸�",JLabel.CENTER);
		center_jp1_jl2.setForeground(new Color(31,66,40));
		center_jp1_jl2.setFont(MyFontsOrOther.f4);
		center_jp1_jl2.addMouseListener(this);
		center_jp1_jl2.setEnabled(false);
		center_jp1_jl3=new JLabel("�����޸�",JLabel.CENTER);
		center_jp1_jl3.setForeground(new Color(31,66,40));
		center_jp1_jl3.setFont(MyFontsOrOther.f4);
		center_jp1_jl3.addMouseListener(this);
		center_jp1_jl3.setEnabled(false);
		dBg.add(center_jp1_jl1);
		dBg.add(center_jp1_jl2);
		dBg.add(center_jp1_jl3);
		/**
		 * �������������˵�������СJPanel
		 */
		cl1=new CardLayout();
		center_jp2=new JPanel(cl1);
		center_jp2_jl1=new JLabel(new ImageIcon("images/arrl.gif"));
		center_jp2_jl1.addMouseListener(this);
		center_jp2_jl2=new JLabel(new ImageIcon("images/arrr.gif"));
		center_jp2_jl2.addMouseListener(this);
		center_jp2.add(center_jp2_jl1,"left");
		center_jp2.add(center_jp2_jl2,"right");
		center_jp1.add(dBg);
		//��������˵��л�center_jp1
		
		/**�����ɼ���ѯģ��������˵�
		 * 
		 */
		DrawBg dbg3=new DrawBg(imagebg);
		
		dbg3_jl1=new JLabel("��ѧ��",JLabel.CENTER);
		dbg3_jl1.setForeground(new Color(31,66,40));
		dbg3_jl1.setFont(MyFontsOrOther.f4);
		dbg3_jl1.addMouseListener(this);
		dbg3_jl1.setEnabled(false);
		
		dbg3_jl2=new JLabel("��ѧ��",JLabel.CENTER);
		dbg3_jl2.setForeground(new Color(31,66,40));
		dbg3_jl2.setFont(MyFontsOrOther.f4);
		dbg3_jl2.addMouseListener(this);
		dbg3_jl2.setEnabled(false);
		
		dbg3_jl3=new JLabel("�ҿ����",JLabel.CENTER);
		dbg3_jl3.setForeground(new Color(31,66,40));
		dbg3_jl3.setFont(MyFontsOrOther.f4);
		dbg3_jl3.addMouseListener(this);
		dbg3_jl3.setEnabled(false);
		
		dbg3.setLayout(new GridLayout(3, 1));
		dbg3.add(dbg3_jl1);
		dbg3.add(dbg3_jl2);
		dbg3.add(dbg3_jl3);
		//����all_jpΪ��Ƭ���֣���������ʾ��ͬ���ܵ������˵���JPanel
		cl3=new CardLayout();
		all_jp=new JPanel(cl3);
		all_jp.add(center_jp1,"��Ϣ��ѯ");
		all_jp.add(dbg3,"�ɼ���ѯ");
		
		//������ʾ��Ϣ��JPanel
		ssiInfo=new ShowStuInfo(welcome,false);
		center_jp3_jp1=new JPanel(new BorderLayout());
		//�����޸���Ϣ��JPanel
		ssiEdit=new ShowStuInfo(welcome,true);
		center_jp3_jb1=new JButton("�޸�");
		center_jp3_jp1.add(ssiEdit,"Center");
		JPanel jp1=new JPanel();
		jp1.add(center_jp3_jb1);
		center_jp3_jp1.add(jp1,"South");
		center_jp3_jb1.addActionListener(this);
		//�����޸������JPanel
		int width=Toolkit.getDefaultToolkit().getScreenSize().width-150;
		int height=Toolkit.getDefaultToolkit().getScreenSize().height-100;
		center_jp3_jp2=new JPanel(new BorderLayout());
		center_jp3_jp2_jl1=new JLabel("�޸�����",JLabel.CENTER);
		center_jp3_jp2_jl1.setFont(MyFontsOrOther.f2);
		
		center_jp3_jp2_jl2=new JLabel("ԭʼ���룺",JLabel.CENTER);
		center_jp3_jp2_jl2.setFont(MyFontsOrOther.f3);
	
		center_jp3_jp2_jl2.setBounds(width/4,height/4, 150, 25);
		center_jp3_jp2_jpf1=new JPasswordField(20);
		center_jp3_jp2_jpf1.setBounds(width/2, height/4, 150, 25);
		center_jp3_jp2_jl3=new JLabel("�����룺",JLabel.CENTER);
		center_jp3_jp2_jl3.setFont(MyFontsOrOther.f3);
		center_jp3_jp2_jl3.setBounds(width/4, height/2, 150, 25);
		center_jp3_jp2_jpf2=new JPasswordField(20);
		center_jp3_jp2_jpf2.setBounds(width/2,height/2, 150, 25);
		center_jp3_jp2_jl4=new JLabel("ȷ�����룺",JLabel.CENTER);
		center_jp3_jp2_jl4.setFont(MyFontsOrOther.f3);
		center_jp3_jp2_jl4.setBounds(width/4, 3*height/4, 150, 25);
		center_jp3_jp2_jpf3=new JPasswordField(20);
		center_jp3_jp2_jpf3.setBounds(width/2,  3*height/4, 150, 25);
		JPanel jp2=new JPanel(null);
		jp2.add(center_jp3_jp2_jl2);
		jp2.add(center_jp3_jp2_jpf1);
		jp2.add(center_jp3_jp2_jl3);
		jp2.add(center_jp3_jp2_jpf2);
		jp2.add(center_jp3_jp2_jl4);
		jp2.add(center_jp3_jp2_jpf3);
		
		JPanel jp3=new JPanel();
		center_jp3_jp2_jb1=new JButton("ȷ���޸�");
		center_jp3_jp2_jb1.addActionListener(this);
		
		center_jp3_jp2_jb2=new JButton("����");
		center_jp3_jp2_jb2.addActionListener(this);
		
		jp3.add(center_jp3_jp2_jb1);
		jp3.add(center_jp3_jp2_jb2);
		center_jp3_jp2.add(center_jp3_jp2_jl1,"North");
		center_jp3_jp2.add(jp2,"Center");
		center_jp3_jp2.add(jp3,"South");
		/**
		 * ������ʾ��ѧ���ѯ�ɼ���JPanel
		 */
		JPanel yearjp1=new JPanel(new BorderLayout());
		JPanel yearjp1_jp1=new JPanel(new FlowLayout(FlowLayout.CENTER));
		JLabel yearjp1_jp1_jl1=new JLabel("��ѧ���ѯ��");
		String year[]={"2010-2011","2011-2012","2012-2013"};
		jcb=new JComboBox(year);
		jcb_jb1=new JButton("��ѯ");
		jcb_jb1.addActionListener(this);
		stuModel=new StudentModel();
		
		stuModel.getScore("","","", welcome);
		jt=new JTable(stuModel);
		jt_jspane=new JScrollPane(jt);
		yearjp1_jp1.add(yearjp1_jp1_jl1);
		yearjp1_jp1.add(jcb);
		yearjp1_jp1.add(jcb_jb1);
		yearjp1.add(yearjp1_jp1,"North");
		yearjp1.add(jt_jspane,"Center");
		/**
		 * ������ʾ��ѧ�ڲ�ѯ�ɼ���JPanel
		 */
		String term[]={"��һѧ��","�ڶ�ѧ��"};
		JLabel jcb2jl1=new JLabel("��ѡ��:");
		String year2[]={"2010-2011","2011-2012","2012-2013"};
		jcb2=new JComboBox(year2);
		jcb3=new JComboBox(term);
		jcb2_jb1=new JButton("ȷ��");
		jcb2_jb1.addActionListener(this);
		JPanel termjp1=new JPanel(new BorderLayout());
		JPanel jcb2jp1=new JPanel(new FlowLayout(FlowLayout.CENTER));
		stuModel2=new StudentModel();
		stuModel2.getScore("","","", welcome);
		jt1=new JTable(stuModel2);
		
		jt1_jspane=new JScrollPane(jt1);
		jcb2jp1.add(jcb2jl1);
		jcb2jp1.add(jcb2);
		jcb2jp1.add(jcb3);
		jcb2jp1.add(jcb2_jb1);
		termjp1.add(jcb2jp1,"North");
		termjp1.add(jt1_jspane,"Center");
		/**
		 * ������ʾ���Ƿ�ҿƵ�JPanel
		 */
		String isPass[]={"ͨ��","δͨ��"};
		JPanel isPassjp1=new JPanel(new BorderLayout());
		JPanel selectIsPassjp1=new JPanel();
		JLabel selectIsPassjp1_jl1=new JLabel("��ѡ��:");
		jcb4=new JComboBox(isPass);
		
		jcb4_jb1=new JButton("��ѯ");
		jcb4_jb1.addActionListener(this);
		selectIsPassjp1.add(selectIsPassjp1_jl1);
		selectIsPassjp1.add(jcb4);
		selectIsPassjp1.add(jcb4_jb1);
		stuModel3=new StudentModel();
		stuModel3.getScore("", "", "", welcome);
		jt2=new JTable(stuModel3);
		jt2_jspane=new JScrollPane(jt2);
		isPassjp1.add(selectIsPassjp1,"North");
		isPassjp1.add(jt2_jspane,"Center");
		//����һ��center_jp3Ϊ��Ƭ���֣���Ҫ��������ʾ��ͬ�Ĺ��ܵ�JPanel
		cl2=new CardLayout();
		center_jp3=new JPanel(cl2);
		center_jp3.add(ssiInfo,"������Ϣ");
		center_jp3.add(center_jp3_jp1,"��Ϣ�޸�");
		center_jp3.add(center_jp3_jp2,"�޸�����");
		center_jp3.add(yearjp1,"��ѧ���ѯ");
		center_jp3.add(termjp1,"��ѧ�ڲ�ѯ");
		center_jp3.add(isPassjp1,"�ҿ������ѯ");
		center_jp4=new JPanel(new BorderLayout());
		center_jp4.add(center_jp2,"West");
		center_jp4.add(center_jp3,"Center");
		jsp=new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,true,all_jp,center_jp4);
		jsp.setDividerLocation(150);
		jsp.setDividerSize(0);
//		dBg.add(center_jp2);
		
		//����״̬��
	
		sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		jp3_jl1=new JLabel("�� ǰ ʱ �䣺"+sdf.format(Calendar.getInstance().getTime())+" ");
		//��ʾ��ǰ��Ϣ
		jp3_jl2=new JLabel();
		
		DrawBg dBg2=new DrawBg(MyFontsOrOther.bottombg);
		//dBg2.setLayout(new FlowLayout(FlowLayout.RIGHT));
		dBg2.setLayout(new BorderLayout());
		jp3_jl1.setFont(MyFontsOrOther.f2);
		timer=new Timer(1000, this);
		timer.start();
//		dBg2.add(jp3_jl1);
//		dBg2.add(jp3_jl2);
		dBg2.add(jp3_jl1,"East");
		dBg2.add(jp3_jl2,"West");
		//jp3.setBackground(new Color(121,224,94));
		//�Ѳ˵��赽��JFrame��
		this.setJMenuBar(jmb);
		this.add(jsp,"Center");
		this.add(dBg2,"South");
		this.setSize(MyFontsOrOther.width,MyFontsOrOther.height-25);
		this.setTitle(" �� ӭ "+welcome+" �� �� ѧ �� �� �� ϵ ͳ");
		this.setIconImage(Toolkit.getDefaultToolkit().getImage("images/stu_Title_image.png"));
		this.setVisible(true);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
	}
	public void actionPerformed(ActionEvent e)
	{
		jp3_jl1.setText("�� ǰ ʱ �䣺"+sdf.format(Calendar.getInstance().getTime())+"");
		if (e.getSource()==jm1_jmi1)
		{
			
			cl3.show(all_jp,"��Ϣ��ѯ");
			cl2.show(center_jp3, "������Ϣ");
			StudentModel studentModel=new StudentModel();
			Students student=studentModel.showAllInfo(id);
			ssiInfo.jtf2.setText(student.getStuName());
			ssiInfo.jtf3.setText(student.getStuSex());
			ssiInfo.jtf4.setText(student.getStuBirth().substring(0,10));
			ssiInfo.jtf5.setText(student.getStuGrade());
			ssiInfo.jtf6.setText(student.getStuDept());
			ssiInfo.jtf7.setText(student.getStuJob());
			ssiInfo.jtf8.setText(student.getStuPL());
			
		}
		else if (e.getSource()==jm1_jmi2)
		{
			cl3.show(all_jp,"��Ϣ��ѯ");
			cl2.show(center_jp3, "��Ϣ�޸�");
		}
		else if(e.getSource()==jm1_jmi3)
		{
			cl3.show(all_jp,"��Ϣ��ѯ");
			cl2.show(center_jp3,"�޸�����");
		}
		else if (e.getSource()==jm2_jmi1)
		{
			
			cl3.show(all_jp,"�ɼ���ѯ");
			cl2.show(center_jp3, "��ѧ���ѯ");
			if (jt1.getRowCount()==0)
			{
				MyFontsOrOther.showMessage("��Ϣ", "���޳ɼ���", JOptionPane.INFORMATION_MESSAGE);
				//JOptionPane.showMessageDialog(this, "���޳ɼ�","��Ϣ",JOptionPane.INFORMATION_MESSAGE);
			}
		}
		else if (e.getSource()==jm2_jmi2)
		{
			cl3.show(all_jp,"�ɼ���ѯ");
			cl2.show(center_jp3, "��ѧ�ڲ�ѯ");
		}
		else if (e.getSource()==jm2_jmi3)
		{
			cl3.show(all_jp,"�ɼ���ѯ");
			cl2.show(center_jp3, "�ҿ������ѯ");
		}
	
		else if (e.getSource()==center_jp3_jb1) {
			String id=this.ssiEdit.jtf1.getText().trim();
			String name=this.ssiEdit.jtf2.getText().trim();
			String sex=this.ssiEdit.jtf3.getText().trim();
			String birthday=this.ssiEdit.jtf4.getText().trim();
			String grade=this.ssiEdit.jtf5.getText().trim();
			String dept=this.ssiEdit.jtf6.getText().trim();
			String job=this.ssiEdit.jtf7.getText().trim();
			String pl=this.ssiEdit.jtf8.getText().trim();
			Students student=new Students(id, name,sex,birthday,grade,dept,job,pl);
			StudentModel studentModel=new StudentModel();
			int i=studentModel.updateStuInfo(student);
			if (i==0)
			{
				JOptionPane.showMessageDialog(null, "�޸�ʧ��");
			}
			else {
				JOptionPane.showMessageDialog(null, "�޸ĳɹ�");
			}
			
			
		}
		
		else if (e.getSource()==jm5_jmi1)
		{
			int confirm=JOptionPane.showConfirmDialog(this, "ȷ���л���½��","",JOptionPane.YES_NO_OPTION);//,JOptionPane.INFORMATION_MESSAGE,new ImageIcon("images/add.png"));
			if (confirm==0)
			{
				new Login();
				this.dispose();
			}
			
			
		}
		else if (e.getSource()==jm5_jmi2) {
			int confirm=JOptionPane.showConfirmDialog(this, "ȷ���˳�ϵͳ��","",JOptionPane.YES_NO_OPTION);
			if (confirm==0)
			{
				System.exit(0);
			}
			else {
				return;
			}
		}
		else if(e.getSource()==jm6_jmi2) {
			new About(this,true);
		}
		else if (e.getSource()==center_jp3_jp2_jb1)
		{
			
			String beforePsw=new String(this.center_jp3_jp2_jpf1.getPassword()).trim();
			String afterPsw=new String(this.center_jp3_jp2_jpf2.getPassword()).trim();
			String againPsw=new String(this.center_jp3_jp2_jpf3.getPassword()).trim();
			if (afterPsw.equals(""))
			{
				JOptionPane.showMessageDialog(this, "�����벻��Ϊ��!");
			}
			else
			{
				if (afterPsw.equals(againPsw))
				{
					LoginModel lm=new LoginModel();
					String result=lm.editPsw(id, beforePsw, afterPsw);
					if (result.equals("success"))
					{
						JOptionPane.showMessageDialog(this, "�޸ĳɹ�");
						
					}
					else {
						JOptionPane.showMessageDialog(this, "ԭʼ���벻��ȷ");
					}
				}
				else {
					JOptionPane.showMessageDialog(this, "�������벻ͬ");
					center_jp3_jp2_jpf2.requestFocus();
				}
			}
			
			
		}else if(e.getSource()==center_jp3_jp2_jb2){
			center_jp3_jp2_jpf1.setText("");
			center_jp3_jp2_jpf2.setText("");
			center_jp3_jp2_jpf3.setText("");
		}
		else if (e.getSource()==jcb_jb1)
		{
			String year=(String) jcb.getSelectedItem();
			stuModel=new StudentModel();
			stuModel.getScore(year,"","",id);
			jt.setModel(stuModel);
//			jt.setBackground(Color.gray);
//			jt.setForeground(Color.green);
			
		}
		else if (e.getSource()==jcb2_jb1)
		{
			String year=(String) jcb2.getSelectedItem();
			String term=(String) jcb3.getSelectedItem();
			
			stuModel2=new StudentModel();
			stuModel2.getScore(year,term,"",id);
			jt1.setModel(stuModel2);
		}
		else if (e.getSource()==jcb4_jb1) {
			String selected=(String)jcb4.getSelectedItem();
			String isPass;
			if(selected.equals("ͨ��"))
			{
				isPass="��";
			}
			else {
				isPass="��";
			}
			stuModel3=new StudentModel();
			stuModel3.getScore("", "",isPass,id);
			jt2.setModel(stuModel3);
		}
	}
	@Override
	public void mouseClicked(MouseEvent e)
	{
		// TODO Auto-generated method stub
		if (e.getSource()==center_jp2_jl1)
		{
			cl1.show(center_jp2,"right");
			jsp.setDividerLocation(0);
			
		}else if (e.getSource()==center_jp2_jl2)
		{
			cl1.show(center_jp2,"left");
			jsp.setDividerLocation(150);
		
		}
		// TODO Auto-generated method stub
		else if(e.getSource()==center_jp1_jl1)
		{
			cl2.show(center_jp3,"������Ϣ");
			StudentModel studentModel=new StudentModel();
			Students student=studentModel.showAllInfo(id);
			ssiInfo.jtf2.setText(student.getStuName());
			ssiInfo.jtf3.setText(student.getStuSex());
			ssiInfo.jtf4.setText(student.getStuBirth().substring(0, 10));
			ssiInfo.jtf5.setText(student.getStuGrade());
			ssiInfo.jtf6.setText(student.getStuDept());
			ssiInfo.jtf7.setText(student.getStuJob());
			ssiInfo.jtf8.setText(student.getStuPL());
		} else if(e.getSource()==center_jp1_jl2)
		{
			cl2.show(center_jp3,"��Ϣ�޸�");
		}else if(e.getSource()==center_jp1_jl3)
		{
			cl2.show(center_jp3,"�޸�����");
		}
		else if(e.getSource()==dbg3_jl1){
			cl2.show(center_jp3, "��ѧ���ѯ");
		}
		else if(e.getSource()==dbg3_jl2){
			cl2.show(center_jp3,"��ѧ�ڲ�ѯ");
		}
		else if(e.getSource()==dbg3_jl3){
			cl2.show(center_jp3,"�ҿ������ѯ");
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
		if(e.getSource()==center_jp1_jl1)
		{
			center_jp1_jl1.setEnabled(true);
			center_jp1_jl1.setCursor(cursor);
			jp3_jl2.setText("��ʾ����ȫ����Ϣ");
			//center_jp1_jl1.setCursor(testCursor);//�ɹ�
		} else if(e.getSource()==center_jp1_jl2)
		{
			center_jp1_jl2.setEnabled(true);
			center_jp1_jl2.setCursor(cursor);
			jp3_jl2.setText("�޸ĸ�����Ϣ");
		}else if(e.getSource()==center_jp1_jl3)
		{
			center_jp1_jl3.setEnabled(true);
			center_jp1_jl3.setCursor(cursor);
			jp3_jl2.setText("�޸ĵ�½����");
		}else if (e.getSource()==center_jp2_jl1)
		{
			center_jp2_jl1.setCursor(cursor);
		}else if (e.getSource()==center_jp2_jl2)
		{
			center_jp2_jl1.setCursor(cursor);
		}
		else if(e.getSource()==dbg3_jl1){
			dbg3_jl1.setEnabled(true);
			dbg3_jl1.setCursor(cursor);
		}
		else if(e.getSource()==dbg3_jl2){
			dbg3_jl2.setEnabled(true);
			dbg3_jl2.setCursor(cursor);
		}
		else if(e.getSource()==dbg3_jl3){
			dbg3_jl3.setEnabled(true);
			dbg3_jl3.setCursor(cursor);
		}
		
	}
	@Override
	public void mouseExited(MouseEvent e)
	{
		// TODO Auto-generated method stub
		if(e.getSource()==center_jp1_jl1)
		{
			center_jp1_jl1.setEnabled(false);
			center_jp1_jl1.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
			jp3_jl2.setText("");
		}
		else if(e.getSource()==center_jp1_jl2)
		{
			center_jp1_jl2.setEnabled(false);
			center_jp1_jl2.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
			jp3_jl2.setText("");
		}else if(e.getSource()==center_jp1_jl3)
		{
			center_jp1_jl3.setEnabled(false);
			center_jp1_jl3.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
			jp3_jl2.setText("");
		}else if (e.getSource()==center_jp2_jl1)
		{
			center_jp2_jl1.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
		}else if (e.getSource()==center_jp2_jl2)
		{
			center_jp2_jl1.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
		}
		else if(e.getSource()==dbg3_jl1){
			dbg3_jl1.setEnabled(false);
			dbg3_jl1.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
		}
		else if(e.getSource()==dbg3_jl2){
			dbg3_jl2.setEnabled(false);
			dbg3_jl2.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
		}
		else if(e.getSource()==dbg3_jl3){
			dbg3_jl3.setEnabled(false);
			dbg3_jl3.setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
		}
		
	}
}
