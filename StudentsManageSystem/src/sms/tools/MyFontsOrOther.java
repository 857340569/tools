package sms.tools;

import java.awt.Font;
import java.awt.Image;
import java.awt.Toolkit;

import javax.swing.JOptionPane;

public class MyFontsOrOther
{
  public static Font f1=new Font("宋体",Font.PLAIN, 45);
  public static Font f2=new Font("宋体",Font.BOLD,16);
  public static Font f3=new Font("隶书",Font.PLAIN,14);
  public static Font f4=new Font("宋体",Font.BOLD,14);
  
  public static int width=Toolkit.getDefaultToolkit().getScreenSize().width;
  public static int height=Toolkit.getDefaultToolkit().getScreenSize().height;
  
  public static Image mainbg=Toolkit.getDefaultToolkit().getImage("images/admin_login_bg.gif");
  public static Image bottombg=Toolkit.getDefaultToolkit().getImage("images/bottombg.gif");
  public static Image mainbg2=Toolkit.getDefaultToolkit().getImage("images/bg.gif");
  public static void showMessage(String title,String content,int type)
  {
	  JOptionPane.showMessageDialog(null,content,title,type );
  }
}
