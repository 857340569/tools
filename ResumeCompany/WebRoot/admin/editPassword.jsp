<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>职位发布</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<link href="./js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<script src="./js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>

<script language="JavaScript" type="text/javascript">
	$(function() {
		$(".changePassword").Validform({
			tiptype : 2,
			showAllError : true
		});
	});
	// 判断网页是否加载完成  
     document.onreadystatechange = function () {   
         if(document.readyState=="complete") {         
             window.parent.loadCompleted();   
         }  
     };
</script>
<style type="text/css">
	body {
		margin-top: 10px;
		background-color: #ffffff;
		margin-left: 10px;
	}
	#change_submit:hover {
		background-image:url("./images/change_focus.png");
	}
	.exeCommonBtn
	{
		width:210px;
		height:40px;
		line-height:40px;
		vertical-align:middle;
		color:#fff;
		float: left;
		background:#4680d1;
		border:none;
		margin-left: 125px;
		margin-top: 45px;
		font-size:20px;
	}
	.exeCommonBtn:hover{
		background:#6fa1e7;
	}
	.ed_ps{
		width:225px;
	}
</style>
</head>

<body topmargin="0" leftmargin="0">
	<form class="changePassword" name="changePassword" id="changePassword" action="myInfo!updatePassword" method="post">
		<table width="100%" style="table-layout:fixed;" border="0"
			cellspacing="2" cellpadding="2">
			<tr>

				<td class="lefttd" style="width: 160px;"><font
					class="releaseJob_need">*</font>&nbsp;原&nbsp;密&nbsp;码：</td>
				<td style="width:240px;"><input type="password" value=""
					id="oldPassword" name="oldPassword" class="inp006 ed_ps" datatype="*6-16" nullmsg="请输入原密码！" autocomplete ="off"/></td>
				<td><div class="Validform_checktip"></div>
			</tr>
			<tr>
				<td class="lefttd"><font
					class="releaseJob_need">*</font>&nbsp;新&nbsp;密&nbsp;码：</td>
				<td><input type="password" value="" id="newPassword"
					name="newPassword" class="inp006 ed_ps" datatype="*6-16"
					nullmsg="请输入新密码！" errormsg="密码范围在6~16位之间！" /></td>
				<td><div class="Validform_checktip"></div>
			</tr>
			<tr>
				<td class="lefttd"><font
					class="releaseJob_need">*</font>&nbsp;确认密码：</td>
				<td><input type="password" value="" id="password2"
					name="password2" class="inp006 ed_ps" datatype="*6-16" recheck="newPassword"
					nullmsg="请再输入一次密码！" errormsg="您两次输入的密码不一致！" /></td>
				<td><div class="Validform_checktip"></div>
			</tr>
			<tr height="10"></tr>
		</table>
		<div id="submit_div">
			<input type="submit"  value="提&nbsp;交" class="exeCommonBtn" id="exeCommonBtn"/>
		</div>
	</form>

</body>
</html>