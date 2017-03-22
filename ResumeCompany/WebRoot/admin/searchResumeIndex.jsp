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
<script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/style.css" type="text/css" media="all" />
<link href="./css/base.css" type="text/css" rel="stylesheet" />
<link href="./css/common.css" type="text/css" rel="stylesheet" />
<link href="js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<script src="js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>
<script src="js/validform/Validform_more.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/area/data.js"></script>
<script type="text/javascript" src="./js/area/areaselect.js"></script>
<link href="js/area/areaselect.css" type="text/css" rel="stylesheet" />
<script src="js/my.placeholder.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<link href="./js/selectjobs//selectjob_v2.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/selectjobs/selectjob_v2.0.js" type="text/javascript" language="javascript"></script>
<style type="text/css">

.job_resume_div{
	margin-left:15px;
}
.job_resume_div_div{
	border-bottom: 1px dotted #808685;
	padding-bottom:10px;
	height: 30px;
	line-height: 30px;
}
#search_condition_div{
	clear:both;
	font-size:15px;
	margin-top:10px;
	float:left;
	width:100%;
}
.job_resume_div_div span{
	float: right;
	margin-right: 15px;
	margin-bottom: 10px;
}
.job_resume_ul li{
	float: left;
	font-size: 15px;
	text-align:left;
	margin-right:20px;
	cursor:pointer;
}
.show_current_item{
	padding-bottom:-15px;
	border:none;
	border-bottom:5px solid #4680d1;
}
.base_cond_item{
	padding:3px 5px;
	display:inline-block;
	cursor:pointer;
}
.base_cond_item:hover{
	background:#d5d5d5;
}
.cond_item_selected{
	background:#9d9d9d;
}
.type_item
{
	margin-bottom:15px;
}
.selectAge
{
	width:75px;
	height: 25px; 
	line-height: 25px; 
	padding-left:3px;
}
.selectAge option {
	font-size:14px;
}
#select_job_cate{
	width:115px;
	height: 22px; 
	line-height: 22px; 
	position: relative;
	top:-2px;
	cursor:pointer;
	padding-left: 3px;
}
.zjp_myselect_currentSelect_icon{
		background:url("images/bg-selectt.png") no-repeat;
		height:30px;
		width:25px; 
		margin-top:8px;
		display:inline-block;
		float:right;
		
	}
#tmpTips{
	background:#E9967A;
	border-radius:3px;
	padding:0px 15px;
	margin-left:20px;
	color:#fff;
	font-size:13px;
	position:relative;
	vertical-align:middle;
	width:850px;
	height:45px;
	line-height:45px;
	margin-top:5px;
}
#tmpTipsContent
{
	font-size:16px; 
}
#tmpTipsClose{
	cursor:pointer;
	position: absolute;
	right:0px;
	top:0px; 
	background:#9d9d9d;
	width:13px;
	height:15px;  
	line-height:13px;  
	text-align:center;
	padding-left:1px;
	font-size:13px;
	color:#fff; 
}
#selected_all_job{
	cursor:pointer;
	color:#E9967A;
	font-size:16px; 
	
	
}
</style>
<script type="text/javascript">
	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	}
	$(function(){
		$(".option_item").each(function(){
			$(this).click(function(){
				$(".option_item").each(function(){
					$(this).attr("class","option_item");
				});
				$(this).attr("class","option_item show_current_item");
				var clickedId=$(this).attr("id");
				if(clickedId=="search_resume")
				{
					$("#search_condition_div").show();
// 					$("#search_condition_div").slideDown(300);
					exeQuery();
				}
				else if(clickedId=="sended_msg")
				{
					$("#search_condition_div").hide();
// 					$("#search_condition_div").slideUp(300);
					$("#secondFrame").attr("src","resume!queryInvitedResumes");
				}
			});
		});
		$(".item_jy").each(function(){
			$(this).click(function(){
				$(".item_jy").each(function(){
					$(this).attr("class","base_cond_item item_jy");
				});
				var selectedVal=$(this).text();
				if(selectedVal=="不限")
				{
					$("#workExp").val("");
				}else
				{
					$("#workExp").val(selectedVal);
				}
				 exeQuery();
				$(this).attr("class","base_cond_item item_jy cond_item_selected");
			});
		});
		$(".item_xl").each(function(){
			$(this).click(function(){
				$(".item_xl").each(function(){
					$(this).attr("class","base_cond_item item_xl");
				});
				var selectedVal=$(this).text();
				if(selectedVal=="不限")
				{
					$("#edu").val("");
				}else
				{
					$("#edu").val(selectedVal);
				}
				 exeQuery();
				$(this).attr("class","base_cond_item item_xl cond_item_selected");
			});
		});
		$("#unlimit_age").click(function(){
			var cssNames=$(this).attr("class");
			if(cssNames.indexOf("cond_item_selected")!=-1)
			{
				$(this).attr("class","base_cond_item");
				$("#selAgeStart").removeAttr("disabled");
				$("#selAgeEnd").removeAttr("disabled");
				changeAge();
			}else
			{
				$(this).attr("class","base_cond_item cond_item_selected");
				$("#selAgeStart").attr("disabled","disabled");
				$("#selAgeEnd").attr("disabled","disabled");
				$("#age").val("");
				exeQuery();
			}
		});
	});
	function onlyNum(event)
	{
		var event = event||window.event;
		var key = event.charCode||event.keyCode;  
		if(key!=8)
		{
		  if(!((key>=48&&key<=57)||(key>=96&&key<=105)))
		  {
			  var isIE=myBrowser()=="IE";
			  if(isIE)
			   {
			   		event.returnValue=false; 
			   }else
			   {
			   		event.preventDefault();
			   }
			}
		}
	}
	function myBrowser(){
		var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
		var isOpera = userAgent.indexOf("Opera") > -1;
		
		if (isOpera){
			return "Opera";
		} //判断是否Opera浏览器
		if (userAgent.indexOf("Firefox") > -1){
			return "FF";
		} //判断是否Firefox浏览器
		if (userAgent.indexOf("Safari") > -1){
			return "Safari";
		} //判断是否Safari浏览器
		if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera){
			return "IE";
		}  //判断是否IE浏览器
	}
	function changeAge()
	{
		var startAgeNum=$("#selAgeStart").val();
		var endAgeNum=$("#selAgeEnd").val();
		
		if(startAgeNum==""||endAgeNum=="")
		{
// 			alert("年龄段请选择完整！");
			return;
		}
		if(startAgeNum>endAgeNum)
		{
			alert("起始年龄不能大于结束年龄！");
			$("#selAgeEnd").find("option:nth-child(1)").attr("selected" , "selected");
			return;
		}
		var ageStr=startAgeNum+","+endAgeNum;
		$("#age").val(ageStr);
		exeQuery();
	}
	function changeSex(val)
	{
		$("#sex").val(val);
		 exeQuery();
	}
	function exeQuery()
	{
		with($("#queryResume"))
		{
			submit();
		}
	}
	$(function(){
		jobInit($("#select_job_cate"),"input");
		var age=16,lastAge=55;
		var contentHmtl="<option value=''>-请选择-</option>";
		for(;age<=lastAge;age++)
		{
			contentHmtl+="<option value='"+age+"'>"+age+"</option>"
		}
		$("#selAgeStart").html(contentHmtl);
		$("#selAgeEnd").html(contentHmtl);
		setTimeout(function(){
			$("#tmpTips").slideUp(500);
		},5000);
		$("#tmpTipsClose").click(function(){
			$("#tmpTips").slideUp(300);
		});
		$("#selected_all_job").click(function(){
			$("#submitJobType").val("");//it's defined in file(js/selectjobs/selectjob_v2.0.js)
			$("#select_job_cate").val("全部职位");
			$("#select_job_dialog").slideUp(300);
			exeQuery();
		});
	});
</script>
</head>
<body>
<div id="tmpTips">
	<span id="tmpTipsContent">云简历现已开放部分用户，诚邀大家体验！</span>
	<div id="tmpTipsClose" title="关闭">x</div>
</div>
<form action="resume!queryResumeByCond" target="secondFrame" method="post" id="queryResume">
	<div class="job_resume_div">
		<div class="job_resume_div_div" >
			<ul class="job_resume_ul" >
				<li><br> 
					<div class="option_item show_current_item" id="search_resume"> 
						</div></li><li><br></li><li><div class="option_item show_current_item" id="search_resume">匹配的简历 
					</div> 
				</li>
				<li>
					<div class="option_item" id="sended_msg">
						发出的面试
					</div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="user.birth" id="age"> 
		<input type="hidden" name="user.sex" id="sex"> 
		<input type="hidden" name="user.education" id="edu"> 
		<input type="hidden" name="resume.workExperience" id="workExp"> 
		<input type="hidden" name="resume.hopeJob" id="job"> 
		<div id="search_condition_div">
			<div class="type_item">
				年龄段：
				<span class="base_cond_item" id="unlimit_age">不限</span>
				<select onchange="changeAge();" id="selAgeStart" class="selectAge" onkeydown="onlyNum(event);">
				</select>&nbsp;-
				<select onchange="changeAge();" id="selAgeEnd" class="selectAge" onkeydown="onlyNum(event);">
				</select>
			</div>
			<div class="type_item">
				性别：
				<label for="un_sex"><input id="un_sex" type="radio" name="gender" value="" checked="checked" onclick="changeSex(this.value);">不限</label>
				<label for="nan_sex"><input id="nan_sex" type="radio" name="gender" value="男" onclick="changeSex(this.value);">男</label>
				<label for="nv_sex"><input id="nv_sex" type="radio" name="gender" value="女" onclick="changeSex(this.value);">女</label>
			</div>
			<div class="type_item">
				经验：
				<span class="base_cond_item item_jy">不限</span>
				<span class="base_cond_item item_jy">一至三年</span>
				<span class="base_cond_item item_jy">三年以上</span>
			</div>
			<div class="type_item">
				学历：
				<span class="base_cond_item item_xl">不限</span>
				<span class="base_cond_item item_xl">初中</span>
				<span class="base_cond_item item_xl">高中</span>
				<span class="base_cond_item item_xl">中专</span>
				<span class="base_cond_item item_xl">大专</span>
				<span class="base_cond_item item_xl">本科</span>
				<span class="base_cond_item item_xl">本科以上</span>
			</div>
			<div class="type_item" style="position:relative;">
				<div style="float: left;">职位匹配：</div>
				<div id="select_job_category" style="position:relative;">
					<input id="select_job_cate" readonly="readonly" value="-请选择-"style="float: left;" onblur="exeQuery();">
					<span class='zjp_myselect_currentSelect_icon' style="position:absolute;left:175px;"></span>
				</div>
				<div id="select_job_dialog">
					<div id="job_dialog_title">选择职位类别:<span id="selected_all_job">全部职位</span></div>
					<div id="job_dialog_content">
						<table id="dialog_show_table">
						
						</table>
					</div>
				</div>
			</div>
			<div style="border-bottom: 1px dotted #808685;clear:both;"></div>
		</div>
	</div>
</form>
<iframe name="secondFrame" id="secondFrame" src="resume!queryResumeByCond" width="100%" height="1000" frameborder="0" scrolling="no"></iframe>
</body>
</html>