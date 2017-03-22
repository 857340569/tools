<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>职位更改</title>
<base href="<%=basePath%>">
<script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<script src="js/common.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/style.css" type="text/css" media="all" />
<jsp:include page="processbar.jsp"></jsp:include> 
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
<link href="./js/selectjobs//selectjob_v2.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/selectjobs/selectjob_v2.0.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript" type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function changePhoneStatus(val){
		if(val=="1")//电话招聘,不能加入集结号中
		{
			$("#addSend").hide();
			$("#showEndTime").hide();
			$("#checkSend").removeAttr("checked");
		}else
		{
			$("#checkSend").attr("checked","checked");
			$("#addSend").show();
			$("#showEndTime").show();
		}
	}
	$(function() {
		$.Placeholder.init();
		$(".releaseJob").Validform({
			tiptype : 2,
			showAllError : true
		});
		mySelectInit();
		mySelectResize();
		jobInit($("#select_job_cate"),"input");
		$("#submitJobType").val("${job.category}");
		var checkType="${job.phoneStatus eq 1}";//电话招聘
		var nowType=$("#invoType").val();//现在所选招聘方式
		if(checkType=="true")
		{
			$("#addSend").hide();
			$("#showEndTime").hide();
			$("#checkSend").removeAttr("checked");
		}
		window.parent.setTitle("职位编辑");
		window.parent.mainTop();
		$("#checkSend").click(function(){
			if($(this).attr("checked")=="checked")
			{
				$("#showEndTime").show();
				$("#endTimeInput").removeAttr("ignore");
				
			}else
			{
				$("#showEndTime").hide();
				$("#endTimeInput").attr("ignore","ignore");
			}
		});
	});
	function setError(idName, tips) {
		$("#" + idName).attr("class", "Validform_checktip Validform_wrong");
		$("#" + idName).text(tips);
	}
	function resetTips(idName, tips) {
		$("#" + idName).removeAttr("class");
		$("#" + idName).attr("class", "Validform_checktip Validform_right");
		$("#" + idName).text(tips);
	}
	function checkData() {
		if($(".active").length>0){
			resetTips("select_welfare_tips", "通过信息验证！");
		}else{
			setError("select_welfare_tips", "请选择职位福利！");
			return;
		}
		var cka= checkAge();
		if(!cka)
			return;
		var arr=new Array();
		var addkey="";
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
		$("#welfare").attr("value",key_word);
		with($("#releaseJob"))
		{
			var checkType="${job.phoneStatus eq 1}";//电话招聘
			var nowType=$("#invoType").val();//现在所选招聘方式
			var isJoinJijiehao="${job.send eq 'jijiehao'}";
			if(checkType=="true"&&nowType=="0")
			{
				if(confirm("之前选择的电话招聘包月服务费将会失效，确定要修改为在线申请方式吗?"))
				{
					submit();
				}
				
			}else if(isJoinJijiehao=="true"&&$("#checkSend").attr("checked")!="checked")
			{
				if(confirm("之前选择加入集结号服务费将会失效，确定要移除集结号吗?"))
				{
					submit();
				}
			}else{
				submit();
			}
			
		}
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
 function reload(){
	$("# brightspot.cbdel").each(function(){
		$(this).unbind("click");
	});
	//删除
	$("#brightspot .cbdel").each(function(){
		$(this).click(function(){
			$(this).parent(".actived").remove();
			addSs();
		});
	});
}
function addSs(){
	if($(".actived").length==0){
		$("#brightspot").css("height","30px");
	}
	if($("#brightspot .actived").length<3){
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
	});
	if("${job.welfare}"=="无")
	{
		$("#k0").attr("class","active");
// 		$("#k0").nextAll().removeClass("active");
// 		$("#brightspot").html("");
	}
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
	reload();
	addSs();
	//追加
	$("#addbrig").click(function(){
		var li_text = $("#txtOthBrig1").val();
		if(li_text == ""|| li_text=="最多增加3个福利"){
			alert("请填写福利信息");
			return false;
		}
		$("#brightspot").css("height","");
		$("#brightspot").append("<li class='actived'>"+li_text+"<a class='cbdel' href='javascript:void(0); '></a></li>");
		$("#txtOthBrig1").val("");
		$("#k0").removeClass("active");
		reload();
		addSs();
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
		setError("ageLimTips","年龄段请选择完整！");
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
</script>
<style type="text/css">
body {
	margin-top: 10px;
	background-color: #ffffff;
	margin-left: 10px
}	
#change_submit:hover {
		background-image:url("./images/change_focus.png");
	}
.lefttd{
	width: 160px;
	height:30px;
	line-height:30px;
	font-size:14px;
	text-align:center;
}
.release_select,.td_input{
	width:240px;
}
#select_welfare_tips{
	margin-top: 5px;
}
.td_input input{
	font-size: 14px;
	width: 225px;
	height: 30px;
	line-height: 30px;
	vertical-align: middle;
}
.release_select select{
	font-size: 14px;
	width: 237px;
	height: 30px;
	margin-left:5px;
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
		margin-left: 145px;
		margin-top: 45px;
		font-size:20px;
	}
	.exeCommonBtn:hover{
		background:#6fa1e7;
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
	.statusTips{
		line-height: 20px;
		padding-left:10px; 
	}
</style>
</head>

<body topmargin="0" leftmargin="0" bgcolor="#f0f0f0">
	<form class="releaseJob" method="post" action="job!updateJob?job.id=${job.id}" id="releaseJob">
		<input type="hidden" name="job.welfare" id="welfare"/>
		<input type="hidden" name="ageStart" id="ageStartHidden"/>
		<table width="100%" style="table-layout:fixed;" border="0"
			cellspacing="2" cellpadding="2">
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;职位名称：</td>
				<td style="width:245px;" >
					<input type="text" 
						<c:if test="${empty job.name}">
							<c:choose>
								<c:when test="${fn:contains(job.category,'-')}">
									value="${fn:split(job.category,'-')[1]}"
								</c:when>
								<c:otherwise>
									value="${job.category}"
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${job.name}">
							value="${job.name}"
						</c:if>
					 name="job.name" class="inp006" datatype="*2-10" nullmsg="请输入职位名称！" errormsg="请认真填写职位名称（2～20个字符)"/>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd" height="28px" style="width: 160px;"><font class="releaseJob_need">*</font>&nbsp;职位类别：</td>
				<td class="release_select">
					<div id="select_job_category" style="position:relative;">
						<input class="inp006" id="select_job_cate" readonly="readonly" 
							<c:choose>
								<c:when test="${fn:contains(job.category,'-')}">
									value="${fn:split(job.category,'-')[1]}"
								</c:when>
								<c:otherwise>
									value="${job.category}"
								</c:otherwise>
							</c:choose>
							style="float:left;cursor:pointer;">
						<span class='zjp_myselect_currentSelect_icon' style="left:215px;position:absolute;"></span>
					</div>
					<div id="select_job_dialog">
						<div id="job_dialog_title">选择职位类别</div>
						<div id="job_dialog_content">
							<table id="dialog_show_table">
							
							</table>
						</div>
					</div>
				</td>
				<td style="width:500px;"><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;需求人数：</td>
				<td class="td_input"><input type="text" maxlength="3" style="width:200px;" value="${job.recruitingNumbers}"
					name="job.recruitingNumbers" class="inp006" datatype="rqNum"
					nullmsg="请输入需求人数！"/>&nbsp;人
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;年龄范围：</td>
				<td class="td_input">
					<c:choose>
						<c:when test="${!empty ageEnd}">
							<span id="ageUnlimite">不限</span>
							<span id="age_input_span"><input onkeydown="onlyNum(event);" onblur="checkAge();" id="ageStart" style="width:60px;height:26px;line-height:26px;padding-left:4px; " maxlength="2"  value="${ageStart}" />-<input onkeydown="onlyNum();" onblur="checkAge();" style="width:60px;height:26px;line-height:26px;padding-left:4px;" id="ageEnd" maxlength="2"  value="${ageEnd}"/></span>
						</c:when>
						<c:otherwise>
							<span class="cond_item_selected" id="ageUnlimite">不限</span>
							<span id="age_input_span" ><input onkeydown="onlyNum(event);" onblur="checkAge();" disabled="disabled" style="width:60px;height:26px;line-height:26px;padding-left:4px;" id="ageStart" maxlength="2"  />-<input onkeydown="onlyNum();" onblur="checkAge();" style="width:60px;height:26px;line-height:26px;padding-left:4px;" disabled="disabled" id="ageEnd" maxlength="2"  /></span>
						</c:otherwise>
					</c:choose>
				</td>
				<td><div class="Validform_checktip" id="ageLimTips"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;性别要求：</td>
				<td class="td_input">
					<select name="sexLimite" datatype="*" class="inp006">
						<option value="不限" <c:if test="${sexLimite eq '不限'}">selected="selected"</c:if> >不限</option>
						<option value="男" <c:if test="${sexLimite eq '男'}">selected="selected"</c:if> >男</option>
						<option value="女" <c:if test="${sexLimite eq '女'}">selected="selected"</c:if> >女</option>
					</select>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;工作地点：</td>
				<td class="td_input"><input type="text" value="${job.workplace}"
					name="job.workplace" class="inp006" datatype="*3-200" errormsg="详细地址只能填写汉字,数字,字母(3-200个字)!"
					nullmsg="请输入工作地点！" />
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;联系电话：</td>
				<td class="td_input"><input type="text" value="${job.contactPhone}"
					name="job.contactPhone" class="inp006" datatype="m|tel" nullmsg="请输入您的联系电话！"/>
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>

			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;工作时间：</td>
				<td class="td_input"><input type="text" value="${job.interviewTime }"
					name="job.interviewTime" class="inp006" datatype="*2-20"
					nullmsg="请填写工作时间！" errormsg="请认真填写工作时间（2～20个字符）！" /></td>
				<td><div class="Validform_checktip"></div>
			</tr>
<tr>
				<td class="lefttd" rowspan="2" style="height: 105px;"><font class="releaseJob_need">*</font>&nbsp;职位福利：</td>
				<td colspan="4">
					<div class="key_div">
						<ul class="welfare_ul">
							<li  style="margin-left: 4px;" id="k0">无</li>
							<li id="k1" <c:if test="${fn:contains(job.welfare, '包吃')}">class="active"</c:if>>包吃</li>
							<li id="k2" <c:if test="${fn:contains(job.welfare, '包住')}">class="active"</c:if>>包住</li>
							<li id="k3" <c:if test="${fn:contains(job.welfare, '双休')}">class="active"</c:if>>双休</li>
							<li id="k4" <c:if test="${fn:contains(job.welfare, '交纳社保')}">class="active"</c:if>>交纳社保</li>
							<li id="k5" <c:if test="${fn:contains(job.welfare, '长白班')}">class="active"</c:if>>长白班</li>
							<li id="k6" <c:if test="${fn:contains(job.welfare, '无需经验')}">class="active"</c:if>>无需经验</li>
							<li id="k7" <c:if test="${fn:contains(job.welfare, '24小时空调')}">class="active"</c:if>>24小时空调</li>
						</ul>
					</div>
					<div class="Validform_checktip" id="select_welfare_tips"></div>
				</td>
				<td></td>
			</tr>
			<tr>
		    <td style="height: 70px;line-height: 70px;" colspan="2">
		        <div class="key_div" style="top:-15px;*top:-20px;position: relative;" >
		            <ul id="brightspot" class="brightspot clear" style="margin-top:3px;margin-bottom:2px;*margin-bottom:10px;margin-left: 4px;">
		          		<c:choose>
		            		<c:when test="${empty addKeyWords}"></c:when>
		            		<c:otherwise>
		            			<c:forEach items="${addKeyWords}" var="addkey">
		            				<li class="actived">${addkey}<a class="cbdel" href="javascript:void(0); "></a></li>
		            			</c:forEach>
		            		</c:otherwise>
		            	</c:choose>
		            </ul>
		            <div id="OthBrig" style="top: -8px;position: relative;" >
		                <input placeholder="最多增加3个福利" maxlength="20" class="textstyle" style="vertical-align:middle" id="txtOthBrig1" type="text">
		                <input value="添加福利" type="button" id="addbrig" class="addbrig">
		                <span id="txtOthBrig1_Tip"></span>
		            </div>
		        </div>
    		</td>
			</tr>
			<tr>
				<td class="lefttd" height="28px"><font class="releaseJob_need">*</font>&nbsp;薪资范围：</td>
				<td class="release_select"><select name="job.workPay" class="inp007" datatype="*"
					errormsg="请选择薪资范围！">
						<option value="面议"
							<c:if test="${job.workPay eq '面议'}">selected="selected"</c:if>>面议</option>
						<option value="1000元以下"
							<c:if test="${job.workPay eq '1000元以下'}">selected="selected"</c:if>>1000元以下</option>
						<option value="1000-2000元"
							<c:if test="${job.workPay eq '1000-2000元'}">selected="selected"</c:if>>1000-2000元</option>
						<option value="2000-3000元"
							<c:if test="${job.workPay eq '2000-3000元'}">selected="selected"</c:if>>2000-3000元</option>
						<option value="3000-5000元"
							<c:if test="${job.workPay eq '3000-5000元'}">selected="selected"</c:if>>3000-5000元</option>
						<option value="5000元以上"
							<c:if test="${job.workPay eq '5000元以上'}">selected="selected"</c:if>>5000元以上</option>
				</select>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd" height="28px"><font class="releaseJob_need">*</font>&nbsp;学历要求：</td>
				<td class="release_select"><select name="job.requreEducation" class="inp007" datatype="*"
					nullmsg="请选择学历范围！" errormsg="请选择学历范围！">
						<option value=""
						<c:if test="${job.requreEducation eq ''}">selected="selected"</c:if>>-请选择-</option>
						<option value="学历不限" 
						<c:if test="${job.requreEducation eq '学历不限'}">selected="selected"</c:if>>学历不限</option>
						<option value="初中"
						<c:if test="${job.requreEducation eq '初中'}">selected="selected"</c:if>>初中</option>
						<option value="高中"
						<c:if test="${job.requreEducation eq '高中'}">selected="selected"</c:if>>高中</option>
						<option value="中专"
						<c:if test="${job.requreEducation eq '中专'}">selected="selected"</c:if>>中专</option>
						<option value="大专"
						<c:if test="${job.requreEducation eq '大专'}">selected="selected"</c:if>>大专</option>
						<option value="本科"
						<c:if test="${job.requreEducation eq '本科'}">selected="selected"</c:if>>本科</option>
						<option value="本科以上"
						<c:if test="${job.requreEducation eq '本科以上'}">selected="selected"</c:if>>本科以上</option>
				</select>
				</td>
				<td><div class="Validform_checktip"></div>
			</tr>
			<tr>
				<td class="lefttd" height="28px"><font class="releaseJob_need">*</font>&nbsp;工作经验：</td>
				<td class="release_select" >
					<select name="job.requreExperience" class="inp007" datatype="*"
						nullmsg="请选择经验范围！" errormsg="请选择经验范围！">
						<option value=""
						<c:if test="${job.requreExperience eq ''}">selected="selected"</c:if>>-请选择-</option>
						<option value="经验不限"
						<c:if test="${job.requreExperience eq '经验不限'}">selected="selected"</c:if>>经验不限</option>
						<option value="一年以下"
						<c:if test="${job.requreExperience eq '一年以下'}">selected="selected"</c:if>>一年以下</option>
						<option value="一至三年"
						<c:if test="${job.requreExperience eq '一至三年'}">selected="selected"</c:if>>一至三年</option>
						<option value="三至五年"
						<c:if test="${job.requreExperience eq '三至五年'}">selected="selected"</c:if>>三至五年</option>
						<option value="五年以上"
						<c:if test="${job.requreExperience eq '五年以上'}">selected="selected"</c:if>>五年以上</option>
					</select>
				</td>
				<td><div class="Validform_checktip"></div>
			</tr>
			<tr>
				<td class="lefttd" rowspan="2"><font
					class="releaseJob_need">*</font>&nbsp;招聘方式：
				</td>
				<td colspan="2">
					<div style="padding-left:4px;">
						<font color="#ff7200">友情提醒：</font>
				        <div class="statusTips">  1.在线申请：应聘者在线申请，企业通过后台查看应聘者信息，确认其合适后再录用  此方式消耗${priceConfig.personalPrice}米粒/人。</div>
				        <div class="statusTips">  2.电话申请：应聘者直接通过电话与企业联系，企业无需后台查看。此方式消耗${priceConfig.jobMonthPrice}米粒/月。</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="release_select" style="width:245px;" >
					<select onchange="changePhoneStatus(this.value);" id="invoType" name="job.phoneStatus" <c:if test="${job.phoneStatus ne 1}">ajaxurl="ajax!checkVipTime"</c:if> datatype="*" nullmsg="请选择招聘方式！" errormsg="请选择招聘方式！">
						<option value="">-请选择-</option>
						<option value="0" <c:if test="${job.phoneStatus eq 0}">selected="selected"</c:if>>在线申请</option>
						<option value="1" <c:if test="${job.phoneStatus eq 1}">selected="selected"</c:if>>电话招聘</option>
					</select>
				</td>
				<td><div class="Validform_checktip" id="checkInvoType"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>职位简介：</td>
				<td colspan="2" class="td_input" style="padding-left: 5px;"><textarea datatype="*5-4000" nullmsg="请输入职位简介！"
					errormsg="职位简介应在5到4000非空字符之间!"
						style="width: 400px; height: 95px;background: no-repeat;border-style: solid;border-color: #CCCCCC;color:#000;"
						class="content" name="job.requirements">${job.requirements}</textarea>
				</td>
				<td><div style="position: relative;left:-320px;" class="Validform_checktip"></div></td>
			</tr>
			<tr id="addSend">
				<td class="lefttd">&nbsp;加入集结号：</td>
				<td colspan="2"><input id="checkSend" type="checkbox" name="job.send" <c:if test="${job.send eq 'jijiehao'}">checked="checked"</c:if> style="border:none;" value="jijiehao"/> 当您急需人才时，加入到集结号中(<font color="#ff7200">此方式消耗${priceConfig.joinJijiehao}米粒/次</font>)，让更多的求职者瞬间知道你！
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr id="showEndTime" <c:if test="${job.send ne 'jijiehao'}">style="display:none;"</c:if> >
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;集结号结束日期：</td>
				<td colspan="2"><input id="endTimeInput" readonly="readonly" type="text" class="inp006" name="job.sendendtime" onclick="WdatePicker({minDate:'%y-%M-{%d+1}',maxDate:'%y-%M-{%d+8}}',dateFmt:'yyyy-MM-dd',readOnly:true})" datatype="*" nullmsg="请选择集结号结束日期！" <c:if test="${job.send eq 'jijiehao'}">value="${job.sendendtime}"</c:if>/> 
				</td>
				<td><div class="Validform_checktip" <div style="position: relative;left:-325px;">集结号显示时间最长为一周！</div></td>
			</tr>
			<tr style="height: 15px;"></tr>
		</table>
		<div id="submit_div">
			<input type="button"  value="修&nbsp;改" class="exeCommonBtn" id="exeCommonBtn" onclick="checkData();" />
		</div>
	</form>
</body>
</html>