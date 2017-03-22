package com.yubso.push.android;

import com.yubso.push.base.AndroidPush;

public class AndroidBroadcast extends AndroidPush {
	public AndroidBroadcast() {
		try {
			this.setPredefinedKeyValue("type", "broadcast");	
		} catch (Exception ex) {
			ex.printStackTrace();
			System.exit(1);
		}
	}
}
