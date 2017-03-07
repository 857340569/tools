package com.zp.tools;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.ScrollPane;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class TestCreateEntity extends JFrame implements ActionListener {
	public static void main(String[] args) {
		new TestCreateEntity("自动生成entity");
	}
	private JButton buttonCreate;
	private JTextField packageNameView,classNameView;
	private JTextArea jsonAreaView;
	private ScrollPane scrollPane;
	public TestCreateEntity(String title)
	{
		super(title);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(400,500);
		
		setLayout(new BorderLayout(5,5)); 
		initViews();
		setVisible(true);
	}
	private void initViews() {
		buttonCreate=new JButton("生成");
		buttonCreate.addActionListener(this);
		packageNameView=new JTextField(10);
		packageNameView.setText("com.xxx.xxx");
		classNameView=new JTextField(10);
		scrollPane=new ScrollPane();
		jsonAreaView=new JTextArea();
		scrollPane.add(jsonAreaView);
		JPanel topPanel=new JPanel(new FlowLayout()); 
		topPanel.add(packageNameView);
		topPanel.add(classNameView);
		getContentPane().add(BorderLayout.NORTH, topPanel);
		getContentPane().add(BorderLayout.CENTER,scrollPane);
		getContentPane().add(BorderLayout.SOUTH,buttonCreate);
		
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		String packName=packageNameView.getText();
		String className=classNameView.getText();
		String jsonStr=jsonAreaView.getText();
		AutoEntityFile.createFileFromJson(jsonStr, className, packName);
	}
	
}
