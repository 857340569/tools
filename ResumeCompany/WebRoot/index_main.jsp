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
    <title>职米官方网站</title>
    <script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
	<link href="./css/base.css" type="text/css" rel="stylesheet" />
	<link href="./css/common.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="./js/common.js"></script>
	<script type="text/javascript">
		var i=2;
		$(function(){
			setInterval(function(){
				{
					i=1;
				}
				$("#client_show").attr("src","./images/index/phone_item_"+i+".png");
				i++;
			
			},2000);
		});
	</script>
	<style type="text/css">
		body{
			font-family:"微软雅黑";
		}
		#main_head{
			background:url("./images/index/main_head_bg.png") no-repeat;
			height: 609px;
			text-align:left;
		}
		#head_main{
			position: relative;
		}
		#head_left{
			width:389px;
			float:left;
			padding-top:330px; 
		}
		#head_center{
			position: absolute;
			left:21%;
		}
		#head_right{
			width:402px;
		    clear:both;
		    position: absolute;
		    z-index:8;
		    top:423px;
		    right:0; 
		    overflow:hidden;
		}
		#head_center_left{
			float:left;
			margin-top: 150px;
			margin-right:130px; 
		}
		#head_center_right{
			float:right;
			margin-top: 50px;
			 position: relative;
			 z-index:10;
		}
		#main_download ul{
			width:1000px;
			margin:0 auto;
			overflow:hidden;
			padding-top:10px; 
		}
		#main_download
		{
			clear:both;
			margin-top:25px; 
			text-align:center;
			background:url("./images/index/download_bg.png") no-repeat;
			height:200px; 
			margin:0 auto;
			background-position:bottom;
		}
		#main_download li{
			width:200px;
			float:left; 
			text-align:center;
		}
		#main_content ul{
			width: 962px;
			display:inline-block; 
		}
		#main_content{
			text-align:center;
			background:#f4f4f4;
		}
		#main_content img{
			width: 962px;
		}
	</style>
  </head>
  <body>
    	<div id="main_head">
    		<div id="head_main">
	    		<div id="head_left">
	    			<img src="./images/index/main_head_left.png">
	    		</div>
	    		<div id="head_center">
	    			<div style="width:970px;overflow:hidden;">
		    			<div id="head_center_left">
		    				<img src="./images/index/main_head_center_left.png">
		    			</div>
		    			<div id="head_center_right">
		    				<img src="./images/index/main_head_center_right1.png" id="client_show">
		    			</div>
		    		</div>
	    		</div>
	    		<div id="head_right">
	    			<img src="./images/index/main_head_right.png">
		    	</div>
    		</div>
    	</div>
    	<div id="main_download" style="z-index:10;position: relative;">
    			<ul>
    				<li style="padding-top:50px;">
    					<img src="./images/index/main_download_label.png">
    				</li>
    				<li style="padding-top:25px;">
    					<a href="https://itunes.apple.com/cn/app/zhi-mi/id929960498?mt=8" target="_blank">
    						<img src="./images/index/download_ios.png" style="border:0px;">
    					</a>
    				</li>
    				<li style="padding-top:25px;">
    					<a href="http://img.91zhimi.com/apk/ZhiMi.apk" >
    						<img src="./images/index/download_android.png" style="border:0px;">
    					</a>
    				</li>
    				<li>
    					<div>
    						<img style="width:120px;height:120px;margin-top:5px;" alt="扫一扫" src="./images/index/app_download_scan.png">
    					</div>
    					<div>
    						扫码下载官方APP
    					</div>
    				</li>
    				<li>
    					<div>
    						<img style="width:120px;height:120px;margin-top:5px; " alt="扫一扫" src="./images/index/app_weixin.png">
    					</div>
    					<div>
    						扫码关注官方微信
    					</div>
    				</li>
    			</ul>
    		</div>
    	<div id="main_content" style="position: relative;z-index:8;margin-top: -25px;  ">
    		<ul>
    			<li><img src="./images/index/main_show_item1.png"></li>
    			<li><img src="./images/index/main_show_item2.png"></li>
    			<li><img src="./images/index/main_show_item3.png"></li>
    			<li><img src="./images/index/main_show_item4.png"></li>
    			<li><img src="./images/index/main_show_item5.png"></li>
    		</ul>
    	</div>
  </body>
</html>
