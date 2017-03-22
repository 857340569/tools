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
<script src="./js/My97DatePicker/WdatePicker.js" type="text/javascript"
	language="javascript"></script>
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
	function reloadComDataEvent()
	{
		$(".show_com_content").each(function(){
			$(this).unbind("click");
		});
		
		$(".show_com_content").each(function(){
			$(this).bind("click",function(){
				$(".show_com_content").each(function(){
					$(this).removeAttr("style");
				});
				$("#select_all_com").removeAttr("style");
				$(this).css("background", "#4b8af6");
				var comName=$(this).attr("title");
				if(comName.length>8)
				{
					comName=comName.substring(0,6)+"...";
				}
				$("#show_com_select_value").text(comName);
				$("#com_id").val($(this).attr("id"));
				$("#data_option_dialog").slideUp(300);
			});
		});
	}
	var currentPage=1;
	var pageSize=10;
	var totalPageCount=0;
	var comIsPassed=false;
	var contentHtml="";
	var comName="";
	function showOptionDialog(){
		var dialogDisStatus=$("#data_option_dialog").css("display");
		if(dialogDisStatus!="none")
		{
			$("#data_option_dialog").slideUp(300);
			return;
		}
		if(contentHtml!="")
		{
			$("#data_option_dialog").slideDown(300);
		}else{
			queryCompanies();
		}
	}
	function prePage()
	{
		currentPage--;
		if(currentPage<1)
		{
			currentPage=1;
			return;
		}
		queryCompanies();
	}
	function nextPage()
	{
		currentPage++;
		if(currentPage>totalPageCount)
		{
			currentPage=totalPageCount;
			return;
		}
		queryCompanies();
	}
	function queryCompanies(){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"company!queryMyCompanies",
			data:{
				"currentPage":currentPage,
				"pageSize"	:pageSize
			},
			success:function(jsondata)
			{
				if(jsondata.companies.length<=0)
				{
					comIsPassed=false;
					setError("op_dia_content", "您还没有发布任何企业,请先在<<企业管理->查看企业>>中点击添加按钮进行发布！");
				}else{
					totalPageCount=jsondata.totalPageCount;
					contentHtml="<ul>";
					for(var i=0;i<jsondata.companies.length;i++)
					{
						var comName=jsondata.companies[i].name;
						if(comName.length>11)
						{
							comName=comName.substring(0,10)+"...";
						}
						contentHtml+="<li class='show_com_content' id='"+jsondata.companies[i].id+"' title='"+jsondata.companies[i].name+"'>"+comName+"</li>";
					}
					contentHtml+="</ul>";
					$("#op_dia_content").html(contentHtml);
					reloadComDataEvent();
					comIsPassed=false;
					if(totalPageCount>1){
						$("#op_dia_footer").show();
					}
					
				}
				$("#data_option_dialog").slideDown(300);
			},
			error:function(jsondata)
			{
				comIsPassed=false;
				setError("op_dia_content", "系统内部错误，请刷新后重试！");
			}
		});
	}
	function setError(infoId,tips)
	{
		$("#"+infoId).html("<font color='red'>"+tips+"</font>");
	}
	$(function(){
		initDialog(true);
		$("#select_all_com").click(function(){
				$(".show_com_content").each(function(){
					$(this).removeAttr("style");
				});
				$("#show_com_select_value").text("全部企业");
				$("#com_id").val(-1);
				$("#data_option_dialog").slideUp(300);
				$("#select_all_com").css("background", "#4b8af6");
				
		});
		$("#del_sel_jobs").click(function(){
			window.frames["secondFrame"].deleteJobs();
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
	left:-10px;
	position: relative;
}
.query_data_li{
	float:left;
	width:100px;
	height: 32px;
	line-height: 32px;
}
.show_com_content{
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
.show_com_content:hover {
	background: #4b8af6;
	color:#fff;
}
#select_all_com{
	height:26px; 
	cursor:pointer; 
	padding-left:8px;
	font-size: 14px;
	float: left;
	width: 100px;
}
#select_all_com:hover {
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
</style>

</head>
<body topmargin="0" leftmargin="0">
	<div>
		<div style="float: left;">
			<form class="queryJobs" id="queryJobs" method="post" action="job!queryJobByComId" target="secondFrame">
			<input type="hidden" name="company.id" id="com_id" value="-1">
			<ul id="query_data_ul">
				<li class="query_data_li" style="text-align: right;">查询条件:</li>
				<li class="query_data_li">
					<div id="show_secom_name" class='zjp_myselect_currentSelect' style="width:150px;height:30px;margin-left:4px;cursor:pointer;" onclick="showOptionDialog();"><span id="show_com_select_value" class='zjp_myselect_currentSelect_show'>-请选择企业-</span><span class='zjp_myselect_currentSelect_icon'></span></div>
					<div id="data_option_dialog" style="display:none;position:absolute;left:4px;top:43px;z-index: 10000;border:1px solid #9d9d9d;height:240px;width:400px;background:#fff; ">
						<div style="padding:10px 10px;">
							<div style="float: left;" style="font-size: 15px;">请选择公司:</div><div id="select_all_com">全部企业</div><div style="float:right;cursor:pointer;" onclick="$('#data_option_dialog').slideUp(300);"><img title="关闭" alt="关闭" src="./images/remove.png"></div>
						</div>
						<div style="padding:10px 20px;height:130px;margin-top:10px;clear:both;padding-right:0px !important;" id="op_dia_content">
						</div>
						<div id="op_dia_footer" style="text-align: right;padding-right:10px;display:none;clear:both;" class="page_a">
							<<<a href="javascript:prePage();">上一页</a>&nbsp;|&nbsp;<a href="javascript:nextPage();">下一页</a>>>
						</div>
					</div>
				</li>
				<li class="query_data_li" style="padding-left:75px;"><input type="submit" class="query_submit" value="查询">
			</ul>
			</form>
		</div>
		<div class="exeBtns">
			<a href="job!toAddPage" style="text-decoration: none" target="mainFrame">
				<div class="leftIconBtn addBtn" style="width:117px; ">
					<span class="btn_icon"><img src="images/btn_icon_add.png"/></span>
					<span class="btn_text">发布职位</span>	
				</div>
			</a>
			<a style="cursor: hand;text-decoration: none;" onClick="secondFrame.window.deleteJobs()" target="mainFrame">
				<div class="leftIconBtn delBtn" style="width:117px; ">
					<span class="btn_icon"><img src="images/btn_icon_del.png"/></span>
					<span class="btn_text">删除职位</span>	
				</div>
			</a>
		</div>
	</div>
	<iframe name="secondFrame" id="secondFrame" src="job!queryHrJobs" width="100%" height="1000" frameborder="0" scrolling="no"></iframe>
</body>
</html>
