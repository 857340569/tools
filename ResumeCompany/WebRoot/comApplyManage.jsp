<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>职位管理</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./css/base.css" rel="stylesheet" type="text/css">
<link href="./css/common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<script src="./js/My97DatePicker/WdatePicker.js" type="text/javascript" language="javascript"></script>
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<link href="js/myselect/myselect-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script language="JavaScript">
	// 判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	};
	function reloadJobDataEvent()
	{
		$(".show_job_content").each(function(){
			$(this).unbind("click");
		});
		
		$(".show_job_content").each(function(){
			$(this).bind("click",function(){
				$(".show_job_content").each(function(){
					$(this).removeAttr("style");
				});
				$(this).css("background", "#4b8af6");
				var jobName=$.trim($(this).text());
				$("#show_job_select_value").text(jobName);
				var jobId=$(this).attr("id");
				$("#job_id").val(jobId);
				$("#job_data_option_dialog").slideUp(300);
			});
		});
	}
	var jobCurrentPage=1;
	var jobPageSize=15;
	var jobTotalPageCount=0;
	var jobIsPassed=false;
	var jobContentHtml="";
	function showJobOptionDialog(){
		if(jobTimeoutEvent!=undefined)
			clearTimeout(jobTimeoutEvent);
		var dialogDisStatus=$("#job_data_option_dialog").css("display");
		if(dialogDisStatus!="none")
		{
			$("#job_data_option_dialog").slideUp(300);
			return;
		}
		if(jobContentHtml!="")
		{
			$("#job_data_option_dialog").slideDown(300);
		}else{
			queryJobs();
		}
	}
	function preJobPage()
	{
		jobCurrentPage--;
		if(jobCurrentPage<1)
		{
			jobCurrentPage=1;
			return;
		}
		queryJobs();
	}
	function nextJobPage()
	{
		jobCurrentPage++;
		if(jobCurrentPage>jobTotalPageCount)
		{
			jobCurrentPage=jobTotalPageCount;
			return;
		}
		queryJobs();
	}
	function queryJobs(){ 
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"job!queryComJobs",
			data:{
				"currentPage":jobCurrentPage,
				"pageSize"	:jobPageSize
			},
			success:function(jsondata)
			{
				var contentTemp="";
				if(jsondata.jobs.length<=0)
				{
					comIsPassed=false;
// 					alert("您还没有发布任何企业,请先在<<企业管理>>中发布！");
					contentTemp="您选择的企业还没有添加职位信息,立即<a href='./admin/releaseJob.jsp'>添加</a>！";
					$("#job_op_dia_content").html("<span style='font-size:14px;'>"+contentTemp+"</span>");
				}else{
					totalPageCount=jsondata.totalPageCount;
					jobContentHtml="<ul>";
					for(var i=0;i<jsondata.jobs.length;i++)
					{
						var jobType=jsondata.jobs[i].category;
						if(jobType.indexOf("-") != -1)
						{
							var splitIndex=jobType.indexOf("-");
							jobType=jobType.substring(splitIndex+1);
						}
						jobContentHtml+="<li class='show_job_content' id='"+jsondata.jobs[i].id+"'>"+jobType+"</li>";
					}
					jobContentHtml+="</ul>";
					$("#job_op_dia_content").html(jobContentHtml);
					reloadJobDataEvent();
					comIsPassed=false;
					$("#job_data_option_dialog").slideDown(300);
					if(totalPageCount>1){
						$("#job_op_dia_footer").show();
					}
				}
				$("#job_data_option_dialog").slideDown(300);
			},
			error:function(jsondata)
			{
				jobIsPassed=false;
				alert("系统内部错误，请刷新后重试！");
			}
		});
	}
	var jobTimeoutEvent;
	function checkJobOptionClose()
	{
		jobTimeoutEvent=setTimeout(function(){
			if(isJobLeave)
			{
				$("#job_data_option_dialog").slideUp(300);
			}
		},300);
	}
	var isLeave=false;
	var isJobLeave=false;
	$(function(){
		$("#job_data_option_dialog").mouseleave(function(){
				isJobLeave=true;
				$("#job_data_option_dialog").slideUp(300);
				if(jobTimeoutEvent!=undefined)
					clearTimeout(jobTimeoutEvent);
			});
			$("#job_data_option_dialog").mouseenter(function(){
				isJobLeave=false;
			});
	});
	$(function(){
		initDialog(true);
		$("#select_all_job").click(function(){
			$(".show_job_content").each(function(){
				$(this).removeAttr("style");
			});
			$("#show_job_select_value").text("全部职位");
			$("#job_id").val(-1);
			$("#job_data_option_dialog").slideUp(300);
			$("#select_all_job").css("background", "#4b8af6");
				
		});
		$("#show_apply_date_value").click(function(){
			WdatePicker({
				skin:"blue",
				isShowClear:true,
				onpicked:function(data) {
					if($("#show_apply_date_value").val()=="")
					{
						$("#timeTips").text("-请选择申请日期-");
					}else{
						$("#timeTips").text("");
					}
				},
				oncleared:function()
				{
					$("#timeTips").text("-请选择申请日期-");
				}
			});
		});
	});
</script>
<style type="text/css">
body {
	margin-top: 10px;
	background-color: #ffffff;
	margin-left: 10px
}
#apply_info_div{
	padding-top:10px;
}
#apply_select_conditions{
	width:210px;
	float: right;
}
#apply_infos{
	margin-right: 220px;
}
#query_data_ul{
	left:-60px;
	position: relative;
}
.query_data_li{
	float:left;
	width:145px;
	height: 32px;
	line-height: 32px;
}
.show_job_content{
	float:left;
	width: 45%;
	margin-left:2%;
	height:26px; 
	line-height:26px; 
	background: url('./images/icons_for_option.png') no-repeat scroll -97px -183px
		transparent;
	padding-left:8px;
	font-size: 14px;
	overflow:hidden;
	word-break: break-all;
	cursor:pointer;
	margin-bottom:5px; 
}
.show_job_content:hover {
	background: #4b8af6;
	color:#fff;
}
#select_all_job{
	height:26px; 
	cursor:pointer; 
	padding-left:8px;
	font-size: 14px;
	float: left;
	width: 100px;
}
#select_all_job:hover {
	background: #4b8af6;
	color:#fff;
}
.query_submit {
	background: #ffb137;
	color: #fff;
	border-style: none;
	width: 80px;
	height: 30px;
	border-radius: 4px;
}

.query_submit:hover {
	background: #eeb000;
}
.zjp_myselect_currentSelect_show{
	font-size:12px;
	color:#333; 
}
</style>

</head>
<body topmargin="0" leftmargin="0">
	<div>
		<div style="float: left;margin-bottom:10px; ">
			<form class="queryJobs" id="queryJobs" method="post" action="job!queryComApplyByCondtion" target="secondFrame">
			<input type="hidden" name="job.id" id="job_id" value="-1">
			<ul id="query_data_ul">
				<li class="query_data_li" style="text-align: right;">查询条件:</li>
				<li class="query_data_li">
					<div id="show_apply_date_name" style="cursor:pointer;">
						<input name="selectTime" id="show_apply_date_value" class='zjp_myselect_currentSelect_show zjp_myselect_currentSelect' style="padding-left:5px;width:130px;height:30px;line-height:30px;margin-left:4px;cursor:pointer;" readonly="readonly"/>
						<span id="timeTips" onclick="document.getElementById('show_apply_date_value').click()" class='zjp_myselect_currentSelect_icon' style="position: relative;top:-42px;left:-4px;width: 130px;background-position:right center;">-请选择申请日期-</span>
					</div>
				</li>
				<li class="query_data_li">
					<div id="show_job_name" class='zjp_myselect_currentSelect' style="width:150px;height:30px;margin-left:10px;cursor:pointer;" onclick="showJobOptionDialog();"><span id="show_job_select_value" class='zjp_myselect_currentSelect_show'>-请选择职位-</span><span class='zjp_myselect_currentSelect_icon'></span></div>
					<div id="job_data_option_dialog" style="display:none;position:absolute;top:39px;z-index: 10000;border:1px solid #9d9d9d;height:210px;width:400px;background:#fff; ">
						<div style="padding:10px 10px;">
							<div style="float: left;" style="font-size: 15px;">请选择职位:</div><div id="select_all_job">全部职位</div><div style="float:right;cursor:pointer;" onclick="$('#job_data_option_dialog').slideUp(300);"><img title="关闭" alt="关闭" src="./images/remove.png"></div>
						</div>
						<div style="padding:5px 20px;height:130px;margin-top:10px;clear: both;" id="job_op_dia_content">
						</div>
						<div id="job_op_dia_footer" style="text-align: right;padding-right:10px;display:none;" class="page_a">
							<<<a href="javascript:preJobPage();">上一页</a>&nbsp;|&nbsp;<a href="javascript:nextJobPage();">下一页</a>>>
						</div>
					</div>
				</li>
				<li class="query_data_li" style="padding-left:35px;"><input type="submit" class="query_submit" value="查询">
			</ul>
			</form>
		</div>
	</div>
	<iframe name="secondFrame" id="secondFrame" src="job!queryComApplyByCondtion" width="100%" height="1000" frameborder="0" scrolling="no"></iframe>
</body>
</html>
