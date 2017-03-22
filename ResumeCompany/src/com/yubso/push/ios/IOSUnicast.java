package com.yubso.push.ios;

import com.yubso.push.base.IOSPush;

public class IOSUnicast extends IOSPush {
	public IOSUnicast() {
		try {
			this.setPredefinedKeyValue("type", "unicast");	
		} catch (Exception ex) {
			ex.printStackTrace();
			System.exit(1);
		}
	}
}
