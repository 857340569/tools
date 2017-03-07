package com.zp.interfac;

import com.zp.tools.StringUtils;


public class DigestUtils {
	private static int[] qRXorKey = { //
			0xDE, 0xC5, 0x90, 0x2C, 0x78, 0x0E, 0x01, 0xC4, 0x07, 0x00, 0x1C, 0x3C, 0x40, 0xD4, 0x7E, 0x45, // 0
			0x7B, 0x7D, 0x4B, 0xDC, 0x06, 0xC3, 0x65, 0x64, 0xEC, 0xF6, 0x7A, 0x7B, 0xB7, 0x58, 0xEF, 0x4D, //
			0x14, 0x7D, 0x91, 0xAE, 0xC2, 0xC5, 0x20, 0xFC, 0x56, 0x47, 0x83, 0x88, 0x4A, 0x5C, 0x12, 0x13, //
			0xA3, 0x21, 0x5E, 0x93, 0x92, 0x51, 0x84, 0xBD, 0x1E, 0xBF, 0x9F, 0x17, 0xCD, 0xFE, 0x6B, 0xFE, //
			0xA8, 0xEF, 0x54, 0x07, 0xA4, 0xDA, 0x0F, 0xA8, 0xD2, 0xF7, 0x35, 0x8E, 0x35, 0x58, 0xE2, 0xD3, // 4
			0x4F, 0xFF, 0xD3, 0xF2, 0xA4, 0x92, 0x49, 0x14, 0x29, 0x24, 0x92, 0x49, 0x4A, 0x49, 0x24, 0x92, //
			0x52, 0x94, 0xDB, 0x4D, 0xCE, 0x61, 0xB1, 0xAC, 0x73, 0x98, 0xDF, 0xA4, 0xE0, 0x09, 0x02, 0x35, //
			0x3F, 0xB9, 0xFD, 0x44, 0x34, 0xEC, 0x70, 0xE1, 0x27, 0x5B, 0xB6, 0x0E, 0x73, 0x9B, 0x8F, 0x31, //
			0x1C, 0x60, 0x47, 0x87, 0xDB, 0x06, 0x3F, 0xA3, 0xF2, 0xF4, 0xF9, 0x54, 0x92, 0x49, 0x29, 0x1A, // 8
			0x27, 0xDA, 0xCA, 0x9D, 0xB5, 0xDB, 0x6A, 0x65, 0x5B, 0xEE, 0xFE, 0xA7, 0xA4, 0xCB, 0x6C, 0x58, //
			0x46, 0x24, 0xC7, 0x1D, 0x94, 0xC6, 0x45, 0xED, 0x8D, 0xB6, 0x3C, 0x43, 0x76, 0x08, 0x71, 0xFA, //
			0xD5, 0xCA, 0x0B, 0x43, 0xA6, 0xC8, 0xAD, 0xF0, 0x1A, 0xE7, 0x3C, 0x96, 0xD2, 0xDF, 0xA4, 0x4B, //
			0xF6, 0x9D, 0xC0, 0xB1, 0xAE, 0x1F, 0xA1, 0x75, 0x7E, 0xCB, 0x37, 0x7F, 0xC1, 0xA6, 0xCE, 0x5C, // C
			0x22, 0xD9, 0xF9, 0x5C, 0x23, 0x36, 0x51, 0x8C, 0x92, 0x01, 0x07, 0x50, 0xD5, 0x38, 0xB9, 0x02, //
			0xF3, 0x8F, 0xB0, 0x9B, 0x41, 0x8D, 0xA2, 0x0E, 0xA0, 0x6E, 0xEC, 0x9F, 0xEC, 0x79, 0x5B, 0x05, //
			0x82, 0xA7, 0x16, 0x16, 0xEE, 0x90, 0x27, 0xDB, 0xFB, 0xC7, 0xF7, 0x56, 0x8B, 0xEC, 0xB6, 0xDB };

	
	static int[] XorKey_CS ={
            0xC7, 0xF7, 0x56, 0x8B, 0xEC, 0xB6, 0xDB, 0xC4, 0x07, 0x00, 0x1C, 0x3C, 0x40, 0xD4, 0x7E, 0x45,
            0x46, 0x24, 0xC7, 0x1D, 0x94, 0xC6, 0x45, 0xED, 0x8D, 0xB6, 0x3C, 0x43, 0x76, 0x08, 0x71, 0xFA, 0x22, 0xD9, 0xF9, 0x5C, 
            0x23, 0x36, 0x51, 0x8C, 0x92, 0x01, 0x07, 0x50, 0xD5, 0x38, 0xB9, 0x02, 0x1C, 0x60, 0x47, 0x87, 0xDB, 0x06, 0x3F, 0xA3,
            0xF2, 0xF4, 0xF9, 0x54, 0x92, 0x49, 0x29, 0x1A, 0xA8, 0xEF, 0x54, 0x07, 0xA4, 0xDA, 0x0F, 0xA8, 0xD2, 0xF7, 0x35, 0x8E,
            0x35, 0x58, 0xE2, 0xD3, 0x3F, 0xB9, 0xFD, 0x44, 0x34, 0xEC, 0x70, 0xE1, 0x27, 0x5B, 0xB6, 0x0E, 0x73, 0x9B, 0x8F, 0x31,
            0x4F, 0xFF, 0xD3, 0xF2, 0xA4, 0x92, 0x49, 0x14, 0x29, 0x24, 0x92, 0x49, 0x4A, 0x49, 0x24, 0x92, 0x52, 0x94, 0xDB, 0x4D,
            0xCE, 0x61, 0xB1, 0xAC, 0x73, 0x98, 0xDF, 0xA4, 0xE0, 0x09, 0x02, 0x35, 0x14, 0x7D, 0x91, 0xAE, 0xC2, 0xC5, 0x20, 0xFC,
            0x56, 0x47, 0x83, 0x88, 0x4A, 0x5C, 0x12, 0x13, 0xA3, 0x21, 0x5E, 0x93, 0x92, 0x51, 0x84, 0xBD, 0x1E, 0xBF, 0x9F, 0x17,
            0xCD, 0xFE, 0x6B, 0xFE, 0x27, 0xDA, 0xCA, 0x9D, 0xB5, 0xDB, 0x6A, 0x65, 0x5B, 0xEE, 0xFE, 0xA7, 0xA4, 0xCB, 0x6C, 0x58,
            0xD5, 0xCA, 0x0B, 0x43, 0xA6, 0xC8, 0xAD, 0xF0, 0x1A, 0xE7, 0x3C, 0x96, 0xD2, 0xDF, 0xA4, 0x4B, 0xF6, 0x9D, 0xC0, 0xB1, 
            0xAE, 0x1F, 0xA1, 0x75, 0x7E, 0xCB, 0x37, 0x7F, 0xC1, 0xA6, 0xCE, 0x5C, 0x7B, 0x7D, 0x4B, 0xDC, 0x06, 0xC3, 0x65, 0x64,
            0xEC, 0xF6, 0x7A, 0x7B, 0xB7, 0x58, 0xEF, 0x4D, 0xF3, 0x8F, 0xB0, 0x9B, 0x41, 0x8D, 0xA2, 0x0E, 0xA0, 0x6E, 0xEC, 0x9F,
            0xEC, 0x79, 0x5B, 0x05, 0x82, 0xA7, 0x16, 0x16, 0xEE, 0x90, 0x27, 0xDB, 0xFB, 0xDE, 0xC5, 0x90, 0x2C, 0x78, 0x0E, 0x01
        };

	// 加密
	private static String getXORCodeX(String str) {
		
		String tmpStr = "";
		String retStr = "";
		String iStr=str.substring(0, 2);
//		str=iStr+StringUtils.utf8ToUnicode(str.substring(2));
		str=StringUtils.utf8ToUnicode(str);
		int iStrIndex = str_16_int(iStr);
		char[] strArr = str.toCharArray();
		int iStrLen = strArr.length;
		for (int i = 0; i < iStrLen; i++) {
			// tmpStr+=Format('%.02X', [ord(strArr[i]) xor QRXorKey[(iStrIndex +
			// i) mod 256]]);
			int casci = (int) strArr[i];
			int key = XorKey_CS[(iStrIndex + i+1) % 256];
			String tem = Integer.toHexString(casci ^ key);
			if (tem.length() < 2) {
				tem = "0" + tem;
			}
			tmpStr += tem;
		}
		
		retStr =iStr+ tmpStr;
		return retStr.toUpperCase();

	}

	// 解密
	public static String getXORDeCode(String str) {
		String tmpStr = "";
		String iDentifier = str.substring(0, 2);
		int i, iStrLen;
		int iDecIndex;
		iStrLen = str.length() / 2;
		char[] strArr = str.toCharArray();
		iDecIndex = str_16_int(iDentifier);
		for (i = 2; i <= iStrLen; i++) {// strArr[(i-1)*2] +""+
										// strArr[(i-1)*2+1]
			int strParHex = str_16_int(str.substring((i - 1) * 2, (i - 1) * 2 + 2));
			int keyHex = XorKey_CS[(i + iDecIndex - 1) % 256];
			int bc = strParHex ^ keyHex;
			tmpStr += (char) bc;
		}
		tmpStr=StringUtils.unicodeToUtf8(tmpStr).substring(2);
		return tmpStr;
	}

	public static int str_16_int(String hexStr) {
//		int x = 0;
//		char[] hexArr = hexStr.toCharArray();
//		for (int i = 0; i < hexStr.length(); i++) {
//			x = x * 16 + char_16_int(hexArr[i]);
//		}
//		return x;
		return Integer.parseInt(hexStr,16);
	}

	
	//将16进制字符转成10进制
	public static int char_16_int(char hex_char) {

//		if (hex_char >= '0' && hex_char <= '9')
//			return (int) hex_char - (int) '0';
//		if (hex_char >= 'a' && hex_char <= 'f')
//			return 10 + (int) hex_char - (int) 'a';
//		if (hex_char >= 'A' && hex_char <= 'F')
//			return 10 + (int) hex_char - (int) 'A';
//		return -1;
		return Integer.parseInt(String.valueOf(hex_char),16);
	}

	public static void main(String[] args) {
//		String abc = getXORCodeX("ABsn=prjSER3KB_TJ&mc=4D7BEC44F35555A9C53F49F1&v=1053&md=5221");
//		System.out.println(abc);
//		String dec = "AB374A0294E8BA7929F58DFFC351A563C298F9C928CBA98486EC5AE2414A8D044AF493FB1D1B9ACC6F650268CAA327716DE4088C31D5E2D4A674BF903F";
//		System.out.println(dec);
//		System.out.println(getXORDeCode(abc));
//		System.out.println("AB" + getXORDeCode(dec));

		// ok sn=prjSER3KB_TJ&mc=4D7BEC44F35555A9C53F49F1&v=1053&md=5221
		// String
		// str="AB374A0294E8BA7929F58DFFC351A563C298F9C928CBA98486EC5AE2414A8D044AF493FB1D1B9ACC6F650268CAA327716DE4088C31D5E2D4A674BF903F";

		// ok sn=prjSER3KB_TJ.exe&mc=3F739943F55055D4C2383E8
		// String
		// str="AB374A0294E8BA7929F58DFFC351A563C298F1C13393BBADD2932CE7424DF20E4BF2E0FB6912ECCC18177563BFAA324268E4";
		// String
		// str="AB374A0294E8BA7929F58DFFC351A563C298F1C13393BBADD2932CE7424DF20E4BF2E0FB6912ECCC18177563BFAA324268E4";

		// String
		// str="AB374A294E8BA7929F58DFFC351A563C298F9C928CBA98486EC5AE2414A8D44AF493FB1D1B9ACC6F65268CAA327716DE488C31D5E2D4A674BF93F";
		// String
		// tr2="AB374A294E8BA7929F58DFFC351A563C298F9C928CBA98486EC5AE2414A8D44AF493FB1D1B9ACC6F65268CAA327716DE488C31D5E2D4A674BF93F";
//		String tr2 = "AB374A0294E8BA7929F58DFFC351A563C298F9C928CBA98486EC5AE2414A8D044AF493FB1D1B9ACC6F650268CAA327716DE4088C31D5E2D4A674BF903F";
		// System.out.println(getXORDeCode(tr2));
		// for(int i=64;i<100;i++)
		// {
		// System.out.println((char)i);
		// }
//		System.out.println(Integer.toHexString(12));
//		 System.out.println(str_16_int("AB"));
//		System.out.println(toHexString("AB"));
//		System.out.println((int)'s');
//		System.out.println((char)115);
//		String jiami=getXORCodeX("AB中文");
//		System.out.println(jiami);
//		System.out.println(getXORDeCode(jiami));
//		System.out.println((int)'1');
//		System.out.println();
//		System.out.println(char_16_int('a'));
//		System.out.println(Integer.parseInt("1111",2));
//		System.out.println(string2Unicode("a"));
//		System.out.println(StringUtils.utf8ToUnicode("a"));
//		String teString="AB94FB5869E5FA3F7196F89AB22AD70EA4E2EF900FC6ADF4889E2F97414EFB054DF196FD1D4B4D78EE36F3565DDCC6494E8768DD0EC3BF82A971BD944A905EDAAEDC496D36B297202EDEA011E2CBEEF3D51C483834F7C760B2DC86EDF037302E0E70E44D047614F52FA4F676D9BD860877463842CD12E9CD6E130662B5A2313469E5088A312C5074B1EB360B95C2C4CA63A2791A2898DF673194EA3C9DE2C706BC0568D6E70F89CE7004DC44D2176B853D43ABBC057FCFE7C394A27A201914A17A7A7910A462A4E879FE51839E43A8EDE7D0393007244DA5E8F2F517CE6677B5BF7A6C262A931168A7A261B68F2E8FAC56FDCE58CC17EAF9A985EB58266BDECC9594FB581EE5FA3C7196F89BC72AD708D3E2EF927AC6ADF6F59E2F97404EFB054DF196FD1D4B4D79EE3FF35425D4B0383F821DDF7FC6CC83AA75C8934F942BDCDAD83C1944B4952252D8A7179FCEEC84A1183D3C45F2B115B8DC86E9F637302E7F70E44C777614F325A4F673DCBD860A00463847B912E9CD65130667B8A2313562E5088A432C5074B6EB360C92C2C4CB17A2791B2898DF623F94EA39EDE2C703BF0568D4970F89CB7104DC42D3176B854F43ABBD0376CFE2B39CD40B501C61A27B7F0A17A366D1EA0CFA2481E947DD9DE5D63B3671224AA1EAF7F761CD6202B1CC7F1A512093116CA1A261B6FE2E8FAD25FDCE5DC617EAFCAE85EB5C236BDEC8E294FB5B6CE5FA3D7296F89BC32AD70BA2E2EF9679C6ADF3F09E2F934749FE044FF995F86F4E4C0EE836F35756DCC648388768DD7FC3BF86A371BD953A905EDAAADC496D46B2972023DEA010EBCBEEF3A81C483847F7C760CEDC86EDF137302E0E70E44D047614F52FA4F676DDBD860F77463842CD12E9CA69130663C8A2313468E5088A372C5074BFEB360C93C2C4CA62A2791A2398DF673494EA3D9AE2C707CD0568D0E10F89CA7404DC47D3176B804F43ABBA027FCFE7C794A27C261914A17A7A7910D062A4EF7FFE5184EA43A8EA90D0393674244DA39CF2F513BD6677B0B87A6C205093116CA1A261B38D2E8FA825FDCE5DBF17EAFFAE85EB5E506BDECB9594FB5F6BE5FA3F0196F899C22AD709D0E2EF917FC6ADF4F09E2F94404EFB004DF196F81F4B4D79EE36F35625DCC648498768D97CC3BF84A371BD973C905EDFAFDC496D36B2972222DEA0119DCBEEF2A61C483A42F7C761CADC86EFF137302B0470E44A007614F124A4F676D9BD860B7B463845BE12E9CC68130665C8A2313065E5088D462C5071C6EB3609E1C2C4CE61A2791D5E98DF613394EA39EAE2C706BD0568D6950F89CB0504DC44D8176B853B43ABBB757FCFE6C694A27F231914A1787A7910D162A4E87CFE51859E43A8E99CD0393774244DA596F2F514B86677B4BE7A6C272693116AA4A261B08B2E8FA955FDCE5DCD17EAFDA485EB595C6BDEC99094FB5A6BE5FA3D0796F89AC02AD709A2E2EF9179C6ADF5879E2F954C4EFB003EF196FB6F4B4D78EC36F35125DCC64C4D8768DA7BC3BF84AE71BD9448905EDBAADC496D34B2972524DEA0139ACBEEF3D21C483C33F7C764C8DC86E9F637302B0C70E449777614F15CA4F670DEBD860970463845C212E9CC6E130663BEA2313411E5088A332C5075C4EB360D91C2C4CE64A2791E2898DF624694EA3A9BE2C700BD0568D6EB0F89C87604DC45D4176B813C43ABB9727FCFE1C094A27A551914A07B7A7912A362A4EF75FE51849E43A8EC94D0393406244DA59AF2F516BA6677B4BE7A6C265093116DA0A261B0F92E8FA822FDCE5DCC17EAFCD985EB59546BDEC8E294FB5A6DE5FA3D0696F899C22AD70AD0E2EF9008C6ADF6F59E2F95304EFB0049F196F86E4B4D7EEF36F3565DDCC64F4A8768DA74C3BF85AC71BD973C905EDBDEDC496F46B2972527DEA013E9CBEEF3A81C483B40F7C762B3DC86EF8037302B0A70E448767614F325A4F671ACBD860B72463844CF12E9CA6D130665C9A2313369E5088C372C5071BEEB360C96C2C4CE66A2791C2398DF624394EA3A99E2C706CA0568D0E10F89CF0704DC42D3176B813D43ABB8077FCFE5C194A27F2C1914A40F7A7913A162A4EC79FE51839E43A8ECE5D0393105244DA3EDF2F512CE6677B4BB7A6C2525931168A0A261B2852E8FA951FDCE5CCD17EAFDA985EB5F506BDEC99594FB5A1BE5FA397196F89EB12AD70EA4E2EF927AC6ADF4899E2F94474EFB044FF196F86F4B4D7FE836F35322DCC64D4D8768DB0EC3BF83A871BD964A905EDBAADC496D37B2972052DEA014EACBEEF3D51C483834F7C760CEDC86EFF637302A7A70E44A067614F159A4F671A8BD860B75463847C812E9CC6F130662B5A2313261E5088C3B2C5072B0EB360A91C2C4CE15A2791D5998DF673694EA3B9AE2C703B60568D7920F89C97C04DC44A5176B813843ABB9027FCFE0C194A27C551914A4087A7912A362A4EF7AFE51829543A8E8E5D0393401244DA59DF2F513C96677B4BA7A6C272A931168D7A261B18C2E8FAC53FDCE59CC17EAFDD9";
//		System.out.println(getXORDeCode(teString));
//		System.out.println(string2Unicode("AB中文"));;
//		System.out.println(StringUtils.utf8ToUnicode("AB中文"));;
//		System.out.println((char)Integer.parseInt("6587",16));;
		
		//进制转换
		//二进制转换成10进制
		System.out.println(Integer.parseInt("101", 2));
		
		//1、获取字符的ASCII码
		char c='张';
		int ascii=(int)c;
		System.out.println(ascii);//24352
		//2、将ASCCII码转换成字符
		int as=24352;
		char cs=(char)as;
		System.out.println(cs);//张
		//3、将10进制转成16进制
		String hexStr=Integer.toHexString(as);//5f20
		System.out.println(hexStr);
		//4、将16进制转换成10进制
		int dec=Integer.parseInt(hexStr, 16);
		System.out.println(dec);//24352
		System.out.println((char)dec);//张
		//5、异或运算
		int a = 1,b = 2,d;
		d=a^b;
		System.out.println(d);//3
		System.out.println(d^b);//1
		System.out.println(a^d);//2
		
		String aaString="我爱你";
		for(int i=0;i<aaString.length();i++)
		{
			System.out.print((int)aaString.charAt(i));
			System.out.print("  ");
		}
		
	}

	/**
	 * 字符串转换unicode
	 */
	public static String string2Unicode(String string) {
	 
	    StringBuffer unicode = new StringBuffer();
	 
	    for (int i = 0; i < string.length(); i++) {
	 
	        // 取出每一个字符
	        char c = string.charAt(i);
	        // 转换为unicode
	        unicode.append("\\u" + Integer.toHexString(c));
	    }
	 
	    return unicode.toString();
	}
	
	public static String toHexString(String s) {
		String str = "";
		for (int i = 0; i < s.length(); i++) {
			int ch = (int) s.charAt(i);
			String s4 = Integer.toHexString(ch);
			str = str + s4;
		}
		return str;
	}
}
