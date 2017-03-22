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
<title>发票申请记录查询</title>
<base href="<%=basePath%>">
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./css/base.css" rel="stylesheet" type="text/css">
<link href="./css/common.css" rel="stylesheet" type="text/css">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"  language="javascript"></script>
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<link href="./css/common.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	};
	$(function(){
		window.parent.setTitle("发票申请记录查询");
	});
</script>
<style type="text/css">
	body {
		padding-top:10px;
		padding-left:10px; 
	}
</style>
</head>
<body>
	<form name="company" id="company" action="" method="post">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="100%">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" width="100%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr align="center" class="dataTittleBg">
										<td>发票类型</td>
										<td>发票抬头</td>
										<td>发票金额</td>
										<td>发票内容</td>
										<td>邮寄地址</td>
										<td>邮寄方式</td>
										<td>收件人</td>
										<td>联系电话</td>
										<td>申请时间</td>
										<td>开具时间</td>
										<td>状态</td>
										<td>备注</td>
									</tr>

									<c:if test="${empty divPage.dataMap['invoices']}">
										<tr align="center">
											<td height="35" class="rd8" colspan="13"><font
												color="red">暂无申请记录</font>
											</td>
										</tr>
									</c:if>
									<c:forEach items="${divPage.dataMap['invoices']}" var="invoice"
										varStatus="status">
										<tr align="center" id="${status.count}" height="29"
											onmouseover="this.style.background='#eeeeee'"
											onmouseout="this.style.background=''">
											<td align="center" class="r8"> 
												${invoice.type}
											</td>
											<td align="center" class="r8">
												${invoice.headName}
											</td>
											<td align="center" class="r8">
												${invoice.pay}
											</td>
											<td align="center" class="r8">
												${invoice.content}
											</td>
											<td align="center" class="r8"> 
												${invoice.address}
											</td>
											<td align="center" class="r8"> 
												${invoice.postWay}
											</td>
											<td align="center" class="r8"> 
												${invoice.recipient}
											</td>
											<td align="center" class="r8"> 
												${invoice.contactPhone}
											</td>
											<td align="center" class="r8"> 
												${invoice.applyTime}
											</td>
											<td align="center" class="r8"> 
												<c:choose>
													<c:when test="${invoice.status==2}">
														${invoice.makeTime}
													</c:when>
													<c:otherwise>
														--
													</c:otherwise>
												</c:choose>
											</td>
											<td align="center" class="r8"> 
												<c:choose>
													<c:when test="${invoice.status==1}">
														申请中
													</c:when>
													<c:when test="${invoice.status==2}">
														完成
													</c:when>
													<c:otherwise>
														其它
													</c:otherwise>
												</c:choose>
											</td>
											<td align="center" class="r8"> 
												<c:choose>
													<c:when test="${empty invoice.remark}">
														暂无
													</c:when>
													<c:otherwise>
														${invoice.remark}
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</table>
								<div style="background-color: #e4ebf1;font-size: 12px;	color: #050505;	white-space:nowrap;">
									<jsp:include page="page.jsp">
										<jsp:param name="url" value="invoice!queryAllInvoices" />
									</jsp:include>
								</div>
							</td>
						</tr>
					</table></td>
			</tr>
		</table>
	</form>
</body>
</html>
