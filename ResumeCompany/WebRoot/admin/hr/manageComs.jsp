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
</script>
<style type="text/css">
.r8{
	font-size: 12px;
	color: #050505;
	white-space:nowrap;
}
</style>
</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="float:left;">
		<tr align="center" class="dataTittleBg" >
			<td>编号</td>
			<td>企业名</td>
			<td>地址</td>
			<td>注册时间</td>
			<td>操作</td>
		</tr>
		<c:if test="${empty divPage.dataMap['companies']}">
			<tr align="center">
				<td height="35" class="rd8" colspan="5"><font
					color="red">你还没有添加任何企业!</font>
				</td>
			</tr>
		</c:if>
		<c:forEach items="${divPage.dataMap['companies']}" var="company"
		varStatus="status">
		<tr align="center" id="${status.count}" height="29"
			onmouseover="this.style.background='#eeeeee'"
			onmouseout="this.style.background=''">
			<td>${(divPage.currentPageNo-1)*divPage.pageSize+status.count}</td>
			<td align="center" class="r8">
				${company.name}
			</td>
			<td align="center" class="r8">
				${company.address}
			</td>
			<td align="center" class="r8">
				<c:if test="${empty company.registTime}">
					未知
				</c:if>
				<c:if test="${!empty company.registTime}">
						${company.registTime}
				</c:if>
			</td>
			<td>
				<a href="myInfo!myInfo?type=queryInfo&company.id=${company.id}" hideFocus="true" target="mainFrame">
					<span class="last_exe_btn_common last_exe_btn_valid">查看</span>
				</a>
				<a href="myInfo!myInfo?type=queryEdit&company.id=${company.id}" hideFocus="true" target="mainFrame">
					<span class=" last_exe_btn_common last_exe_btn_valid">修改</span>
			</td>
		</tr>
	</c:forEach>
	</table>
	<div  class="r8" style="background-color: #e4ebf1;clear: both;" >
		<jsp:include page="../page.jsp">
			<jsp:param name="url" value="company!queryAllHrCompany" />
		</jsp:include>
	</div>
</body>
</html>