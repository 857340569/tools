<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<link href="css/base.css" type="text/css" rel="stylesheet" />
<link href="./js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<link href="./css/searchResume.css" type="text/css" rel="stylesheet" />
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<script src="./js/validform/Validform_v5.3.2_min.js"
	type="text/javascript" language="javascript"></script>
<script src="./js/validform/Validform_more.js" type="text/javascript"
	language="javascript"></script>
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<title>添加交友信息</title>
<style type="text/css">
.lefttd{
	width: 160px;
	height: 32px;
}
#flash {
	height: 110px;
	vertical-align: middle;
}
.suld_img {
	border: 1px solid #9d9d9d;
	height: 105px;
	width: 105px;
	display: inline-block;
}

.supd_img {
	height: 105px;
	width: 105px;
	float: left;
}

</style>
</head>
<body>
<form >
		<div class="resume_div"><h1 class="tip_h">用户头像</h1></div>
		<ul style="margin-left:100px">
			<li>
				<div id="flash">
					<span class="cet"> 
						<span class="suld_img" id="suld_img">
							<c:choose>
								<c:when test="${empty user.photo}"><img src="./images/head.png" class="supd_img" id="supd_img"></c:when>
								<c:otherwise> <img src="/badou_upload/${user.photo}" class="supd_img" id="supd_img"> </c:otherwise>
							</c:choose>
						</span>
					</span> 
				</div>
			</li>
		</ul>
		<div class="resume_div" style="clear:both;"><h1 class="tip_h">用户基本信息</h1></div>
			<ul class="infor_basic_ul">
				<li>姓&nbsp;&nbsp;&nbsp;&nbsp;名：${user.name}</li>
				<li>性&nbsp;&nbsp;&nbsp;&nbsp;别：${user.sex}</li>
				<li>籍&nbsp;&nbsp;&nbsp;&nbsp;贯：${user.birthplace}</li>
				<li>学&nbsp;&nbsp;&nbsp;&nbsp;历：${user.education}</li>
				<li>婚姻状况：${user.martialStatus}</li>
				<li>出生年月：${user.birth}</li>
				<li>联系方式：
					<c:choose>
						<c:when test="${status > 0}">
							${user.phone}
						</c:when>
						<c:otherwise>
							${fn:substring(user.phone,0,7)}****
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
			<div class="resume_div"><h1 class="tip_h">工作信息</h1></div>
			<ul class="infor_basic_ul">
				<li>工作经验：${resume.workExperience}</li>
				<li>期望从事职位：${resume.hopeJob}</li>
				<li>期望工作地点：${resume.hopePlace}</li>
				<li>目前工作状态：
					<c:choose>
						<c:when test="${resume.currentState eq 0}">
						现在处在离职状态，马上可以上岗
						</c:when>
						<c:when test="${resume.currentState eq 1}">
						现在处在工作阶段，想换个工作环境
						</c:when>
						<c:otherwise>
						目前暂无跳槽打算
						</c:otherwise>
					</c:choose>
				</li>
				<li class="require_basic_li" style="height: 100%;">工作要求：<span>${resume.jobRequirement}</span></li>
			</ul>
			<div class="resume_div"><h1 class="tip_h">工作经历</h1></div>
			<ul class="infor_basic_ul">
				<c:if test="${empty workExperiences}">
					<font color="red"  class="no_work"  >该用户还没添加工作经历</font>
				</c:if>
				<c:forEach items="${workExperiences}" var="workExperience" >
					<li  class="com_basic_li">公司名称：${workExperience.companyName}</li>
					<li>任职岗位：${workExperience.job}</li>
					<li style="margin-bottom: 5px;">工作时间：${workExperience.startTime}-${workExperience.startTime}</li>
				</c:forEach>
			</ul>
		</form>
</body>
</html>