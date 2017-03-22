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
	<script type="text/javascript" src="./js/checkCode.js"></script>
	<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
	<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
	<jsp:include page="./admin/processbar.jsp"></jsp:include>
	<!--[if IE 6]> 
	<script type="text/javascript" src="js/DD_belatedPNG_0.0.8a.js"></script>
	<script>
		DD_belatedPNG.fix("#showBrowserUpdateBg,background");
	</script>
	<![endif]-->
	<script type="text/javascript">
	var isShow = false;
	function loginCheck() {
		if (document.getElementById("userName").value == "") {
			alertDialog("用户名不能为空哦！");
			document.getElementById("userName").focus();
			return;
		}
		if (document.getElementById("password").value.length < 6) {
			alertDialog("输入的密码不能小于6位字符哦！");
			document.getElementById("password").focus();
			return;
		}
		var checkCode=validate();
		if(!checkCode) 
			return; 
		if (isShow) {
			$("#load").css("display", "none");
			isShow = false;
		} else {
			$("#load").css("display", "block");
			isShow = true;
		}
		with ($("#loginForm")) {
			submit();
		}
	}
	function doChange(val)
	{
		var registerHtml="";
		comTypeSelected=val;
		if(val==0)
		{
			changeRegister(val);
			if($("#type_setting").css("display")!="none"&&comTypeSelected==lastComType){
				typeSettingShowState(comTypeSelected,false);
			}else
			{
				typeSettingShowState(comTypeSelected,true);
			}
			
		}else
		{
			changeRegister(val);
			if($("#type_setting").css("display")!="none"&&comTypeSelected==lastComType){
				typeSettingShowState(comTypeSelected,false);
			}else
			{
				typeSettingShowState(comTypeSelected,true);
			}
		}
		lastComType=val;
	}
	var comTypeSelected=0;
	var lastComType=0;
	var selectedTypeName="typeName";
	function typeSettingShowState(type,isShow)
	{
		if(isShow)
		{
			$("#show_guide").hide();
			$("#type_setting").hide();
		}
		if(type==0)
		{
			$("#show_guide").find("s").css("left","110px");
			$("#type_setting").css("left","80px");
		}else
		{
			$("#show_guide").find("s").css("left","180px");
			$("#type_setting").css("left","150px");
		}
		if(isShow)
		{
			$("#show_guide").show();
			$("#type_setting").slideDown(300);
		}else
		{
			$("#type_setting").slideUp(300);
			setTimeout(function(){
				$("#show_guide").hide();
			},300);
			
		}
	}
	function changeRegister(val)
	{
		if(val==0)
		{
// 			registerHtml="还没有企业管理账号？<span class='rgaspan'><a id='comRegister' href='./admin/register.jsp' target='_blank'>立即注册</a></span>";
// 			$("#register_span").html(registerHtml);
// 			$("#regist_btn").show();
// 			$("#register_span").hide();
			$("#all_reg").attr("href","./admin/register.jsp");
			$("#all_reg").removeAttr("title");
			$("#regist_btn").text("注  册");
			$("#regist_btn").css("background","#4680D1");
			
		}else
		{
// 			registerHtml="还没有连锁管理账号？<span class='rgaspan'><a id='hrRegister' href='http://wpa.qq.com/msgrd?v=3&uin=2827914559&site=qq&menu=yes' title='请拨打电话至0512-68311590,获取账号密码' target='_blank'>联系客服</a></span>"
// 			$("#register_span").html(registerHtml);
// 			$("#regist_btn").hide();
// 			$("#register_span").show();
			$("#all_reg").attr("href","http://wpa.qq.com/msgrd?v=3&uin=2827914559&site=qq&menu=yes");
			$("#all_reg").attr("title","也可拨打电话至0512-68311590,获取账号密码！");
			$("#regist_btn").text("联系客服");
			$("#regist_btn").css("background","#ff9435");
		}
	}
	$(function(){
		var getSettingInt=parseInt(getCookie(selectedTypeName));
		if(!isNaN(getSettingInt))
		{
			$("input:radio[value='"+getSettingInt+"']").attr("checked","checked");
			changeRegister(getSettingInt);
		}
	
        $("#vcode").bind("keypress",function(event){
             if(event.keyCode == "13")    
             {
                 loginCheck();
             }
         });
         $("#default_text").click(function(){
         	typeSettingShowState(comTypeSelected,false);
         	addCookie(selectedTypeName,comTypeSelected,7*24);
         	setTimeout(function(){
         		alert("企业类型默认值设置成功，有效期为7天!");
         	},350);
         	
         });
          $("#default_text").mouseleave(function(){
         	typeSettingShowState(comTypeSelected,false);
         });
          $("#userName").focus(function(){
         	typeSettingShowState(comTypeSelected,false);
         });
     });
     function addCookie(name,value,expiresHours){ 
		var cookieString=name+"="+escape(value); 
		//判断是否设置过期时间 
		if(expiresHours>0){ 
		var date=new Date(); 
			date.setTime(date.getTime+expiresHours*3600*1000); 
			cookieString=cookieString+"; expires="+date.toGMTString(); 
		} 
		document.cookie=cookieString; 
	}
	function getCookie(name){ 
		var strCookie=document.cookie; 
		var arrCookie=strCookie.split("; "); 
		for(var i=0;i<arrCookie.length;i++){ 
		var arr=arrCookie[i].split("="); 
		if(arr[0]==name)return arr[1]; 
		} 
		return ""; 
	} 
	function deleteCookie(name){ 
		var date=new Date(); 
		date.setTime(date.getTime()-10000); 
		document.cookie=name+"=v; expires="+date.toGMTString(); 
	} 
	</script>
	<style type="text/css">
		body{
			font-family:"微软雅黑";
		}
		#login_head{
			background:url("./images/index/login_head_bg.png") no-repeat;
			height: 609px;
			text-align:center;
		}
		#login_content
		{
			text-align:center;
		}
		#head_right{
			text-align:left;
			float: right;
			width: 350px;
			height: 385px;
			margin-top:100px;
			padding-top:20px;
			background:#fff;
			background:url("./images/index/login_right_bg.png") no-repeat;
		}
		#login_ul{
			text-align:left;
			margin-left:40px;
			margin-top:30px;
			width:  280px;
		}
		#login_ul li{
			height:60px;
			line-height:60px;
		}
		.login_label{
			text-align:left;
			width:75px;
			display:inline-block;
			font-size:14px;
			height: 60px;
			line-height: 60px;
		}
		.login_input_v{
			width: 185px;
			font-size:14px;
			height:23px; 
			position: relative;
			top:3px;
			padding-top: 7px;
		}
		#login_btn,#regist_btn{
			width:120px;
			height: 36px;
			line-height: 36px;
			background:#4680D1;
			border:none;
			color:#fff; 
			float: left;
			margin-right: 20px;
			display:inline-block;
			text-align:center;
		}
		#regist_btn:HOVER,#hrRegister:HOVER,#login_btn:HOVER
		{
			opacity: 0.6;                 /* Firefox, Safari(WebKit), Opera)*/
			filter: "alpha(opacity=60)"; /* IE 8 */
			filter: alpha(opacity=60);   /* IE 4-7 */
		}
		#comRegister:VISITED,#hrRegister:VISITED{
			color:blue;
		}
		.rgaspan{
			border-bottom:1px solid blue;
			height:18px;
			font-size:14px;
			display:inline-block;
			
		}
		.register_span{
			position:relative;
			top: -65px;
			left:-80px;
		}
		#register_span{
			float: right;
			margin-right:40px;
		}
		.title_show_fir{
			font-size: 46.44px;
			line-height:75px; 
		}
		.title_show_sec{
			font-size: 24px;
			color:#2f2f2f;
			font-weight:bold;
		}
		.title_show_line_height{
			line-height:35px; 
		}
		.content_show_fir{
			font-size: 24px;
			color:#2f2f2f;
			line-height:35px;
			font-weight:normal;
		}
		.content_show_title{
			font-size: 21px;
			color:#2f2f2f;
			font-weight:bold;
		}
		.descr_detail_show{
			text-align:left;
			margin-top: 80px;
		}
		.content_div_row{
			text-align:center;
			
		}
		.content_div_row_inner{
			width:1000px; 
			padding:20px; 
			margin: 0 auto;
		}
		.descr_detail_left{
			float: left;
		}
		.descr_detail_right{
			float: left;
		}
		#item1_table{
			margin-top:10px;
			width:450px;
		}
		.item4_top{
			margin-top:15px; 
		}
		#login_outer_div{
			width:1000px;
			margin: 0 auto;
		}
		#head_left{
			width:550px;
			height:609px;
			float:left; 
			
		}
		#head_left img{
			margin-top:80px;
			width:530px;
		}
		#show_guide{
			display: none;
		}
		s {
			position: absolute;
			top: 30px;
			*top: 30px;
			left: 110px;
			*left: 110px;
			height: 0;
			width: 0;
			font-size: 0;
			line-height: 0;
			border-color: transparent transparent green transparent;
			border-style: dashed dashed solid dashed;
			border-width: 10px;
			z-index: 1100;
			
		}
		
		i {
			position: absolute;
			top: -9px;
			*top: -9px;
			left: -10px;
			height: 0;
			width: 0;
			font-size: 0;
			line-height: 0;
			border-color: transparent transparent #fff transparent;
			border-style: dashed dashed solid dashed;
			border-width: 10px;
		}
		#type_setting{
			display: inline-block;
			position:absolute;
			top: 50px;
			left:80px;
			border: 1px solid green;
			width: 60px;
			height: 35px;
			line-height: 35px;
			padding:0px 25px;
			z-index: 1001;
			background:#ffffff;
			display: none;
		}
		#default_text{
			cursor:pointer;
		}
	</style>
  </head>
  <body>
    	<div id="login_head">
    		<div id="login_outer_div">
    			<div id="head_left">
    				<img src="./images/index/login_head_left.png">
    			</div>
	    		<div id="head_right">
		    		<form name="loginForm" target="_parent" id="loginForm" method="post" action="login!login">
	    			<input type="hidden" name="toLogin" value="toLogin">
	    			<ul id="login_ul" style="position:relative;">
	    				<li>
		    				<span class="login_label">企业类型:</span>&nbsp;
	    					<label for="comtype1" hideFocus="true"><input id="comtype1" name="comType" type="radio" checked="checked" value="0" onclick="doChange(this.value)">企业直招</label>&nbsp;&nbsp;
	    					<label for="comtype2" hideFocus="true"><input id="comtype2" name="comType" type="radio" value="1"  onclick="doChange(this.value)">连锁企业</label>
	    					<div id="show_guide"><s><i></i></s></div>
	    					<div id="type_setting">
	    						<div><span id="default_text">设置为默认</span></div>
	    					</div>
	    				</li>
	    				<li>
	    					<span class="login_label">用户名:</span><input class="login_input_v" type="text" name="userName" id="userName" >
	    				</li>
	    				<li>
	    					<span class="login_label">密码:</span><input class="login_input_v" type="password" name="password" id="password">
	    				</li>
	    				<li>
	    					<span class="login_label">验证码:</span><input class="login_input_v" type="text"  name="rand" id="vcode" maxlength="4" autocomplete="off"  style="width:85px; ">
	    					<img id="code" title="看不清，换一张" border=0 style="cursor: pointer;vertical-align: middle;position:relative;bottom:3px;" onclick="javascript:show();return false;" />
	    				</li>
	    				<li style="margin-top:35px;" id="reg_log_li">
	    					<a><span id="login_btn" onClick="loginCheck();">登&nbsp;录</span></a>
	    					<a href="./admin/register.jsp" target="_blank" id="all_reg"><span id="regist_btn">注&nbsp;册</span></a>
	    				</li>
	    			</ul>
	    			<span id="register_span">
<!--     						还没有企业管理账号？<span class="rgaspan"> -->
<!--     							<a id="comRegister" href="./admin/register.jsp" target="_blank">立即注册</a> -->
<!--     						</span> -->
   					</span>
   					</form>
	    		</div>
			    	
    		</div>
    	</div>
    	<div style="text-align:center;">
    		<img src="./images/index/login_activity_show_2.png">
    	</div>
    	<div style="text-align:center;">
    		<img src="./images/index/login_activity_split.png">
    	</div>
    	<div id="login_content" style="margin-top: -3px;">
    		
    		<div class="content_div_row" style="background:#e7edf6">
    			<div class="content_div_row_inner" style="height: 540px;padding-top: 60px;">
					<div class="descr_detail_left descr_detail_show">
						<div>
							<img src="./images/index/login_item1_label.png">
						</div>
						<div class="title_show_fir" style="color:#ffa800;">
							六大首创等你来发现！
						</div>
						<div class="title_show_sec title_show_line_height">
							集结号&nbsp;&nbsp;&nbsp;云简历&nbsp;&nbsp;&nbsp;扫一扫（实景）
						</div>
						<div class="title_show_sec title_show_line_height" style="font-size:25px;">
							信鸽&nbsp;&nbsp;&nbsp;附近的人&nbsp;&nbsp;&nbsp;适合我的
						</div>
					</div>
					<div class="descr_detail_right" style="width: 300px;">
						<img src="./images/index/login_item1_img.png">
					</div>
				</div>
			</div>
   			<div class="content_div_row" style="background:#fbedef;">
    			<div class="content_div_row_inner" style="height: 640px;">
    				<div class="descr_detail_left" style="clear:both;margin-right:45px;">
						<img src="./images/index/login_item0_img.png">
					</div>
    				<div class="descr_detail_right descr_detail_show" style="width:550px;">
						<div class="title_show_fir" style="color:#f6c84b;margin-top:80px; ">
							完美体验 低成本
						</div>
						<div class="title_show_sec title_show_line_height">
							零风险：<span class="content_show_fir" >
								免费发布&nbsp;&nbsp;&nbsp;效果付费
							</span>
						</div>
						<div class="title_show_sec title_show_line_height item4_top">
							低成本：<span class="content_show_fir" >
								一张地铁单程票的费用<br/><span style="margin-left:100px; ">即可招募一名优秀员工</span>
							</span>
						</div>
						<div class="title_show_sec title_show_line_height item4_top">
							高效率：<span class="content_show_fir" >
								双方确认&nbsp;&nbsp;&nbsp;搞定一切
							</span>
						</div>
					</div>
    			</div>
   			</div>
   			<div class="content_div_row" style="background:#f2fbea;">
    			<div class="content_div_row_inner" style="height: 600px;">
    				<div class="descr_detail_left descr_detail_show" style="clear:both;margin-right:45px; width:480px;">
						<div class="title_show_fir" style="color:#419fa3;margin-top:80px;">
							增值服务 绝无仅有
						</div>
						<div class="title_show_sec title_show_line_height">
							动态：<span class="content_show_fir" >
								企业版朋友圈
							</span>
						</div>
						<div class="title_show_sec title_show_line_height">
							活动：<span class="content_show_fir" >
								属于你的宣传舞台
							</span>
						</div>
					</div>
    				<div class="descr_detail_right">
    					<img src="./images/index/login_item3_img.png">
					</div>
    			</div>
   			</div>
   			<div class="content_div_row" style="background:#ffe0d9;">
    			<div class="content_div_row_inner" style="height: 640px;">
    				<div class="descr_detail_left" style="clear:both;margin-right:45px;">
						<img src="./images/index/login_item4_img.png">
					</div>
    				<div class="descr_detail_right descr_detail_show" style="width:550px;">
						<div class="title_show_fir" style="color:#cc596e;margin-top: 80px;">
							与众相同却与众不同
						</div>
						<div class="title_show_sec title_show_line_height">
							关注招聘：<span class="content_show_fir" >
								喜欢你的人逃不掉
							</span>
						</div>
						<div class="title_show_sec title_show_line_height">
							紧急招聘：<span class="content_show_fir" >
								想招就能招得来
							</span>
						</div>
					</div>
    			</div>
   			</div>
   			<div class="content_div_row" style="background:#eff8ff">
   				<div class="content_div_row_inner" style="height: 500px;">
    				<div class="descr_detail_left descr_detail_show" style="width:440px;">
						<div class="title_show_fir" style="color:#a16bca;clear:both;margin-right:45px;">
							内心独白
						</div>
						<div class="content_show_fir">
							职米只为企业提供信息发布平台
						</div>
						<div class="content_show_fir">
							为你与求职者搭建直接沟通平台
						</div>
						<div class="content_show_fir">
							职米属于你的职业版社交圈
						</div>
					</div>
					<div class="descr_detail_right" style="margin-top: 60px;">
						<img src="./images/index/login_item2_img.png" style="width:500px;">
					</div>
    			</div>
   			</div>
   			<div class="content_div_row" style="background:#eff8ff">
    			<div class="content_div_row_inner" style="text-align: right;padding-right:345px;clear:both;">
    				<div class="title_show_sec title_show_line_height" style="color:#ff873f;">
    					一直在创新， 只为你认可
    				</div>
    				<div class="content_show_fir" style="color:#2f2f2f;">
    					--职米Family
    				</div>
    			</div>
    		</div>
    	</div>
    	
  </body>
</html>
