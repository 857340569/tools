package com.yubso.resumecompany.entity;

/**
 * PushMessage entity.
 * 推送消息表
 */

public class PushMessage implements java.io.Serializable {

	public enum FromType{
		COMPANY,HR,ADMIN,FRIEND
	}
	/**
	 * 
	 * SINGLE:向单一用户发送消息
	 * ALL：向所有用户发送消息
	 *
	 */
	public enum ToType{
		SINGLE,ALL
	}
	
	public enum MsgType{
		SYSTEM,JOB,FRIEND,ACTIVITY,ATTENTION
	}
	public enum ReceiveStatus{
		RECEIVED,SENDING
	}
	private Integer id;
	private String pushNo;
	private String action;//获取消息的action,eg:action=xxxxx?pushNo=32sdaskl32f31dcew349;
	private Integer msgFromId;//发送者id
	private String msgTo;//接收消息目标
	private Integer fromType;//发送者类型
	private Integer toType;//接收者类型
	private Integer contentId;//内容id
	private Integer msgType;//消息类型
	private String msgContent;//消息内容
	private String msgTitile;//消息标题
	private Integer receiveStatus;//接收状态
	private String pushTime;//发送时间

	// Constructors

	/** default constructor */
	public PushMessage() {
	}

	/** full constructor */
	public PushMessage(String pushNo, String action, Integer msgFromId,
			String msgTo, Integer fromType, Integer toType, Integer contentId,
			Integer msgType, String msgContent, String msgTitile,
			Integer receiveStatus, String pushTime) {
		this.pushNo = pushNo;
		this.action = action;
		this.msgFromId = msgFromId;
		this.msgTo = msgTo;
		this.fromType = fromType;
		this.toType = toType;
		this.contentId = contentId;
		this.msgType = msgType;
		this.msgContent = msgContent;
		this.msgTitile = msgTitile;
		this.receiveStatus = receiveStatus;
		this.pushTime = pushTime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPushNo() {
		return this.pushNo;
	}

	public void setPushNo(String pushNo) {
		this.pushNo = pushNo;
	}

	public String getAction() {
		return this.action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public Integer getMsgFromId() {
		return this.msgFromId;
	}

	public void setMsgFromId(Integer msgFromId) {
		this.msgFromId = msgFromId;
	}

	public String getMsgTo() {
		return this.msgTo;
	}

	public void setMsgTo(String msgTo) {
		this.msgTo = msgTo;
	}

	public Integer getFromType() {
		return this.fromType;
	}

	public void setFromType(Integer fromType) {
		this.fromType = fromType;
	}

	public Integer getToType() {
		return this.toType;
	}

	public void setToType(Integer toType) {
		this.toType = toType;
	}

	public Integer getContentId() {
		return this.contentId;
	}

	public void setContentId(Integer contentId) {
		this.contentId = contentId;
	}

	public Integer getMsgType() {
		return this.msgType;
	}

	public void setMsgType(Integer msgType) {
		this.msgType = msgType;
	}

	public String getMsgContent() {
		return this.msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public String getMsgTitile() {
		return this.msgTitile;
	}

	public void setMsgTitile(String msgTitile) {
		this.msgTitile = msgTitile;
	}

	public Integer getReceiveStatus() {
		return this.receiveStatus;
	}

	public void setReceiveStatus(Integer receiveStatus) {
		this.receiveStatus = receiveStatus;
	}

	public String getPushTime() {
		return this.pushTime;
	}

	public void setPushTime(String pushTime) {
		this.pushTime = pushTime;
	}

}