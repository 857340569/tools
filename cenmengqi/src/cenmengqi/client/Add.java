package cenmengqi.client;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import cenmengqi.bean.User;
import cenmengqi.model.UserDao;
import cenmengqi.utils.StringUtils;
import javax.swing.JRadioButton;

public class Add extends BaseFrame implements ActionListener {
	private JPanel mainPanel;// 桌布
	private JButton exitBtn, ensuretBtn;// 按钮

	private JLabel name,number,Pwd,department,sex,education,nativePlace,userType;// 用户名
	private JTextField nameField,numberField,departmentField,eduField,nativePlaceField,userTypeField;// 输入框
	private JPasswordField pwdField;
	private JRadioButton sexMan;
	private JRadioButton sexWoman;

	public Add() {
		setSize(1003, 613);
		setResizable(false);
		setDefaultCloseOperation(EXIT_ON_CLOSE);// 关闭
		setTitle("添加用户");
		setIconImage(new ImageIcon("images/logo.png").getImage());
		setLocation(width / 2 - getWidth() / 2, height / 2 - getHeight() / 2);
		mainPanel = createImgBgPanel("images/content_bg.png");
//		mainPanel=new JPanel();
		mainPanel.setLayout(null);

		name = new JLabel("姓名");
		name.setForeground(Color.white);
		name.setBounds(240, 100, 48, 33);
		mainPanel.add(name);

		nameField = new JTextField(20);
		nameField.setBounds(300, 100, 120, 33);
		mainPanel.add(nameField);
		
		number = new JLabel("编号");
		number.setForeground(Color.white);
		number.setBounds(550, 100, 120, 33);
		mainPanel.add(number);

		numberField = new JTextField(20);
		numberField.setBounds(610, 100, 120, 33);
		mainPanel.add(numberField);
		
		Pwd = new JLabel("密码");
		Pwd.setForeground(Color.white);
		Pwd.setBounds(240, 150, 48, 33);
		mainPanel.add(Pwd);

		pwdField = new JPasswordField(20);
		pwdField.setBounds(300, 150, 120, 33);
		mainPanel.add(pwdField);
		
		department = new JLabel("部门");
		department.setForeground(Color.white);
		department.setBounds(550, 150, 120, 33);
		mainPanel.add(department);

		departmentField = new JTextField(20);
		departmentField.setBounds(610, 150, 120, 33);
		mainPanel.add(departmentField);
		
		sex = new JLabel("性别");
		sex.setForeground(Color.white);
		sex.setBounds(240, 200, 48, 33);
		mainPanel.add(sex);
		
		ButtonGroup buttonGroup=new ButtonGroup();
		sexMan = new JRadioButton("男");
		sexMan.setSelected(true);
		sexMan.setBounds(299, 205, 48, 23);
		sexMan.setForeground(Color.white);
		sexMan.setFocusPainted(false);
		//设置radiobutton 背景透明
		sexMan.setContentAreaFilled(false);
		mainPanel.add(sexMan);
		
		sexWoman = new JRadioButton("女");
		sexWoman.setBounds(357, 205, 48, 23);
		sexWoman.setForeground(Color.white);
		sexWoman.setFocusPainted(false);
		sexWoman.setContentAreaFilled(false);
		mainPanel.add(sexWoman);
		
		buttonGroup.add(sexMan);
		buttonGroup.add(sexWoman);
		
		education = new JLabel("学历");
		education.setForeground(Color.white);
		education.setBounds(550, 200, 120, 33);
		mainPanel.add(education);

		eduField = new JTextField(20);
		eduField.setBounds(610, 200, 120, 33);
		mainPanel.add(eduField);
		
		nativePlace = new JLabel("出生地");
		nativePlace.setForeground(Color.white);
		nativePlace.setBounds(240, 250, 48, 33);
		mainPanel.add(nativePlace);

		nativePlaceField = new JTextField(20);
		nativePlaceField.setBounds(300, 250, 120, 33);
		mainPanel.add(nativePlaceField);
		
		userType = new JLabel("用户类型");
		userType.setForeground(Color.white);
		userType.setBounds(550, 250, 120, 33);
		//mainPanel.add(userType);

		userTypeField = new JTextField(20);
		userTypeField.setBounds(610, 250, 120, 33);
	//	mainPanel.add(userTypeField);

		ensuretBtn = new JButton("确定");
		ensuretBtn.setFocusPainted(false);
		// 注册点击事件
		ensuretBtn.addActionListener(this);
		ensuretBtn.setBounds(300, 500, 80, 30);
		mainPanel.add(ensuretBtn);

		exitBtn = new JButton("退出");
		exitBtn.setFocusPainted(false);
		// 注册点击事件
		exitBtn.addActionListener(this);
		exitBtn.setBounds(600, 500, 80, 30);
		mainPanel.add(exitBtn);

		getContentPane().add(mainPanel);
		setVisible(true);

	}
	public Add(User us){
		this();
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new Add();

	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		if (e.getSource() == ensuretBtn) {
			String userName=nameField.getText();
			String number=numberField.getText();
			String pwd=pwdField.getText();
			String department=departmentField.getText();
			String sex=sexMan.isSelected()?"男":"女";
			String edu=eduField.getText();
			String userNative=nativePlaceField.getText();
			if(StringUtils.isEmpty(userName,number,pwd,department,sex,edu,userNative))
			{
				showMessage("请完善员工信息！");
				return;
			}
			User user=UserDao.queryUserByNumber(number);
			//如果根据这个编号查询出来员工信息了，说明这个员工已经存在了
			if(user!=null)
			{
				showMessage("员工编号已经存在！");
				return;
			}
			user=new User(userName, number, pwd, department, sex, edu, userNative);
			boolean isSuccess=UserDao.addUser(user);
			if(isSuccess)
			{
				showMessage("员工信息已经添加！");
				dispose();
			}else
			{
				showMessage("员工信息添加失败！");
			}
					
		} else if (e.getSource() == exitBtn) {
			dispose();//关掉窗口  而不退出应用
		}
	}
}
