package cmq.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class ExcelUtils {
	
	public static void readExcel(String path) {
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
				Map<String, Map<String, Integer>> sheetCounts = new HashMap<>();
				List<String> names = new ArrayList<>();
				String currentName = "";

				// 读取数据
				for (int row = 0; row < rows; row++) {
					Row r = sheet.getRow(row);
					if (r == null)
						continue;
					for (int col = 0; col < cols; col++) {
						Cell cell = r.getCell(col);
						if (cell == null)
							continue;// 合并了的单元格就不存在了，所以循环取可能就为空了
						if (row % 3 == 0 && col == 1) {
							currentName = cell.getStringCellValue();
							if (StringUtils.isEmpty(currentName) || currentName.contains("请签字确认")) {
								continue;
							}
							names.add(currentName);
							HashMap<String, Integer> currentUser = new HashMap<>();
							sheetCounts.put(currentName, currentUser);
							// System.out.println("得到名字了：" +
							// r.getCell(col).getStringCellValue());
						}
						// System.out.println(currentName);
						CellType cellType = cell.getCellTypeEnum();
						if (sheetCounts.containsKey(currentName) && col >= 3 && col <= 34
								&& cellType == CellType.STRING) {
							Map<String, Integer> currentUser = sheetCounts.get(currentName);
							String content = cell.getStringCellValue();
							if (!currentUser.containsKey(content)) {
								currentUser.put(content, 1);
							} else {
								currentUser.put(content, currentUser.get(content) + 1);
							}
						}

					}
				}

				// 空心方块是调休 三角形是出差 4是加班时间
				int count = 0;
				int rowIndex = 0;
				int colIndex = 0;
				for (String name : names) {
					count++;
					rowIndex = count * 3;
					colIndex = 35;
					Map<String, Integer> temp = sheetCounts.get(name);
					if (temp == null)
						continue;
					System.out.print(name + ":\t");
					Integer chuQin = temp.get("/");
					float cqv = chuQin == null ? 0 : (float) chuQin / 2;
					System.out.print("实出勤:" + cqv + "天\t");
					setCellVal(sheet, rowIndex, colIndex++, cqv);

					Integer chuChai = temp.get("△");
					float ccv = chuChai == null ? 0 : (float) chuChai / 2;
					System.out.print("出差:" + ccv + "天\t");
					setCellVal(sheet, rowIndex, colIndex++, ccv);

					Integer jiaBan = temp.get("4");
					float jbv = jiaBan == null ? 0 : jiaBan * 4;
					System.out.print("周六/日:" + jbv + "小时\t");
					setCellVal(sheet, rowIndex, colIndex++, jbv);

					// 如果无节假日 ，则需要注释掉
					Integer jieJiaRi = temp.get("节假日符号");
					float jjrv = jieJiaRi == null ? 0 : jieJiaRi * 4;
					System.out.print("节假日:" + jjrv + "小时\t");
					setCellVal(sheet, rowIndex, colIndex++, jjrv);

					Integer shiJia = temp.get("●");
					float sjv = shiJia == null ? 0 : shiJia * 4;
					System.out.print("事假:" + sjv + "小时\t");
					setCellVal(sheet, rowIndex, colIndex++, sjv);

					Integer bingJia = temp.get("○");
					float bjv = bingJia == null ? 0 : bingJia * 4;
					System.out.print("病假:" + bjv + "小时\t");
					setCellVal(sheet, rowIndex, colIndex++, bjv);

					Integer kuangGong = temp.get("＃");
					float kgv = kuangGong == null ? 0 : kuangGong * 4;
					System.out.print("旷工:" + kgv + "小时\t");
					setCellVal(sheet, rowIndex, colIndex++, kgv);

					Integer tiaoXiu = temp.get("□");
					float txv = tiaoXiu == null ? 0 : tiaoXiu * 4;
					System.out.print("调休:" + txv + "小时\t");
					setCellVal(sheet, rowIndex, colIndex++, txv);

					Integer daiXin = temp.get("◆");
					float dxv = daiXin == null ? 0 : daiXin * 4;
					System.out.println("带薪:" + dxv + "小时\t");
					setCellVal(sheet, rowIndex, colIndex++, dxv);
				}
			}
			// FileOutputStream out = new FileOutputStream(new File(path));
			FileOutputStream out = new FileOutputStream(new File(path.substring(0, path.length() - 4) + "2.xls"));
			workbook.write(out);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private static void setCellVal(Sheet sheet, int rowIndex, int colIndex, Object val) {

		Row row = sheet.getRow(rowIndex);
		if (row != null) {
			Cell cell = row.getCell(colIndex);
			if (cell != null && val != null) {
				String valStr = val.toString();
				if (valStr.endsWith(".0")) {
					valStr = valStr.substring(0, valStr.length() - 2);
				}
				cell.setCellValue(valStr);
			}
		}

	}
}
