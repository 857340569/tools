

import java.awt.Component;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Vector;

import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableCellRenderer;

public class ImageViewTest {
 public static void main(String[] args){
  JFrame frame = new ImagViewFrame();
  frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
  frame.setLocation(600,200);
  frame.setVisible(true);
 }
}
class ImagViewFrame extends JFrame{
 public ImagViewFrame(){
  //set the frame
  setTitle("ImagViewTest");
  setSize(DEFAULT_WIDTH,DEFAULT_HEIGHT);
  
  
  Vector columnNames = new Vector();
  columnNames.add("Ë÷Òý");
  columnNames.add("ˆDÆ¬");
  columnNames.add("ÃèÊö");
  columnNames.add("•rég");
  ImageIcon icon = new ImageIcon("resource/images/headImg/h102.png");
  Vector rowData = new Vector();
  rowData.add(1);
  rowData.add(icon);
  rowData.add("7ÔÂ");
  rowData.add("2011-09-02");
  Vector cells = new Vector();
  cells.add(rowData);
  
  
  tableModel = new MyTableModel(cells,columnNames);
  table = new JTable(tableModel);
  table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
  JScrollPane scrollPane = new JScrollPane(table,
    JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED,
    JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
  add(scrollPane);
 }
 private static final int DEFAULT_WIDTH = 300;
 private static final int DEFAULT_HEIGHT = 400;
 private MyTableModel tableModel;
 private JTable table;
}
class MyTableModel extends DefaultTableModel{
 public MyTableModel(Vector cells,Vector columnNames){
  super(cells,columnNames);
 }
 public Class getColumnClass(int col){
  Vector v = (Vector) super.dataVector.elementAt(0);
  if(v.elementAt(col)!=null){
   return v.elementAt(col).getClass();
  }else{
   return "".getClass();
  }
 }
 public boolean isCellEditable(int row,int col){
  return false;
 }
}

