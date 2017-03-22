<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/base.css">
<title>交易失败！</title>
<style type="text/css">
#money {
	font-size: 17px;
}

#bodyDiv {
	font-size: 16px;
	color: #0072E3;
	font-weight: bold;
	position: relative;
	left: 32%;
	margin-top: 200px;
}

#mainLeft {
	padding: 15px;
}

#mainLeft,#mainRight {
	float: left;
	padding: 15px;
}

.main {
	margin-top: 15px;
}

.closeBtn {
	padding: 6px;
	background: #ffb137;
	border: 1px solid #9d9d9d;
	border-radius: 3px;
	font-size: 15px;
	margin-right: 8px;
	color: #e5f8ff;
}
</style>
<script type="text/javascript">
	function closePage() {
		var ua=navigator.userAgent;
		$("#rem_time").text(navigator.appName);
		var ie=navigator.appName=="Microsoft Internet Explorer"?true:false;
		if(ie){ 
		    var IEversion=parseFloat(ua.substring(ua.indexOf("MSIE ")+5,ua.indexOf(";",ua.indexOf("MSIE ")))) ;
		    $("#rem_time").text(IEversion);
			 if(IEversion< 5.5){ 
			    var str  = '<object id=noTipClose classid="clsid:ADB880A6-D8FF-11CF-9377-00AA003B7A11">';
			    str += '<param name="Command" value="Close"></object>'; 
			    document.body.insertAdjacentHTML("beforeEnd", str); 
			    document.all.noTipClose.Click(); 
		    } 
		    else if(IEversion==6){ 
				window.opener=null;
				window.close();
		    } 
		    else if(IEversion==7){ 
				window.open('','_top');
				window.top.close();
		    }else{
		    	window.opener=null; 
		        window.open('', '_self', ''); 
		        window.close(); 
		    }
		} 
		else{ 
			window.opener=null;
			window.open("", "_self"); 
			window.close();
		} 
	}
	var time_rem = 10;
	var updateText;
	function startAutoClose() {
		setTimeout(closePage, 10000);
		updateText=setInterval(function() {
			time_rem--;
			$("#rem_time").text(time_rem);
		}, 1000);
	}
	function contactService(){
		window.clearInterval(updateText);
		window.location.href="http://wpa.qq.com/msgrd?v=3&uin=2827914559&site=qq&menu=yes";
	}
	$(function() {
		startAutoClose();
	});
</script>
</head>
<body>
	<div id="bodyDiv">
		<div id="titleDiv"></div>
		<div id="mainDiv">
			<div id="mainLeft">
				<img alt="" src="./images/pay_error.png">
			</div>
			<div id="mainRight">
				<div id="main_1" class="main">
					<span>对不起，本次交易失败！</span>
				</div>
				<div id="main_2" class="main">
					若存在问题，请联系客服QQ：<a href="javascript:void(0);" onclick="contactService();" target="_self">2827914559</a>
				</div>
				<div id="main_3" class="main">
					<span id="rem_time">10</span>秒，页面会自动关闭
				</div>
				<div id="main_4" class="main">
					<button class="closeBtn" onclick="closePage();">立即关闭</button>
				</div>
			</div>
		</div>
		<div id="titleDiv"></div>
	</div>
</body>
</html>