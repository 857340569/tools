<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>附近的简历信息</title>
    <script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
	<script language="JavaScript" type="text/JavaScript" src="js/common.js"></script>
	<link href="css/base.css" rel="stylesheet" type="text/css" />
 	<script type="text/javascript">
		document.onreadystatechange = function() {
			if (document.readyState == "complete") {
				window.parent.loadCompleted();
			}
		};
		function nearbyShow(showAddress)
		{
			$("#title").text("所选位置:");
			$("#showHistoryPlace").text(showAddress);
		}
		$(function(){
			reloadHisItemEvent();
			loadHistPlace();
		});
		function reloadHisItemEvent()
		{
			$(".histItem").each(function(){
				var item=$(this);
				$(this).unbind("mouseover");
				$(this).unbind("mouseleave");
				$(this).unbind("click");
				$(this).find(".histPlaRemoveIcon").unbind("click");
				$(this).bind("mouseover",function(){
					item.find(".histPlaRemoveIcon").css("display","inline-block");
					
				});
				$(this).bind("mouseleave",function(){
					item.find(".histPlaRemoveIcon").hide();
				});
				$(this).bind("click",function(){
					var seleText=item.find(".histItemContent").text();
					queryNearby(seleText);
					nearbyShow(seleText);
				});
				$(this).find(".histPlaRemoveIcon").bind("click",function(e){
					deleteHistPlace(item.find(".histItemContent").text(),item);
					e.stopPropagation();
				});
			});
		}
		function loadHistPlace(){
			$.ajax({
				type:"post",
				async:false,
				url:"ajax!loadHistPlace",
				dataType:"json",
				data:{
				},
				success:function(jsondata){
				var contentHtml="";
					var datas=jsondata.histPlaces;
					for(var i=0;i<datas.length;i++)
					{
						contentHtml+="<span class='histItem'><span class='histItemContent'>"+datas[i]+"</span><span class='histPlaRemoveIcon' title='删除'>x</span></span>";
					}
					$("#showHistoryPla").html(contentHtml);
					reloadHisItemEvent();
				}
			});
		}
		function deleteHistPlace(selectedAddress,$dom){
			$.ajax({
				type:"post",
				async:false,
				url:"ajax!deleteHistPlace",
				dataType:"json",
				data:{
					"selectedAddress":selectedAddress
				},
				success:function(jsondata){
					$dom.remove();
				}
			});
		}
	function queryNearby(selectedAddress)
 	{
 		$("#selectedAddress").val(selectedAddress);
 		with($("#nearByForm"))
 		{
 			submit();
 		}
 	}
 	</script>
 	<style type="text/css">
 		#showPla{
 			font-size:18px;
 			line-height:42px;  
 			padding-left:20px; 
 		}
 		#showHistoryPlace{
 			color:#FFB448;
 		}	
 		#title{
 		}	
 		#showHistoryPla{
 			margin-left:20px; 
 			margin-bottom:20px; 
 		}
 		.histItem{
 			margin-right: 15px;
 			position: relative;
 			cursor:pointer;
 		}
 		.histItemContent{
 			display:inline-block;
 			padding:0px 5px;
 			line-height:25px;
 			border:1px solid #9d9d9d;  
 		}
 		.histPlaRemoveIcon{
 			cursor:pointer;
 			position: absolute;
 			right:0px;
 			top:-6px; 
 			background:#9d9d9d;
 			width:15px;
 			height:15px;  
 			line-height:13px;  
 			display:none;
 			text-align:center;
 			font-size:15px;
 			color:#fff; 
 		}
 	</style>
  </head>
  <body>
  	<form action="resume!nearbyResumes" method="post" id="nearByForm" target="secondFrame">
  		<input type="hidden" name="selectedAddress" id="selectedAddress"/> 
  	</form>
  	<div id="showPla"><span id="title">提示:</span><span id="showHistoryPlace">请选择地图中一点查看周边简历信息！</span></div>
  	<div id="showHistoryPla"></div>
    <div>
    	<iframe name="secondFrame" id="secondFrame" src="./admin/nearbyMap.jsp" width="100%" height="1000" frameborder="0" scrolling="no"></iframe>
    </div>
  </body>
</html>
