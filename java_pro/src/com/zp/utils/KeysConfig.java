package com.zp.utils;


/**
 * 加密key管理
 * @author zjp
 * @date 2016年7月19日
 */
public class KeysConfig {
	/*
	 * 二维码加密key
	 */
	public static int[] xorKey_QRCode = { //
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

	/**
	 * 获取加密参数key
	 */
	public static int[] xorKey_ServerData ={
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
}
