package cenmengqi.client;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.ListSelectionModel;
import javax.swing.border.EmptyBorder;

import cenmengqi.bean.User;
import cenmengqi.model.UserDao;
import cenmengqi.model.UserTableModel;

public class Query extends BaseFrame implements ActionListener{

	private JPanel contentPane;
	private JTextField textField;
	private JTable table;
	private JButton queryBtn;
	private JButton delBtn;
	private JButton editBtn;
	private List<User> users;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Query frame = new Query();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public Query() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(1003,613);
		setLocation(width/2-getWidth()/2, height/2-getHeight()/2);
		setTitle("查询");
		setIconImage(new ImageIcon("images/logo.png").getImage());
		contentPane=createImgBgPanel("images/content_bg.png");
//		contentPane=new JPanel();
        contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(null);
		setContentPane(contentPane);
		
		textField = new JTextField();
		textField.setText("请输入姓名");
		textField.setBounds(118, 37, 164, 23);
		contentPane.add(textField);
		textField.setColumns(10);

		queryBtn = new JButton("查询");
		queryBtn.setBounds(346, 37, 93, 23);
		queryBtn.addActionListener(this);
		contentPane.add(queryBtn);

		delBtn = new JButton("删除");
		delBtn.setBounds(644, 37, 93, 23);
		delBtn.addActionListener(this);
		contentPane.add(delBtn);

		table = new JTable();
		//设置单选
		table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		
		JScrollPane scrollPane=new JScrollPane(table);
		scrollPane.setBounds(78, 98, 839, 430);
		contentPane.add(scrollPane);
		
		editBtn = new JButton("编辑");
		editBtn.setBounds(495, 37, 93, 23);
		contentPane.add(editBtn);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource()==queryBtn)
		{
			String name=textField.getText();
			if(name.equals("请输入姓名"))
			{
				name="";
			}
			users=UserDao.queryUsers(name);
			UserTableModel tableModel=new UserTableModel(users);
//			DefaultTableModel model = (DefaultTableModel) table.getModel();
//			model.setColumnIdentifiers(tableModel.getTitles());
			table.setModel(tableModel);
		}else if(e.getSource()==delBtn)
		{
			int[] selectedRows=table.getSelectedRows(); 
			if (selectedRows.length==0)
			{
				JOptionPane.showMessageDialog(this, "请选择要删除的员工!");
			}else
			{
				int position=selectedRows[0];
				User user=users.get(position);
				int result=JOptionPane.showConfirmDialog(this,"确定要删除该员工信息吗？","信息提示",JOptionPane.YES_NO_OPTION);
				if(result==0)
				{
//					JOptionPane.showMessageDialog(this, user.getName()+" 信息已经删除");
					boolean  isSuccess=UserDao.deleteUser(user);
					if(isSuccess)
					{
						users.remove(user);
						UserTableModel tableModel=new UserTableModel(users);
						table.setModel(tableModel);
						JOptionPane.showMessageDialog(this, user.getName()+" 信息已经删除成功");
					}else{
						JOptionPane.showMessageDialog(this, user.getName()+" 信息删除失败");
					}
				}
			}
		}else if(e.getSource()==editBtn)
		{
			int[] selectedRows=table.getSelectedRows(); 
			if (selectedRows.length==0)
			{
				JOptionPane.showMessageDialog(this, "请选择要编辑的员工!");
			}else
			{
				int position=selectedRows[0];
				User user=users.get(position);
				new Add(user,"修改用户信息");
			}
		}
	}
}
