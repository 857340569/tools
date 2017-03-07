package cenmengqi.client;

import java.awt.Toolkit;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;

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
		DrawBg drawBg=new DrawBg(new ImageIcon(imgPath).getImage());
		return drawBg;
	}
	
	/**
	 *创建图片按钮
	 */
	protected JButton createImgBtn(String imgPath) {
		return new JButton(new ImageIcon(imgPath));
		
	}
	
}
