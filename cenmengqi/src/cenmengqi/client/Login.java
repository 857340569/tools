package cenmengqi.client;

import java.awt.Color;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

public class Login extends BaseFrame{
	private JPanel mainPanel;
	private JButton loginBtn,resetBtn;
	
	private JLabel labelName,labelPwd;
	private JTextField nameField;
	private JPasswordField passwordField;
	public Login() {
		setSize(1003,613);
		setResizable(false);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setTitle("登录");
		setLocation(width/2-getWidth()/2, height/2-getHeight()/2);
		mainPanel=createImgBgPanel("images/login_bg.png");
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
		
		
		loginBtn=createImgBtn("images/login_btn.png");
		loginBtn.setBounds(452, 388, 40, 33);
		mainPanel.add(loginBtn);
		
		resetBtn=createImgBtn("images/reset_btn.png");
		resetBtn.setBounds(500, 388, 40, 33);
		
		
		mainPanel.add(resetBtn);
		add(mainPanel);
		setVisible(true);
		
	}
	public static void main(String[] args) {
		new Login();
	}
}
