<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/style.css" type="text/css" media="all" />
<link href="./css/base.css" type="text/css" rel="stylesheet" />
<link href="./css/common.css" type="text/css" rel="stylesheet" />
<link href="js/area/areaselect.css" type="text/css" rel="stylesheet" />
<link href="js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<script src="js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>
<script src="js/validform/Validform_more.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/area/data.js"></script>
<script type="text/javascript" src="./js/area/areaselect.js"></script>
<script src="js/my.placeholder.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<link href="js/myselect/myselect-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="js/myselect/myselect-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<script src="./js/my.placeholder.js" type="text/javascript" language="javascript"></script>
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<link href="./css/informa-tip.css" rel="stylesheet" type="text/css">
<script src="./js/My97DatePicker/WdatePicker.js" type="text/javascript" language="javascript"></script>
<title>已发出的面试邀请-职米</title>
<style type="text/css">
	body{
		margin-top: 10px;
		margin-left: 10px
	}
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
			style="padding-top: 7px;margin-top:5px;">
			<tr>
				<td height="215" valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="215" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr align="center" class="dataTittleBg">
										<td>姓名</td>
										<td>性别</td>
										<td>年龄</td>
										<td>手机号</td>
										<td>学历</td>
										<td>求职意向</td>
										<td>目前工作状态</td>
										<td>邀请时间</td>
										<td>操作</td>
									</tr>
									<c:if test="${empty divPage.dataMap['resumes']}">
										<tr align="center">
											<td height="35" class="rd8" colspan="9"><font
												color="red">
												暂无发出任何面试邀请信息！
												</font>
											</td>
										</tr>
									</c:if>
									<c:forEach items="${divPage.dataMap['resumes']}"
										var="resume" varStatus="status">
										<tr align="center" id="${status.count}" height="29"
											onmouseover="this.style.background='#eeeeee'"
											onmouseout="this.style.background=''">
											<td align="center" class="r8 useName">
												${divPage.entitysMap[resume.id].name}
											</td>
											<td align="center" class="r8">
												${divPage.entitysMap[resume.id].sex}
											</td>
											<td align="center" class="r8">
												${divPage.entitysMap[resume.id].birth}
											</td>
											<td align="center" class="r8">
												${divPage.entitysMap[resume.id].phone}
											</td>
											<td align="center" class="r8">
												${divPage.entitysMap[resume.id].education}
											</td>
											<c:choose>
												<c:when test="${empty resume.hopeJob||empty resume.currentState}">
													<td align="center" class="r8" colspan="2">
														该用户简历信息不完整
													</td>
												</c:when>
												<c:otherwise>
													<td align="center" class="r8">
														${resume.hopeJob}
													</td>
													<td align="center" class="r8">
														<c:choose>
															<c:when test="${!empty resume.currentState}">
																<c:if test="${resume.currentState eq '0'}">
																	离职中，马上可以上岗 
																</c:if>
																<c:if test="${resume.currentState eq '1'}">
																	任职中，想换个工作环境
																</c:if>
																<c:if test="${resume.currentState eq '2'}">
																	目前暂无换工作打算
																</c:if>
															</c:when>
															<c:otherwise>
																其它
															</c:otherwise>
														</c:choose>
													</td>
												</c:otherwise>
											</c:choose>
											<td>
												${divPage.dataMap['pushMessages'][resume.id].pushTime}
											</td>
											<td align="center">
												<a href="resume!queryResumeById?resume.id=${resume.id}" target="mainFrame"> 
													<span class="last_exe_btn_common last_exe_btn_other">查看</span>
												</a>
											</td>
										</tr>
									</c:forEach>
								</table>
								<div class="r8">
									<jsp:include page="page.jsp">
										<jsp:param name="url" value="resume!queryInvitedResumes" />
										<jsp:param name="para" value="${pageUrl}" />
									</jsp:include>
								</div></td>
						</tr>
					</table>
		</table>
	</form>
</body>
</html>