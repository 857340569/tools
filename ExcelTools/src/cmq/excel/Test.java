package cmq.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import cmq.utils.StringUtils;

public class Test {
	public static void main(String[] args) {
//		readExcel("2017��3�·��о�Ժ���ڱ�  - ��������.xls");
		System.out.println("�����뿼�ڱ����֣�Ҫ������׺��������ʾ������ǰ�����ַ�����Tab�������Զ���ȫ���֣�");
		Scanner scanner=new Scanner(System.in);
		String path=scanner.nextLine();
		if(!path.endsWith(".xls"))
		{
			System.out.println("��");
			return;
		}
	}
	

	
}
