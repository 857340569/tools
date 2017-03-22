<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>信息提示</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/base.css" type="text/css"  />
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<script type="text/javascript">
	$(function(){
		var varType="${type}";
		if(varType=="addCom")
		{
			window.parent.changeStep(3);
		}
	});
	window.parent.mainTop();
</script>
<style type="text/css">
	#reg a:hover {
		text-decoration: underline;
	}
	.mar003{
	   margin-left: 15px;
	   font-size:14px;
	}
</style>
</head>
<body>
<div class="mar003"><br><br>提示：${message}</div>
</body>
</html>