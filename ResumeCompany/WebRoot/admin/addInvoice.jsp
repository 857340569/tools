<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>在线申请发票</title>
<base href="<%=basePath%>">
<script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/style.css" type="text/css"/>
<link href="./css/base.css" type="text/css" rel="stylesheet" />
<link href="./css/common.css" type="text/css" rel="stylesheet" />
<link href="js/area/areaselect.css" type="text/css" rel="stylesheet" />
<link href="js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<script src="js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>
<script src="js/validform/Validform_more.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/area/data.js"></script>
<script type="text/javascript" src="./js/area/areaselect.js"></script>
<script src="js/my.placeholder.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<link href="js/myselect/myselect-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="js/myselect/myselect-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<script src="./js/my.placeholder.js" type="text/javascript" language="javascript"></script>
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript">
	$(function() {
		$.Placeholder.init();
		$("#addInvoice").Validform({
			tiptype : 2,
			showAllError : true

		});
		mySelectInit();
		mySelectResize();
	});
	function setError(idName, tips) {
		$("#" + idName).attr("class", "Validform_checktip Validform_wrong");
		$("#" + idName).text(tips);
	}
	function resetTips(idName, tips) {
		$("#" + idName).removeAttr("class");
		$("#" + idName).attr("class", "Validform_checktip Validform_right");
		$("#" + idName).text(tips);
	}
	function checkAllOk() {
		resetTips("addressTips", "通过信息验证！");
	}
	function checkSelectAddress() {
		var isPassed = false;
		var count=0;
		$(".input_select").each(function(){
			if($(this).css("display") != "none")
			{
				count++;
			}
		});
		if(count==2)
			$("#addressTips").css("left","-552px");
		if(count==3)
			$("#addressTips").css("left","-450px");
		if ($("#pr2").text() == "-请选择-") {
			setError("addressTips", "请选择省份！");
			isPassed = false;
		} else {
			if ($("#ci2").text() == "-请选择-") {
				setError("addressTips", "请选择城市！");
				isPassed = false;
			} else {
				if ($("#co2").css("display") != "none") {
					if ($("#co2").text() == "-请选择-") {
						setError("addressTips", "请选择区域！");
						isPassed = false;
					} else {
						resetTips("addressTips", "通过信息验证！");
						isPassed = true;
					}

				} else {
					resetTips("addressTips", "通过信息验证！");
					isPassed = true;
					$("#addressTips").css("left","-552px");
				}
			}
		}
		return isPassed;
	}
	function checkCustom() {
		var checkAddress = checkSelectAddress();
		if (checkAddress)
			return true;
		return false;
	}
	function myBrowser(){
		var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
		var isOpera = userAgent.indexOf("Opera") > -1;
		
		if (isOpera){
			return "Opera";
		} //判断是否Opera浏览器
		if (userAgent.indexOf("Firefox") > -1){
			return "FF";
		} //判断是否Firefox浏览器
		if (userAgent.indexOf("Safari") > -1){
			return "Safari";
		} //判断是否Safari浏览器
		if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera){
			return "IE";
		}  //判断是否IE浏览器
	}
	$(function() {
		$(".sel_address").each(function() {
			$(this).bind("contentchange", function() {
				checkSelectAddress();
// 				changePostPay();
			});
		});
	});
 	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	}
	var wayTips=["","此费用由公司（远博索）支付，3—10天可寄到，部分省市将寄存至当地邮政局，需自行领取","此快递费用需客户自付（费用：省内12元，省外20元）"," 此快递费用需客户自付（费用：省内13元、省外22元)","此快递费用需客户自付（费用：省内8元、省外12元)"
,"自行上门索取发票，无须产生费用"];
	var selectedIndex=0;
	var postPayNum=0;
	function changePay()
	{
		selectedIndex=$("#postWay option:selected").index();
		$("#postWay").attr("sucmsg",wayTips[selectedIndex]);
// 		changePostPay();
	}
	function changePostPay()
	{
		var selectedAddress=getSelectedAddress();
		switch(selectedIndex)
		{
			case 0:
			case 1:
			case 5:
				postPayNum=0;
				break;
			case 2:
				if(selectedAddress.indexOf("江苏省")!=-1)
				{
					postPayNum=12;
				}else
				{
					postPayNum=20;
				}
				break;
			case 3:
				if(selectedAddress.indexOf("江苏省")!=-1)
				{
					postPayNum=13;
				}else
				{
					postPayNum=22;
				}
				break;
			case 4:
				if(selectedAddress.indexOf("江苏省")!=-1)
				{
					postPayNum=8;
				}else
				{
					postPayNum=12;
				}
			break;
		}
// 		$("#showPostPay").text(postPayNum+".00");
// 		$("#postPay").val(postPayNum);
	}
	function getSelectedAddress()
	{
		var data="";
		var data1 = $("#pr2").text();
		var data2 = $("#ci2").text();
		var data3 = $("#co2").text();
		if (data3 == "-请选择-") {
			data = data1 + data2;
		} else {
			data = data1 + data2 + data3;
		}
		return data;
	}
	function submitForm()
	{
// 		var checkUnInvoicedPay="${(cyPayMoney-cyInvoicedMoney)<=0}";
// 		if(checkUnInvoicedPay=="true")
// 		{
// 			alert("本年度未开发票金额为0.0元，不能申请发票！");
// 			return;
// 		}
		
		$("input").each(function(){
			$(this).blur();
		});
		$("select").each(function(){
			$(this).blur();
		});
		$("textarea").each(function(){
			$(this).blur();
		});
		var checkSelectedAddress=checkSelectAddress();
		if(!checkSelectedAddress)
		{
			return;
		}
		var selectedAddress=getSelectedAddress();
		$("#selectedAddressData").val(selectedAddress);
		if($(".Validform_error").length==0)
		{
			with($("#addInvoice"))
			{
				submit();
			}
		}
	}
</script>
<style type="text/css">
body {
	padding-top: 5px;
	background-color: #ffffff;
	margin-left: 10px
}
select{
	width: 240px;
	height: 30px;
	margin-left:4px;
}
.input_select {
	height: 32px;
	padding-left: 6px;
	font-size: 13px;
	width: 100px;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 2px;
	line-height: 32px;
	background: #fff url('./images/bg-selectt.png') right center no-repeat;
	cursor: pointer;
	color: #000000;
	display: inline-block;
	text-align: left;
	overflow: hidden;
	white-space: nowrap;
}

.li_tips {
	font-size: 12px !important;
	padding-left: 10px;
}

#addressTips {
	margin-left: 10px;
	position: relative;
}
input,textarea {
	border:1px solid #ccc;
}

.lefttd {
	width: 140px;
	text-align: left;
	padding-left:45px;
}
.postTips{
	line-height: 20px;
	padding-left:10px; 
}
#footer_info{
	border-top: 1px dotted #808685;
	padding-left:20px;
	padding-top:10px;  
	margin-top:10px;  
}
</style>
</head>

<body topmargin="0" leftmargin="0">
	<div style="float:right;padding-right:25px;line-height: 26px;font-size:15px; "><a href="invoice!queryAllInvoices" target="mainFrame" title="点击查看申请记录">申请记录</a></div>
	<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#a2b6cf">
	<tr>
		<td align="center" colspan="3" height="37">客户${currentYear}年度统计</td>
	</tr>
	<tr align="center" class="dataTittleBg" style="background:#a2b6cf" >
		<td>本年度消费总金额</td>
		<td>本年度已开发票金额</td>
		<td>本年度未开发票金额</td>
	</tr>
	<tr align="center" height="29">
		<td class="r8">${cyPayMoney}元</td>
		<td class="r8">${cyInvoicedMoney}元</td>
		<td class="r8">${cyPayMoney-cyInvoicedMoney}元</td>
	</tr>
	</table>
	<div style="line-height: 25px;border-bottom: 1px dotted #808685;margin-bottom:5px;">*客户发票开具详细资料</div>
	<form id="addInvoice" method="post"
		action="invoice!addInvoice">
		<input type="hidden" id="selectedAddressData" name="selectedAddress"/>
		<table width="100%" style="table-layout:fixed;" border="0"
			cellspacing="2" cellpadding="2">
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;发票类型：</td>
				<td style="width:245px;"><select id="invoType" name="invoice.type" datatype="*" nullmsg="请选择发票类型！" errormsg="请选择发票类型！">
						<option value="">-请选择-</option>
						<option value="增值税普通发票">增值税普通发票</option>
				</select>
				</td>
				<td style="width:550px;"><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;发票抬头：</td>
				<td class="release_select">
					<input class="inp006" name="invoice.headName" id="headName" datatype="s2-10" nullmsg="请填写发票抬头！" errormsg="请认真填写发票抬头(2~10个字符)！">
				</td>
				<td><div class="Validform_checktip">请填写公司名称或个人姓名</div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;发票金额：</td>
				<td class="release_select">
<!-- 					<span id="showPay" style="padding-left:4px;">${cyPayMoney-cyInvoicedMoney}元</span> -->
<!-- 					<input class="inp006" ajaxurl="invoice!checkInvoicePay" name="invoice.pay" id="showPay" datatype="n1-10" nullmsg="请填写发票金额！" errormsg="发票金额只能为数字(1~10位)！"> -->
					<input class="inp006"  ajaxurl="invoice!checkInvoicePay" name="invoice.pay" id="showPay" datatype="spenum,floatint,ft" nullmsg="请填写发票金额！">
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;发票内容：</td>
				<td class="release_select"><select name="invoice.content"
					 datatype="*" nullmsg="请选择发票内容！" errormsg="请选择发票内容！">
						<option value="">-请选择-</option>
						<option value="网络服务费">网络服务费</option>
				</select>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;邮寄地址：</td>
				<td colspan="2" id="selectAddr"><span id="pr2" type="text"
					class="input_select sel_address"
					style="width: 112px; margin-left: 4px;"
					name="seachprov">-请选择-</span> <span id="ci2" type="text"
					class="input_select sel_address" name="seachcity">-请选择-</span> <span
					id="co2" type="text" class="input_select sel_address"
					name="seachdistrict">-请选择-</span>
				</td>
				<td class="li_tips" colspan="1" style="padding-left: 0px;"><div
						class="Validform_checktip" id="addressTips"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;详细地址：</td>
				<td><input type="text" name="invoice.address"
					class="inp006" datatype="s3-150" nullmsg="请输入详细地址！"
					errormsg="详细地址只能填写汉字,数字,字母(3-150个字)!" /></td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;邮政编码：</td>
				<td><input type="text" name="invoice.postCode" class="inp006"
					datatype="n6-6" nullmsg="请输入邮政编码！" errormsg="邮政编码由6位数字组成!" />
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;收 件 人：</td>
				<td class="release_select">
					<input class="inp006" name="invoice.recipient" id="recepient" datatype="s2-10" nullmsg="请填写收件人！" errormsg="请认真填写收件人(2~10个字符)！">
				</td>
				<td><div class="Validform_checktip">请填写联系人全名</div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;联系电话：</td>
				<td><input type="text" name="invoice.contactPhone" class="inp006"
					datatype="m|tel" nullmsg="请输入您的联系电话！" />
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd" rowspan="2"><font class="releaseJob_need">*</font>&nbsp;邮寄方式：</td>
				<td>
					<div style="padding-left:4px;">
						<font color="#ff7200">友情提醒：</font>
				        <div class="postTips">  1.快递费用需自付；</div>
				        <div class="postTips">  2.快递费用由客户收到发票时再进行付款。</div>
				        <div class="postTips">  3.请选择能到达的快递方式，若选择错误<br>&nbsp;&nbsp;&nbsp;&nbsp;引起的损失，由申请人自负。</div>
				        <div class="postTips">  4.下面提示的快递费用仅供参考。</div>
					</div>
				</td>
				<td></td>
			</tr>
			<tr>
				<td><select name="invoice.postWay"
					 datatype="*" nullmsg="请选择邮寄方式！" errormsg="请选择邮寄方式！" onchange="changePay()" id="postWay">
						<option value="">-请选择-</option>
						<option value="挂号信">挂号信</option>
						<option value="EMS">EMS</option>
						<option value="顺丰">顺丰</option>
						<option value="韵达">韵达</option>
						<option value="自取">自取</option>
					</select>
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td><br><br></td>
				<td align="left">
					<input type="button"  value="申&nbsp;请" class="exeCommonBtn" onclick="submitForm();"/>
				</td>
			</tr>
		</table>
		<div id="footer_info">
			<div><font color="#ff7200">其他说明：</font></div>
　			<div>&nbsp;&nbsp;&nbsp;&nbsp;1、凡已汇款的客户请及时在汇款当期向我司申请发票，跨年度不再提供发票，请及时索取。</div>
　			<div>&nbsp;&nbsp;&nbsp;&nbsp;2、欲开具发票的客户请务必详细填写以上资料。 </div>
		</div>
		<script type="text/javascript">
			new locationCard({
				ids : [ 'pr2', 'ci2', 'co2' ]
			}).init();
		</script>
		<div id="hd_da_ta"></div>
	</form>

</body>
</html>