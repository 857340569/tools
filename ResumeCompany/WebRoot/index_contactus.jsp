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
    <title>职米官方网站</title>
    <script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
	<link href="./css/base.css" type="text/css" rel="stylesheet" />
	<link href="./css/common.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="./js/common.js"></script>
	<script type="text/javascript">
		$(function(){
		});
	</script>
	<style type="text/css">
		#login_head{
			background:#309bed;
			height: 489px;
		}
	</style>
  </head>
  <body>
    	<div id="login_head">
    		<div id="head_left">
    			<img alt="login_left" src="./images/index/login_head_left.png">
    		</div>
    		<div id="head_right">
    			<div id="head_login_div">
    				
    			</div>
    		</div>
    	</div>
  </body>
</html>
