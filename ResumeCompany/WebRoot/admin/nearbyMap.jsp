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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=rShnpA3r40gtv2M9Gsm7aUw6"></script>
 	<script type="text/javascript">
 	var preoverLay;
 	var address;
 	// 复杂的自定义覆盖物
    function ComplexCustomOverlay(point){
      this._point = point;
    }
   	ComplexCustomOverlay.prototype = new BMap.Overlay();
    ComplexCustomOverlay.prototype.initialize = function(map){
    	  var showHtml="<div id='overlay_inner'><div>当前位置:<span id='showLocation'></span></div><div><span id='searchBtn'>附近求职者</span></div><div id='arrow'></div></div>";
	      this._map = map;
	      var div = this._div = document.createElement("div");
	      var $outerDiv=$(div);
	      $outerDiv.attr("class","overlay_outer");
	      $outerDiv.html(showHtml);
	      var point=this._point;
	      $outerDiv.css("z-index",BMap.Overlay.getZIndex(point.lat));
	      map.getPanes().labelPane.appendChild(div);
	      $("#searchBtn").click(function(e){
				e.stopPropagation(); 
				queryNearby(point.lat,point.lng,address);
				window.parent.nearbyShow(address);
			});
// 			$outerDiv.mouseleave(function(e){
// 				e.stopPropagation(); 
// 				 map.removeOverlay(preoverLay);
// 	 		});
	      return div;
    };
    ComplexCustomOverlay.prototype.draw = function(){
      var map = this._map;
      var $div= $(this._div);
      var pixel = map.pointToOverlayPixel(this._point);
      $div.css("top",pixel.y - 160 + "px");
       $div.css("left",pixel.x - 60 + "px");
      $div. css("z-index",BMap.Overlay.getZIndex(this._point.lat));
    };
 	$(function(){
 		// 百度地图API功能
 		//关闭底图可点功能
 		var map = new BMap.Map("allmap", {enableMapClick:false});
		var point = new BMap.Point(116.331398,39.897445);
		map.centerAndZoom(point,12);
		map.enableScrollWheelZoom();
		map.enableDragging();
		
		var myFun=function(result){
			var cityName = result.name;
			map.setCenter(cityName);
		};
		var myCity = new BMap.LocalCity();
		myCity.get(myFun);
		
		var geoc = new BMap.Geocoder(); 
		//单击获取点击的经纬度
		map.addEventListener("click",function(e){
			var pt = e.point;
			geoc.getLocation(pt, function(rs){
				map.removeOverlay(preoverLay);
				var addComp = rs.addressComponents;
				address=addComp.province +addComp.city+ addComp.district + addComp.street + addComp.streetNumber;
				//alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
	   			 var myCompOverlay = new ComplexCustomOverlay(pt);
	   			 preoverLay=myCompOverlay;
	  			 map.addOverlay(myCompOverlay);
	  			 $("#showLocation").text(address);
			});        
		});
 	});
 	function queryNearby(lat,lng,selectedAddress)
 	{
 		$("#lat").val(lat);
 		$("#lng").val(lng);
 		$("#selectedAddress").val(selectedAddress);
 		with($("#nearByForm"))
 		{
 			submit();
 		}
 	}
 	</script>
 	<style type="text/css">
 		#allmap{
 			width:100%;
 			height:650px; 
 		}
 		#arrow{
 			position: absolute;
 			width:11px;
 			height:10px; 
 			top:135px;
 			left:60px;
 			overflow:hidden; 
 			background:url("http://map.baidu.com/fwmap/upload/r/map/fwmap/static/house/images/label.png") no-repeat;
 		}
 		#showLocation{
 			
 		}
 		.overlay_outer{
 			width:330px;
 			height:135px;
 			background:#EE5D5B; 
 			position: absolute;
 			-moz-user-select:none;
 			white-space: nowrap;
 			color:#fff;
 			font-size:16px; 
 			line-height:28px; 
 			
 		}
 		#overlay_inner{
 		
 			word-break:break-all; 
 			margin:20px 15px; 
 			white-space:normal;
 		}
 		#searchBtn{
 			width:120px;
 			height:30px;
 			line-height:30px;
 			display: inline-block;
 			border:1px solid #9d9d9d;
 			text-align:center;   
 			position: relative;
 			left:90px;
 			top:12px;
 			background:#3e3e3e;
 		}
 	</style>
  </head>
  <body>
  	<form action="resume!nearbyResumes" method="post" id="nearByForm">
  		<input type="hidden" name="selectedAddress" id="selectedAddress"/> 
  		<input type="hidden" name="resume.lat" id="lat"/> 
  		<input type="hidden" name="resume.lng" id="lng"/> 
  	</form>
    <div id="allmap"></div>
  </body>
</html>
