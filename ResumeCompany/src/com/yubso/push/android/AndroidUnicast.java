package com.yubso.push.android;

import com.yubso.push.base.AndroidPush;

public class AndroidUnicast extends AndroidPush {
	public AndroidUnicast() {
		try {
			this.setPredefinedKeyValue("type", "unicast");	
		} catch (Exception ex) {
			ex.printStackTrace();
			System.exit(1);
		}
	}
}