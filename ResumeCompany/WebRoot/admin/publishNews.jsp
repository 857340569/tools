<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
    <title>发表动态</title>
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
    <link href="js/validform/validform_style.css" type="text/css" rel="stylesheet" />
	<script src="js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>
	<script language="javascript" type="text/javascript" src="./js/common.js"></script> 
	<link href="css/base.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="./js/contenListener.js"></script>
	<link rel="stylesheet" href="./js/flash_upload/flash_upl.css" type="text/css"  />
	<script language="JavaScript" src="./js/flash_upload/upload.js"></script>
	<script language="JavaScript" src="./js/swfobject.js"></script>
	<link href="js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
	<script src="js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
	<script type="text/javascript">
	var saveNewsImgsPath="upload/company/${id}";
		$(function(){
			$("#news_form").Validform({
				tiptype :2,
				showAllError : true
			});
			initFlashUpload(saveNewsImgsPath,false);
			reloadEvent();
		});
	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	}
	function appendNewsContent()
	{
		var appendHtml="<div class='news_content_part'>"+
	    		"	<div class='news_remove_lock'>"+
	    		"		<img src='images/push_pin.png'/>"+
	    		"	</div>"+
	    		"	<div class='clearFloat'></div>"+
	    		"	<div class='news_content editableDiv' contentEditable='true'></div>"+
	    		" 	<div class='contentTips Validform_checktip' style='position:relative;top:-136px;left:5px;'>请在这里输入动态内容</div>"+
	    		" </div>";
		$("#news_content_div").append(appendHtml);
		reloadEvent();
		if($(".news_content_part").length>=3)
		{
			$("#add_content_btn").css("display","none");
			$("#contentTips").css("margin-left","0px");
		}
	}
	function unbindEvent(){
		$(".news_content_part").each(function(){
			$(this).unbind("mouseover");
			$(this).unbind("mouseout");
			$(this).find(".news_content").unbind("blur");
			$(this).find("img").unbind("click");
			$(this).find(".news_content").unbind("contentchange");
			$(this).find(".contentTips").unbind("click");
		});
	}
	var newsContentIsPassed=true;
	function reloadEvent(){
		unbindEvent();
		if($(".news_content_part").length>=3)
		{
			$("#add_content_btn").css("display","none");
			$("#contentTips").css("margin-left","0px");
		}
		
		//绑定删除事件
		$(".news_content_part").each(function(){
			var current=$(this);
			if($(".news_content_part").length>1)
			{
				$(this).find("img").click(function(){
					if($(".news_content_part").length==1)
					{
						alertDialog("最少保留一条动态内容!");
						return;
					}
					if($.trim(current.find(".news_content").text())=="")
					{
						current.remove();
						if($(".news_content_part").length<3)
						{
							$("#add_content_btn").css("display","block");
							$("#contentTips").css("margin-left","8px");
						}
					}else{
						if(confirm("删除后无法恢复,确定要删除该条内容吗?"))
						{
							current.remove();
							if($(".news_content_part").length<3)
							{
								$("#add_content_btn").css("display","block");
								$("#contentTips").css("margin-left","8px");
							}
						}
					}
				});
				$(this).mouseover(function(){
					$(this).find("img").attr("src","images/remove.png");
				});
				$(this).mouseout(function(){
					$(this).find("img").attr("src","images/push_pin.png");
				});
			}
			$(this).find(".contentTips").click(function(){
				current.find(".news_content").focus();
			});
			//内容提示
			$(this).find(".news_content").bind("contentchange",function(){
				if($.trim($(this).text())=="")
				{
					current.find(".contentTips").show();
				}else
				{
					current.find(".contentTips").hide();
				}
			});
			//验证是否输入内容
			$(this).find(".news_content").blur(function(){
				checkContentIsPassed();
			});
		});
	}
	function fixTips(isPassed,tipsId,tipsContent){
		if(isPassed)
		{
			$("#"+tipsId).attr("class","Validform_checktip Validform_right");
		}else{
			$("#"+tipsId).attr("class","Validform_checktip Validform_wrong");
		}
		$("#"+tipsId).text(tipsContent);
	}
	//判断动态标题是否为空
	function checktitle(){
		var isPassed=$.trim($("#news_title_input").val())!="";
		var tipsContent=isPassed?"通过信息验证!":"请填写动态标题!";
		if(isPassed)
		{
			var titleLength= $.trim($("#news_title_input").val()).length;
			if(titleLength<2||titleLength>50)
			{
				tipsContent="请认真填写动态标题(2~50字)！";
				isPassed=false;
			}
		}
		fixTips(isPassed,"title_tips",tipsContent);
		return isPassed;
	}
	//判断动态内容是否完整
	function checkContentIsPassed(){
		var isPassed=true;
		$(".news_content").each(function(){
			if($.trim($(this).text())=="")
			{
				fixTips(false,"news_contentTips","请完善动态内容!");
				isPassed=false;
				return false;
			}
		});
		if(isPassed)
		{
			fixTips(true,"news_contentTips","通过信息验证!");
		}
		return isPassed;
	}
	function checkImgs(){
		var isPassed=$(".upd_img").length>=1;
		var tipsContent=isPassed?"通过信息验证!":"请至少上传一张动态图片!";
		fixTips(isPassed,"upd_tips",tipsContent);
// 		if(isPassed)
// 		{
// 			$("#upd_tips").css("color","#afafaf");
// 		}else
// 		{
// 			$("#upd_tips").css("color","#ff0000");
// 		}
		return isPassed;
	}
	function submitData()
	{
		if(!checktitle())
		{
			return;
		}
		if(!checkContentIsPassed())
		{
			return;
		}
		if(!checkImgs())
		{
			return;
		}
		var newsDataHtml="";
		var index=0;
		$(".news_content").each(function(){
			index++;
			if(index>3)
	 		{
	 			return false;
	 		}
			newsDataHtml+=inputHiddenHtml("news.content"+index,$(this).text());
		});
		index=0;
		$(".upd_img").each(function(){
			index++;
			if(index>3)
	 		{
	 			return false;
	 		}
			var urlStr = $(this).attr("src");
	 		var fileName = urlStr.substring(urlStr.lastIndexOf("/")+1);
			newsDataHtml+=inputHiddenHtml("news.image"+index,saveNewsImgsPath+"/"+fileName);
		});
		$("#hid_da_ta").html(newsDataHtml);
		return false;
		with($("#news_form"))
		{
			submit();
		}
	}
	function inputHiddenHtml(nameStr,valueStr){
		return "<input type='hidden' name='"+nameStr+"' value='"+valueStr+"'/>";
	}
	</script>
	<style type="text/css">
		.remove{
			background-image:url("/images/remove.png");
		}
		#s_udimg{
			padding-top:10px;
		}
	
		#upd_tips_div li{
			float:left;
			height:45px;
			line-height:45px;
			vertical-align:middle;
		}
		#upd_li_left{
		}
		#upd_li_right{
			width:350px;
			margin-left:5px;
		}
	
		#news_outer_div{
			margin-left:40px;
			padding-top: 25px;
		}
		.news_input_div,.Validform_checktip,.news_label{
			float:left;
			line-height: 30px;
			height: 30px;
			vertical-align:middle;
		}
		#news_title_input{
			height: 21px;
			width:210px;
			padding-top:4px;
		}
		.news_label
		{
			width:80px;
			font-size:14px;
			display:inline-block;
		}
		.clearFloat{
			clear:both;
			height: 0;/*ie6/7 bug */
		}
		.row_div{
			margin-top:10px;
		}
		.news_content_part{
			width:280px;
			height:160px;
			border:1px solid #9d9d9d; 
			margin-right:10px;
			margin-top:10px;
			float:left;
		}
		.news_remove_lock{
			
			float:right;
			margin-right: 5px;
			margin-top: 5px;
			
		}
		.news_remove_lock img{
			width:18px;
			height:18px;
		}
		.news_content{
			padding-top:0px !important;
			padding:10px;
			font-size: 12px;
			letter-spacing:2px;
			line-height:18px;
			width:260px;
			height:120px;
			
		}
/* 		.substring(0,13)+"<br/>"+content.substring(13) */
		.contentTips{
			width:100%;
			height:30px; 
			position:relative;
			top:-136px;
			left:5px;
			
		}
		.editableDiv{
			overflow: hidden;
			word-break: break-all;
			font-family: simsun; 
		}
		.exeCommonBtn
		{
			width:210px;
			height:40px;
			line-height:40px;
			vertical-align:middle;
			color:#fff;
			float: left;
			background:#4680d1;
			border:none;
			margin-left: 80px;
			margin-top: 45px;
			font-size:20px;
		}
		.exeCommonBtn:hover{
			background:#6fa1e7;
		}
		*:focus { outline: none; }
		#add_content_btn{
			width:70px;
			height:30px;
			float:left;
			background:#eeaa19;
			border:none;
			color:#fff;
			margin-left:8px;
		}
		#add_content_btn:hover{
			background:#ffbb28;
	}
	</style>
	
  </head>
  <body>
  	<form action="news!addNews" id="news_form" name="news_form" method="post">
    	<div id="news_outer_div">
    		<div id="news_title_div">
    			<div class="news_input_div">
    				<span class="news_label">标题：</span>
    				<input id="news_title_input" type="text" name="news.title" datatype="*2-50" nullmsg="请输入动态标题！" errormsg="请认真填写动态标题(2~50字)！">
    			</div>
    			<div class="tips">
    				<div id="title_tips" class="Validform_checktip">请填写动态标题!</div>
    			</div>
    		</div>
    		<div class="clearFloat"></div>
    		<div id="news_content_label_div" class="row_div">
    			<div class="news_input_div">
    				<span class="news_label">动态内容：</span>
    			</div>
    			<div class="tips">
    				<div id="news_contentTips" style="margin-left: 0px;" class="Validform_checktip">最多可填写三条动态内容!</div>
    			</div>
    			<input id="add_content_btn" type="button" hideFocus="true" value="添加内容" onclick="appendNewsContent();">
    		</div>
    		<div class="clearFloat"></div>
    		<div style="width: 900px;margin-left:80px;" id="news_content_div">
	    		<div class="news_content_part">
	    			<div class="news_remove_lock">
	    				<img src="images/push_pin.png"/>
	    			</div>
	    			<div class="clearFloat"></div>
	    			<div class="news_content editableDiv" contentEditable="true"></div>
	    			<div class="contentTips Validform_checktip">请在这里输入动态内容</div>
	    		</div>
	    	</div>
	    	<div class="clearFloat"></div>
	    	<div id="news_upload_div" class="row_div">
    			<div class="news_input_div">
    				<span class="news_label">动态图片：</span>
    			</div>
    			<div>
    				<div id="upd_tips" class="Validform_checktip" style="margin-left:0px;">最多可上传3张图片，支持jpg/gif/png/jpeg格式!</div>
    			</div>
    		</div>
    		<div class="clearFloat"></div>
    		<div id="s_udimg" class="row_div" style="margin-left: 80px;margin-top:0px;">
    			<span id="led_img_sn">
    			</span>
    			<span id="flsu" class="flstyle" style="margin-left:4px;">
					
				</span>
    		</div>
    		<div class="clearFloat"></div>
    		<div id="hid_da_ta"></div>
    		<div id="submit_div">
				<input type="button"  value="发&nbsp;布" class="exeCommonBtn" id="exeCommonBtn" onclick="submitData();"/>
			</div>
    	</div>
    </form>
  </body>
</html>
