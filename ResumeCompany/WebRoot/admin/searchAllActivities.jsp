<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>活动管理</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./css/base.css" rel="stylesheet" type="text/css">
<link href="./css/common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<script src="./js/My97DatePicker/WdatePicker.js" type="text/javascript"
	language="javascript"></script>
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>

<script language="JavaScript">
	// 判断网页是否加载完成  
	document.onreadystatechange = function() {
			window.parent.loadCompleted();
		}
</script>
<style type="text/css">
body {
	margin-top: 10px;
	background-color: #ffffff;
	margin-left: 10px
}
#apply_info_div{
	padding-top:10px;
}
#apply_select_conditions{
	width:210px;
	float: right;
}
#apply_infos{
	margin-right: 220px;
}
</style>

</head>
<body topmargin="0" leftmargin="0">
	<form name="jobForm" id="jobForm" action="new!deleteSelectJobs">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="float: left;">
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					style="border-bottom:none;">
					<tr>
						<td valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr align="center" class="dataTittleBg" >
									<td>活动标题</td>
									<td>活动类型</td>
									<td>活动主办方</td>
									<td>活动时间</td>
									<td>活动地点</td>
									<td  title="只有通过审核的动态,才能展示到客户端上">审核状态</td>
									<td>备注</td>
									<td>操作</td>
								</tr>
								<c:if test="${empty divPage.dataMap['activities']}">
									<tr align="center">
										<td height="35" class="rd8" colspan="9"><font color="red">还没有发布任何动态！</font>
										</td>
									</tr>
								</c:if>
								<c:forEach items="${divPage.dataMap['activities']}" var="actItem"
									varStatus="status">
									<tr align="center" id="${status.count}" height="29"
										onmouseover="this.style.background='#eeeeee'"
										onmouseout="this.style.background=''">
										<td align="center" class="r8">
											<c:choose>
												<c:when test="${fn.length(actItem.title)>15}">${fn:substring(actItem.title,0,15)}...</c:when>
												<c:otherwise>${fn:substring(actItem.title,0,15)}</c:otherwise>
											</c:choose>
										</td>
										<td>${actItem.label}</td>
										<td>${actItem.organizers}</td>
										<td>
											<c:choose>
												<c:when test="${actItem.holdTime eq actItem.endTime}">
													${actItem.holdTime}
												</c:when>
												<c:otherwise>
													${actItem.holdTime}至${actItem.endTime}
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											${actItem.activitiesPlace}
										</td>
										<td align="center" class="r8">
											<c:choose>
												<c:when test="${actItem.auditStatus==0}">
													通过审核
												</c:when>
												<c:when test="${actItem.auditStatus==1}">
													审核中
												</c:when>
												<c:when test="${actItem.auditStatus==2}">
													未通过审核
												</c:when>
												<c:otherwise>
													审核中
												</c:otherwise>
											</c:choose>
										</td>
										<td title="${actItem.remarks}">
											<c:choose>
												<c:when test="${actItem.auditStatus==2}">
														失败原因：<c:choose>
														<c:when test="${fn:length(actItem.remarks)>10}">
															${fn:substring(actItem.remarks,0,10)}...
														</c:when>
														<c:otherwise>
															${actItem.remarks}
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													暂无
												</c:otherwise>
											</c:choose>
										</td>
										<td align="center" class="r8"><a href="activities!queryActsById?activities.id=${actItem.id}&type=find">
												<span class="last_exe_btn_common last_exe_btn_valid">查看</span>													
											</a>
											<c:choose>
												<c:when test="${actItem.auditStatus==0}">
													<span class=" last_exe_btn_common last_exe_btn_invalid" title="已通过审核，不能编辑">修改</span>
												</c:when>
												<c:otherwise>
													<a href="activities!queryActsById?activities.id=${actItem.id}&type=toEdit">
														<span class=" last_exe_btn_common last_exe_btn_valid">修改</span>
													</a>
												</c:otherwise>
											</c:choose>
											<a href="activities!deleteActById?activities.id=${actItem.id}" onclick="return confirm('删除后将无法恢复,确定要删除吗?')">
												<span class=" last_exe_btn_common last_exe_btn_valid">删除</span>
											</a>
										</td>
									</tr>
									<tr>
										<td width="100%" height="1px" bgcolor="#aaaaaa" colspan="9">
										</td>
									</tr>
									<c:if test="${status.count%2==0}">
									</c:if>
								</c:forEach>
							</table>
							<div>
								<jsp:include page="page.jsp">
									<jsp:param name="url" value="activities!queryAllActivities" />
								</jsp:include>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
</body>
</html>
