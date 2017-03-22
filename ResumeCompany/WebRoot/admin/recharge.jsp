<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户充值</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<link rel="stylesheet" type="text/css" href="./css/base.css">
<link rel="stylesheet" type="text/css" href="./css/common.css">
<link rel="stylesheet" type="text/css" href="./css/style.css">
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<link href="./js/myselect/myselect-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/myselect/myselect-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<style type="text/css">
	.rowTd{
		font-size: 15px;
		text-align: center;
	}
	.surplusCount{
		font-size:16px;
		font-family: sans-serif;
		font-weight:bold;
		color:#ffb137;
		
	}
	.WIDtotal_fee_select{
		width: 180px;
		height:30px;
		font-size:14px;
		margin-left: 30%;
		padding-top: 5px;
	}
	#surplusDiv{
		font-size: 14px;
		padding-left:8px;
		margin: 8px 0px;
		float: left;
	}
	#bg{
		background:#fff;
		width: 100%;
		height: 100%;
		left: 0;
		top: 0; /*FF IE7*/
		filter: alpha(opacity = 50); /*IE*/
		opacity: 0.7; /*FF*/
		z-index: 98;
		position: fixed !important; /*FF IE7*/
		position: absolute; /*IE6*/
		display: none;
		
	}
	#payTips{
		position: fixed;
		z-index: 99;
		width: 350px;
		height: 210px;
		top:21%;
		left:35%;
		border:1px solid #9d9d9d;
		display: none;
	}
	.payBtn{
		background:#303030;
		border:1px solid #9d9d9d;
		border-radius:3px;
		font-size: 14px;
		margin-right: 8px;
		height:35px;
	}
	#tipTittleDiv{
		color:#e5f8ff;
		background:#4680d1;
		line-height: 35px;
		height: 35px;
		vertical-align: middle;
		padding-left:15px;
		font-size: 14px;
	}
	#tipContentDiv{
		margin-top:15px;
		font-size: 15px;
		text-align: center;
	}
	#payBtnDiv{
		float: right;
		padding-right:15px;
		position: relative;
		bottom:-35px;
	}
	#paySuccessBtn{
		background:#ffb137;
		color:#fff;
	}
	#payAgainBtn{
		background:	#E0E0E0;
	}
	body {
		min-width: 400px;
	}
</style>
<script type="text/javascript">
	var total_num;
	var goodsName;
	var totalMoney;
	var traceNo;
	function totalPay(obj)
	{
		totalMoney=$(obj).attr("value");
		$("#payCount").text(totalMoney);
		if("${comType==0&&company.authType>0}"=="true")
		{
			$("#payCount").attr("style","text-decoration:line-through;");
			var discoun="${company.discount}";
			if(!isNullOrEmpty(discoun))
			{
				var discc=parseFloat(discoun);
				if(discc>0)
				{
					totalMoney=discc*10000*totalMoney/10000;
				}
			}
			
		}
		$("#payTotal").text(totalMoney);
		var subjectStr=$(obj).find("option:selected").text();
		$("#WIDsubject").attr("value","米粒超值包");
		goodsName="米粒超值包-"+subjectStr;
		$("#WIDbody").attr("value",goodsName);
		total_num=$(obj).find("option:selected").attr("id");
		$("#WIDtotal_fee").val(totalMoney);
	}
	function isNullOrEmpty(strVal) {
	if (strVal == '' || strVal == null || strVal == undefined) {
		return true;
	} else {
		return false;
	}
}
	function checkOrder(){
	
		var obj=$(".WIDtotal_fee_select");
		if($(obj).get(0).selectedIndex==0)
		{
// 			alert("请选择要购买的套餐!");
			alertDialog("请选择要购买的套餐!");
			return false;
		}
		var orderResult=false;
		$.ajax({
			type : "post",
			async : false,
			dataType:"json",
			url : "pay!saveOrder",
			data : {
				"paymentOrder.totalMoney":parseFloat(totalMoney),
				"paymentOrder.goodsName":goodsName,
				"paymentOrder.totalNum":parseInt(total_num)
			},
			success : function(jsondata) {
				if(jsondata.status==0)
				{
					orderResult=true;
					$("#WIDout_trade_no").attr("value",jsondata.traceNo);
					changePayDisplay("block");
					traceNo=jsondata.traceNo;
				}
				else{
					alertDialog("对不起，订单提交失败，请重新提交！");
				}
			}
		});
		return orderResult;
	}
	function cancelOrder(){
		//cancelOrder
		$.ajax({
			type : "post",
			async : false,
			dataType:"json",
			url : "pay!cancelOrder",
			data : {
				"traceNo":traceNo
			},
			success : function(jsondata) {
				if(jsondata.status==0)
				{
// 					alert("订单取消成功!");
				}
				else{
// 					changePayDisplay("none");
				}
			}
		});
		changePayDisplay("none");
	}
	function paySuccess()
	{
		changePayDisplay("none");
		window.location.href="myInfo!myInfo?type=queryAccount";
	}
	function changePayDisplay(state)
	{
		$("#payTips").css("display",state);
		$("#bg").css("display",state);
	}
	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	}
	function setMinWidth(width) {

	    var bWidth = ($(window).width() <= width) ? width : '100%';
	    $("body").width(bWidth);
	    
	    // 窗口放大缩小
	    $(window).resize(function () {
			$(".zjp_myselect").css("margin-left",($("#type_title").width()/2-$(".zjp_myselect").width()/2)+"px");
	        var bWidth = ($(window).width() <= width) ? width : '100%';
	        $("body").width(bWidth);
	
	    });

	}
	$(function() {
// 		setMinWidth(960);
		mySelectInit();
		mySelectResize();
		initDialog(true);
		 $(window).resize(function () {
				$(".zjp_myselect").css("margin-left",($("#type_title").width()/2-$(".zjp_myselect").width()/2)+"px");
	
	    });
// 		window.onresize =function(){
// 			$(".zjp_myselect").css("margin-left",($("#type_title").width()/2-$(".zjp_myselect").width()/2)+"px");
// 		}; 
	});
</script>
</head>
<body>
	<div style="margin-left: 10px;">
		<div id="surplusDiv">当前账户余额：
			<c:if test="${comType eq 0}">
				<span class="surplusCount">${company.accountBalance}</span>米粒。
				<span>
					<c:if test="${company.authType>0}">
						获得${authTypeName}认证
						<c:if test="${empty company.discount||company.discount<0}">。</c:if>
						<c:if test="${company.discount>0}">,享受${discountName}充值优惠。</c:if>
					</c:if>
				</span>
			</c:if>
			<c:if test="${comType eq 1}">
				<span class="surplusCount">${hr.payAccount}</span>米粒。
			</c:if>
		</div>
		<div style="float:right;font-size:14px;margin: 8px 0px;padding-right:25px;"><a href="pay!queryAllPayRecord" target="mainFrame" title="点击查看充值记录">充值记录</a></div>	
		<div style="float: left;width: 100%">
			<form action="./admin/alipay/alipayapi.jsp" onsubmit="return checkOrder();" target="_blank" method="post">
				<input type="hidden" id="WIDsubject" name="WIDsubject"> 
				<input type="hidden" id="WIDbody" name="WIDbody"> 
				<input type="hidden" id="WIDout_trade_no" name="WIDout_trade_no"> 
				<input type="hidden" id="WIDtotal_fee" name="WIDtotal_fee" > 
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr style="text-align: center;" class="dataTittleBg">
						<td style="width: 30%;">服务名称</td>
						<td style="width: 40%;" id="type_title">套餐类型</td>
						<td style="width: 30%;">金额</td>
					</tr>
					<tr>
						<td height="33" class="rowTd">米粒超值包</td>
						<td>
							<div style="height: 5px;"></div>
							<select class="WIDtotal_fee_select" onchange="totalPay(this)" style="width:200px; ">
								<option value="0">请选择</option>
								<option value="100" id="100">A套餐：100米粒/100元</option>
								<option value="300" id="380">B套餐：380米粒/300元</option>
								<option value="500" id="590">C套餐：590米粒/500元</option>
								<option value="1000" id="1200">D套餐：1200米粒/1000元</option>
								<option value="3000" id="3700">E套餐：3700米粒/3000元</option>
							</select>
						</td>
						<td class="rowTd"><span id="payCount">0</span>元</td>
					</tr>
				</table>
				<hr>
				<div style="float: right;width:150px;">
					<div>应付总价：<span id="payTotal" class="surplusCount">0</span>&nbsp;元</div>
					<div style="margin-top: 10px;"><input type="submit" value="前去支付" style="padding:6px;font-size:14px;background: #ffb137;border-radius:4px solid #000;border-style:none;color:#fff;"/></div>
				</div>
			</form>
		</div>
	</div>
	<div id="payTips">
		<div id="tipTittleDiv">网上支付提示</div>
		<div id="tipContentDiv"><img alt="waiting" src="images/order_waiting.gif">&nbsp;<span style="position: relative;top:-25px;">请您在新打开的页面完成支付</span></div>
		<div id="payBtnDiv" >
			<input style="width:110px;" type="button" id="paySuccessBtn" class="payBtn" onclick="paySuccess();" hidefocus="true" value="支付成功"/>
			<input style="width:110px;" type="button" id="payAgainBtn" class="payBtn" onclick="cancelOrder();" hidefocus="true" value="重新下单"/>
		</div>
	</div>
	<div id="bg"></div>
</body>
</html>