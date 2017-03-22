<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>职位发布</title>
<base href="<%=basePath%>">
<script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/style.css" type="text/css" media="all" />
<link href="./css/base.css" type="text/css" rel="stylesheet" />
<link href="./css/common.css" type="text/css" rel="stylesheet" />
<link href="js/area/areaselect.css" type="text/css" rel="stylesheet" />
<link href="js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<script src="js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>
<script src="js/validform/Validform_more.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/area/data.js"></script>
<script type="text/javascript" src="./js/area/areaselect.js"></script>
<script src="js/my.placeholder.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<link href="js/myselect/myselect-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="js/myselect/myselect-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<script src="./js/my.placeholder.js" type="text/javascript" language="javascript"></script>
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<link href="./js/selectjobs//selectjob_v2.01.css" rel="stylesheet" type="text/css"  />
<script src="./js/selectjobs/selectjob_v2.0.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript" type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	Array.prototype.S=String.fromCharCode(2);
	Array.prototype.in_array=function(e)
	{
		var r=new RegExp(this.S+e+this.S);
		return (r.test(this.S+this.join(this.S)+this.S));
	};
	$(function() {
		$.Placeholder.init();
		$(".releaseJob").Validform({
			tiptype : 2,
			showAllError : true

		});
		initDialog(true);
		jobInit($("#select_job_cate"),"input");
		$("#select_job_cate").focus(function(){
			$("#data_option_dialog").hide();
		});
		
		$("#checkSend").click(function(){
			if($(this).attr("checked")==true||$(this).attr("checked")=="checked")
			{
				$("#showEndTime").show();
				$("#endTimeInput").removeAttr("ignore");
				
			}else
			{
				$("#showEndTime").hide();
				$("#endTimeInput").attr("ignore","ignore");
			}
		});
		var address="${jobAddress}";
		setDefaultAddress(address);
		window.parent.setTitle("添加职位");
	});
	var lastAddress="";
	//设置默认选择地址  借助/js/area 地址选择插件
	function setDefaultAddress(addre)
	{
		//初始化
		$("#pr2").text("-请选择-");
        $("#ci2").text("-请选择-"); 
        $("#co2").show();
        $("#co2").text("-请选择-"); 
		if(isEmptyValue(addre))
		{
			return;
		}
		lastAddress=addre;
		var pri,ci,co;
		var pris=_areaselect_data['p'];
		pri=getPartAddress(pris);
		if(!isEmptyValue(pri)){
			$("#pr2").text(pri);
			lastAddress=lastAddress.substring(lastAddress.indexOf(pri)+pri.length);
			var cis=_areaselect_data['c'][pri];
			ci=getPartAddress(cis);
			if(!isEmptyValue(ci)){
				$("#ci2").text(ci);
				lastAddress=lastAddress.substring(lastAddress.indexOf(ci)+ci.length);
				var cos=_areaselect_data['a'][pri + '-' + ci];
				if(!isEmptyValue(cos))
				{
					co=getPartAddress(cos);
					if(!isEmptyValue(co))
					{
						$("#co2").text(co);
						lastAddress=lastAddress.substring(lastAddress.indexOf(co)+co.length);
					}
				}else
				{
					$("#co2").hide();
				}
			}
		}
		$("#addrDetail").val(lastAddress);
	}
	//根据数据数组，取得数据
	function getPartAddress(dataArray)
	{
		var dataStr="";
		for(var index=0;index<dataArray.length;index++)
		{
			dataStr=dataArray[index];
			if(lastAddress.indexOf(dataStr) != -1)
			{
				break;
			}else
			{
				if(index==dataArray.length-1)
				{
					dataStr="";
				}
			}
		}
		return dataStr;
	}
	function checkWelfare()
	{
		var checkWel=$(".active").length>0;
		var checkSelfInput=$(".actived").length>0;
		if(checkWel||checkSelfInput){
			resetTips("select_welfare_tips", "通过信息验证！");
			return true;
		}else{
			setError("select_welfare_tips", "请选择或填写职位福利！");
			return false;
		}
	}
	function checkData() {
		$("input").each(function(){
			$(this).blur();
		});
		$("select").each(function(){
			$(this).blur();
		});
		$("textarea").each(function(){
			$(this).blur();
		});
		var checkHasCompany="${comType eq 1}";
		var checkCompany=true;
		if(checkHasCompany=="true")
		{
			checkCompany=$.trim($("#show_com_select_value").text())!="-请选择-";
			if(checkCompany)
			{
				resetTips("select_com_tips", "通过信息验证！");
			}else{
				setError("select_com_tips", "请选择职位所属公司！");
			}
		}
		var cka= checkAge();
		var checkWel=checkWelfare();
		var checkResult = checkCustom();
		if (!checkResult||!checkCompany||!checkWel||!cka)
			return;
		else
			checkAllOk();
		var data;
		var data1 = $("#pr2").text();
		var data2 = $("#ci2").text();
		var data3 = $("#co2").text();
		if (data3 == "-请选择-") {
			data = data1 + data2;
		} else {
			data = data1 + data2 + data3;
		}
		var key_word="";
		
 		if($("#k0").attr("class")=="active")
 		{
 			key_word="无";
 		}else
 		{
 			var arr=new Array();
			var addArr = new Array();
	  		 $("li[class='active']").each(function(){
				var key = $(this).text();
	     		arr.push(trim(key));
	 		});
	  		 $("li[class='actived']").each(function(){
				var key = $(this).text();
	     		addArr.push(trim(key));
	 		});
	  		if(addArr==""){
	 			key_word =arr.join("/");
	 		}else{
	 			key_word =arr.join("/")+","+addArr.join("/");
	 		}
 		}
		$("#hd_da_ta").html("<input type='hidden' name='provCity' value='"+data+"' /><input type='hidden' name='job.welfare' value='"+key_word+"' />");
		with($("#releaseJob"))
		{
			submit();
		}
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
		var count=0;
		$(".input_select").each(function(){
			if($(this).css("display") != "none")
			{
				count++;
			}
		});
		if(count==2)
			$("#addressTips").css("left","-452px");
		if(count==3)
			$("#addressTips").css("left","-350px");
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
					}

				} else {
					resetTips("addressTips", "通过信息验证！");
					isPassed = true;
					$("#addressTips").css("left","-452px");
				}
			}
		}
		return isPassed;
	}
	function checkCustom() {
		var checkAddress = checkSelectAddress();
		if (checkAddress)
			return true;
		return false;
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
	$(function() {
		reloadComDataEvent();
		$(".sel_address").each(function() {
			$(this).bind("contentchange", function() {
				checkSelectAddress();
			});
		});
		setOtherParam(1);
		mySelectInit();
		mySelectResize();
// 		mySelectResizeParam(245,30,14,4);
	});
 	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	}
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
				$(this).css("background", "#4b8af6");
				setDefaultAddress($(this).attr("address"));
				var comName=$(this).attr("title");
				if(comName.length>14)
				{
					comName=comName.substring(0,11)+"...";
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
					setError("select_com_tips", "您还没有发布任何企业,请先在<<企业管理>>中发布！");
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
						contentHtml+="<li class='show_com_content' id='"+jsondata.companies[i].id+"' title='"+jsondata.companies[i].name+"' address='"+jsondata.companies[i].address+"'>"+comName+"</li>";
					}
					contentHtml+="</ul>";
					$("#op_dia_content").html(contentHtml);
					reloadComDataEvent();
					comIsPassed=false;
					$("#data_option_dialog").slideDown(300);
					if(totalPageCount>1){
						$("#op_dia_footer").show();
					}
					
				}
			},
			error:function(jsondata)
			{
				comIsPassed=false;
				setError("select_com_tips", "系统内部错误，请刷新后重试！");
			}
		});
	}
	function reload(){
		$(".cbdel").each(function(){
			$(this).unbind("click");
		});
		//删除
		$(".cbdel").each(function(){
			$(this).click(function(){
				$(this).parent('.actived').remove();
				addSs();
				checkWelfare();
			});
		});
	}
//去除空格
function trim(str){   
     str = str.replace(/^(\s|\u00A0)+/,'');   
     for(var i=str.length-1; i>=0; i--){   
         if(/\S/.test(str.charAt(i))){   
             str = str.substring(0, i+1);   
             break;   
         }   
     }   
    	 return str;   
	}  
//显示/隐藏增加福利按钮
function addSs(){
	if($(".actived").length==0){
		$("#brightspot").css("height","30px");
	}
	if($(".actived").length<3){
		$("#OthBrig").show();
	}else{
		$("#OthBrig").hide();
	}
	
}
	$(function(){
		$(".welfare_ul li").click(function(){
			if($(this).attr("class")=="active"){
				$(this).removeClass("active");
			}else{
				$(this).attr("class","active");
				if($.trim($(this).text())=="无")
				{
					$(this).nextAll().removeClass("active");
					$("#brightspot").html("");
					$("#brightspot").css("height","30px");
				}else
				{
					$("#k0").removeClass("active");
				}
			}
			checkWelfare();
		});
	
	//追加
	$("#addbrig").click(function(){
		var li_text = $("#txtOthBrig1").val();
		if(li_text == "" || li_text=="最多增加3个福利"){
			alert("请填写福利信息");
			return false;
		}
		$("#brightspot").css("height","");
		$("#brightspot").append("<li class='actived'>"+li_text+"<a class='cbdel' href='javascript:void(0); '></a></li>");
		$("#txtOthBrig1").val("");
		$("#k0").removeClass("active");
		reload();
		addSs();
		checkWelfare();
  	});
  	//年龄不限选择
  	$("#ageUnlimite").click(function(){
		var ageLimiteClass=$("#ageUnlimite").attr("class");
		if(ageLimiteClass=="cond_item_selected")
		{
			$("#ageUnlimite").removeAttr("class");
			$("#ageStart").removeAttr("disabled");
			$("#ageEnd").removeAttr("disabled");
		}else
		{
			$("#ageUnlimite").attr("class","cond_item_selected");
			$("#ageStart").attr("disabled","disabled");
			$("#ageEnd").attr("disabled","disabled");
		}
		checkAge();
	});
  });
   function checkAge()
  {
  	var ageLimiteClass=$("#ageUnlimite").attr("class");
	if(ageLimiteClass=="cond_item_selected")
	{
		resetTips("ageLimTips", "通过信息验证！");
		$("#ageStartHidden").val("不限");
		return true;
	}
	var startAgeNum=$("#ageStart").val();
	var endAgeNum=$("#ageEnd").val();
	if(startAgeNum==""||endAgeNum=="")
	{
		setError("ageLimTips","年龄段请填写完整！");
		return false;
	}
	if(startAgeNum>endAgeNum)
	{
		setError("ageLimTips","起始年龄不能大于结束年龄！");
		return false;
	}
	$("#ageStartHidden").val(startAgeNum+"-"+endAgeNum);
	resetTips("ageLimTips", "通过信息验证！");
	return true;
  }
  function onlyNum(event)
	{
		var key = event.charCode||event.keyCode;  
		if(key!=8)
		{
		  if(!((key>=48&&key<=57)||(key>=96&&key<=105)))
		  {
			  var isIE=myBrowser()=="IE";
			  if(isIE)
			   {
			   		window.event.returnValue=false;
			   }else
			   {
			   		event.preventDefault();
			   }
			}
		}
	}
	function changePhoneStatus(val){
		if(val=="1")//电话招聘,不能加入集结号中
		{
			$("#addSend").hide();
			$("#showEndTime").hide();
			$("#checkSend").removeAttr("checked");
			$("#endTimeInput").attr("ignore","ignore");
		}else
		{
			$("#checkSend").attr("checked","checked");
			$("#addSend").show();
			$("#showEndTime").show();
			$("#endTimeInput").removeAttr("ignore");
		}
	}
</script>
<style type="text/css">
select{
	width: 240px;
	height: 30px;
	margin-left:4px;
}
#select_welfare_tips{
	margin-top: 5px;
}
.release_select{
	width: 245px;
	height: 30px;
	line-height: 30px;
	vertical-align: middle;
	font-size: 13px;
}
#change_submit:hover {
	background-image: url("./images/release_focus.png");
}

.input_select {
	height: 32px;
	padding-left: 6px;
	font-size: 13px;
	width: 100px;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 2px;
	line-height: 32px;
	background: #fff url('./images/bg-selectt.png') right center no-repeat;
	cursor: pointer;
	color: #000000;
	display: inline-block;
	text-align: left;
	overflow: hidden;
	white-space: nowrap;
}

.li_tips {
	font-size: 12px !important;
	padding-left: 10px;
}

#addressTips {
	margin-left: 10px;
	position: relative;
}
input,textarea {
	border:1px solid #ccc;
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
}
.show_com_content:hover {
	background: #4b8af6;
	color:#fff;
}
.lefttd {
	width: 140px;
	text-align: left;
	padding-left:45px;
}
.addbrig:FOCUS{
	border:1px solid #DCDEE1;  
}
#show_com_select_value
{
	overflow:hidden;
}
.statusTips{
	line-height: 20px;
	padding-left:10px; 
}
#ageUnlimite{
		padding:0px 5px;
		display:inline-block;
		cursor:pointer;
		height:24px;
		line-height:24px;
		margin-left:4px;
}
#ageUnlimite:hover{
	background:#d5d5d5;
}
.cond_item_selected{
	background:#9d9d9d;
}
</style>
</head>

<body topmargin="0" leftmargin="0">
	<form class="releaseJob" id="releaseJob" method="post"
		action="job!releaseJob">
		<input type="hidden" name="company.id" id="com_id">
		<input type="hidden" name="ageStart" id="ageStartHidden"/>
		<table width="100%" style="table-layout:fixed;" border="0"
			cellspacing="2" cellpadding="2">
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;职位名称：</td>
				<td style="width:245px;" ><input type="text" value="" name="job.name"
					class="inp006" datatype="*2-10" nullmsg="请输入职位名称！" errormsg="请认真填写职位名称（2～20个字符)"/>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font
					class="releaseJob_need">*</font>&nbsp;职位类别：</td>
				<td class="release_select" style="width:245px;" >
					<div id="select_job_category" style="position:relative;float: left;">
						<input datatype="*" nullmsg="请选择职位类别！" errormsg="请选择职位类别！" class="inp006" id="select_job_cate" readonly="readonly" style="float: left;cursor:pointer;">
						<span class='zjp_myselect_currentSelect_icon' style="position:absolute;left:215px;" ></span>
					</div>
					<div style="float: left;position: absolute;top:54px;left:437px;"><div class="Validform_checktip"></div></div>
				</td>
				<td style="width:450px;">
					<div id="select_job_dialog">
						<div id="job_dialog_title">选择职位类别</div>
						<div id="job_dialog_content">
							<table id="dialog_show_table">
							
							</table>
						</div>
					</div>
				</td>
			</tr>
			<c:if test="${comType eq 1}">
				<tr>
					<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;所属公司：</td>
					<td style="position: relative;">
						<div id="show_secom_name" class='zjp_myselect_currentSelect' style="width:226px;height:30px;margin-left:4px;cursor:pointer;" onclick="showOptionDialog();"><span id="show_com_select_value" class='zjp_myselect_currentSelect_show'>-请选择-</span><span class='zjp_myselect_currentSelect_icon'></span></div>
						
						<div id="data_option_dialog" style="display:none;position:absolute;left:4px;top:39px;z-index: 10000;border:1px solid #9d9d9d;height:210px;width:400px;background:#fff; ">
							<div style="padding:10px 10px;">
								<div style="float: left;" style="font-size: 15px;">请选择公司:</div><div style="float:right;cursor:pointer;" onclick="$('#data_option_dialog').slideUp(300);"><img title="关闭" alt="关闭" src="./images/remove.png"></div>
							</div>
							<div style="padding:10px 20px;height:130px;margin-top:10px;clear:both;" id="op_dia_content">
							</div>
							<div id="op_dia_footer" style="text-align: right;padding-right:10px;display:none;" class="page_a">
								<<<a href="javascript:prePage();">上一页</a>&nbsp;|&nbsp;<a href="javascript:nextPage();">下一页</a>>>
							</div>
						</div>
					</td>
					<td>
						<div class="Validform_checktip" id="select_com_tips"></div>
					</td>
				</tr>
			</c:if>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;需求人数：</td>
				<td><input type="text" value="" name="job.recruitingNumbers" style="width:210px;"
					class="inp006" datatype="rqNum" nullmsg="请输入需求的人数！" maxlength="3"
					/>&nbsp;<span id="show_dw" style="display:inline-block; line-height:30px;height: 40px;">人</span>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;年龄范围：</td>
				<td>
					<span id="ageUnlimite">不限</span>
					<span id="age_input_span"><input onkeydown="onlyNum(event);" onblur="checkAge();" id="ageStart" style="width:60px;height:26px;line-height:26px;padding-left:4px; " maxlength="2"  value="${ageStart}" />-<input onkeydown="onlyNum(event);" onblur="checkAge();" style="width:60px;height:26px;line-height:26px;padding-left:4px;" id="ageEnd" maxlength="2"  value="${ageEnd}"/></span>
				</td>
				<td><div class="Validform_checktip" id="ageLimTips"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;性别要求：</td>
				<td class="release_select">
					<select name="sexLimite" datatype="*">
						<option value="不限">不限</option>
						<option value="男">男</option>
						<option value="女">女</option>
					</select>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;工作时间：</td>
				<td><input type="text" value="" name="job.interviewTime"
					class="inp006" datatype="*2-20" nullmsg="请输入工作时间！"
					errormsg="请认真填写工作时间（2～20个字符）！" />
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;薪资范围：</td>
				<td class="release_select"><select name="job.workPay"
					 datatype="*" nullmsg="请选择发布的薪资范围！"
					errormsg="请选择发布的薪资范围！">
						<option value="">-请选择-</option>
						<option value="面议">面议</option>
						<option value="1000元以下">1000元以下</option>
						<option value="1000-2000元">1000-2000元</option>
						<option value="2000-3000元">2000-3000元</option>
						<option value="3000-5000元">3000-5000元</option>
						<option value="5000元以上">5000元以上</option>
				</select>
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;学历要求：</td>
				<td class="release_select"><select name="job.requreEducation"
					 datatype="*" nullmsg="请选择学历范围！" errormsg="请选择学历范围！">
						<option value="">-请选择-</option>
						<option value="学历不限">学历不限</option>
						<option value="初中">初中</option>
						<option value="高中">高中</option>
						<option value="中专">中专</option>
						<option value="大专">大专</option>
						<option value="本科">本科</option>
						<option value="本科以上">本科以上</option>
				</select>
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;工作经验：</td>
				<td class="release_select"><select name="job.requreExperience"
					 datatype="*" nullmsg="请选择经验范围！" errormsg="请选择经验范围！">
						<option value="">-请选择-</option>
						<option value="经验不限">经验不限</option>
						<option value="一年以下">一年以下</option>
						<option value="一至三年">一至三年</option>
						<option value="三至五年">三至五年</option>
						<option value="五年以上">五年以上</option>
				</select>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			
			  <tr>
				<td class="lefttd" rowspan="2" style="height: 105px;"><font class="releaseJob_need">*</font>&nbsp;职位福利：</td>
				<td colspan="3">
					<div class="key_div">
						<ul class="welfare_ul">
							<li  style="margin-left: 4px;" id="k0" >无</li>
							<li id="k1" >包吃</li>
							<li id="k2">包住</li>
							<li id="k3">双休</li>
							<li id="k4">交纳社保</li>
							<li id="k5">长白班</li>
							<li id="k6">无需经验</li>
							<li id="k7">24小时空调</li>
						</ul>
					</div>
					<div class="Validform_checktip" id="select_welfare_tips"></div>
				</td>
				<td></td>
			</tr>
			<tr>
		    <td style="height: 70px;line-height: 70px;padding:5px 0px; " colspan="2">
		        <div class="key_div" style="top:-15px;*top:-20px;position: relative;" >
		            <ul id="brightspot" class="brightspot clear" style="margin-top:3px;margin-bottom:2px;*margin-bottom:10px;margin-left: 4px;height:30px; ">
		            </ul>
		            <div id="OthBrig" style="top: -8px;position: relative;" >
		                <input placeholder="最多增加3个福利" maxlength="20" class="textstyle" style="vertical-align:middle" id="txtOthBrig1" type="text">
		                <input value="添加福利" type="button" id="addbrig" class="addbrig" style="border:1px solid #DCDEE1;margin-left:8px; ">
		                <span id="txtOthBrig1_Tip"></span>
		            </div>
		        </div>
    		</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;工作地点：</td>
				<td colspan="2" id="selectAddr"><span id="pr2" type="text"
					class="input_select sel_address"
					style="width: 112px; margin-left: 4px;"
					name="seachprov">-请选择-</span> <span id="ci2" type="text"
					class="input_select sel_address" name="seachcity">-请选择-</span> <span
					id="co2" type="text" class="input_select sel_address"
					name="seachdistrict">-请选择-</span>
				</td>
				<td class="li_tips" colspan="1" style="padding-left: 0px;"><div
						class="Validform_checktip" id="addressTips"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;详细地址：</td>
				<td><input type="text" name="addrDetail" id="addrDetail"
					class="inp006" datatype="s3-150" nullmsg="请输入地址！"
					errormsg="详细地址只能填写汉字,数字,字母(3-150个字)!" /></td>
				<td><div class="Validform_checktip">为保证定位准确请填写真实详细地址!</div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;联系电话：</td>
				<td><input type="text" name="job.contactPhone" class="inp006"
					datatype="m|tel" nullmsg="请输入您的联系电话！" />
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd" rowspan="2"><font
					class="releaseJob_need">*</font>&nbsp;招聘方式：
				</td>
				<td colspan="2">
					<div style="padding-left:4px;">
						<font color="#ff7200">友情提醒：</font>
				        <div class="statusTips">  1.在线申请：应聘者在线申请，企业通过后台查看应聘者信息，确认其合适后再录用。此方式消耗${priceConfig.personalPrice}米粒/人。</div>
				        <div class="statusTips">  2.电话申请：应聘者直接通过电话与企业联系，企业无需后台查看。此方式消耗${priceConfig.jobMonthPrice}米粒/月。</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="release_select" style="width:245px;" >
					<select onchange="changePhoneStatus(this.value);" id="invoType" name="job.phoneStatus" ajaxurl="ajax!checkVipTime" datatype="*" nullmsg="请选择招聘方式！" errormsg="请选择招聘方式！">
						<option value="">-请选择-</option>
						<option value="0">在线申请</option>
						<option value="1">电话招聘</option>
					</select>
				</td>
				<td style="width:450px;"><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;职位简介：</td>
				<td colspan="2"><textarea datatype="*5-4000" nullmsg="请输入职位简介！"
					errormsg="职位简介应在5到4000非空字符之间!"
						style="margin-left:4px;width: 400px; height: 95px;background: no-repeat;border-style: solid;border-color: #CCCCCC;color:#000;"
						class="content" name="job.requirements" value=""></textarea>
				</td>
				<td><div style="position: relative;left:-280px;" class="Validform_checktip"></div></td>
			</tr>
			
			<tr id="addSend">
				<td class="lefttd">&nbsp;加入集结号：</td>
				<td colspan="2"><input id="checkSend" type="checkbox" name="job.send" checked="checked" style="border:none;" value="jijiehao"/> 当您急需人才时，加入到集结号中(<font color="#ff7200">此方式消耗${priceConfig.joinJijiehao}米粒/次</font>)，让更多的求职者瞬间知道你！
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr id="showEndTime">
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;集结号结束日期：</td>
				<td colspan="2"><input id="endTimeInput" readonly="readonly" type="text" class="inp006" name="job.sendendtime" onclick="WdatePicker({minDate:'%y-%M-{%d+1}',maxDate:'%y-%M-{%d+7}}',dateFmt:'yyyy-MM-dd',readOnly:true})" datatype="*" nullmsg="请选择集结号结束日期！" ajaxurl="ajax!checkJijiehaoAccount"/> 
				</td>
				<td><div class="Validform_checktip" <div style="position: relative;left:-420px;">集结号显示时间最长为一周！</div></td>
			</tr>
			<tr>
				<td><br><br></td>
				<td align="left">
					<input type="button"  value="发&nbsp;布" class="exeCommonBtn" onclick="checkData();"/>
				</td>
			</tr>
		</table>

		<script type="text/javascript">
			new locationCard({
				ids : [ 'pr2', 'ci2', 'co2' ]
			}).init();
		</script>
		<div id="hd_da_ta"></div>
	</form>

</body>
</html>