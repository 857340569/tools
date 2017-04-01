package cmq.excel;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import cmq.utils.StringUtils;

public class Test {
	public static void main(String[] args) {
		readExcel("2017��3�·��о�Ժ���ڱ�  - ��������.xls");
	}

	private static void readExcel(String path) {
		try {
			File file = new File(path);
			// ��ù�����
			Workbook workbook = WorkbookFactory.create(file);
			// ��ù��������
			int sheetCount = workbook.getNumberOfSheets();
			// ����������
			for (int i = 0; i < sheetCount; i++) {
				Sheet sheet = workbook.getSheetAt(i);
				// �����������
				int rows = sheet.getLastRowNum() + 1;
				// ����������Ȼ��һ�У��ڵõ���������
				Row tmp = sheet.getRow(0);
				if (tmp == null) {
					continue;
				}
				int cols = tmp.getPhysicalNumberOfCells();
				Map<String, Map<String,Integer>> sheetCounts=new HashMap<>();
				List<String> names=new ArrayList<>();
				String currentName="";
				
				// ��ȡ����
				for (int row = 0; row < rows; row++) {
					Row r = sheet.getRow(row);
					if (r == null)
						continue;
					for (int col = 0; col < cols; col++) {
						Cell cell = r.getCell(col);
						if (row % 3 == 0 && col == 1) {
							currentName=cell.getStringCellValue();
							if(StringUtils.isEmpty(currentName)||currentName.contains("��ǩ��ȷ��"))
							{
								continue;
							}
							names.add(currentName);
							HashMap<String,Integer> currentUser=new HashMap<>();
							sheetCounts.put(currentName, currentUser);
//							System.out.println("�õ������ˣ�" + r.getCell(col).getStringCellValue());
						}
//						System.out.println(currentName);
						CellType cellType = cell.getCellTypeEnum();
						if(sheetCounts.containsKey(currentName)&&col>=3&&col<=34&&cellType == CellType.STRING)
						{
							Map<String,Integer> currentUser=sheetCounts.get(currentName);
							String content=cell.getStringCellValue();
							if(!currentUser.containsKey(content))
							{
								currentUser.put(content, 1);
							}else
							{
								currentUser.put(content, currentUser.get(content)+1);
							}
						}

					}
				}
				
				//���ķ����ǵ��� �������ǳ��� 4�ǼӰ�ʱ��
				for (String name:names) {
					Map<String,Integer> temp=sheetCounts.get(name);
					if(temp==null) continue;
					System.out.print(name+":\t");
					Integer chuQin=temp.get("/");
					System.out.print("ʵ����:"+(chuQin==null?0:(float)temp.get("/")/2)+"��\t");
					Integer chuChai=temp.get("��");
					System.out.print("ʵ����:"+(float)temp.get("/")/2+"��\t����:"+(chuChai==null?0:(float)chuChai/2)+"��\t");
					Integer jiaBan=temp.get("4");
					System.out.print("����/����:"+(jiaBan==null?0:jiaBan*4)+"Сʱ\t");
					
					Integer shiJia=temp.get("��");
					System.out.print("�¼�:"+(shiJia==null?0:shiJia*4)+"Сʱ\t");
					
					Integer bingJia=temp.get("��");
					System.out.print("����:"+(bingJia==null?0:bingJia*4)+"Сʱ\t");
					
					Integer kuangGong=temp.get("��");
					System.out.print("����:"+(kuangGong==null?0:kuangGong*4)+"Сʱ\t");
					
					Integer tiaoXiu=temp.get("��");
					System.out.print("����:"+(tiaoXiu==null?0:tiaoXiu*4)+"Сʱ\t");
					
					Integer daiXin=temp.get("��");
					System.out.println("��н:"+(daiXin==null?0:(float)daiXin/2)+"Сʱ\t");
//					while (tempKeys.hasNext()) {
//						String keyTemp=tempKeys.next();
//						System.out.println(keyTemp+"��"+temp.get(keyTemp));
//					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
