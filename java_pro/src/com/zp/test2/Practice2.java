package com.zp.test2;

public class Practice2 {
	public static void main(String[] args) {
		 method1();
		 method2();
		 method3();
		 method4();
	}
	//工2元 母1.5 小0.5
	/**
	 * 解释有点勉强
	 */
	public static void method1()
	{
		System.out.println("Practice2.method1()");
		int count = 1;

		int poult = 1;
		int henMax=(int)(100/1.5);
		int record=0;//记录数
		for (int coke = 1; coke <100/2; coke ++) {
			for (int hen = 1; hen <henMax; hen++) {
				poult = 100 - (coke + hen);
				float result1 = 2 * coke + hen * 1.5F + poult / 2F;
				count++;
				if (result1 == 100.0) {
					record++;
					System.out.println("公鸡数：" + coke + "母鸡数：" + hen + "小鸡数："
							+ poult);
					henMax=hen;//公鸡最贵，公鸡越来越多，母鸡只能越来越少了
				}
			}
		}
		System.out.println("total:"+record);
		System.out.println("cala count:"+count);
	}
	/**
	 * 改进
	 */
	public static void method2()
	{
		System.out.println("Practice2.method2()");
		int count = 1;
		int poult = 1;
		int record=0;//记录数
		//100 为100钱
		for (int coke = 1; coke <100/2; coke ++) {
			//母鸡数量限制
			//100 为100钱
			int henMax=(int)((100-coke*2)/1.5);
			for (int hen = 1; hen <henMax; hen++) {
				//100 为100只
				poult = 100 - (coke + hen);
				float result1 = 2 * coke + hen * 1.5F + poult / 2F;
				count++;
				if (result1 == 100.0) {
					record++;
					System.out.println("公鸡数：" + coke + "母鸡数：" + hen + "小鸡数："
							+ poult);
				}
			}
		}
		System.out.println("total:"+record);
		System.out.println("cala count:"+count);
	}
	
	public static void method3()
	{
		System.out.println("Practice2.method3()");
		int count=0;
		int record=0;//记录数
		
		for (float i = 2; i < 100; i+=2) {//公鸡总钱数
			for (float j = 3; j < 100-i; j+=1.5) {//母鸡总钱数
				count++;
				int x=(int)i/2;
				int y=(int)(j/1.5);
				int z=(int)((100-i-j)/0.5);
				if(x+y+z==100)
				{
					record++;
					System.out.println("公鸡数：" +  x + " 母鸡数：" + y+ " 小鸡数："
							+ z);
				}
			}
		}
		System.out.println("total:"+record);
		System.out.println("cala count:"+count);
		
	}
	/**
	 * 三层循环计算量更大
	 */
	public static void method4()
	{
		System.out.println("Practice2.method4()");
		int count=0;
		int record=0;//记录数
		for (float i = 2; i < 100; i+=2) {
			for (float j = 1.5f; j < 100-i; j+=1.5) {
				for (float k = 0.5f; k <= 100-i-j; k+=0.5) {
					count++;
					int x=(int)i/2;
					int y=(int)(j/1.5);
					int z=(int)(k/0.5);
					if(x+y+z==100&&i+j+k==100f)
					{
						record++;
						System.out.println("公鸡数：" +  x + " 母鸡数：" + y+ " 小鸡数："+ z);
					}
				}
			}
		}
		System.out.println("total:"+record);
		System.out.println("cala count:"+count);
		
	}
}