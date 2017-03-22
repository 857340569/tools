<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    response.setStatus(200); // 200 = HttpServletResponse.SC_OK
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<link rel="icon" href="http://img.91zhimi.com/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="http://img.91zhimi.com/favicon.ico" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<title>找不到页面</title>
<script type="text/javascript">
 //判断网页是否加载完成  
    document.onreadystatechange = function () {   
        if(document.readyState=="complete") {         
            window.parent.loadCompleted();   
        }  
    };
</script>
</head>
<body bgcolor="#efefef">
<div align="center" style="vertical-align: middle;">
<img src="./images/404page.jpg">
</div>
</body>
</html>