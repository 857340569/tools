package sms.view;

import java.awt.Frame;

import javax.swing.JDialog;
import javax.swing.JLabel;

import sms.tools.MyFontsOrOther;

public class About extends JDialog
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JLabel jl1,jl2,jl3;
//	public static void main(String [] args)
//	{
//		new About();
//	}
	
	public void init()
	{
		jl1=new JLabel("����",JLabel.CENTER);
		jl2=new JLabel("ѧ������ϵͳ",JLabel.CENTER);
		jl3=new JLabel("���ߣ�SeekYou",JLabel.CENTER);
		this.add(jl1,"North");
		this.add(jl2,"Center");
		this.add(jl3,"South");
		this.setTitle("����");
		this.setSize(400,300);
		this.setLocation(MyFontsOrOther.width/3-100, MyFontsOrOther.height/3-150);
		this.setVisible(true);
	}
	public About(Frame frame,boolean modal)
	{
		super(frame,true);
		this.init();
	}
}
