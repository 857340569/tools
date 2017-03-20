package cenmengqi.client;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JPanel;

import cenmengqi.model.UserDao;

public class UserInterface extends BaseFrame implements ActionListener {
	private JPanel mainPanel;// 桌布
	private JButton searchBtn, exitBtn;// 按钮

	public UserInterface() {
		setSize(1003, 613);
		setResizable(false);
		setDefaultCloseOperation(EXIT_ON_CLOSE);// 关闭
		setTitle("一般用户界面");
		setIconImage(new ImageIcon("images/logo.png").getImage());
		setLocation(width / 2 - getWidth() / 2, height / 2 - getHeight() / 2);
		mainPanel = createImgBgPanel("images/login_bg.png");
		mainPanel.setLayout(null);

		searchBtn = new JButton("查询信息");
		searchBtn.setFocusPainted(false);
		// 注册点击事件
		searchBtn.addActionListener(this);
		searchBtn.setBounds(455, 250, 100, 30);
		mainPanel.add(searchBtn);

		exitBtn = new JButton("退出");
		exitBtn.setFocusPainted(false);
		// 注册点击事件
		exitBtn.addActionListener(this);
		exitBtn.setBounds(455, 310, 100, 30);
		mainPanel.add(exitBtn);

		add(mainPanel);
		setVisible(true);
	}

	public static void main(String[] args) {
		if(UserDao.DEBUG)
		{
			new UserInterface();
		}
	}

	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == searchBtn) {

		} else if (e.getSource() == exitBtn) {

		}
	}
}
