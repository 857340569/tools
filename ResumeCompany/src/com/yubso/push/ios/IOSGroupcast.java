package com.yubso.push.ios;

import com.yubso.push.base.IOSPush;

public class IOSGroupcast extends IOSPush {
	public IOSGroupcast() {
		try {
			this.setPredefinedKeyValue("type", "groupcast");	
		} catch (Exception ex) {
			ex.printStackTrace();
			System.exit(1);
		}
	}
}
