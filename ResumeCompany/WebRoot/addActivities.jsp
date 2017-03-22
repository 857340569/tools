<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="./js/validform/Validform_more.js" type="text/javascript" language="javascript"></script>
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
// 		$("#close").click(function(){
// 			$("#wx_tips").slideUp(300);
// 			$(".phonetxt").animate({"margin-top":"70px"},300);
// 		});
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
		document.getElementById("fnumone").innerText = strone.length + "/2000";
	}

	function pnum2() {
		var strone = document.getElementById("fonttwo").value;
		document.getElementById("fnumtwo").innerText = strone.length + "/2000";
	}

	function pnum3() {
		var strone = document.getElementById("fontthree").value;
		document.getElementById("fnumthree").innerText = strone.length + "/2000";
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
		$("input").each(function(){
			$(this).blur();
		});
		$("select").each(function(){
			$(this).blur();
		});
		$("textarea").each(function(){
			$(this).blur();
		});
		var timePassed=checkBegainEnd();
		var addressPassed=checkAddressData();
		if(!timePassed||!addressPassed)
			return;
		var dataHtml=inputHiddenHtml("provCity",data);
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
	//验证地址
	function checkAddressData() {
		var checkResult = checkCustom();
		if (!checkResult)
			return false;
		else
			checkAllOk();
		data=getData();
		return true;
	}
	function getData(){
		var dateTemp="";
		var data1 = $("#pr2").text();
		var data2 = $("#ci2").text();
		var data3 = $("#co2").text();
		if (data3 == "-请选择-") {
			dateTemp = data1 + data2;
		} else {
			dateTemp = data1 + data2 + data3;
		}
		detail=$("#fontaddress").val();
		return dateTemp;
	}
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
	function checkSelectAddress() {
		var isPassed = false;
		if ($("#pr2").text() == "-请选择-") {
			setError("addressTips", "请选择省份！");
			isPassed = false;
		} else {
			if ($("#ci2").text() == "-请选择-") {
				setError("addressTips", "请选择城市！");
				isPassed = false;
			} else {
				if ($("#co2").css("display") != "none") {
					if ($("#co2").text() == "-请选择-") {
						setError("addressTips", "请选择区域！");
						isPassed = false;
					} else {
						resetTips("addressTips", "通过信息验证！");
						isPassed = true;
						data=getData();
						$("#adrs2").text(data+detail);
					}
				} else {
					resetTips("addressTips", "通过信息验证！");
					isPassed = true;
					data=getData();
					$("#adrs2").text(data+detail);
				}
			}
		}
		return isPassed;
	}
	function checkCustom() {
		var markCount = 0;
		var checkAddress = checkSelectAddress();
		if (markCount == 0 && checkAddress)
			return true;
		return false;
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
	function changeType(val)
	{
		$("#showType").text(val);
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
#wx_tips{
	background:#E9967A;
	border-radius:3px;
	padding:0px 15px;
	margin-left:20px;
	color:#fff;
	font-size:13px;
	position:relative;
	vertical-align:middle;
	width:850px;
	height:105px;
	margin-top:5px;
	line-height:25px;
/* 	display:none; */
}
#tips{
	display: inline-block;
	float:left;
	width:835px;
}
#close{
	background:url("images/icons.png") no-repeat scroll -310px 0px;
	width: 15px;
	height: 12px;
	display: inline-block;
	float:right;
	cursor:pointer;
	margin-top:5px;
}
#newsLeft{
	float:left;
	width:500px;
	padding-left:20px;
	padding-right:20px; 
	margin-top:15px; 
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
/*style for iSimulateSelect*/
.i_selectbox {
	margin-top: 15px;
	height: 20px;
	position: relative;
	font-size: 13px;
	left: 3px;
}

.i_selectbox .i_currentselected {
	width:103%;
	height: 30px;
	background: #fff url('images/bg-selectt.png') right center no-repeat;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 10px;
	line-height: 30px;
	cursor: pointer;
	top: -15px;
	position: relative;
}

.i_selectbox .i_selectoption {
	overflow-x: hidden;
	overflow-y: auto;
	position: absolute;
	left: -5px;
	top: -2px;
	padding: 5px;
	background-color: #fff;
	background: rgba(255, 255, 255, .9);
	-webkit-box-shadow: -2px 3px 5px rgba(0, 0, 0, .3);
	-moz-box-shadow: -2px 3px 5px rgba(0, 0, 0, .3);
	box-shadow: -2px 3px 5px rgba(0, 0, 0, .3);
	border-radius: 5px;
	border-right: 1px solid #eee
}

.i_selectbox .i_selectoption dt {
	height: 24px;
	background-color: #eee;
	text-indent: 5px;
	font-style: italic;
	color: #555;
	line-height: 24px;
}

.i_selectbox .i_selectoption dd {
	height: 30px;
	border-bottom: 1px dashed #ccc;
	cursor: pointer;
	text-indent: 10px;
	line-height: 30px
}

.i_selectbox .i_selectoption dd:hover {
	background-color: #888;
	color: #fff
}

.i_selectbox .i_selectoption dd.selected {
	background-color: #555;
	color: #fff
}

.input_select {
	height: 30px;
	padding-left: 6px;
	font-size: 13px;
	width: 100px;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 2px;
	line-height: 30px;
	background: #fff url('images/bg-selectt.png') right center no-repeat;
	cursor: pointer;
	color: #000000;
	display: inline-block;
	text-align: left;
	overflow:hidden;
}
input{
	height: 26px;
	line-height:26px;
} 
input,textarea{
	padding-left:8px;
}
</style>
</head>
<body>
	<form name="actsform" id="actsform" action="activities!addActivities" method="post">
		<div id="wx_tips">
			<span id="tips">&nbsp;&nbsp;&nbsp;&nbsp;职米是一个社交类求职平台，平台内有大量潜在你所需的消费者，在平台上发布活动信息，能为企业提供很好的宣专渠道，让企业在用极少成本的 前提下获得更多的消费群体，除此之外在活动信息下端会显示企业所招聘职位信息，让有意加入企业的应聘者直接应聘。省去诸多环节，节省大量 招聘成本！

<br>&nbsp;&nbsp;&nbsp;&nbsp;发布一条活动信息将会从账户余额中扣除<span style="text-decoration:line-through;">${priceConfig.activityPrice}米粒</span>(限时免费)，请认真填写信息(注意：活动内容可加入联系方式，如邮箱/QQ/微信号等)!</span>
			<span id="close" style="display:none;"></span>
		</div>
		<div id="newsContent">
			<div id="newsLeft">
				<div class="fontlitte">
					<font face="宋体" color="#222222" style="font-weight:bold;">活动标题</font>
				</div>
				<div>
					<input class="iptlitte" id="iptlitte" type="text" name="activities.title"
						onblur="fontlitte()" datatype="*1-40" nullmsg="请输入活动的标题！"
						errormsg="文本框最多只能输入40个字">
				</div>
				<div class="check">&nbsp;</div>
				<div class="fontlitte">
					<font face="宋体" color="#222222" style="font-weight:bold;">主办方：</font>
				</div>
				<div>
					<input class="iptlitte" id="host_text" type="text" name="activities.organizers"
						onblur="phost()" datatype="*1-30" nullmsg="请输入主办方！"
						errormsg="文本框最多只能输入30个字">
				</div>
				<div class="check">&nbsp;</div>
				<div class="fontlitte">
					<font face="宋体" color="#222222" style="font-weight:bold;">活动类型：</font>
				</div>
				<div>
					<select name="activities.label"  datatype="*" nullmsg="请选择活动类型！" onchange="changeType(this.value)">
						<option value="">-请选择-</option>
						<option value="商超">商超</option>
						<option value="亲子">亲子</option>
						<option value="门店">门店</option>
						<option value="景点">景点</option>
						<option value="游乐园">游乐园</option>
						<option value="展览">展览</option>
						<option value="音乐">音乐</option>
						<option value="市集">市集</option>
						<option value="主题">主题</option>
					</select>
				</div>
				<div class="check" style="padding-top: 5px;">&nbsp;</div>
				<div class="fontlitte" style="clear:both;margin-top: 5px">
					<font face="宋体" color="#222222" style="font-weight:bold;">活动时间：</font>
				</div>
				<div style="margin-top:5px;">
					<span class="span_time">开始时间：</span>
					<input class="iptTime Wdate" id="iptTime1" type="text" name="activities.holdTime" style="margin-left: 0px;height: 26px;line-height:26px;"
						onblur="ptime1()" onclick="WdatePicker({minDate:'%y-%M-{%d+1}',dateFmt:'yyyy-MM-dd',readOnly:true})">
					<span class="span_time" style="margin-left: 2px;">结束时间：</span>
						<input class="iptTime Wdate" id="iptTime2" type="text" name="activities.endTime" style="margin-left: 0px;height: 26px;line-height:26px;"
						onblur="ptime2()" onclick="WdatePicker({minDate:'%y-%M-{%d+1}',dateFmt:'yyyy-MM-dd',readOnly:true})">
			</div>
			<div class="check li_tips"><div class="Validform_checktip" id="pickTimeTips"></div></div>
			<div class="fontlitte">
				<font face="宋体" color="#222222" style="font-weight:bold;">活动地点：</font>
			</div>
			<div  id="addresss">
				<span id="pr2" class="input_select sel_address"
					style="width: 100px; margin-left: 20px;"
					name="seachprov" >-请选择-</span> <span id="ci2" type="text"
					class="input_select sel_address" name="seachcity" >-请选择-</span> <span
					id="co2" class="input_select sel_address" name="seachdistrict" >-请选择-</span>
					
			</div>
			<div class="check li_tips"><div class="Validform_checktip" id="addressTips"></div></div>
			<div class="fontlitte">
				<font face="宋体" color="#222222" style="font-weight:bold;">详细地址：</font>
			</div>
			<div>
				<input class="iptlitte" id="fontaddress" type="text" name="activities.activitiesPlace"
					onblur="paddress()" datatype="*1-30" nullmsg="请输入详细地址！"
					errormsg="文本框最多只能输入30个字">
					
			</div>
			<div class="check">&nbsp;</div>
			<div class="fontlitte">
				<font face="宋体" color="#222222" style="font-weight:bold;">联系方式：</font>
			</div>
			<div>
				<input class="iptlitte" id="fontaddress" type="text" name="activities.phone" ignore="ignore"
					datatype="m|tel"/>
					
			</div>
			<div class="check">&nbsp;</div>
			<div class="fontlitte">
				<font face="宋体" color="#222222" style="font-weight:bold;">加入等你来：</font>
			</div>
			<div style="line-height:28px;vertical-align:middle; ">
				<input style="float:left;margin-left:14px; " id="checkSend" type="checkbox" name="activities.send" checked="checked" style="border:none;" value="dengnilai"/>
				<span style="display: inline-block;">加入到等你来中(<font color="#ff7200">限时免费</font>)，让更多的求职者瞬间知道您所发布的活动信息！</span>
			</div>
			<div class="check">&nbsp;</div>
					<div class="imgdiv">
						<font face="宋体" color="#222222" style="font-weight:bold;"> 动态图片</font><font
							face="宋体" color="#8d8d8d" size="1"> (选填，最多三张。)</font>
					</div>
					<div style="height: 110px;" class="imgdiv">
						<span id="led_img_sn"> </span>
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
								(为了在手机上更好的显示，一个文本框只能输入2000字)</font>
						</div>
						<div>
							<textarea class="boxes" id="fontone" name="activities.content1"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;"
								onblur="pone()" onKeyUp="pnum1()" datatype="*1-2000"
								nullmsg="请输入要填写的内容！" errormsg="文本框最多只能输入2000个字"></textarea>
						</div>
						<div class="checktext">&nbsp;</div>
						<div class="numone">
							<font id="fnumone">0/2000</font>
						</div>
					</div>
					<div class="txt">
						<div>
							<font face="宋体" color="#222222" style="font-weight:bold;">
								正文2</font><font face="宋体" color="#8d8d8d" size="1">
								(为了在手机上更好的显示，一个文本框只能输入2000字)</font>
						</div>
						<div>
							<textarea class="boxes" id="fonttwo" name="activities.content2"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;"
								onblur="ptwo()" onKeyUp="pnum2()" datatype="*1-2000" ignore="ignore"
								errormsg="文本框最多只能输入2000个字"></textarea>
						</div>
						<div class="checktext">&nbsp;</div>
						<div class="numone">
							<font id="fnumtwo">0/2000</font>
						</div>
					</div>
					<div class="txt">
						<div>
							<font face="宋体" color="#222222" style="font-weight:bold;">
								正文3</font><font face="宋体" color="#8d8d8d" size="1">
								(为了在手机上更好的显示，一个文本框只能输入2000字)</font>
						</div>
						<div>
							<textarea class="boxes" id="fontthree" name="activities.content3"
								style="overflow-x:hidden;width: 440px; height: 100px;margin-top: 5px;" ignore="ignore"
								onblur="pthree()" onKeyUp="pnum3()" datatype="*1-2000"
								errormsg="文本框最多只能输入2000个字"></textarea>
						</div>
						<div class="checktext">&nbsp;</div>
						<div class="numone">
							<font id="fnumthree">0/2000</font>
						</div>
					</div>
					<div id="hidimg"></div>
					<div class="submitbton" style="clear: both;margin-left: 30px;" align="center">
					<input type="button" value="发&nbsp;&nbsp;布" class="exeCommonBtn" onclick="subForm();"  />
					</div>
			</div>
			<div id="newsRight">
				<div style="font-size: 15px;margin-top:15px;">手机上预览效果:</div>
				<div class="phoneview">
					<div style="float: left;" >
						<img src="./images/news_active_preview_bg.png" width="280"
							style="margin-top: 15px;">
					</div>
					<div class="phonetxt" style="margin-top:180px;">
						<div align="left">
							<font id="fontlitte" style="margin-left: 15px;font-size: 12px;">标题</font>
						</div>
						<div style="margin: 0px;padding: 0px;width: 210px;height: 1px;background-color: #ac8caa;overflow:hidden;"></div>
						<div id="pone">
							<p style="margin-left: 15px;font-size: 12px;" align="left">主办方:<span id="host">xxxxx</span></p>
						</div>
						<div id="pone">
							<p style="margin-left: 15px;font-size: 12px;" align="left">活动类型:<span id="showType">xxxxx</span></p>
						</div>
						<div id="pone">
							<p  style="margin-left: 15px;font-size: 12px;" align="left">活动时间:<span id="iptime1">xxxx</span>--<span id="iptime2" >xxxx</span></p>
						</div>
						<div id="pone">
							<p style="width: 210;font-size: 12px;margin-left: 15px;" align="left">详细地址:<span id="adrs2">xxxxxxx</span></p>
						</div>
						<div style="margin-top: 20px;">
							<img id="imgone" src="./images/friend_ad_2.png" width="220">
						</div>
						<div id="pone">
							<p id="ponee"
								style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
								align="left">正文第一段</p>
						</div>
						<div style="margin-top: 20px;">
							<img id="imgtwo" src="./images/friend_ad_2.png" width="220">
						</div>
						<div>
							<p id="ptwo"
								style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
								align="left">正文第二段</p>
						</div>
						<div style="margin-top: 20px;">
							<img id="imgthree" src="./images/friend_ad_2.png" width="220">
						</div>
						<div>
							<p id="pthree"
								style="text-indent:2em;width: 210;font-size: 12px;margin-left: 10px;"
								align="left">正文第三段</p>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>