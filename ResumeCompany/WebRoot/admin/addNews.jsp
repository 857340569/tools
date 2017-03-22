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
<link rel="stylesheet" href="./css/base.css" type="text/css" media="all" />
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
<script src="./js/common.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/area/data.js"></script>
<link href="./js/area/areaselect.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./js/area/areaselect.js"></script>
<script language="JavaScript">
	$(function() {
		mySelectInit();
		mySelectResize();
		 new locationCard({
                ids: ['pr2', 'ci2', 'co2']
         }).init();
        $(".sel_address").each(function(){
			$(this).bind("contentchange",function(){
				checkSelectAddress();	
			});
		});
// 		$("#close").click(function(){
// 			$(".phonetxt").animate({"margin-top":"70px"},300);
// 			$("#wx_tips").slideUp(300);
// 		});
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
		saveNewsImgPath+="company/${id}/news";
	}else if("${comType}"=="1")
	{
		saveNewsImgPath+="hr/${id}/news";
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
		var count = 0;
		var dataHtml="";
		var checkAddress=checkSelectAddress();
		if(!checkAddress)
		{
			return;
		}
	  var data;
      var data1 = $("#pr2").text();
      var data2 = $("#ci2").text();
      var data3 = $("#co2").text();
      if(data3=="-请选择-"){
      	data = data1+data2;
      }else{
      	data = data1+data2+data3;
      }
      dataHtml+=inputHiddenHtml("news.address",data);
	  $(".upd_img").each(function(){
	 		count++;
	 		if(count>3)
	 		  return false;
		    var urlStr = $(this).attr("src");
	 		var filePathName = saveNewsImgPath+"/"+urlStr.substring(urlStr.lastIndexOf("/")+1);
	 		dataHtml+=inputHiddenHtml("news.image"+count,filePathName);
		});
		$("#hidimg").html(dataHtml);
		with($("#newsform"))
		{
			submit();
		}
	}
	
	function inputHiddenHtml(nameStr,valueStr){
		return "<input type='hidden' name='"+nameStr+"' value='"+valueStr+"'/>";
	}
	function changeSelect(val){
		if(val==1){
			window.location.href="addNewsHref.jsp";
		}
	}
function checkSelectAddress()
{
	var isPassed=false;
	 if($("#pr2").text()=="-请选择-")
	 {
	 	setError("addressTips","请选择省份！");
	 	isPassed=false;
	 }
     else
     {
     	if($("#ci2").text()=="-请选择-")
     	{
     	   setError("addressTips","请选择城市！");
           isPassed=false;
     	}
       else
       {	
       		if($("#co2").css("display")!="none")
	        {
	        	$("#addressTips").removeAttr("style");	
	       		if($("#co2").text()=="-请选择-")
	       		{
		     	   setError("addressTips","请选择区域！");
		           isPassed=false;
		     	}
      			else
      			{
      				resetTips("addressTips","通过信息验证！");
      				isPassed=true;
      			}
	        }
	        else
	       	 {
	       	 	$("#addressTips").css("left","-150px");
   				resetTips("addressTips","通过信息验证！");
   				isPassed=true;
      		}	
       	}
     }
     return isPassed;
}
function setError(idName,tips)
{
	 $("#"+idName).attr("class","Validform_wrong");
     $("#"+idName).text(tips);
}
function resetTips(idName,tips)
{
	 $("#"+idName).removeAttr("class");
	 $("#"+idName).attr("class","Validform_right");
     $("#"+idName).text(tips);
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
	margin-top: 20px;
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
	line-height:25px;
	color:#fff;
	font-size:13px;
	position:relative;
	vertical-align:middle;
	width:850px;
	height:95px;
	margin-top:5px;
	word-break:break-all;
/* 	display:none; */
}
#tips{
	display: inline-block;
	float:left;
	width:830px;
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

/*style for iSimulateSelect*/
.i_selectbox {
	margin-top: 20px;
	height: 32px;
	position: relative;
	font-size: 13px;
}

.i_selectbox .i_currentselected {
	width: 234px;
	height: 32px;
	background: #fff url('images/bg-selectt.png') right center no-repeat;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 10px;
	line-height: 32px;
	cursor: pointer
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
	-moz-border-radius:5px;
	-webkit-border-radius:5px;
	border-right: 1px solid #eee;
	border-left:1px solid #eee;
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
	height: 32px;
	padding-left: 6px;
	font-size: 13px;
	width: 120px;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 2px;
	line-height: 32px;
	background: #fff url('images/bg-selectt.png') right center no-repeat;
	cursor: pointer;
	color: #000000;
	display: inline-block;
	text-align: left;
	overflow: hidden;
	white-space: nowrap;
}
.select_city{
	margin-left:20px;
}
.select_city li{
	float:left;
}
input,textarea{
	padding-left:8px;
}
</style>
</head>
<body>
	<form name="newsform" id="newsform" action="news!addNews" method="post">
		<div id="wx_tips">
			<span id="tips">&nbsp;&nbsp;&nbsp;&nbsp;企业动态 由职米首创，在动态栏目中，企业可以发布员工活动、企业环境、企业活动等图文信息，已引导的方式让应聘者全面了解公司，在企业动 态下端会显示企业所招聘职位信息，让应聘者了解后直接应聘，此方式大大提高应聘者的应聘率，也帮助企业招募到更有意向的员工。
<br>&nbsp;&nbsp;&nbsp;&nbsp;发布一条动态信息将会从账户余额中扣除<span style="text-decoration:line-through;">${priceConfig.newsPrice}米粒</span>(限时免费)，请认真填写信息(注意：请不要在动态内容加任何联系方式，如邮箱/QQ/微信号等)!
</span>
			<span id="close" style="display:none;"></span>
		</div>
		<div id="newsContent">
			<div id="newsLeft">
					<div style="height:15px;clear:both;"></div>
					<span style="font-weight:bold;padding-left: 20px;"><font face="宋体" color="#222222" style="font-weight:bold;">动态标题</font></span>
					<div style="height:5px;"></div>
					<div>
						<input class="iptlitte" id="iptlitte" type="text" name="news.title" style="height:28px;line-height: 28px;"
							onblur="fontlitte()" datatype="*1-25" nullmsg="请填写动态标题！"
							errormsg="请认真填写动态标题(1~25个字符)！">
					</div>
					<div class="check">&nbsp;</div>
					<div class="fontlitte" style="margin-top:0px; ">
						<font face="宋体" color="#222222" style="font-weight:bold;">动态类型：</font>
					</div>
					<div>
						<select name="news.label"  datatype="*" nullmsg="请选择动态类型！" onchange="changeType(this.value)">
							<option value="">-请选择-</option>
							<option value="工厂">工厂</option>
							<option value="写字楼">写字楼</option>
							<option value="商超 ">商超</option>
							<option value="门店">门店</option>
							<option value="游乐园">游乐园</option>
						</select>
					</div>
					<div class="check" style="padding-top: 5px;">&nbsp;</div>
					<span style="font-weight:bold;padding-left: 20px;margin-top:5px;clear:both;display:block;"><font face="宋体" color="#222222" style="font-weight:bold;">动态地址</font></span>
					<div style="height:5px;clear:both;"></div>
					<div>
						<ul class="select_city">
							<li><span id="pr2" class="input_select sel_address"
								name="seachprov">-请选择-</span>
							</li>
							<li><span id="ci2" class="input_select sel_address" name="seachcity">-请选择-</span>
							</li>
							<li><span id="co2" class="input_select sel_address" name="seachdistrict">-请选择-</span>
							</li>
						</ul>
					</div>
					<div class="check" style="clear:both;padding-left:5px;margin-top:3px;margin-bottom:5px;margin-left: 26px; height:10px;">
						<span class="Validform_checktip" id="addressTips"></span>
					</div>
					<div class="imgdiv" style="clear:both;">
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
							<textarea class="boxes" id="fontone" name="news.content1"
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
							<textarea class="boxes" id="fonttwo" name="news.content2"
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
							<textarea class="boxes" id="fontthree" name="news.content3"
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
					<div class="phonetxt" style="margin-top:170px;">
						<div align="left">
							<font id="fontlitte" style="margin-left: 15px;font-size: 12px;">标题</font>
						</div>
						<div
							style="margin:5px 0px;width: 210px;height: 1px;background-color: #ac8caa;overflow:hidden;"></div>
						<div align="left">
							<font id="showType" style="margin-left: 15px;font-size: 12px;">动态类型</font>
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