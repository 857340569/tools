<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">

<title>testflash</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<script language="JavaScript" src="./js/swfobject.js"></script>
<script>
	$(function() {
		showLogoSwf();
	});
	function showLogoSwf() {
		var flashvars = {
			name1 : "hello",
			name2 : "world",
			name3 : "foobar"
		};
		var params = {
			menu : "false"
		};
		var attributes = {
			id : "dynamicContent2",
			name : "dynamicContent2"
		};
		swfobject
				.embedSWF(
						"upload_single_small_img.swf",
						"licenceswfcontent",
						"120",
						"40",
						"10.0.0",
						"http://www.adobe.com/cfusion/knowledgebase/index.cfm?id=6a253b75",
						flashvars, params, attributes);
	}
</script>
</head>

<body>
	<div id="licenceSwf" style="margin-top:10px; ">
		<div>
			<span id='licenceswfcontent'></span>
		</div>
	</div>
	<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0"
	WIDTH="120" HEIGHT="40" id="myMovieName">
	<PARAM NAME=movie VALUE="upload_single_small_img.swf">
	<PARAM NAME=quality VALUE=high>
	<PARAM NAME=bgcolor VALUE=#FFFFFF>
	<EMBED src="upload_single_small_img.swf" quality=high bgcolor=#FFFFFF WIDTH="120"
		HEIGHT="40" wmode="transparent"
		NAME="myMovieName" ALIGN="" TYPE="application/x-shockwave-flash"
		allowScriptAccess="always"
		PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">
	</EMBED>
	</OBJECT>
</body>
</html>
