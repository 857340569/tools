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
<title>活动详情</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/base.css" type="text/css" media="all" />
<link rel="stylesheet" href="./css/common.css" type="text/css" media="all" />
<link rel="stylesheet" href="./css/style.css" type="text/css" media="all" />
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<link rel="stylesheet" href="./js/flash_upload/flash_upl.css" type="text/css" />
<script language="JavaScript" src="./js/framechild.js"></script>
<script type="text/javascript">
	$(function() {
		 var auditStatus="${activities.auditStatus==0}";
		  if(auditStatus!="true")
		  {
//       		  window.parent.setExeContent(true,"编辑","images/top_edit_btn.png","activities!queryActsById?activities.id=${activities.id}&type=toEdit");
		  }
	});
</script>
<style type="text/css">
	body {
		padding-top:10px;
		padding-left:10px; 
	}
	.seachContent{
		padding-left:8px;
	}
</style>
</head>
<body topmargin="0" leftmargin="0">
<table width="100%" style="table-layout:fixed;" border="0"
	cellspacing="2" cellpadding="2">
	<tr class="seachjob_td" >
		<td class="lefttd"  style="width:150px;">活动标题：</td>
		<td style="border: 1px" ><div class="seachContent">${activities.title}</div>
		</td>
		
	</tr>
	<tr>
		<td class="lefttd" height="28px">&nbsp;活动主办方：</td>
		<td><div class="seachContent">${activities.organizers}</div>
		</td>
	</tr>
	<tr>
		<td class="lefttd" height="28px">&nbsp;活动类型：</td>
		<td><div class="seachContent">${activities.label}</div>
		</td>
	</tr>
	<tr class="seachjob_td">
		<td class="lefttd"> 活动地点：</td>
		<td class="seachContent"><p style="width: 550px;">${activities.activitiesPlace}</p>
		</td>
	</tr>
	<tr class="seachjob_td">
		<td class="lefttd"> 活动时间：</td>
		<td class="seachContent"><p style="width: 550px;" >${activities.holdTime}--${activities.endTime}</p>
		</td>
	</tr>
	<tr class="seachjob_td">
		<td class="lefttd"> 联系方式：</td>
		<td class="seachContent"><p style="width: 550px;" >
			<c:if test="${empty activities.phone}">
				未填写
			</c:if>
			<c:if test="${!empty activities.phone}">
				${activities.phone}		
			</c:if>
		</p>
		</td>
	</tr>
	<tr class="seachjob_td">
		<td class="lefttd"> 是否加入等你来：</td>
		<td class="seachContent"><p style="width: 550px;" >
			<c:choose>
				<c:when test="${activities.send eq 'dengnilai'}">
					是
				</c:when>
				<c:otherwise>
					否
				</c:otherwise>
			</c:choose>
		</p>
		</td>
	</tr>
		<tr>
		<td class="lefttd"><font class="need"></font>&nbsp;活动内容1：</td>
		<td class="seachContent"><p style="width: 550px;">${activities.content1}</p>
		</td>
	</tr>
	<tr >
		<td class="lefttd"><font class="need"></font>&nbsp;活动内容2：</td>
		<td class="seachContent"><p  style="width: 550px;" >
				<c:if test="${empty activities.content2}">
					未填写
				</c:if>
				<c:if test="${!empty activities.content2}">
					${activities.content2}		
				</c:if>
			</p>
		</td>
	</tr>
	<tr >
		<td class="lefttd"><font class="need"></font>&nbsp;活动内容3：</td>
		<td class="seachContent"><p  style="width: 550px;" >
				<c:if test="${empty activities.content3}">
					未填写
				</c:if>
				<c:if test="${!empty activities.content3}">
					${activities.content3}		
				</c:if>
			</p>
		</td>
	</tr>
	<tr>
		<td class="lefttd" style="height: 120px;"><font class="releaseJob_need"></font> &nbsp;活动图片：</td>
		<td colspan="2" >
			<div id="s_udimg">
				<span id="led_img_sn">
					<c:if test="${empty activities.image1&&empty activities.image2&&empty activities.image3}">
						<p  style="width: 550px;line-height:120px;margin-left:8px;" >未上传</p>
					</c:if>
					<c:if test="${!empty activities.image1}">
							<span class="uld_img" id="10">
							 	<img src="/badou_upload/${activities.image1}" class="upd_img">
							 	<img style="display: none;" class="remove" id="rem10" src="images/remove.png" title="删除">
							 </span>
						 </c:if>
						 <c:if test="${!empty activities.image2}">
							<span class="uld_img" id="11">
							 	<img src="/badou_upload/${activities.image2}" class="upd_img">
							 	<img style="display: none;" class="remove" id="rem11" src="images/remove.png" title="删除">
							 </span>
						 </c:if>
						 <c:if test="${!empty activities.image3}">
							<span class="uld_img" id="12">
							 	<img src="/badou_upload/${activities.image3}" class="upd_img">
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
			<c:if test="${activities.auditStatus!=0}">
				<a href="activities!queryActsById?activities.id=${activities.id}&type=toEdit" style="text-align:center;" target="mainFrame"  class="exeCommonBtn">修&nbsp;改</a>
			</c:if>
		</td>
	</tr>
	</table>
</body>
</html>