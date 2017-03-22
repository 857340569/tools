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
<title>充值记录查询</title>
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
		window.parent.setTitle("充值记录查询");
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
										<td>名称</td>
										<td>订单编号</td>
										<td>支付金额(元)</td>
										<td>充值数量(米粒)</td>
										<td>充值时间</td>
									</tr>

									<c:if test="${empty divPage.dataMap['paymentRecords']}">
										<tr align="center">
											<td height="35" class="rd8" colspan="5"><font
												color="red">暂无充值记录</font>
											</td>
										</tr>
									</c:if>
									<c:forEach items="${divPage.dataMap['paymentRecords']}" var="paymentRecord"
										varStatus="status">
										<tr align="center" id="${status.count}" height="29"
											onmouseover="this.style.background='#eeeeee'"
											onmouseout="this.style.background=''">
											<c:choose>
												<c:when test="${fn:length(paymentRecord.traceNo)<32}">
													<td align="center" class="r8" colspan="3">
														系统赠送
													</td>
												</c:when>
												<c:otherwise>
													<td align="center" class="r8">
														${paymentRecord.goodsName}
													</td>
													<td align="center" class="r8">
														${paymentRecord.traceNo}
													</td>
													<td align="center" class="r8">
														${paymentRecord.money}
													</td>
												</c:otherwise>
											</c:choose>
											<td align="center" class="r8">
												${paymentRecord.payNum}
											</td>
											<td align="center" class="r8">
												${paymentRecord.boughtDate}
											</td>
										</tr>
									</c:forEach>
								</table>
								<div style="background-color: #e4ebf1;font-size: 12px;	color: #050505;	white-space:nowrap;">
									<jsp:include page="page.jsp">
										<jsp:param name="url" value="pay!queryAllPayRecord" />
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
