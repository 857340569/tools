package com.yubso.push.base;

import java.util.Iterator;
import java.util.Map;

import com.yubso.resumecompany.util.PushController.DisplayType;

public class PushService {
	public static boolean sendAndroidMessage(PushMessageSendHandler pushMessageSendHandler, AndroidPush androidPush,DisplayType displayType,String msgContent,Map<String, String> extra)
	{
		try {
			if(androidPush!=null)
			{
				androidPush.setPredefinedKeyValue("display_type", displayType.name().toLowerCase());
				androidPush.setPredefinedKeyValue("custom", msgContent);//用户自定义内容
				androidPush.setPredefinedKeyValue("production_mode", "true");
				if(extra!=null)
				{
					Iterator<String> extraKeys=extra.keySet().iterator();
					while(extraKeys.hasNext())
					{
						String key=extraKeys.next();
						String val=extra.get(key);
						androidPush.setExtraField(key, val);
					}
				}
				return androidPush.send(pushMessageSendHandler);
			}
		} catch (Exception e) {
			System.out.println(PushService.class.getName()+":"+e);
		}
		return false;
	}
}
