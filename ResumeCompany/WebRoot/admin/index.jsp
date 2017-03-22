<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>职米企业用户登录页面</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript" type="text/JavaScript" src="js/common.js"></script>
<script type="text/javascript" src="js/checkCode.js"></script>
<link href="css/base.css" rel="stylesheet" type="text/css" />
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<jsp:include page="./processbar.jsp"></jsp:include>
<link type="image/x-icon" href="/images/123.ico" rel="icon">
<script language="JavaScript" type="text/JavaScript">
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
	$(function(){
         $("#vcode").bind("keypress",function(event){
             if(event.keyCode == "13")    
             {
                 loginCheck();
             }
         });
     });
</script>

<style type="text/css">
body {
	background-color: #ffffff;
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
	margin-left: 0px;
}
#load {
	position: absolute;
	z-index: 22;
	background: #ffffff;
	height: 100%;
	width: 100%;
	filter: alpha(opacity = 60);
	opacity: 0.7;
}
#code{
	position:relative;
	top:-6px;
}
</style>
</head>

<body>
	<div id="load" align="center" style="display: none;">
		<img style="margin-top: 400px" src="./images/badou_load.gif">
	</div>
	<form name="loginForm" target="_self" id="loginForm" method="post"
		action="login!login">
		<div style="width: 100%;height:80px;line-height:80px;vertical-align:middle;background: #4680d1;"
			align="center">
			<div style="width: 950px;" align="left">
				<img src="./images/login_title_new.png">
			</div>
		</div>
		<div style="width: 100%;" align="center">
			<div style="margin-top:35px;width: 950px;" align="center">
				<img src="./images/login_logintop.png"  style="width: 327px;position:relative;left:-30px;"> <input type="hidden"
					name="toLogin" value="toLogin">
			</div>
		</div>
		<div align="center" style="margin-top:25px;position:relative;left:-94px;font-size:14px;">
			企业类型:&nbsp;<label for="comtype1" hideFocus="true"><input id="comtype1" name="comType" type="radio" checked="checked" value="0">直招</label>&nbsp;&nbsp; <label for="comtype2" hideFocus="true"><input id="comtype2" name="comType" type="radio" value="1">人力资源</label>
		</div>
		<div style="width: 100%;" align="center">
			<div align="center"
				style="width: 950px; height: 33px;margin-top: 25px;">
				<ul style="list-style: none;">
					<li style="float: left; width: 280px">&nbsp;</li>
					<li style="float: left;"><img src="./images/login_user.png"
						border="0">
					</li>
					<li style="float: left;"><input type="text" name="userName" value="admin"
						id="userName"
						style="width:220px; height:30px; border:solid 1px #e8e8e8; font-size:20px; color:#283439;background-color: #e8e8e8;padding-left: 6px; ">
					</li>
				</ul>
			</div>
		</div>
		<div style="width: 100%;" align="center">
			<div align="center"
				style="width: 950px; height: 33px;margin-top: 30px;">
				<ul style="list-style: none;">
					<li style="float: left; width: 280px">&nbsp;</li>
					<li style="float: left;"><img src="./images/login_passw.png"
						border="0">
					</li>
					<li style="float: left;"><input type="password" value="123456"
						name="password" id="password"
						style="width:220px; height:30px; border:solid 1px #e8e8e8; 
						font-size:20px; color:#283439;background-color: #e8e8e8;padding-left: 6px; ">
					</li>
				</ul>
			</div>
		</div>
		<div style="width: 100%;" align="center">
			<div align="center"
				style="width: 950px; height: 33px;margin-top: 30px;">
				<ul style="list-style: none;">
					<li style="float: left; width: 280px">&nbsp;</li>
					<li style="float: left;"><img src="./images/login_code.png"
						border="0">
					</li>
					<li style="float: left;"><input type="text" name="rand" id="vcode" maxlength="4" autocomplete="off"
						style="width:125px; height:30px; border:solid 1px #e8e8e8; 
						font-size:20px; color:#283439;background-color: #e8e8e8; padding-left: 6px;">
						<img id="code" title="看不清，换一张" border=0 style="cursor: pointer;vertical-align: middle;"
						onclick="javascript:show();return false;" />
					</li>
				</ul>
			</div>
		</div>
		<div style="width: 100%;" align="center">
			<div align="center"
				style="width: 950px; height: 33px;margin-top: 30px;">
				<ul style="list-style: none;">
					<li style="float: left; width: 280px">&nbsp;</li>
					<li style="float: left;"><a onClick="loginCheck();"><img
							src="images/login_l.png" border="0" id="login"
							style="cursor:pointer;"> </a>
					</li>
					<li style="float: left; width: 20px">&nbsp;</li>
					<li style="float: left;"><a href="./admin/register.jsp"><img
							src="images/login_r.png" border="0" id="register"
							style="cursor:pointer;"> </a>
					</li>
				</ul>

			</div>
		</div>
		<div style="width: 100%;" align="center">
			<div align="center"
				style="width: 950px; height: 33px;margin-top: 50px;">
				
			</div>
		</div>
		<div
			style="width: 100%;height:34px;line-height:34px;background: #4680d1;
			position:fixed;	bottom:0;text-align: center;vertical-align: middle;">
			<font color="#ffffff" face="微软雅黑">
					如果您的浏览器版本过旧，可能无法正常使用该系统。请升级到IE8及以上版本，或者使用chrome和火狐浏览器。 </font>
			</div>
	</form>
	<iframe id="childframe" name="childframe" src="" width="0" height="0"></iframe>
</body>
</html>