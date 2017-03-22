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
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./css/base.css" rel="stylesheet" type="text/css">
<link href="./css/common.css" rel="stylesheet" type="text/css">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<script language="JavaScript" type="text/JavaScript"
	src="./js/common.js"></script>
<script src="./js/My97DatePicker/WdatePicker.js" type="text/javascript"
	language="javascript"></script>

<script language="JavaScript">
	function checkAll() {
		for ( var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document
					.getElementById("ifAll").checked;
		}
	}
	function deleteJobs(){
		if($("input:checkbox[name=selectFlag]:checked").length<=0)
		{
			alert("请先选择要删除的职位!");
		}else{
			if(confirm("删除选中的职位将不能恢复，请谨慎操作，确定要删除吗？"))
			{
				with($("#jobForm"))
				{
					submit();
				}
			}
		}
	}
	//职位续期
	function vipExtension(jobId,phoneStatus){
	
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : "job!jobVipExtension",
			data:{
				"job.id":jobId
			},
			success : function(jsondata)
			{
			
 				if(jsondata.status=="y")
 				{
 					$("#"+jobId).attr("href","javascript:updateDeleteStatus("+jobId+","+phoneStatus+",1)");
					$("#"+jobId).find("span").text("下线");
					$("#"+jobId).find("span").attr("title","下线后用户将查看不到该条职位信息");
 					alert(jsondata.info);
 				}else if(jsondata.status=="n")
 				{
 					alert(jsondata.info);
 				}
 			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				window.top.location.href="<%=basePath%>index.jsp?2";
 			}
 		});
	}
	function updateDeleteStatus(jobId,phoneStatus,delStatus)
	{
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : "job!changeDeleteStatus",
			data:{
				"job.id":jobId,
				"job.phoneStatus":phoneStatus,
				"job.deleteStatus":delStatus
			},
			beforeSend : function() {
			},
			success : function(jsondata)
			{
			
 				if(jsondata.status=="expired")//电话招聘过期
 				{
 					if(confirm("该职位包月时间已到期，不能上线，是否续费一个月?"))
 					{
 						vipExtension(jobId,phoneStatus);
 					}
 				}
 				else if(jsondata.status=="y")
 				{
 					if(delStatus==1)//设置为下线
 					{
 						$("#"+jobId).attr("href","javascript:updateDeleteStatus("+jobId+","+phoneStatus+",0)");
 						$("#"+jobId).find("span").text("上线");
 						$("#"+jobId).find("span").removeAttr("title");
 					}else
 					{
 						$("#"+jobId).attr("href","javascript:updateDeleteStatus("+jobId+","+phoneStatus+",1)");
 						$("#"+jobId).find("span").text("下线");
 						$("#"+jobId).find("span").attr("title","下线后用户将查看不到该条职位信息");
 					}
 					alert(jsondata.info);
 				}else if(jsondata.status=="n")
 				{
 					alert(jsondata.info);
 				}
 				
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				window.top.location.href="<%=basePath%>index.jsp?2";
 			}
	});
	}
</script>
</head>
<body topmargin="0" leftmargin="0">
	<form name="jobForm" id="jobForm" action="job!deleteSelectJobs" target="mainFrame" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="float: left;">
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					style="border-bottom:none;">
					<tr>
						<td valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr align="center" class="dataTittleBg" >
									<td height="29"><input type="checkbox" name="ifAll"
										id="ifAll" onClick="checkAll()" title="全选/反选">
									</td>
									<td>职位类别</td>
									<c:if test="${comType eq 1 }">
										<td>所属公司</td>
									</c:if>
									<td>招聘方式</td>
									<td>招聘人数</td>
									<td>工作地点</td>
									<td>发布时间</td>
									<td>申请人数</td>
									<td title="只有通过审核的职位,才能被用户搜索到">审核状态</td>
									<td>备注</td>
									<td>操作</td>
								</tr>
								<c:if test="${empty divPage.dataMap['jobs']}">
									<tr align="center">
										<td height="35" class="rd8" colspan="8"><font color="red">还没有发任何职位！</font>
										</td>
									</tr>
								</c:if>
								<c:forEach items="${divPage.dataMap['jobs']}" var="job"
									varStatus="status">
									<tr align="center" id="${status.count}" height="29"
										onmouseover="this.style.background='#eeeeee'"
										onmouseout="this.style.background=''">
										<td class="r8"><input type="checkbox" name="selectFlag"
											class="checkbox1" value="${job.id}">
										</td>
										<td align="center" class="r8">
											<c:choose>
												<c:when test="${fn:contains(job.category,'-')}">
													${fn:split(job.category,"-")[1]}
												</c:when>
												<c:otherwise>
													${job.category}
												</c:otherwise>
											</c:choose>
										</td>
										<c:if test="${comType eq 1 }">
											<td>${divPage.dataMap['companies'][job.id].name}</td>
										</c:if>
										<td align="center" class="r8">
											<c:choose>
												<c:when test="${job.phoneStatus==0}">
													在线申请
												</c:when>
												<c:otherwise>
													电话招聘
												</c:otherwise>
											</c:choose>
										</td>
										<td align="center" class="r8">
											${job.recruitingNumbers}
										</td>
										<td align="center" class="r8">
											${job.workplace}
										</td>
										<td align="center" class="r8">
											${job.releaseTime}
										</td>
										<td align="center" style="font-size: 18px;color: #050505;">
											<c:choose>
												<c:when test="${job.auditStatus==0}">
													<c:choose>
														<c:when test="${divPage.entitysMap[job.id]>0}">
															<a href="job!queryApplyByJobId?job.id=${job.id}&type=mainFrame" target="mainFrame" title="点击查看申请详情">${divPage.entitysMap[job.id]}</a>
														</c:when>
														<c:otherwise>
															0
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													--
												</c:otherwise>
											</c:choose>
										</td>
										<td align="center" class="r8">
											<c:choose>
												<c:when test="${job.auditStatus==0}">
													通过审核
												</c:when>
												<c:when test="${job.auditStatus==1}">
													审核中
												</c:when>
												<c:when test="${job.auditStatus==2}">
													未通过审核
												</c:when>
												<c:otherwise>
													审核中
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${job.auditStatus==2}">
													失败原因：${job.remarks}
												</c:when>
												<c:otherwise>
													暂无
												</c:otherwise>
											</c:choose>
										</td>
										<td align="center" class="r8">
											<a href="job!queryJobById?job.id=${job.id}" target="mainFrame">
												<span class=" last_exe_btn_common last_exe_btn_valid">查看</span>
											 </a>
											<c:choose>
												<c:when test="${job.auditStatus==0}">
													<span class=" last_exe_btn_common last_exe_btn_invalid" title="已通过审核，不能编辑">修改</span>
												</c:when>
												<c:otherwise>
													<a href="job!editJob?job.id=${job.id}" target="mainFrame">
														<span class=" last_exe_btn_common last_exe_btn_valid">修改</span>
													 </a>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${empty job.deleteStatus||job.deleteStatus==0}">
													<a href="javascript:updateDeleteStatus(${job.id},${job.phoneStatus},1)" id="${job.id}">
														<span class=" last_exe_btn_common last_exe_btn_valid" title="下线后用户将查看不到该条职位信息">下线</span>
													</a>
												</c:when>
												<c:otherwise>
													<a href="javascript:updateDeleteStatus(${job.id},${job.phoneStatus},0)" id="${job.id}">
														<span class=" last_exe_btn_common last_exe_btn_valid">上线</span>
													 </a>
												</c:otherwise>
											</c:choose>
											<a href="job!deletejob?job.id=${job.id}" onclick="return confirm('删除后将无法恢复,确定要删除吗?')" target="mainFrame">
												<span class=" last_exe_btn_common last_exe_btn_valid">删除</span>
											</a>
										</td>
									</tr>
								</c:forEach>
							</table>
							<div>
								<jsp:include page="../page.jsp">
									<jsp:param name="url" value="${actionUrl}" />
									<jsp:param name="para" value="${pageUrl}" />
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
