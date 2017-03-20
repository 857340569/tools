package cenmengqi.client;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JPanel;

public class AdministratorInterface extends BaseFrame implements ActionListener {
	private JPanel mainPanel;// 桌布
	private JButton delBtn, addBtn, exitBtn, searchBtn;// 按钮

	public AdministratorInterface() {
		setSize(1003, 613);
		setResizable(false);
		setDefaultCloseOperation(EXIT_ON_CLOSE);// 关闭
		setTitle("管理员界面");
		setIconImage(new ImageIcon("images/logo.png").getImage());
		setLocation(width / 2 - getWidth() / 2, height / 2 - getHeight() / 2);
		mainPanel = createImgBgPanel("images/login_bg.png");
		mainPanel.setLayout(null);

		addBtn = new JButton("添加用户");
		addBtn.setFocusPainted(false);
		// 注册点击事件
		addBtn.addActionListener(this);
		addBtn.setBounds(455, 220, 100, 30);
		mainPanel.add(addBtn);

		delBtn = new JButton("删除用户");
		delBtn.setFocusPainted(false);
		// 注册点击事件
		delBtn.addActionListener(this);
		delBtn.setBounds(455, 260, 100, 30);
		mainPanel.add(delBtn);

		searchBtn = new JButton("信息查询");
		searchBtn.setFocusPainted(false);
		// 注册点击事件
		searchBtn.addActionListener(this);
		searchBtn.setBounds(455, 300, 100, 30);
		mainPanel.add(searchBtn);

		exitBtn = new JButton("退出");
		exitBtn.setFocusPainted(false);
		// 注册点击事件
		exitBtn.addActionListener(this);
		exitBtn.setBounds(455, 340, 100, 30);
		mainPanel.add(exitBtn);

		add(mainPanel);
		setVisible(true);
	}

	public static void main(String[] args) {
		new AdministratorInterface();
	}

	/**
	 * 点击按钮后
	 */

	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == delBtn) {

		} else if (e.getSource() == addBtn) {

		} else if (e.getSource() == searchBtn) {

		} else if (e.getSource() == exitBtn) {
			System.exit(0);

		}
	}
}
