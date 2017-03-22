package com.yubso.push.ios;

import com.yubso.push.base.IOSPush;

public class IOSBroadcast extends IOSPush {
	public IOSBroadcast() {
		try {
			this.setPredefinedKeyValue("type", "broadcast");	
		} catch (Exception ex) {
			ex.printStackTrace();
			System.exit(1);
		}
	}
}
