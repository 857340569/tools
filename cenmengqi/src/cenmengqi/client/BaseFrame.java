package cenmengqi.client;

import java.awt.Image;
import java.awt.Toolkit;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

import cenmengqi.utils.DrawBg;

public class BaseFrame extends JFrame{
	protected Toolkit tookit;
	protected int height;
	protected int width;
	
	public BaseFrame() {
		tookit=Toolkit.getDefaultToolkit();
		width=tookit.getScreenSize().width;
		height=tookit.getScreenSize().height;
	}
	/**
	 * 创建有背景图片的panel
	 * @param imgAbsPath
	 * @return
	 */
	protected DrawBg createImgBgPanel(String imgPath)
	{
//		DrawBg drawBg=new DrawBg(new ImageIcon(imgPath).getImage());
//		return drawBg;
		ImageIcon imageIcon=new ImageIcon(imgPath);
		Image image=imageIcon.getImage();
		DrawBg drawBg=new DrawBg(image);
		return drawBg;
		
	}
	
	/**
	 *创建图片按钮
	 */
	protected JButton createImgBtn(String imgPath) {
		return new JButton(new ImageIcon(imgPath));
		
	}
	/**
	 * 显示消息面板
	 * @param msg
	 */
	protected void showMessage(String msg) {
		JOptionPane.showMessageDialog(this, msg);
	}
	
}
