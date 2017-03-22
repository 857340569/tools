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
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布动态</title>

<link href="./js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="./css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="./css/common.css" type="text/css" media="all" />
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<script src="./js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./js/flash_upload/flash_upl.css" type="text/css" />
<script language="JavaScript" src="./js/flash_upload/upload.js"></script>
<script language="JavaScript" src="./js/swfobject.js"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<link href="./js/myselect/myselect-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/myselect/myselect-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<link href="./js/area/areaselect.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./js/area/data.js"></script>
<script type="text/javascript" src="./js/area/areaselect.js"></script>
<script src="./js/jquery/select-jquery.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<script language="JavaScript" type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
<script language="JavaScript" type="text/javascript" src="./js/common.js"></script>
<script language="JavaScript">
	$(function() {
		mySelectInit();
		mySelectResize();
		new locationCard({
				ids : [ 'pr2', 'ci2', 'co2' ]
		}).init();
		$(".sel_address").each(function() {
			$(this).bind("contentchange", function() {
				checkSelectAddress();
			});
		});
		$("#actsform").Validform({
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
		saveNewsImgPath+="company/${id}/activities";
	}else if("${comType}"=="1")
	{
		saveNewsImgPath+="hr/${id}/activities";
	}
	$(function() {
		initFlashUpload(saveNewsImgPath, false);
	});

	function subForm() {
		var dataHtml="";
		var isPassed=checkBegainEnd();
		if(!isPassed)
			return;
		var count = 0;
		var imgsDataHtml="";
		$(".upd_img").each(function(){
	 		count++;
	 		if(count>3)
	 		  return false;
		    var urlStr = $(this).attr("src");
	 		var filePathName = saveNewsImgPath+"/"+urlStr.substring(urlStr.lastIndexOf("/")+1);
	 		imgsDataHtml+=inputHiddenHtml("activities.image"+count,filePathName);
		});
		dataHtml+=imgsDataHtml;
		$("#hidimg").html(dataHtml);
		with($("#actsform"))
		{
			submit();
		}
	}
	
	function inputHiddenHtml(nameStr,valueStr){
		return "<input type='hidden' name='"+nameStr+"' value='"+valueStr+"'/>";
	}
	var data="";
	var detail="";
	function setError(idName, tips) {
		$("#" + idName).attr("class", "Validform_checktip Validform_wrong");
		$("#" + idName).text(tips);
	}
	function resetTips(idName, tips) {
		$("#" + idName).removeAttr("class");
		$("#" + idName).attr("class", "Validform_checktip Validform_right");
		$("#" + idName).text(tips);
	}
	function checkAllOk() {
		resetTips("addressTips", "通过信息验证！");
	}
	//主办方，活动时间，活动地点
	function ptime1() {
		checkBegainEnd();
		document.getElementById("iptime1").innerHTML = document.getElementById("iptTime1").value;
	}
	function ptime2() {
		checkBegainEnd();
		document.getElementById("iptime2").innerHTML = document.getElementById("iptTime2").value;
	}

	function phost() {
		document.getElementById("host").innerHTML = document.getElementById("host_text").value;
	}

	function paddress() {
		
		document.getElementById("adrs2").innerHTML = data+document.getElementById("fontaddress").value;
	}
	function checkBegainEnd()
	{
		var startTime=$("#iptTime1").val();
		var endTime=$("#iptTime2").val();
		if(startTime==""){
  			setError("pickTimeTips", "请选择活动开始时间！");
  			return false;
		}
		if(endTime=="")
		{
			setError("pickTimeTips", "请选择活动结束时间！");
  			return false;
		}
		var time1 =startTime.replace(/\-/g, "");
		var time2 =endTime.replace(/\-/g, "");
 		if(parseInt(time1) >parseInt(time2)){
  			setError("pickTimeTips", "活动结束时间不能晚于开始时间！");
  			return false;
 		}
 		resetTips("pickTimeTips", "通过信息验证！");
 		return true;
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
#newsLeft{
	float:left;
	width:500px;
	padding-left:20px;
	padding-right:20px; 
}
#newsRight{
	width:300px; 
	float:left;
}
#newsContent{
	max-width: 1200px;  
	min-width:852px; 
}
.span_time{
	margin-left: 20px;
	height: 26px;
	line-height:26px;
	
}
input{
	height: 26px;
	line-height:26px;
}
input,textarea{
	padding-left:8px;
}
.Validform_checktip{
	line-height:30px;
}
</style>
</head>
<body>
	<form name="actsform" id="actsform" action="activities!updateActivitiesById" method="post">
		<input type="hidden" name="activities.id" value="${activities.id}">
		<div id="newsContent">
			<div id="newsLeft">
				<div class="fontlitte">
					<font face="宋体" color="#222222" style="font-weight:bold;">活动标题</font>
				</div>
				<div>
					<input class="iptlitte" id="iptlitte" type="text" name="activities.title" value="${activities.title}"
						onblur="fontlitte()" datatype="*1-40" nullmsg="请输入活动的标题！"
						errormsg="文本框最多只能输入40个字">
				</div>
				<div class="check">&nbsp;</div>
				<div class="fontlitte">
					<font face="宋体" color="#222222" style="font-weight:bold;">主办方：</font>
				</div>
				<div>
					<input class="iptlitte" id="host_text" type="text" name="activities.organizers" value="${activities.organizers}"
						onblur="phost()" datatype="*1-30" nullmsg="请输入主办方！"
						errormsg="文本框最多只能输入30个字">
				</div>
				<div class="check">&nbsp;</div>
				<div class="fontlitte">
					<font face="宋体" color="#222222" style="font-weight:bold;">活动类型：</font>
				</div>
				<div>
					<select name="activities.label"  datatype="*" nullmsg="请选择活动类型！">
						<option value="">-请选择-</option>
						<option value="商超" <c:if test="${activities.label eq '商超'}">selected="selected"</c:if>>商超</option>
						<option value="亲子" <c:if test="${activities.label eq '亲子'}">selected="selected"</c:if>>亲子</option>
						<option value="门店" <c:if test="${activities.label eq '门店'}">selected="selected"</c:if>>门店</option>
						<option value="景点" <c:if test="${activities.label eq '景点'}">selected="selected"</c:if>>景点</option>
						<option value="游乐园" <c:if test="${activities.label eq '游乐园'}">selected="selected"</c:if>>游乐园</option>
						<option value="展览" <c:if test="${activities.label eq '展览'}">selected="selected"</c:if>>展览</option>
						<option value="音乐" <c:if test="${activities.label eq '音乐'}">selected="selected"</c:if>>音乐</option>
						<option value="市集" <c:if test="${activities.label eq '市集'}">selected="selected"</c:if>>市集</option>
						<option value="主题" <c:if test="${activities.label eq '主题'}">selected="selected"</c:if>>主题</option>
					</select>
				</div>
				<div class="check" style="width:400px;vertical-align:middle; ">&nbsp;</div>
				<div class="fontlitte" style="clear:both;margin-top:20px; ">
					<font face="宋体" color="#222222" style="font-weight:bold;">活动时间：</font>
				</div>
				<div style="margin-top:5px;">
					<span class="span_time">开始时间：</span>
					<input value="${activities.holdTime}" class="iptTime Wdate" id="iptTime1" type="text" name="activities.holdTime" style="margin-left: 0px;height: 26px;line-height:26px;"
						onblur="ptime1()" onclick="WdatePicker({minDate:'%y-%M-{%d+1}',dateFmt:'yyyy-MM-dd',readOnly:true})">
					<span class="span_time" style="margin-left: 2px;">结束时间：</span>
						<input value="${activities.endTime}" class="iptTime Wdate" id="iptTime2" type="text" name="activities.endTime" style="margin-left: 0px;height: 26px;line-height:26px;"
						onblur="ptime2()" onclick="WdatePicker({minDate:'%y-%M-{%d+1}',dateFmt:'yyyy-MM-dd',readOnly:true})">
			</div>
			<div class="check li_tips"><div class="Validform_checktip" id="pickTimeTips"></div></div>
			<div class="fontlitte">
				<font face="宋体" color="#222222" style="font-weight:bold;">详细地址：</font>
			</div>
			<div>
				<input value="${activities.activitiesPlace}" class="iptlitte" id="fontaddress" type="text" name="activities.activitiesPlace"
					onblur="paddress()" datatype="*1-30" nullmsg="请输入详细地址！"
					errormsg="文本框最多只能输入30个字">
					
			</div>
			<div class="check">&nbsp;</div>
			<div class="fontlitte">
				<font face="宋体" color="#222222" style="font-weight:bold;">联系方式：</font>
			</div>
			<div>
				<input class="iptlitte" id="fontaddress" type="text" name="activities.phone" ignore="ignore" value="${activities.phone}"
					datatype="m|tel">
					
			</div>
			<div class="fontlitte">
				<font face="宋体" color="#222222" style="font-weight:bold;">加入等你来：</font>
			</div>
			<div style="line-height:28px;vertical-align:middle; ">
				<input <c:if test="${activities.send eq 'dengnilai'}">checked="checked"</c:if> style="float:left;margin-left:14px; " id="checkSend" type="checkbox" name="activities.send" style="border:none;" value="dengnilai"/>
				<span style="display: inline-block;">加入到等你来中(<font color="#ff7200">限时免费</font>)，让更多的求职者瞬间知道您所发布的活动信息！</span>
			</div>
			<div class="check">&nbsp;</div>
			<div class="imgdiv">
						<font face="宋体" color="#222222" style="font-weight:bold;"> 动态图片</font><font
							face="宋体" color="#8d8d8d" size="1"> (选填，最多三张。)</font>
					</div>
					<div style="height: 110px;" class="imgdiv">
						<span id="led_img_sn">
							<c:if test="${!empty activities.image1}">
								<span class="uld_img" id="10">
								 	<img src="/badou_upload/${activities.image1}" class="upd_img">
								 	<img style="display: none;" class="remove" id="rem10" src="images/remove.png" title="删除">
								 </span>
							 </c:if>
							 <c:if test="${!empty activities.image2}">
								<span class="uld_img" id="11">
								 	<img src="/badou_upload/${activities.image2}" class="upd_img">
								 	<img style="display: none;" class="remove" id="rem11" src="images/remove.png" title="删除">
								 </span>
							 </c:if>
							 <c:if test="${!empty activities.image3}">
								<span class="uld_img" id="12">
								 	<img src="/badou_upload/${activities.image3}" class="upd_img">
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
							<textarea class="boxes" id="fontone" name="activities.content1"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;"
								onblur="pone()" onKeyUp="pnum1()" datatype="*1-200" maxlength="200"
								nullmsg="请输入要填写的内容！" errormsg="文本框最多只能输入200个字">${activities.content1}</textarea>
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
							<textarea class="boxes" id="fonttwo" name="activities.content2"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;"
								onblur="ptwo()" onKeyUp="pnum2()" datatype="*1-200" ignore="ignore" maxlength="200"
								errormsg="文本框最多只能输入200个字">${activities.content2}</textarea>
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
							<textarea class="boxes" id="fontthree" name="activities.content3" maxlength="200"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;" ignore="ignore"
								onblur="pthree()" onKeyUp="pnum3()" datatype="*1-200"
								errormsg="文本框最多只能输入200个字">${activities.content3}</textarea>
						</div>
						<div class="checktext">&nbsp;</div>
						<div class="numone">
							<font id="fnumthree">0/200</font>
						</div>
					</div>
					<div id="hidimg"></div>
					<div class="submitbton" style="clear: both;margin-left: 30px;" align="center">
					<input type="button" value="更&nbsp;&nbsp;新" class="exeCommonBtn" onclick="subForm();"  />
					</div>
			</div>
			<div id="newsRight">
				<div style="font-size: 15px;margin-top:15px;">手机上预览效果:</div>
				<div class="phoneview">
					<div style="float: left;" >
						<img src="./images/news_active_preview_bg.png" width="280"
							style="margin-top: 15px;">
					</div>
					<div class="phonetxt" style="margin-top:65px;">
						<div align="left">
							<font id="fontlitte" style="margin-left: 15px;font-size: 12px;">标题:${activities.title}</font>
						</div>
						<div style="margin: 0px;padding: 0px;width: 210px;height: 1px;background-color: #ac8caa;overflow:hidden;"></div>
						<div id="pone">
							<p style="margin-left: 15px;font-size: 12px;" align="left">主办方:<span id="host">${activities.organizers}</span></p>
						</div>
						<div id="pone">
							<p  style="margin-left: 15px;font-size: 12px;" align="left">活动时间:<span id="iptime1">${activities.holdTime}</span>至<span id="iptime2">${activities.endTime}</span></p>
						</div>
						<div id="pone">
							<p style="width: 210;font-size: 12px;margin-left: 15px;" align="left">详细地址:<span id="adrs2">${activities.activitiesPlace}</span></p>
						</div>
						<div style="margin-top: 20px;">
							<img id="imgone" src="/badou_upload/${activities.image1}" width="220">
						</div>
						<div id="pone">
							<p id="ponee"
								style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
								align="left">${activities.content1}</p>
						</div>
						<div style="margin-top: 20px;">
							<img id="imgtwo" src="/badou_upload/${activities.image2}" width="220">
						</div>
						<div>
							<p id="ptwo"
								style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
								align="left">${activities.content2}</p>
						</div>
						<div style="margin-top: 20px;">
							<img id="imgthree" src="/badou_upload/${activities.image3}" width="220">
						</div>
						<div>
							<p id="pthree"
								style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
								align="left">${activities.content3}</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>