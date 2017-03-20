package cenmengqi.client;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.CardLayout;
import javax.swing.JPasswordField;
import javax.swing.JEditorPane;
import javax.swing.JScrollBar;
import javax.swing.JSlider;
import javax.swing.JSeparator;
import javax.swing.JSpinner;
import javax.swing.JFormattedTextField;
import javax.swing.JTable;
import javax.swing.JRadioButton;
import javax.swing.JCheckBox;

public class AdminFrame extends JFrame {

	private JPanel contentPane;
	private JPasswordField passwordField;
	private JTable table;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					AdminFrame frame = new AdminFrame();
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
	public AdminFrame() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(new CardLayout(0, 0));
		
		JRadioButton rdbtnNewRadioButton = new JRadioButton("New radio button");
		contentPane.add(rdbtnNewRadioButton, "name_8159348087225");
		
		table = new JTable();
		contentPane.add(table, "name_8150165116436");
		
		JFormattedTextField formattedTextField = new JFormattedTextField();
		contentPane.add(formattedTextField, "name_8130365570137");
		
		JSpinner spinner = new JSpinner();
		contentPane.add(spinner, "name_8124148974811");
		
		JSeparator separator = new JSeparator();
		contentPane.add(separator, "name_8121613062428");
		
		JSlider slider = new JSlider();
		contentPane.add(slider, "name_8118453144958");
		
		JScrollBar scrollBar = new JScrollBar();
		contentPane.add(scrollBar, "name_8114813094164");
		
		JEditorPane editorPane = new JEditorPane();
		contentPane.add(editorPane, "name_8110085202108");
		
		passwordField = new JPasswordField();
		contentPane.add(passwordField, "name_8102582485193");
		
		JCheckBox checkBox = new JCheckBox("火");
		contentPane.add(checkBox, "name_8166283392832");
	}

}
