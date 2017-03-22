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
<title>职位管理</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./css/base.css" rel="stylesheet" type="text/css">
<link href="./css/common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<script type="text/javascript">
	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
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
									<td>动态标题</td>
									<td>动态类型</td>
									<td>动态内容1/动态链接</td>
									<td>动态内容2</td>
									<td>动态内容3</td>
									<td title="只有通过审核的动态,才能展示到客户端上">审核状态</td>
									<td>备注</td>
									<td>发布时间</td>
									<td>操作</td>
								</tr>
								<c:if test="${empty divPage.dataMap['news']}">
									<tr align="center">
										<td height="35" class="rd8" colspan="8"><font color="red">还没有发布任何动态！</font>
										</td>
									</tr>
								</c:if>
								<c:forEach items="${divPage.dataMap['news']}" var="newsItem"
									varStatus="status">
									<tr align="center" id="${status.count}" height="29"
										onmouseover="this.style.background='#eeeeee'"
										onmouseout="this.style.background=''">
										<td align="center" class="r8">
											${newsItem.title}
										</td>
										<td align="center" class="r8">
											${newsItem.label}
										</td>
										<td align="center" class="r8" title="${newsItem.content1}">
											<c:choose>
												<c:when test="${fn:length(newsItem.content1)>16}">
													${fn:substring(newsItem.content1,0,16)}...
												</c:when>
												<c:otherwise>
													${newsItem.content1}
												</c:otherwise>
											</c:choose>
											
										</td>
										<td align="center" class="r8" title="${newsItem.content2}">
											<c:choose>
												<c:when test="${!empty newsItem.content2}">
													<c:choose>
														<c:when test="${fn:length(newsItem.content2)>16}">
															${fn:substring(newsItem.content2,0,16)}...
														</c:when>
														<c:otherwise>
															${newsItem.content2}
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${newsItem.srcType==1}">
															--
														</c:when>
														<c:otherwise>
															未填写
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
											
										</td>
										<td align="center" class="r8" title="${newsItem.content3}">
											<c:choose>
												<c:when test="${!empty newsItem.content3}">
													<c:choose>
														<c:when test="${fn:length(newsItem.content3)>16}">
															${fn:substring(newsItem.content3,0,16)}...
														</c:when>
														<c:otherwise>
															${newsItem.content3}
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${newsItem.srcType==1}">
															--
														</c:when>
														<c:otherwise>
															未填写
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</td>
										<td align="center" class="r8">
											<c:choose>
												<c:when test="${newsItem.auditStatus==0}">
													通过审核
												</c:when>
												<c:when test="${newsItem.auditStatus==1}">
													审核中
												</c:when>
												<c:when test="${newsItem.auditStatus==2}">
													未通过审核
												</c:when>
												<c:otherwise>
													审核中
												</c:otherwise>
											</c:choose>
										</td>
										<td title="${newsItem.remarks}">
											<c:choose>
												<c:when test="${newsItem.auditStatus==2}">
														失败原因：<c:choose>
														<c:when test="${fn:length(newsItem.remarks)>10}">
															${fn:substring(newsItem.remarks,0,10)}...
														</c:when>
														<c:otherwise>
															${newsItem.remarks}
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													暂无
												</c:otherwise>
											</c:choose>
										</td>
										<td>${newsItem.publishTime}</td>
										<td align="center" class="r8"><a
											style="text-decoration: none"
											href="news!queryNewsById?news.id=${newsItem.id}&type=find">
												<span class="last_exe_btn_common last_exe_btn_valid">查看</span>
											</a>
											<c:choose>
												<c:when test="${newsItem.auditStatus==0}">
													<span class=" last_exe_btn_common last_exe_btn_invalid" title="已通过审核，不能编辑">修改</span>
												</c:when>
												<c:otherwise>
													<a href="news!queryNewsById?news.id=${newsItem.id}&type=toEdit">
														<span class=" last_exe_btn_common last_exe_btn_valid">修改</span>
													</a>
												</c:otherwise>
											</c:choose>
											<a href="news!deleteNewsById?news.id=${newsItem.id}"
											onclick="return confirm('删除后将无法恢复,确定要删除吗?')">
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
									<jsp:param name="url" value="news!queryAllNews" />
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
