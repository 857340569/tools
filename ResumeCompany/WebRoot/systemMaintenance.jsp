<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>系统维护中</title>
	<link href="./css/base.css" rel="stylesheet" type="text/css">
	<link href="./css/common.css" rel="stylesheet" type="text/css">
	<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"  language="javascript"></script>
	<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
	<link href="./css/common.css" rel="stylesheet" type="text/css">
	<style type="text/css">
		body {
			padding-top:10px;
			padding-left: 10px;
			font-size: 18px; 
		}
	</style>
    <script type="text/javascript">
    	//判断网页是否加载完成  
		document.onreadystatechange = function() {
			if (document.readyState == "complete") {
				window.parent.loadCompleted();
			}
		};
    </script>
  </head>
  		系统维护中，系统维护时间为：02:00~04:00！
  <body>
    
  </body>
</html>
