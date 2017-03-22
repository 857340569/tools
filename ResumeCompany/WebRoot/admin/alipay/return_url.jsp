<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.yubso.resumecompany.action.LoginAction"%>
<%@page import="com.yubso.resumecompany.entity.HumanResource"%>
<%@page import="com.yubso.resumecompany.entity.PaymentRecord.BuyerType"%>
<%@page import="com.yubso.resumecompany.entity.PaymentOrder.TraceStatus"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.yubso.resumecompany.alipay.config.*"%>
<%@ page import="com.yubso.resumecompany.alipay.util.*"%>
<%@ page import="com.yubso.resumecompany.util.*"%>
<%@page import="com.yubso.resumecompany.entity.Company"%>
<%@page import="com.yubso.resumecompany.entity.PaymentRecord"%>
<%@page import="com.yubso.resumecompany.entity.PaymentOrder"%>
<%@page import="com.yubso.resumecompany.util.SQLHelper.ExecuteType"%>
<html>
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝页面跳转同步通知页面</title>
  </head>
  <body>
<%
	//获取支付宝GET过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map requestParams = request.getParameterMap();
	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {valueStr = (i == values.length - 1) ? valueStr + values[i]: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		params.put(name, valueStr);
	}
	
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	//商户订单号
	String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//支付宝交易号
	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//交易状态
	String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
	//计算得出通知验证结果
	boolean verify_result = AlipayNotify.verify(params);
	if(verify_result){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码
		PaymentOrder paymentOrder=SQLHelper.queryEntityByConditions(PaymentOrder.class, "traceNo='"+out_trade_no+"'");
		if(paymentOrder!=null)
		{
			Object comTypeObj=session.getAttribute(LoginAction.COM_TIPE);
			if(comTypeObj==null)
			{
				response.sendRedirect("payError.jsp");
				return;
			}
			String comTypeStr=comTypeObj.toString().trim();
			if(!StringUtil.regMaches(StringUtil.NUM_REGEX,comTypeStr))
				return;
			int buyerType=BuyerType.values()[Integer.parseInt(comTypeStr)].ordinal();
			//创建充值记录
			PaymentRecord paymentRecord=new PaymentRecord();
			paymentRecord.setBuyerId(paymentOrder.getBuyerId());
			paymentRecord.setBuyerType(buyerType);
			paymentRecord.setGoodsName(paymentOrder.getGoodsName());
			paymentRecord.setMoney(paymentOrder.getTotalMoney());
			paymentRecord.setPayNum(paymentOrder.getTotalNum());
			paymentRecord.setBoughtDate(DateUtil.getNowDateStr(""));
			paymentRecord.setTraceNo(out_trade_no);
			//改变订单状态
			paymentOrder.setTraceStatus(TraceStatus.OK.ordinal());
			boolean updateResult=false;
			if(buyerType==BuyerType.COMPANY.ordinal())
			{
				//更新买家账户
				Company company=SQLHelper.queryEntityByConditions(Company.class, "id="+paymentOrder.getBuyerId());
				int accout=company.getAccountBalance()+paymentOrder.getTotalNum();
				company.setAccountBalance(accout);
				updateResult=SQLHelper.updateByTransation(new int[]{ExecuteType.UPDATE.ordinal(),ExecuteType.UPDATE.ordinal(),ExecuteType.ADD.ordinal()}, new String[]{"id="+paymentOrder.getBuyerId(),"",""},paymentOrder,company,paymentRecord);
			}
			else if(buyerType==BuyerType.HR.ordinal()){
				HumanResource hr=SQLHelper.queryEntityByConditions(HumanResource.class, "id="+paymentOrder.getBuyerId());
				int accout=hr.getPayAccount()+paymentOrder.getTotalNum();
				hr.setPayAccount(accout);
				updateResult=SQLHelper.updateByTransation(new int[]{ExecuteType.UPDATE.ordinal(),ExecuteType.UPDATE.ordinal(),ExecuteType.ADD.ordinal()}, new String[]{"id="+paymentOrder.getBuyerId(),"",""},paymentOrder,hr,paymentRecord);
			}
			if(!updateResult)
			{
				response.sendRedirect("payError.jsp");
				return;
			}
		}
		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		if(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")){
	//判断该笔订单是否在商户网站中已经做过处理
		//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
		//如果有做过处理，不执行商户的业务程序
		}
		double totalMoney=paymentOrder.getTotalMoney();
		//该页面可做页面美工编辑
		request.setAttribute("totalMoney", paymentOrder.getTotalMoney());
		request.getRequestDispatcher("paySuccess.jsp").forward(request, response);
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{
		//该页面可做页面美工编辑
		response.sendRedirect("payError.jsp");
	}
%>
  </body>
</html>