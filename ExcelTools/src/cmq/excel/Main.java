package cmq.excel;

import java.util.Scanner;

import cmq.utils.ExcelUtils;

public class Main {
	public static void main(String[] args) {
		System.out.println("请输入考勤表名字:(要包含后缀名)");
		Scanner scanner=new Scanner(System.in);
		while(true)
		{
			//2017年3月份研究院考勤表  - 工研中心.xls
			String path=scanner.nextLine();
			if(!path.endsWith(".xls"))
			{
				System.out.println("请输入*.xls格式的文件名称");
				continue;
			}
			if(!path.startsWith("./"))
			{
				path="./"+path;
			}
			ExcelUtils.readExcel(path);
			System.out.println("已生成最新的"+path.substring(2, path.length() - 4) + "2.xls文件");
			break;
		}
	}

	
}
