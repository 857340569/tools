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
<title>购买电话包月服务</title>
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
	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	};
	$(function() {
		$("#jobVipPay").Validform({
			tiptype : 2,
			showAllError : true

		});
		initMonth();
	});
	function initMonth()
	{
		var indexM=1;
		var monthHtml="<select onchange='changeTotal();' name='selectTime' id='payMonth'>";
		for(;indexM<=24;indexM++)
		{
			monthHtml+="<option value='"+indexM+"'>"+indexM+"</option>";
		}
		monthHtml+="</select>";
		$("#selectMonth").html(monthHtml);
	}
	function changeTotal(){
		
		var payPrice=parseInt("${priceConfig.jobMonthPrice}");
		var inputVal=$("#payMonth").val();
		var type="^[0-9]*[1-9][0-9]*$"; 
		var re=new RegExp(type); 
		if(inputVal.match(re)!=null)
		{
			var month=parseInt(inputVal);
			$("#totalMoney").text(month*payPrice);
		}else
		{
			$("#totalMoney").text(0);
		}
	}
	function submitForm(){
		$("#payMonth").blur();
		if($("#totalMoney").text()!="0")
		{
			var payPrice=parseInt("${priceConfig.jobMonthPrice}");
			var month=parseInt($("#payMonth").val());
			if(confirm("确定要从账户余额中扣除"+month*payPrice+"米粒服务费吗？"))
			{
				with($("#jobVipPay"))
				{
					submit();
				}
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
input,textarea {
	border:1px solid #ccc;
}

.lefttd {
	width: 160px;
	padding-left:30px;
}
.centerTd{
	width: 160px;
	padding-left:4px;
}
#payMonth{
	width: 100px;
}
</style>
</head>

<body topmargin="0" leftmargin="0">
	
	<div>
		<div><font color="#ff7200" style="font-size:15px; ">服务信息：</font></div>
		<div style="line-height:25px;margin-left:20px; ">
			<c:choose>
				<c:when test="${empty chv||empty chv.endTime}">
					还未购买包月套餐。
				</c:when>
				<c:otherwise>
					服务到期时间为:${chv.endTime}。
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div style="line-height: 25px;border-bottom: 1px dotted #808685;margin-bottom:5px;">*充值/续费服务平台</div>
	<form id="jobVipPay" method="post" action="job!payJobVip">
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td class="lefttd">服务名称：</td>
				<td class="centerTd">
					电话招聘包月服务费
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd">充值/续费：</td>
				<td class="centerTd">
					<font color="#ff7200">${priceConfig.jobMonthPrice}</font>&nbsp;米粒/月
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;支付时长：</td>
				<td class="centerTd">
				
<!-- 					<input  style="width:120px;vertical-align:middle;" onblur="changeTotal();" name="selectTime" id="payMonth" maxlength="3" type="text" class="inp006"  datatype="month" nullmsg="请填写支付时长！" errormsg="月份只能为正整数！" />&nbsp; -->
					<span id="selectMonth">
					
					</span>
					<label style="vertical-align:middle; display:inline-block;">月</label> 
				</td>
				<td><div class="Validform_checktip">请填写支付时长</div></td>
			</tr>
			<tr>
				<td class="lefttd">应付金额：</td>
				<td class="centerTd">
					<font color="#ff7200" id="totalMoney">${priceConfig.jobMonthPrice}</font>&nbsp;米粒
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td style="width:160px; "><br><br></td>
				<td align="left" class="centerTd" colspan="2">
					<input  style="position: relative;left:-30px;" type="button"  value="支&nbsp;付" class="exeCommonBtn" onclick="submitForm();"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>