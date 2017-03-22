package com.yubso.resumecompany.util;

import java.util.Map;

import com.yubso.push.android.AndroidBroadcast;
import com.yubso.push.android.AndroidCustomizedcast;
import com.yubso.push.android.AndroidGroupcast;
import com.yubso.push.base.PushMessageSendHandler;
import com.yubso.push.base.PushService;

public class PushController {
	//消息类型，值为notification或者message
    //      notification-通知, message-消息.
	public enum DisplayType{
		NOTIFICATION,MESSAGE
	}
	/**
	 * 
	 * @param pushMessageSendHandler 发送消息处理结果回调函数 
	 * @param alias 别名
	 * @param msgContent action 字符串
	 * @return
	 */
	//向单个用户发送消息
	public static boolean sendSimpleAndroidMessageWithAlias(PushMessageSendHandler pushMessageSendHandler,String alias,String msgContent)
	{
		AndroidCustomizedcast customizedcast = new AndroidCustomizedcast(alias);
		return PushService.sendAndroidMessage(pushMessageSendHandler,customizedcast, DisplayType.MESSAGE, msgContent, null);
	}
	//向单个用户发送消息
	public static boolean sendSimpleAndroidMessageWithAlias(PushMessageSendHandler pushMessageSendHandler,String alias,String msgContent,Map<String, String> extra)
	{
		AndroidCustomizedcast customizedcast = new AndroidCustomizedcast(alias);
		return PushService.sendAndroidMessage(pushMessageSendHandler,customizedcast, DisplayType.MESSAGE, msgContent, extra);
	}
	//向所有用户发送消息
	public static boolean sendAllAndroidMessage(PushMessageSendHandler pushMessageSendHandler,String msgContent)
	{
		AndroidBroadcast androidBroadcast=new AndroidBroadcast();
		return PushService.sendAndroidMessage(pushMessageSendHandler,androidBroadcast, DisplayType.MESSAGE, msgContent, null);
	}
	//通过标签向android用户发消息
	public static boolean sendAndroidMessageByTags(PushMessageSendHandler pushMessageSendHandler,String msgContent,String ...tags)
	{
		AndroidGroupcast groupcast=new AndroidGroupcast(tags);
		return PushService.sendAndroidMessage(pushMessageSendHandler,groupcast, DisplayType.MESSAGE, msgContent, null);
	}
}
