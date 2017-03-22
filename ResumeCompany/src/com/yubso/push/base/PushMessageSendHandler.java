package com.yubso.push.base;

public interface PushMessageSendHandler {
	public void onMessageSended(boolean isSuccess,String message);
}
