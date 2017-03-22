<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布动态</title>
<base href="<%=basePath%>">
<link href="./js/validform/validform_style.css" type="text/css"
	rel="stylesheet" />
<link rel="stylesheet" href="./css/style.css" type="text/css"
	media="all" />
<link rel="stylesheet" href="./css/common.css" type="text/css"
	media="all" />
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<script src="./js/validform/Validform_v5.3.2_min.js"
	type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./js/flash_upload/flash_upl.css"
	type="text/css" />
<script language="JavaScript" src="./js/flash_upload/upload.js"></script>
<script language="JavaScript" src="./js/swfobject.js"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<link href="./js/myselect/myselect-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/myselect/myselect-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript">
	$(function() {
		mySelectInit();
		mySelectResize();
		$("#close").click(function(){
			$("#wx_tips").slideUp(300);
		});
		$("#newsform").Validform({
			tiptype : 2,
			showAllError : true
		});
		//内容提示
		$("#led_img_sn").bind("contentchange", function() {
			var count = 0;
			$(".upd_img").each(function() {
				count++;
				if (count > 3)
					return false;
				var urlStr = $(this).attr("src");
				if (count == 1) {
					var imgone = document.getElementById("imgone");
					imgone.src = urlStr;
				}
				if (count == 2) {
					var imgtwo = document.getElementById("imgtwo");
					imgtwo.src = urlStr;
				}
				if (count == 3) {
					var imgthree = document.getElementById("imgthree");
					imgthree.src = urlStr;
				}
			});
		});
	});

	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	};

	function pone() {
		document.getElementById("ponee").innerHTML = document
				.getElementById("fontone").value;
	}

	function ptwo() {
		document.getElementById("ptwo").innerHTML = document
				.getElementById("fonttwo").value;
	}

	function pthree() {
		document.getElementById("pthree").innerHTML = document
				.getElementById("fontthree").value;
	}

	function fontlitte() {
		document.getElementById("fontlitte").innerHTML = document
				.getElementById("iptlitte").value;
	}

	function pnum1() {
		var strone = document.getElementById("fontone").value;
		document.getElementById("fnumone").innerText = strone.length + "/200";
	}

	function pnum2() {
		var strone = document.getElementById("fonttwo").value;
		document.getElementById("fnumtwo").innerText = strone.length + "/200";
	}

	function pnum3() {
		var strone = document.getElementById("fontthree").value;
		document.getElementById("fnumthree").innerText = strone.length + "/200";
	}
	var saveNewsImgPath = "upload/";
	if("${comType}"=="0")
	{
		saveNewsImgPath+="company/${id}/news";
	}else if("${comType}"=="1")
	{
		saveNewsImgPath+="hr/${id}/news";
	}
	$(function() {
		initFlashUpload(saveNewsImgPath, false);
	});

	function subForm() {
		var count = 0;
		var imgsDataHtml="";
		$(".upd_img").each(function(){
	 		count++;
	 		if(count>3)
	 		  return false;
		    var urlStr = $(this).attr("src");
	 		var filePathName = saveNewsImgPath+"/"+urlStr.substring(urlStr.lastIndexOf("/")+1);
	 		imgsDataHtml+=inputHiddenHtml("news.image"+count,filePathName);
		});
			$("#hidimg").html(imgsDataHtml);
		with($("#newsform"))
		{
			submit();
		}
	}
	
	function inputHiddenHtml(nameStr,valueStr){
		return "<input type='hidden' name='"+nameStr+"' value='"+valueStr+"'/>";
	}
</script>

<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
}

.leftdiv {
	margin-top: 10px;
	margin-left: 20px;
	width: 560px;
	height: 600px;
}

.fontlitte {
	margin-left: 20px;
	margin-top: 20px;
	margin-bottom: 5px;
}

.check {
	margin-left: 20px;
	width: 230px;
}

.checktext {
	margin-left: 2px;
	width: 230px;
}

.iptlitte {
	margin-left: 20px;
	width: 318px;
	height: 26px;
	line-height: 26px;
}

.imgdiv {
	margin-top: 10px;
	margin-left: 15px;
}

.txt {
	margin-top: 10px;
	margin-left: 15px;
}

.boxes {
	font-size: 12px;
	color: #1e1e1e;
}

.phoneview {
	margin-top: 20px;
	height: 600px;
}

.phonetxt {
	height: 430px;
	width: 240px;
	position:absolute;
	left:560px;
	overflow-Y: scroll;
	overFlow-x: hidden;
	top:70px;
}
.numone {
	position: absolute;
	z-index: 12;
	margin-left: 380px;
	margin-top: -45px;
}
.supd_img {
	height: 105px;
	width: 105px;
}

.flup {
	width: 98px;
	height: 24px;
	*top: -40px;
	position: relative;
	margin-top: 22px;
	margin-left: 5px;
}


.submitbton {
	width: 540px;
}
select {
	font-size: 14px;
	height: 28px;
	width: 185px;
	margin-left: 20px;
}
#pone,#ptwo,#pthree{
	word-break: break-all;
}
#wx_tips{
	background:#E9967A;
	border-radius:3px;
	padding:0px 15px;
	margin-left:20px;
	height:30px;
	line-height:30px;
	color:#fff;
	font-size:14px;
	position:relative;
	vertical-align:middle;
	width:80%;
	margin-top:5px;
/* 	display:none; */
}
#tips{
	display: inline-block;
	float:left;
}
#close{
	background:url("images/icons.png") no-repeat scroll -310px 0px;
	width: 15px;
	height: 12px;
	display: inline-block;
	float:right;
	cursor:pointer;
	position:relative;
	top:2px;
	right: -12px;
}
#newsLeft{
	float:left;
	width:500px;
	padding-left:20px;
	padding-right:20px; 
	margin-top:20px;
}
#newsRight{
	width:300px; 
	float:left;
}
#newsContent{
	max-width: 1200px;  
	min-width:852px; 
}
.Validform_checktip{
	line-height:30px;
}
input,textarea{
	padding-left:8px;
}
</style>
</head>
<body>
	<form name="newsform" id="newsform" action="news!updateNews" method="post">
		<input type="hidden" name="news.id" value="${news.id}"/>
		<input type="hidden" name="news.srcType" value="${news.srcType}"/>
		<div id="newsContent">
			<div id="newsLeft">
				<div style="height:15px;clear:both;"></div>
				<span style="font-weight:bold;padding-left: 20px;"><font face="宋体" color="#222222" style="font-weight:bold;">动态标题</font></span>
				<div style="height:5px;"></div>
				<div>
					<input class="iptlitte" id="iptlitte" type="text" name="news.title" value="${news.title}"
						onblur="fontlitte()" datatype="*1-25" nullmsg="请填写动态标题！"
						errormsg="请认真填写动态标题(1~25个字符)！">
				</div>
				<div class="check">&nbsp;</div>
				<div class="fontlitte" style="margin-top:0px; ">
					<font face="宋体" color="#222222" style="font-weight:bold;">动态类型：</font>
				</div>
				<div>
					<select name="news.label"  datatype="*" nullmsg="请选择动态类型！">
						<option value="">-请选择-</option>
						<option value="工厂" <c:if test="${news.label eq '工厂'}">selected="selected"</c:if>>工厂</option>
						<option value="写字楼" <c:if test="${news.label eq '写字楼'}">selected="selected"</c:if>>写字楼</option>
						<option value="商超 " <c:if test="${news.label eq '商超 '}">selected="selected"</c:if>>商超</option>
						<option value="门店" <c:if test="${news.label eq '门店'}">selected="selected"</c:if>>门店</option>
						<option value="游乐园" <c:if test="${news.label eq '游乐园'}">selected="selected"</c:if>>游乐园</option>
					</select>
				</div>
				<div class="check" style="width:400px;vertical-align:middle; ">&nbsp;</div>
				<div class="fontlitte" style="margin-top:30px;clear:both; ">
					<font face="宋体" color="#222222" style="font-weight:bold;">动态地址：</font>
				</div>
				<div>
					<input class="iptlitte" id="iptlitte" type="text" name="news.address" value="${news.address}"
						onblur="fontlitte()" datatype="*1-25" nullmsg="请填写动态地址！"
						errormsg="请认真填写动态地址(1~200个字符)！">
				</div>
				<div class="check">&nbsp;</div>
				<c:if test="${news.srcType==0}">
					<div class="imgdiv">
						<font face="宋体" color="#222222" style="font-weight:bold;"> 动态图片</font><font
							face="宋体" color="#8d8d8d" size="1"> (选填，最多三张。)</font>
					</div>
					<div style="height: 110px;" class="imgdiv">
						<span id="led_img_sn">
							<c:if test="${!empty news.image1}">
								<span class="uld_img" id="10">
								 	<img src="/badou_upload/${news.image1}" class="upd_img">
								 	<img style="display: none;" class="remove" id="rem10" src="images/remove.png" title="删除">
								 </span>
							 </c:if>
							 <c:if test="${!empty news.image2}">
								<span class="uld_img" id="11">
								 	<img src="/badou_upload/${news.image2}" class="upd_img">
								 	<img style="display: none;" class="remove" id="rem11" src="images/remove.png" title="删除">
								 </span>
							 </c:if>
							 <c:if test="${!empty news.image3}">
								<span class="uld_img" id="12">
								 	<img src="/badou_upload/${news.image3}" class="upd_img">
								 	<img style="display: none;" class="remove" id="rem12" src="images/remove.png" title="删除">
								 </span>
							 </c:if>
						</span>
						 <span id="flsu" class="flstyle"
							style="margin-left:4px;"> </span>
					</div>
					<div>
						<font id="upd_tips" color="#afafaf" style="font-size: 12px;margin-left: 40px;" >最多可上传3张图片</font>
					</div>
					<div class="txt" style="clear: both;">
						<div>
							<font face="宋体" color="#222222" style="font-weight:bold;">
								正文1</font><font face="宋体" color="#8d8d8d" size="1">
								(为了在手机上更好的显示，一个文本框只能输入200字)</font>
						</div>
						<div>
							<textarea class="boxes" id="fontone" name="news.content1"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;"
								onblur="pone()" onKeyUp="pnum1()" datatype="*1-200" maxlength="200"
								nullmsg="请输入要填写的内容！" errormsg="文本框最多只能输入200个字">${news.content1}</textarea>
						</div>
						<div class="checktext">&nbsp;</div>
						<div class="numone">
							<font id="fnumone">0/200</font>
						</div>
					</div>
					<div class="txt">
						<div>
							<font face="宋体" color="#222222" style="font-weight:bold;">
								正文2</font><font face="宋体" color="#8d8d8d" size="1">
								(为了在手机上更好的显示，一个文本框只能输入200字)</font>
						</div>
						<div>
							<textarea class="boxes" id="fonttwo" name="news.content2"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;"
								onblur="ptwo()" onKeyUp="pnum2()" datatype="*1-200" ignore="ignore" maxlength="200"
								errormsg="文本框最多只能输入200个字">${news.content2}</textarea>
						</div>
						<div class="checktext">&nbsp;</div>
						<div class="numone">
							<font id="fnumtwo">0/200</font>
						</div>
					</div>
					<div class="txt">
						<div>
							<font face="宋体" color="#222222" style="font-weight:bold;">
								正文3</font><font face="宋体" color="#8d8d8d" size="1">
								(为了在手机上更好的显示，一个文本框只能输入200字)</font>
						</div>
						<div>
							<textarea class="boxes" id="fontthree" name="news.content3" maxlength="200"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;" ignore="ignore"
								onblur="pthree()" onKeyUp="pnum3()" datatype="*1-200"
								errormsg="文本框最多只能输入200个字">${news.content3}</textarea>
						</div>
						<div class="checktext">&nbsp;</div>
						<div class="numone">
							<font id="fnumthree">0/200</font>
						</div>
					</div>
					<div id="hidimg"></div>
				</c:if>
				<c:if test="${news.srcType==1}">
					<div class="fontlitte">
						<font face="宋体" color="#222222" style="font-weight:bold;">动态链接：</font>
					</div>
					<div>
						<input class="iptlitte" id="iptlitte" type="text" name="news.content1" style="padding-top: 5px;"
						onblur="fontlitte()" datatype="url" nullmsg="请输入的动态链接！"value="${news.content1}"
						errormsg="输入的动态链接不正确！">
					</div>
					<div style="padding-left:25px;">
						<div class="Validform_checktip"></div>
					</div>
				</c:if>
				<div class="submitbton" style="clear: both;margin-left: 30px;" align="center">
					<input type="button" value="修&nbsp;&nbsp;改" class="exeCommonBtn" onclick="subForm();"  />
				</div>
			</div>
			<c:if test="${news.srcType==0}">
				<div id="newsRight">
					<div style="font-size: 15px;margin-top:15px;">手机上预览效果:</div>
					<div class="phoneview">
						<div style="float: left;" >
							<img src="./images/news_active_preview_bg.png" width="280"
								style="margin-top: 15px;">
						</div>
						<div class="phonetxt" style="margin-top:63px;">
							<div align="left">
								<font id="fontlitte" style="margin-left: 15px;font-size: 12px;">${news.title}</font>
							</div>
							<div
								style="margin: 0px;padding: 0px;width: 210px;height: 1px;background-color: #ac8caa;overflow:hidden;"></div>
							<div style="margin-top: 20px;">
								<c:if test="${!empty news.image1}">
									<img id="imgone" src="/badou_upload/${news.image1}" width="220">
								</c:if>
								<c:if test="${empty news.image1}">
									<img id="imgone" src="./images/friend_ad_2.png" width="220">
								</c:if>
							</div>
							<div id="pone">
								<p id="ponee"
									style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
									align="left">${news.content1}</p>
							</div>
							<div style="margin-top: 20px;">
								<c:if test="${!empty news.image2}">
									<img id="imgone" src="/badou_upload/${news.image2}" width="220">
								</c:if>
								<c:if test="${empty news.image2}">
									<img id="imgone" src="./images/friend_ad_2.png" width="220">
								</c:if>
							</div>
							<div>
								<p id="ptwo"
									style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
									align="left">
									<c:choose>
											<c:when test="${!empty news.content2}">
												${news.content2}
											</c:when>
											<c:otherwise>
												正文第三段
											</c:otherwise>
										</c:choose>
									</p>
							</div>
							<div style="margin-top: 20px;">
								<c:if test="${!empty news.image3}">
									<img id="imgone" src="/badou_upload/${news.image3}" width="220">
								</c:if>
								<c:if test="${empty news.image3}">
									<img id="imgone" src="./images/friend_ad_2.png" width="220">
								</c:if>
							</div>
							<div>
								<p id="pthree"
									style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
									align="left">
										<c:choose>
											<c:when test="${!empty news.content3}">
												${news.content3}
											</c:when>
											<c:otherwise>
												正文第三段
											</c:otherwise>
										</c:choose>
								</p>
							</div>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</form>
</body>
</html>