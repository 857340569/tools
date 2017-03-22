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
<title>消费记录查询</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link href="./css/base.css" rel="stylesheet" type="text/css">
<link href="./css/common.css" rel="stylesheet" type="text/css">
<link href="./css/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<link href="./css/common.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	};
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
										<td>编号</td>
										<td>名称</td>
										<td>消费数量(米粒)</td>
										<td>消费时间</td>
									</tr>

									<c:if test="${empty divPage.dataMap['expenseRecords']}">
										<tr align="center">
											<td height="35" class="rd8" colspan="4"><font
												color="red">暂无消费记录</font>
											</td>
										</tr>
									</c:if>
									<c:forEach items="${divPage.dataMap['expenseRecords']}" var="expenseRecord"
										varStatus="status">
										<tr align="center" id="${status.count}" height="29"
											onmouseover="this.style.background='#eeeeee'"
											onmouseout="this.style.background=''">
											<td>${(divPage.currentPageNo-1)*divPage.pageSize+status.count}</td>
											<td align="center" class="r8">
												${expenseRecord.goodsName}
											</td>
											<td align="center" class="r8">
												${expenseRecord.payNum}
											</td>
											<td align="center" class="r8">
												${expenseRecord.payDate}
											</td>
										</tr>
									</c:forEach>
								</table>
								<div style="background-color: #e4ebf1;font-size: 12px;	color: #050505;	white-space:nowrap;">
									<jsp:include page="page.jsp">
										<jsp:param name="url" value="pay!queryAllExpenseRecord" />
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
