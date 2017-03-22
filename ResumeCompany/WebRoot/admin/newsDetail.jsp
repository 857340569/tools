<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>动态详情</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/base.css" type="text/css" media="all" />
<link rel="stylesheet" href="./css/common.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<script language="JavaScript" src="./js/framechild.js"></script>
<link rel="stylesheet" href="./js/flash_upload/flash_upl.css" type="text/css" />
</head>
<script type="text/javascript">
	$(function() {
		 var auditStatus="${news.auditStatus==0}";
		  if(auditStatus!="true")
		  {
// 	      	  window.parent.setExeContent(true,"编辑","images/top_edit_btn.png","news!queryNewsById?news.id=${news.id}&type=toEdit");
		  }
	});
</script>
<style>
	.seachContent{
		margin-left:8px; 
	}
</style>
<body topmargin="0" leftmargin="0">
<table width="100%" style="table-layout:fixed;" border="0"
	cellspacing="2" cellpadding="2">
	<tr class="seachjob_td" >
		<td class="lefttd"  style="width:150px;">动态标题：</td>
		<td style="border: 1px" ><div class="seachContent">${news.title}</div>
		</td>
		
	</tr>
	<tr class="seachjob_td" >
		<td class="lefttd"  style="width:150px;">动态类型：</td>
		<td style="border: 1px" ><div class="seachContent">${news.label}</div>
		</td>
		
	</tr>
	<tr class="seachjob_td" >
		<td class="lefttd"  style="width:150px;">动态地址：</td>
		<td style="border: 1px" ><div class="seachContent">${news.address}</div>
		</td>
		
	</tr>
	<tr>
		<td class="lefttd" height="28px">&nbsp;发布时间：</td>
		<td><div class="seachContent">${news.publishTime}</div>
		</td>
	</tr>
	<tr class="seachjob_td">
		<td class="lefttd"> 正文1/动态链接：</td>
		<td><p style="width: 550px;" class="seachContent" >${news.content1}</p>
		</td>
	</tr>

	<c:choose>
		<c:when test="${news.srcType eq 1}"></c:when>
		<c:otherwise>
		<tr>
		<td class="lefttd"><font class="need"></font>&nbsp;正文2：</td>
		<td><p style="width: 550px;" class="seachContent">
				<c:if test="${empty news.content2}">
					未填写
				</c:if>
				<c:if test="${!empty news.content2}">
					${news.content2}		
				</c:if>
			</p>
		</td>
	</tr>
	<tr >
		<td class="lefttd"><font class="need"></font>&nbsp;正文3：</td>
		<td><p  style="width: 550px;" class="seachContent">
			<c:if test="${empty news.content3}">
				未填写
			</c:if>
			<c:if test="${!empty news.content3}">
				${news.content3}		
			</c:if>
			</p>
		</td>
	</tr>
	<tr>
		<td class="lefttd" style="height: 120px;"><font class="releaseJob_need"></font> &nbsp;动态图片：</td>
		<td colspan="2" >
			<div id="s_udimg">
				<span id="led_img_sn">
					<c:if test="${empty news.image1&&empty news.image1&&empty news.image3}">
						<p  style="width: 550px;line-height: 120px;" class="seachContent">未上传</p>
					</c:if>
					<c:if test="${!empty news.image1}">
							<span class="uld_img" id="10">
							 	<img src="/badou_upload/${news.image1}" class="upd_img">
							 	<img style="display: none;" class="remove" id="rem10" src="images/remove.png" title="删除">
							 </span>
						 </c:if>
						 <c:if test="${!empty news.image2}">
							<span class="uld_img" id="11">
							 	<img src="/badou_upload/${news.image2}" class="upd_img">
							 	<img style="display: none;" class="remove" id="rem11" src="images/remove.png" title="删除">
							 </span>
						 </c:if>
						 <c:if test="${!empty news.image3}">
							<span class="uld_img" id="12">
							 	<img src="/badou_upload/${news.image3}" class="upd_img">
							 	<img style="display: none;" class="remove" id="rem12" src="images/remove.png" title="删除">
						</span>
					</c:if>
				</span>
			</div>
		</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<c:if test="${news.auditStatus!=0}">
					<a href="news!queryNewsById?news.id=${news.id}&type=toEdit" style="text-align:center;" target="mainFrame"  class="exeCommonBtn">修&nbsp;改</a>
				</c:if>
			</td>
		</tr>
		</c:otherwise>
	</c:choose>
</table>
</body>
</html>