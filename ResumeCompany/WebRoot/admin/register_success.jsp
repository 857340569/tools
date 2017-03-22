<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">

<title>恭喜你，注册成功！</title>
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript">
var comName="${empty company.loginAccount}";
var psw="${empty company.loginPassword}";
if(comName=="true"||psw=="true")
{
	window.location.href="<%=basePath%>index.jsp?2";
}
$(function(){
	var time=5;
	setInterval(function(){
		time--;
		if(time==0)
			
			subForm();
		$("#time").text(time);
	},1000);
});
function subForm()
{
	with($("#loginForm"))
	{
		submit();
	}
}
</script>
</head>

<body>
	<form name="loginForm" target="_parent" id="loginForm" method="post" action="login!login">
		<input type="hidden" name="toLogin" value="toLogin">
		<input type="hidden" name="comType" value="0">
		<input type="hidden" name="userName" value="${company.loginAccount}">
		<input type="hidden" name="password" value="${company.loginPassword}">
		<input type="hidden" name="type" value="direct_regist">
		<font color=green>提示：注册成功,<label id="time">5</label>秒后将自动跳转登录页面,</font>
		<a href="javascript:;" onclick="subForm();" >立即跳转</a>
	</form>
</body>
</html>