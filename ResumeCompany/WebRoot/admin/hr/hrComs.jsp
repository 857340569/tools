<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>代理公司</title>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="./css/base.css">
<link rel="stylesheet" type="text/css" href="./css/common.css">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript" type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
<link href="./js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./js/contenListener.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<script type="text/javascript">

//判断网页是否加载完成  
 document.onreadystatechange = function () {   
     if(document.readyState=="complete") {         
         window.parent.loadCompleted();   
     }  
 };
</script>
<style type="text/css">

body {
	padding-top:10px;
	padding-left:10px; 
}
.hr_tit_gude{
	background:#82b1f3;
	color:#fff;
	font-size:15px;
	text-align:center;
	width: 100px;
	height: 40px;
	line-height: 40px;
	margin-bottom:10px; 
	margin-left: 10px;
}
#add_com{
	margin-top:10px;
	cursor:pointer;
	float:left;
}
#add_com a:visited{
	color:#fff;
}
#add_com:hover{
	background:#96c2ff;
}
</style>
</head>
<body>
	<div class="hr_tit_gude" style="background:#96c2ff">
		总公司信息
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="float:left;border-bottom:2px solid #4680d1;">
		<tr align="center" class="dataTittleBg" >
			<td>企业名</td>
			<td>地址</td>
			<td>注册时间</td>
			<td>操作</td>
		</tr>
		<tr height="29">
			<td align="center" class="r8">
				${hr.name}
			</td>
			<td align="center" class="r8">
				${hr.address}
			</td>
			<td align="center" class="r8">
				<c:if test="${empty hr.registTime}">
					未知
				</c:if>
				<c:if test="${!empty hr.registTime}">
						${hr.registTime}
				</c:if>
			</td>
			<td align="center" class="r8">
				<a href="myInfo!hrInfo?type=queryInfo" target="mainFrame"><span class="last_exe_btn_common last_exe_btn_valid">查看</span></a>
				<a href="myInfo!hrInfo?type=queryEdit" target="mainFrame"><span class=" last_exe_btn_common last_exe_btn_valid">修改</span></a>
			</td>
		</tr>
	</table>
	<div class="hr_tit_gude" id="add_com">
		<a href="./admin/hr/addComMain.jsp" target="mainFrame" hideFocus="true" style="color:#fff;">添加下属公司</a>
	</div>
	<iframe name="secondFrame" id="secondFrame" src="company!queryAllHrCompany" width="100%" height="800px" frameborder="0" scrolling="no"></iframe>
	
</body>
</html>