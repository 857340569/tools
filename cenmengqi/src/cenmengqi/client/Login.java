package cenmengqi.client;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

public class Login extends BaseFrame implements ActionListener{
	private JPanel mainPanel;//桌布
	private JButton loginBtn,resetBtn;//按钮
	
	private JLabel labelName,labelPwd;//用户名
	private JTextField nameField;//输入框
	private JPasswordField passwordField;//密码框
	public Login() {
		setSize(1003,613);
		setResizable(false);
		setDefaultCloseOperation(EXIT_ON_CLOSE);//关闭
		setTitle("企业人事管理系统");
		setIconImage(new ImageIcon("images/logo.png").getImage());
		setLocation(width/2-getWidth()/2, height/2-getHeight()/2);
		mainPanel=createImgBgPanel("images/login_bg.png");
//		mainPanel=createImgBgPanel("images/ccc.jpg");
		mainPanel.setLayout(null);
		
		labelName=new JLabel("用户名");
		labelName.setForeground(Color.white);
		labelName.setBounds(400, 237, 40, 33);
		mainPanel.add(labelName);
		
		nameField=new JTextField(20);
		nameField.setBounds(450, 240, 120, 26);
		mainPanel.add(nameField);
		
		
		labelPwd=new JLabel("密码");
		labelPwd.setForeground(Color.white);
		labelPwd.setBounds(400, 278, 40, 33);
		mainPanel.add(labelPwd);
		
		passwordField=new JPasswordField(20);
		passwordField.setBounds(450, 280, 120, 26);
		mainPanel.add(passwordField);
		
		
//		loginBtn=createImgBtn("images/login_btn.png");
//		loginBtn.setBounds(452, 388, 40, 33);
//		mainPanel.add(loginBtn);
//		
//		resetBtn=createImgBtn("images/reset_btn.png");
//		resetBtn.setBounds(500, 388, 40, 33);
//		mainPanel.add(resetBtn);
		
		loginBtn=new JButton("登录");
		loginBtn.setFocusPainted(false);
		//注册点击事件
		loginBtn.addActionListener(this);
//		loginBtn.setForeground(Color.white);
		loginBtn.setBounds(455, 340, 80, 30);
		mainPanel.add(loginBtn);
		
		add(mainPanel);
		setVisible(true);
		
	}
	public static void main(String[] args) {
		new Login();
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource()==loginBtn)
		{
			
		}
	}
}
