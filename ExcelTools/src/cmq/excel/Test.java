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
		readExcel("2017年3月份研究院考勤表  - 工研中心.xls");
	}

	private static void readExcel(String path) {
		try {
			File file = new File(path);
			// 获得工作簿
			Workbook workbook = WorkbookFactory.create(file);
			// 获得工作表个数
			int sheetCount = workbook.getNumberOfSheets();
			// 遍历工作表
			for (int i = 0; i < sheetCount; i++) {
				Sheet sheet = workbook.getSheetAt(i);
				// 获得数据行数
				int rows = sheet.getLastRowNum() + 1;
				// 获得列数，先获得一行，在得到该行列数
				Row tmp = sheet.getRow(0);
				if (tmp == null) {
					continue;
				}
				int cols = tmp.getPhysicalNumberOfCells();
				Map<String, Map<String,Integer>> sheetCounts=new HashMap<>();
				List<String> names=new ArrayList<>();
				String currentName="";
				
				// 读取数据
				for (int row = 0; row < rows; row++) {
					Row r = sheet.getRow(row);
					if (r == null)
						continue;
					for (int col = 0; col < cols; col++) {
						Cell cell = r.getCell(col);
						if (row % 3 == 0 && col == 1) {
							currentName=cell.getStringCellValue();
							if(StringUtils.isEmpty(currentName)||currentName.contains("请签字确认"))
							{
								continue;
							}
							names.add(currentName);
							HashMap<String,Integer> currentUser=new HashMap<>();
							sheetCounts.put(currentName, currentUser);
//							System.out.println("得到名字了：" + r.getCell(col).getStringCellValue());
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
				
				//空心方块是调休 三角形是出差 4是加班时间
				for (String name:names) {
					Map<String,Integer> temp=sheetCounts.get(name);
					if(temp==null) continue;
					System.out.print(name+":\t");
					Integer chuQin=temp.get("/");
					System.out.print("实出勤:"+(chuQin==null?0:(float)temp.get("/")/2)+"天\t");
					Integer chuChai=temp.get("△");
					System.out.print("实出勤:"+(float)temp.get("/")/2+"天\t出差:"+(chuChai==null?0:(float)chuChai/2)+"天\t");
					Integer jiaBan=temp.get("4");
					System.out.print("周六/周日:"+(jiaBan==null?0:jiaBan*4)+"小时\t");
					
					Integer shiJia=temp.get("●");
					System.out.print("事假:"+(shiJia==null?0:shiJia*4)+"小时\t");
					
					Integer bingJia=temp.get("○");
					System.out.print("病假:"+(bingJia==null?0:bingJia*4)+"小时\t");
					
					Integer kuangGong=temp.get("＃");
					System.out.print("旷工:"+(kuangGong==null?0:kuangGong*4)+"小时\t");
					
					Integer tiaoXiu=temp.get("□");
					System.out.print("调休:"+(tiaoXiu==null?0:tiaoXiu*4)+"小时\t");
					
					Integer daiXin=temp.get("◆");
					System.out.println("带薪:"+(daiXin==null?0:(float)daiXin/2)+"小时\t");
//					while (tempKeys.hasNext()) {
//						String keyTemp=tempKeys.next();
//						System.out.println(keyTemp+"："+temp.get(keyTemp));
//					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
