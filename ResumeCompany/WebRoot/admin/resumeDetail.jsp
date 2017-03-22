<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户信息</title>
<base href="<%=basePath%>">
<link href="./css/style.css" rel="stylesheet" type="text/css">
<script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="./js/common.js"></script> 
<style type="text/css">
body {
	padding: 0;
	margin-top: 0px;
	margin-bottom: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
*{
	margin: 0;
	padding: 0;
}
ul {
	list-style: none;
}
li{
	margin-bottom: 10px;
	float: left;
	width: 90%;
}
.a {
	display: inline-block;
	border-width: 1px 0;
	border-color: #ffb137;
	border-style: solid;
	vertical-align: middle;
	*display: inline;
	zoom: 1;
}

.b {
	height: 22px;
	border-width: 0 10px;
	border-color: #ffb137;
	border-style: solid;
	margin: 0 -1px;
	background: #ffb137;
	position: relative;
	_float: left;
}

.c {
	line-height: 10px;
	background: #ffb137;
	border-bottom: 2px solid #ffb137;
}

.d {
	padding: 0 8px;
	line-height: 22px;
	color: #aaaaaa;
	margin-top: -1px;
	cursor: pointer;
}
.ul_data{
	margin-left: 15px;
}
.ul_data li{
	width: 15%;
	float: left;
	font-size: 16px;
	color: #555;
	white-space: nowrap;
}
.ul_data li span{
	font-size: 14px;
}
.div_img{
	float: left;
	width: 120px;
	height: 220px;
}
.div_img img{
	height: 120px;
	width: 120px;
}
.div_self{
	clear: both;
	width: 500px;
	height: 150px;
	border: 1px dashed #000;
	margin-left: 20px;
	color: #555;
	font-size: 14px;
	padding-top: 10px;
}
</style>
</head>
<body>
	<div style="height: 10px;clear: both;"></div>
	<div style="clear: both; margin-left: 30px;">
		<div class="a">
			<div class="b">
				<div class="c"></div>
				<div class="d">基本信息</div>
			</div>
		</div>
	</div>
	<div style="height: 10px;clear: both;"></div>
	<div style="margin-left: 60px; margin-top: 10px;">
		<div class="div_img">
				<img src="${user.photo}">
		</div>
		<div style="margin-top: 5px;">
			<ul>
				<li>
					<ul class="ul_data">
						<li>姓&nbsp;&nbsp;&nbsp;&nbsp;名：<span>${user.name}</span></li>
						<li>性&nbsp;&nbsp;&nbsp;&nbsp;别：<span>${user.sex}</span></li>
					</ul>
				</li>
				<li>
					<ul class="ul_data">
						<li>出生年月：<span>${user.birth}</span></li>
						<li>籍&nbsp;&nbsp;&nbsp;&nbsp;贯：<span>${user.birthplace}</span></li>
					</ul>
				</li>
				<li>
					<ul class="ul_data">
						<li>工作经验：<span>${resume.workExperience}</span></li>
						<li>期望职位：<span>${resume.hopeJob}</span></li>
					</ul>
				</li>
				<li>
					<ul class="ul_data">
						<li>工作状态：<span><c:if test="${resume.currentState eq '0'}">
									现在处在离职状态，马上可以上岗 
								</c:if>
								<c:if test="${resume.currentState eq '1'}">
									现在处在工作阶段，想换个工作环境
								</c:if>
								<c:if test="${resume.currentState eq '2'}">
									目前暂无换工作打算
								</c:if>
							</span>
						</li>
						<li>&nbsp;</li>
					</ul
				</li>
			</ul>
		</div>
	</div>
		<div style="clear: both; margin-left: 30px;margin-left: 20px;">
			<div class="a">
				<div class="b">
					<div class="c"></div>
					<div class="d">工作要求：</div>
				</div>
			</div>
		</div>
	<div style="clear:both; margin-left: 40px;margin-top: 20px;">
		<div class="div_self">&nbsp;&nbsp;&nbsp; ${resume.jobRequirement}</div>
	</div>

</body>
</html>