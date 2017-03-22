<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>职位查询</title>
<base href="<%=basePath%>">
<script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<link href="css/common.css" type="text/css" rel="stylesheet" />
<link href="css/base.css" type="text/css" rel="stylesheet" />
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<script language="JavaScript" src="./js/framechild.js"></script>
<jsp:include page="processbar.jsp"></jsp:include> 
<script language="JavaScript" type="text/JavaScript">
	$(function() {
		  window.parent.mainTop();
	});
</script>
<style type="text/css">
	.okBtn{
		height: 40px;
		width: 150px;
		border: 0px none;
		cursor: pointer;
		border-radius: 4px;
		background:#ffb137;
		-moz-border-radius:4px;
		-webkit-border-radius:4px;
		behavior: url(css/ie-css3.htc); 
		margin-top: 40px;
		color: #fff;
	}
	.seachContent{
		padding:10px;
		font-size:14px;
	}
</style>
</head>

<body topmargin="0" leftmargin="0" style="margin-left: 10px;background-color: #ffffff;margin-top: 10px;">
	<table width="800" style="table-layout:fixed;" border="0" cellspacing="2" cellpadding="2">
		<tr class="seachjob_td">
			<td class="lefttd" style="width:180px;"> 职位名称：</td>
			<td><div class="seachContent">
				<c:choose>
					<c:when test="${empty job.name}">
						<c:choose>
							<c:when test="${fn:contains(job.category,'-')}">
								${fn:split(job.category,"-")[1]}
							</c:when>
							<c:otherwise>
								${job.category}
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						${job.name}
					</c:otherwise>
				</c:choose>
			</div>
			</td>
		</tr>
		<tr class="seachjob_td">
			<td class="lefttd"> 需求人数：</td>
			<td><div class="seachContent">${job.recruitingNumbers}</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;年龄范围：</td>
			<td><div class="seachContent">
				<c:if test="${!empty ageEnd}">
					${ageStart}-${ageEnd}岁
				</c:if>
				<c:if test="${empty ageEnd}">
					${ageStart}
				</c:if>
			</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;性别要求：</td>
			<td><div class="seachContent">${sexLimite}</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd"><font class="need"></font>&nbsp;工作地点：</td>
			<td><div class="seachContent">${job.workplace}</div>
			</td>
		</tr>
		<tr >
			<td class="lefttd"><font class="need"></font>&nbsp;联系电话：</td>
			<td><div class="seachContent">${job.contactPhone}</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;薪资范围：</td>
			<td><div class="seachContent">${job.workPay}</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;面试时间：</td>
			<td><div class="seachContent">${job.interviewTime }</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;工作经验：</td>
			<td><div class="seachContent">${job.requreExperience }</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;学历要求：</td>
			<td><div class="seachContent">${job.requreEducation}</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;福利：</td>
			<td><div class="seachContent">${job.welfare }</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;是否加入集结号：</td>
			<td><div class="seachContent">
				<c:choose>
					<c:when test="${job.send eq 'jijiehao'}">
						是
					</c:when>
					<c:otherwise>
						否
					</c:otherwise>
				</c:choose>
			</div>
			</td>
		</tr>
		<c:if test="${job.send eq 'jijiehao'}">
			<tr>
				<td class="lefttd" height="28px">&nbsp;集结号到期时间：</td>
				<td><div class="seachContent">
					${job.sendendtime}
				</div>
				</td>
			</tr>
		</c:if>
		<tr>
			<td class="lefttd">&nbsp;职位简介：</td>
			<td><div class="seachContent">${job.requirements}</div></td>
		</tr>
		<tr>
			<td></td>
<!-- 			 var auditStatus="${job.auditStatus==0}"; -->
<!-- 		  if(auditStatus!="true") -->
<!-- 		  { -->
<!-- // 	      	  window.parent.setExeContent(true,"编辑","images/top_edit_btn.png","job!editJob?job.id=${job.id}"); -->
<!-- 		  } -->
<!-- 			<td><input onclick="javascript:history.go(-1);window.parent.setExeContent(false);" name="okBtn" class="okBtn" type="button" value="确定"></td> -->
			<td>
				<c:if test="${job.auditStatus!=0}">
					<a href="job!editJob?job.id=${job.id}" style="text-align:center;" target="mainFrame"  class="exeCommonBtn">编&nbsp;辑</a>
				</c:if>
			</td>
		</tr>
	</table>
</body>
</html>