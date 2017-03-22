<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta name ="keywords" content="职米APP,职米官方网站,职米,职米网,找工作">
 	<meta name="description" content="职米官方网站,附近工作，扫一扫、摇一摇、找适合我的工作！职米APP下载"> 
    <meta name="baidu-site-verification" content="2MFNYAIIAq" />
 	<meta name="360-site-verification" content="1caa8eeaa9a90e2779e69a6bd8942df3" />
    <link rel="icon" href="http://img.91zhimi.com/favicon.ico" type="image/x-icon" />
 	<link rel="shortcut icon" href="http://img.91zhimi.com/favicon.ico" type="image/x-icon" />
    <title>职米官方网站</title>
    <script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
	<link href="./css/base.css" type="text/css" rel="stylesheet" />
	<link href="./css/common.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="./js/common.js"></script>
	<!--[if IE 6]> 
	<script type="text/javascript" src="js/DD_belatedPNG_0.0.8a.js"></script>
	<script>
		$(function() {
			var updateTipsHtml="<div id='showBrowserUpdate'><div id='showBrowserUpdateBg'></div><div id='showContentUpdate'>"
				+"您的浏览器版本过低，可能无法正常访问系统，请升级后再继续访问!<span id='closeUpdate'>×</span></div></div>";
			$("body").prepend(updateTipsHtml);
			
			DD_belatedPNG.fix("#showBrowserUpdateBg,background");
			$("#showContentUpdate").slideDown(300);
			setTimeout(function() {
				$("#showBrowserUpdateBg").show();
			}, 300);
			$("#closeUpdate").click(function() {
				$("#showContentUpdate").slideUp(300);
				setTimeout(function() {
					$("#showBrowserUpdateBg").hide();
				}, 300);
			});
		});
	</script> 
	<![endif]-->
	<script type="text/javascript">
		var isPc=isPcDevice();
		if(!isPc)
		{
			window.location.href="http://www.91zhimi.com/cloudresume_db/index.jsp";
		}
		$(function(){
			$(".head_guide_text").each(function(){
				$(this).click(function(){
					$(".head_guide_text").each(function(){
						$(this).find("a").css("color", "#000");
					});
					$(this).find("a").css("color", "#4680d1");
// 					alert(window.frames["indexFrame"].getHeight());
				});
				var param=location.search.substr(1);
				if(param=="2")
				{
					$("#index_head_top").find("ul li:eq(1)").find("a").css("color", "#4680d1");
					$("#indexFrame").attr("src","./index_login.jsp");
				}else if(param=="3")
				{
					$("#index_head_top").find("ul li:eq(2)").find("a").css("color", "#4680d1");
					$("#indexFrame").attr("src","./index_league.jsp");
				}
				else{
					$(".head_guide_text:first").find("a").css("color", "#4680d1");
				}
			});
			$("#indexFrame").load(function(){
				$(this).removeAttr("style");
				$(this).css("height",window.frames["indexFrame"].getHeight()+"px");
			
			});
		});
		function isPcDevice() {
			var sUserAgent = navigator.userAgent.toLowerCase();
			var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
			var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
			var bIsMidp = sUserAgent.match(/midp/i) == "midp";
			var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
			var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
			var bIsAndroid = sUserAgent.match(/android/i) == "android";
			var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
			var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
			if (bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid
					|| bIsCE || bIsWM) {
				return false;
			}
			return true;
	}
	</script>
	<style type="text/css">
		body{
			font-family:"微软雅黑";
			overflow-x:hidden;
		}
		#head_guide{
			padding:10px 0px;
			text-align: center;
		}
		#head_content{
			width:600px;
			display: inline-block;
		}
		#index_logo_div{
			float:left;
			margin-right:30px; 
		}
		#index_head_top li{
			width: 100px;
			height:46px;
			line-height:46px;
			float: left;
			text-align:center;
		}
		.head_guide_text{
			font-size: 16px;
			font-family:"微软雅黑";
			cursor:pointer;
		}
		.head_guide_text a {
			color:#000;
		}
		#footer{
			background:#f5f5f5;
			height:255px;
			text-align: center;
			color:#aeaeae;
		}
		#foo_content{
			width:820px;
			margin-top: 20px;
			display:inline-block; 
		}
		.f_split{
			width: 1px;
			height:180px;
			float:left;
			margin-left:5px;
			margin-right:5px;
			background:#aeaeae;
		}
		#f_left{
			float:left;
			width:160px;
		}
		#f_center{
			width:300px;
			float:left;
			padding:0px 10px;
		}
		#f_right{
			width:290px;
			float:left;
			padding:0px 10px;
		}
		.div_clear{
			height:0px;
			clear:both;
		}
		.center_title,.right_title{
			font-size:16px;
			text-align:left;
			margin:12px 0px;
			font-weight:bold;
		}
		.center_content,.right_content{
			font-size:12px; 
			text-align:left; 
			line-height:20px; 
			margin-left: 5px;
		}
		.right_content img{
			margin-right:5px;
		}
		#footer_auth{
			text-align:center;
			height:35px;
			line-height:35px;
		}
		.logo{
			width: 46px;
			height:46px;
		}
#showBrowserUpdate {
	position: absolute;
	width: 100%;
	height: 100%;
	text-align: center;
}

#showBrowserUpdateBg {
	width: 100%;
	height: 6000px;
	background: url("images/index/trans.png");
	filter: alpha(opacity = 60);
	opacity: 0.7;
	-moz-opacity:0.7;
	-khtml-opacity: 0.7;   
}

#showContentUpdate {
	height: 40px;
	line-height: 40px;
	background:#fff;
	border: 1px solid #9d9d9d;
	font-size: 21px;
	position: relative;
	display:none;
	top:-100%;
	_top:-6000px;
}

#closeUpdate {
	position: absolute;
	right: 30px;
	top: -1px;
	_top: 2px;/*for IE6*/
	cursor: pointer;
	color: #000;
	font-size: 35px;
	_font-size: 25px;
}
	</style>
  </head>
  <body>
    	<div id="head_guide">
    		<div id="head_content">
    			<div id="index_logo_div"><img alt="logo" src="./images/index/index_logo.png" class="logo"></div>
	    		<div id="index_head_top">
	    			<ul>
	    				<li><span class="head_guide_text"><a href="index_main.jsp" target="indexFrame">首页</a></span></li>
	    				<li><span class="head_guide_text"><a href="index_login.jsp" target="indexFrame">企业登录</a></span></li>
	    				<li><span class="head_guide_text"><a href="index_league.jsp" target="indexFrame">加盟代理</a></span></li>
	    			</ul>
	    		</div>
    		</div>
    	</div>
    	<div style="clear:both;">
    		<iframe src="index_main.jsp" name="indexFrame" id="indexFrame" width="100%" scrolling="no" frameborder="0" height="700"></iframe>
    	</div>
    	<div id="footer">
    		<div id="foo_content">
	    		<div id="f_left">
	    			<div>
	    				<div style="float: left;"><img alt="logo" src="./images/index/index_logo.png" class="logo"></div>
	    				<div style="font-size:16px;float:left;height:46px;line-height:46px;font-weight:bold;margin-left:10px; ">职米网</div>
	    			</div>
	    			<div class="div_clear"></div>
	    			<div style="margin-top:10px;text-align:left;margin-left:15px; ">
	    				<img style="width:80px;height:80px;" alt="扫一扫" src="./images/index/app_download_scan.png">
	    			</div>
	    		</div>
	    		<div class="f_split"></div>
	    		<div id="f_center">
	    			<div class="center_title">
	    				个人用户
	    			</div>
	    			<div class="center_content">
	    				附近工作，扫一扫、摇一摇、找适合我的工作！
	    				<br>
	    				虚拟朋友，让你聊天也能赚钱！
	    			</div>
	    			<div class="center_title">
	    				企业用户
	    			</div>
	    			<div class="center_content">
	    				智能云简历，让你招到要找的人（行业首创）
	    				<br>
	    				动态 、活动引导招聘，招聘效率提高多倍（行业首创）
	    			</div>
	    		</div>
	    		<div class="f_split"></div>
	    		<div id="f_right">
	    			<div class="right_title">
	    				联系我们
	    			</div>
	    			<div class="right_content">
		    			<div>
		    				<img src="./images/index/footer_location.png" style="float: left;height:17px;width:17px;">
		    				<div style="height:17px;line-height:17px;">苏州高新区滨河路588号赛格3期519室</div>
		    			</div>
		    			<div style="margin-top:12px; ">
		    				<img src="./images/index/footer_phone.png" style="float: left;height:17px;width:17px;">
		    				<div style="height:17px;line-height:17px;margin-right:20px;float: left; ">0512-68311590</div>
		    				<img src="./images/index/footer_email.png" style="float: left;height:17px;width:17px;">
		    				<div style="height:17px;line-height:17px;">fuwu@91zhimi.com</div>
		    			</div>
	    			</div>
	    		</div>
    		</div>
    		<div id="footer_auth">&copy; 2011-2014 Yubso Information technology All rights reserved</div>
    	</div>
    	<script type="text/javascript">
			var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
			document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F71fb897256de6d6e92629bee1b23d526' type='text/javascript'%3E%3C/script%3E"));
		</script>
  </body>
</html>
