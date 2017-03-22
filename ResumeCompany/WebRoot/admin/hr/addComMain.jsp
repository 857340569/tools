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
    <title></title>
	<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
	<link href="./css/base.css" type="text/css" rel="stylesheet" />
	<link href="./css/common.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="./js/common.js"></script>
	<script type="text/javascript">
	window.parent.mainTop();
			// 判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	};
	function changeStep(step)
	{
		switch(step)
		{
			case 2:
				$("#add_step1").css("background","url('./images/step1_bg_common.png') no-repeat");
				$("#add_step2").css("background","url('./images/step_next_bg_current.png') no-repeat");
				$("#add_step3").css("background","url('./images/step_next_bg_common.png') no-repeat");
				break;
			case 3:
				$("#add_step1").css("background","url('./images/step1_bg_common.png') no-repeat");
				$("#add_step2").css("background","url('./images/step_next_bg_common.png') no-repeat");
				$("#add_step3").css("background","url('./images/step_next_bg_current.png') no-repeat");
				break;
		}
	}
	</script>
	<style type="text/css">
		#head_step{
			margin-left:15px;
		}
		#head_step div{
			font-size:14px;
			float: left;
			text-align:center;
			width:270px;
			height:35px;
			line-height:35px;
			font-weight: bold;
			margin-top: 15px;
		}
		#add_step1{
			background:url("./images/step1_bg_current.png") no-repeat;
			color:#fff;
		}
		#add_step2{
			background:url("./images/step_next_bg_common.png") no-repeat;
			margin-left:-25px;
			color:#4680d1;
		}
		#add_step3{
			background:url("./images/step_next_bg_common.png") no-repeat;
			margin-left:-37px;
			color:#4680d1;
		}
	</style> 
  </head>
  <body>
    	<div id="head_step">
    		<div id="add_step1">1.填写企业基本资料</div>
    		<div id="add_step2">2.上传企业图片</div>
    		<div id="add_step3">3.完成</div>
    	</div>
    	<div>
    		<iframe src="./admin/hr/addComFirst.jsp" name="secondFrame" id="secondFrame" width="100%" height="900" scrolling="no" frameborder="0" style="padding-left:65px; "></iframe>
    	</div> 
  </body>
</html>
