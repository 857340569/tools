package sms.view;

import java.awt.Color;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.BorderFactory;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.UIManager;

import sms.model.LoginModel;
import sms.tools.DrawBg;
import sms.tools.MyFontsOrOther;

public class Login extends JFrame implements ActionListener
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	Image image1,image2,image3_title;

	JLabel dbg1_jl1,dbg2_jl1,dbg2_jl2;
	JTextField dbg2_jtf1;
	JPasswordField dbg2_jpf1;
	DrawBg dbg1,dbg2;
	JButton dbg2_jb1;
	
	public static void main(String[] args)
	{
		// TODO Auto-generated method stub
		 try
		{
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e)
		{
			// TODO: handle exception
			throw new RuntimeException(e);
		}
		new Login();
	}
	public Login()
	{
		//背景
		image1=Toolkit.getDefaultToolkit().getImage("images/admin_login_bg.gif");
		dbg1=new DrawBg(image1);
		dbg1.setLayout(null);
		int width=Toolkit.getDefaultToolkit().getScreenSize().width;
		int height=Toolkit.getDefaultToolkit().getScreenSize().height;
		
		dbg1_jl1= new JLabel("学  生  管  理  系 统",JLabel.CENTER);
		dbg1_jl1.setFont(MyFontsOrOther.f1);
		dbg1_jl1.setBounds(0,40,width, 100);
		dbg1_jl1.setForeground(new Color(41,119,44));
		//把学生管理系统这个标签加入到上
		dbg1.add(dbg1_jl1);
		image2=new ImageIcon("images/admin_login.png").getImage();
		//创建一个带有背景的Jpanel
		dbg2=new DrawBg(image2);
		//设置dbg2为空布局
		dbg2.setLayout(null);
		//创建用户名，密码两个JLabel和文本框，密码框及设置 字体大小 
		dbg2_jl1=new JLabel("用户名：");
		dbg2_jl1.setFont(MyFontsOrOther.f2);
		dbg2_jtf1=new JTextField(15);
		
		dbg2_jtf1.setFont(MyFontsOrOther.f2);
		dbg2_jtf1.setBorder(BorderFactory.createLoweredBevelBorder());
		dbg2_jtf1.setBackground(new Color(121,224,94));
		
		dbg2_jl2=new JLabel("密  码：");
		dbg2_jl2.setFont(MyFontsOrOther.f2);
		dbg2_jpf1=new JPasswordField(15);
		dbg2_jpf1.addActionListener(this);
		dbg2_jpf1.setBorder(BorderFactory.createLoweredBevelBorder());
		dbg2_jpf1.setBackground(new Color(121,224,94));
		//设置用户名，密码两个JLabel和文本框，密码框的位置，及大小 
		dbg2_jl1.setBounds(180, 30, 90, 30);
		dbg2_jl2.setBounds(180, 80, 90, 30);
		dbg2_jtf1.setBounds(240, 30, 180,30);
		dbg2_jpf1.setBounds(240, 80, 180,30);
		//设置中间的背景大小及位置
		dbg2.setBounds(width/2-250, height/2-100, 500,200);
		//设置中景背景的颜色
		dbg2.setBackground(new Color(121,224,94));
		
		dbg2_jb1=new JButton(new ImageIcon("images/admin_login_button.gif"));
	//	dbg2_jb1.setPressedIcon(new ImageIcon("images/bg.gif"));
		//dbg2_jb1.setRolloverIcon(new ImageIcon("images/bg.gif"));
		//注册监听
		dbg2_jb1.addActionListener(this);
//		设置按钮的位置及大小 		
		dbg2_jb1.setBounds(255,125,90,26);
		//把用户名，密码两个JLabel和文本框，密码框添加到dbg2上
		dbg2.add(dbg2_jl1);
		dbg2.add(dbg2_jl2);
		dbg2.add(dbg2_jtf1);
		dbg2.add(dbg2_jpf1);
		dbg2.add(dbg2_jb1);
		
		//氢dbg2加入 到dbg1的JPanel上面
		dbg1.add(dbg2);
		this.setSize(width,height);
		
		this.add(dbg1);
		this.setTitle("欢迎登陆学生管理系统!");
		//创建软件图标
		image3_title=new ImageIcon("images/login.png").getImage();
		this.setIconImage(image3_title);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setVisible(true);
	}
	public void actionPerformed(ActionEvent e)
	{
		
		if (e.getSource()==dbg2_jb1)
		{
			String name=this.dbg2_jtf1.getText().trim();
			String psw=new String(this.dbg2_jpf1.getPassword()).trim();
//			System.out.println(name);
//			System.out.println(psw);
			LoginModel lm=new LoginModel();
			String reslut=lm.check(name, psw).trim();
//			System.out.println(reslut);
//			System.out.println(reslut.trim().equals("管理员"));
			if (name.equals("")||psw.equals(""))
			{
				JOptionPane.showMessageDialog(null, "用户或密码为空");
				this.dbg2_jtf1.requestFocus();
			}
			else {
				if (reslut.equals("学生")||reslut.equals("班长"))
				{
					System.out.println("学生端登陆成功");
					new StudentInfo(name);
					this.dispose();
				}
				else if (reslut.equals("管理员")||reslut.equals("教师")) {
					System.out.println("教师端登陆成功");
					new TeacherManage(name);
					this.dispose();
				}
				else if (reslut.equals("pswError"))
				{
					JOptionPane.showMessageDialog(this, "密码错误！");
					this.dbg2_jpf1.requestFocus();
					return;
					
				}
				else {
					JOptionPane.showMessageDialog(this, "用户不存在或身份不明确！");
					this.dbg2_jtf1.requestFocus();
					return;
				}
			}
			
			
			
		}
	}

}
