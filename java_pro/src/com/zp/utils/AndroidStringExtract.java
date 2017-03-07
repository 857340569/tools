package com.zp.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AndroidStringExtract {

	private List<String> test=new ArrayList<>();
	
	public static void main(String[] args) {
		String content="<string name=\"recharge_title\">充值</string>\r\n" + 
				"   	<string name=\"recharge_label_money\">充值金额：</string>\r\n" + 
				"   	<string name=\"recharge_money_tips\">请输入充值金额(元)</string>\r\n" + 
				"   	<string name=\"recharge_money_empty\">请输入充值的金额！</string>\r\n" + 
				"   	<string name=\"recharge_money_limit\">充值的金额不能小于0.01元！</string>\r\n" + 
				"   	<string name=\"recharge_money_failure\">账户信息未获取成功，正在重新获取&#8230;</string>\r\n" + 
				"   	<string name=\"recharge_label_way\">支付方式</string>\r\n" + 
				"   	<string name=\"recharge_way_alipay\">支付宝支付</string>\r\n" + 
				"   	<string name=\"recharge_way_wxpay\">微信支付</string>\r\n" + 
				"   	<string name=\"recharge_btn_text\">确认支付</string>\r\n" + 
				"   	<string name=\"recharge_ordering\">正在获取支付信息中&#8230;</string>\r\n" + 
				"   	<string name=\"recharge_paying\">订单正在处理中&#8230;</string>\r\n" + 
				"   	<string name=\"recharge_paying_error\">订单处理失败,请重试!</string>\r\n" + 
				"   	<string name=\"recharge_result\">支付结果</string>\r\n" + 
				"   	<string name=\"recharge_success\">支付成功</string>\r\n" + 
				"   	<string name=\"recharge_cancel\">取消支付!</string>\r\n" + 
				"   	<string name=\"recharge_failure\">支付失败</string>\r\n" + 
				"   	<string name=\"recharge_failure_tips\">支付遇到问题，请尝试重新支付</string>\r\n" + 
				"   	<string name=\"recharge_retry\">重新支付</string>\r\n" + 
				"   	<string name=\"recharge_close\">关闭</string>\r\n" + 
				"   	<string name=\"recharge_return\">返回</string>\r\n" + 
				"   	<string name=\"recharge_order_id\">支付单号</string>\r\n" + 
				"   	<string name=\"recharge_order_money\">支付金额</string>\r\n" + 
				"   	<string name=\"recharge_order_time\">支付时间</string>\r\n" + 
				"   	<string name=\"text_valid\">验证</string>\r\n" + 
				"   	<string name=\"text_yes\">是</string>\r\n" + 
				"   	<string name=\"text_no\">否</string>\r\n" + 
				"   	<string name=\"tips_teacher_valid\">该手机号已经成功绑定账号，请登录！</string>\r\n" + 
				"   	<string name=\"tips_teacher_reg_success\">绑定账号成功，请登录！</string>\r\n" + 
				"   	<string name=\"valid_teacher_info\"><Data><![CDATA[教师姓名：<font color=\"#0094E1\">%1$s</font>\\r\\n所在部门：<font color=\"#0094E1\">%2$s</font>]]></Data></string>\r\n" + 
				"   \r\n" + 
				"   	<!-- 其它用户界面 -->\r\n" + 
				"   	<string name=\"other_main_condition\">消费情况</string>\r\n" + 
				"   	<string name=\"other_main_personal\">个人消费</string>\r\n" + 
				"   	<string name=\"other_main_devices\">终端汇总</string>\r\n" + 
				"   	<string name=\"other_main_account\">账户余额</string>\r\n" + 
				"   	<string name=\"other_main_recharge\">充值</string>\r\n" + 
				"   	<string name=\"other_main_pay_records\">消费记录</string>\r\n" + 
				"   	\r\n" + 
				"   	<string name=\"other_label_order\">id编号</string>\r\n" + 
				"   	<string name=\"other_label_name\">姓名</string>\r\n" + 
				"   	<string name=\"other_label_total\">累计金额</string>\r\n" + 
				"   	<string name=\"other_label_department\">部门</string>\r\n" + 
				"   	<string name=\"other_label_money\">消费额</string>\r\n" + 
				"   	<string name=\"other_label_balance\">余额</string>\r\n" + 
				"   	<string name=\"other_label_terminal\">终端</string>\r\n" + 
				"   	<string name=\"other_label_terminal_no\">终端号</string>\r\n" + 
				"   	<string name=\"other_label_time\">时间</string>\r\n" + 
				"   	<string name=\"text_search_keyword\">关键词搜索</string>\r\n" + 
				"   	<string name=\"hint_startdate\">开始时间</string>\r\n" + 
				"   	<string name=\"hint_enddate\">截至时间</string>";
		
		String ex=">.*</";
		Pattern pattern1=Pattern.compile(ex);
		Matcher matcher=pattern1.matcher(content);
		
		while (matcher.find()) { 
			String item=matcher.group(0);
			item=item.substring(1,item.length()-2);
		    System.out.println(item);
		  } 
		
		
	}
}
