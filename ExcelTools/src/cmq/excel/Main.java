package cmq.excel;

import java.util.Scanner;

import cmq.utils.ExcelUtils;

public class Main {
	public static void main(String[] args) {
		System.out.println("�����뿼�ڱ�����:(Ҫ������׺��)");
		Scanner scanner=new Scanner(System.in);
		while(true)
		{
			//2017��3�·��о�Ժ���ڱ�  - ��������.xls
			String path=scanner.nextLine();
			if(!path.endsWith(".xls"))
			{
				System.out.println("������*.xls��ʽ���ļ�����");
				continue;
			}
			if(!path.startsWith("./"))
			{
				path="./"+path;
			}
			ExcelUtils.readExcel(path);
			System.out.println("���������µ�"+path.substring(2, path.length() - 4) + "2.xls�ļ�");
			break;
		}
	}

	
}
