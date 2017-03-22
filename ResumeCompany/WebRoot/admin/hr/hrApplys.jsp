<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>申请管理</title>
<link rel="stylesheet" href="./css/style.css" type="text/css" />
<link href="./css/base.css" type="text/css" rel="stylesheet" />
<link href="./css/common.css" type="text/css" rel="stylesheet" />
<link href="./css/informa-tip.css" rel="stylesheet" type="text/css">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<script src="./js/My97DatePicker/WdatePicker.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript">
	$(function(){
		initDialog(true);
		//显示在mainFrame 中显示
		if("${type}"=="mainFrame")
		{
			$("body").attr("class","mainFrameBody");
		}
	});
	function checkAll() {
		for ( var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document
					.getElementById("ifAll").checked;
		}
	}
	//通知
	function changeEmployState(status) {
		if($("input:checkbox[name=selectFlag]:checked").length<=0)
		{
			var errormsg=status==1?"请先选择要邀请面试的用户！":"请先选择要录用的用户！";
			
			window.parent.alertDialog(errormsg);
		}else{
		
		}

	}
	var isShow = false;
	function tips(e, name, sex, phone, address, workExperience, hopework, jobRequire, state,birth) {

		$("#tipsWin").css("top", e.clientY - 60);
		$("#tipsWin").css("left", e.clientX + 20);
		if (isShow) {
			$("#tipsWin").css("display", "none");
			isShow = false;
		} else {
			$("#tipsWin").css("display", "block");
			$("#applyName").text(checkData(name));
			$("#sex").text(checkData(sex));
			$("#birth").text(checkData(birth));
			if (state == "ok") {
				$("#phone").text(checkData(phone));
			} else {
				phone=checkData(phone);
				if(phone)
				{
					$("#phone").text(phone.substring(0,7)+"****");
				}else
				{
					$("#phone").text("***********");
				}
			}
			$("#address").text(checkData(address));
			$("#workExperience").text(checkData(workExperience));
			$("#hopework").text(checkData(hopework));
			$("#selfAssess").text(checkData(jobRequire));
			isShow = true;
		}
	}
	function checkData(dataParam)
	{
		if(dataParam=="")
		{
			return "未填写";
		}
		return dataParam;
	}
	//弹出
	function treatments(uName,comName,sex,jobname,state,workPlace,contactPhone) {
		$(".tipdiv").css("display", "block");
		$("#companyName").val(comName);
		$(".tipdiv .sendName").text(uName);
		if (sex == "男") {
			$(".tipdiv .sexSpan").text("先生:");
		} else if(sex=="女"){
			$(".tipdiv .sexSpan").text("女士:");
		}else{
			$(".tipdiv .sexSpan").text("先生/女士:");
		}
		$("#contactPhone").val(contactPhone);
		$("#tipAddress").val(workPlace);
		$(".tipdiv .jobName").attr("value", jobname);
		if (state == 1){
			$("#whatDo").text("面试");
		}
		if (state == 2) {
			$("#whatDo").text("任职");
		}
	}
	var msgContent="";
	//弹出，确定按钮
	function sureTipButton(userName,state) {
		if ($.trim($("#companyName").val())== "") {
			alert("公司名称不能为空！");
			return false;
		}
		if ($.trim($("#informtimes").val()) == "") {
			if(state != 2)
			{
				alert("请填写面试时间！");
			}else
			{
				alert("请填写任职时间！");
			}
			return false;
		}
		if ($.trim($("#tipAddress").val()) == "") {
			if(state != 2)
			{
				alert("请填写面试地点！");
			}else
			{
				alert("请填写任职地点！");
			}
			
			return false;
		}
		if ($.trim($("#jobName").val()) == "") {
			if(state != 2)
			{
				alert("请填写面试职位！");
			}else
			{
				alert("请填写任职职位！");
			}
			return false;
		}
		if ($.trim($("#contactPhone").val()) == "") {
			alert("请填写联系方式！");
			return false;
		}
		var  notifyType="";
		if (state == 1||state ==-1){
			notifyType="参加面试，一定要来哟！";
		}else if (state == 2) {
			notifyType="上班，一定要来哟！";
		}
		//notifyType  面试/任职
		msgContent="&&您非常符合我们招聘"+$("#jobName").val()+"的要求，请您于"+$("#informtimes").val()+"到"+$("#tipAddress").val()+notifyType+"联系方式为："+$("#contactPhone").val();
		return true;
	}
	//关闭弹出框
	function closeTipdiv() {
		$(".tipdiv").css("display", "none");

	}
      //userName推送用户名
	 //uName，姓名
      function notifyUser(applyId,comId,comName,jobId,uName,userName,deviceType,state,jobname,sex,workPlace,contactPhone)
      {
      	if("${comType}"=="0")
		{
			comId="${id}";
			comName="${name}";
		}
		if(jobname.indexOf("-") != -1)
		{
			var splitIndex=jobname.indexOf("-");
			jobname=jobname.substring(splitIndex+1);
		}
      	treatments(uName,comName,sex,jobname,state,workPlace,contactPhone);
      	$("#sendToUserBtn").unbind("click");	
      	$("#sendToUserBtn").click(function(){
      		var checkInput=sureTipButton(uName,state);
      		if(checkInput)
      		{
      			var showConfirms="";
      			if (state ==-1){
					showConfirms="第二发送通知将不再扣费但不能取消,确定要发送通知吗?";
				}
				if (state ==1){
					showConfirms="发送通知将会扣除${priceConfig.personalPrice}米粒服务费且通知后将不能取消,确定要发送通知吗?";
				}
				if (state == 2) {
					showConfirms="录用后将不能取消,确定要发送录用信息吗?";
				}
				if (confirm(showConfirms)) {
					$.ajax({
						type:"post",
						async:false,
						url:"push!notifyUser",
						dataType:"json",
						data:{
							"company.id":parseInt(comId),
							"company.name":comName,
							"job.id":parseInt(jobId),
							"pushMessage.msgContent":msgContent,
							"status":state,
							"jobApplication.id":parseInt(applyId),
							"user.userName":userName,
							"user.deviceType":parseInt(deviceType)
						},
						success:function(jsondata){
							closeTipdiv();
							if(jsondata.type=="y")
							{
								
// 								if(state==1)
// 								{
// 									$("#"+applyId).html("<a title='通知消息已发送，点击录用！' href='javascript:notifyUser("+applyId+","+comId+",\""+comName+"\","+jobId+",\""+userName+"\","+deviceType+",2,\""+jobname+"\",\""+sex+"\");'>已通知</a>");
// 								}else if(state==2)
// 								{
// 									$("#"+applyId).html("<span title='录用消息已发送，请耐心等待用户回应！'>已录用</span>");
// 									$("#"+applyId).next(".timeTd").html(jsondata.jobApplication.employTime);
// 								}
								if(state==-1)
								{
									$("#"+applyId).html("<span title='通知消息已发送两次，不能再次推送' class='last_exe_btn_common last_exe_btn_invalid'>已通知</span>");
								}else if(state==1)
								{
									$("#"+applyId).html("<span title='通知消息最近发送过,3天后才能再次发送' class='last_exe_btn_common last_exe_btn_invalid'>已通知</span>");
								}
								$("#"+applyId).next(".timeTd").html(jsondata.jobApplication.employTime);
							}
							alert(jsondata.message);
							
						}
					
					});
				}
      		}
      	});	
      }
      $(function(){
		$("#informtimes").click(function(){
			WdatePicker({
				skin:"blue",
				isShowClear:true,
				dateFmt:"yyyy-MM-dd HH:mm",
				onpicked:function(data) {
				},
				oncleared:function()
				{
				}
			});
		});
	});
</script>

</script>
<style type="text/css">
#tipsWin {
	position: absolute;
	z-index: 22;
	background: url(./images/kuang.png) no-repeat;
	height: 260px;
	width: 500px;
}

a:visited {
	color: #0066cc;
}

.envelope_content td {
	font-size: 13px;
	font-family: 宋体;
	text-align: left;
}

.envelope_tr_bg {
	background-color: #f9e0bd;
	height: 30px;
	margin-bottom: 5px;
}

.envelope_tr {
	background-color: #f2f3f3;
	height: 30px;
	margin-bottom: 5px;
}
.leftIconBtn{
	width:100px;
	height:35px;
	line-height:35px;
	vertical-align:middle;
	color:#fff;
	float: left;
	margin-right:15px; 
}
.btn_icon{
	float:left;
	position: relative;
	top:9px;
	left:15px;
	margin-right: 5px;
}
.btn_icon img{
	width:15px;
	height:15px;
}

.btn_text{
	float:right;
	margin-right:15px; 
	font-size: 18px;
}
.notyBtn{
	background:#82b1f3;
}
.empBtn{
	background:#eeaa19;
}
.empBtn .btn_text{
	position: relative;
	left:-12px;
}
.exportBtn{
	background:#82af6f;
	display:none;
}
.notyBtn:hover{
	background:#96c2ff;
}
.empBtn:hover{
	background:#ffbb28;
}
.exportBtn:hover{
	background:#96c283;
}
.exeBtns
{
	float:right;
	margin-bottom: 15px;
}
.btn_disp_none{
	display:none;
}
.exeMenu{
	position:absolute;
	text-align: left;
	left:-30px;
	top:20px;
	width:100px;
	height:70px;
	border:1px solid #9d9d9d;
	background:#fff; 
	display:none;
}
.exeMenu li{
	text-align:left;
	padding-left:15px;
	font-size: 14px;
	height: 30px;
	line-height:30px;
	cursor:pointer;
}
#tipdivs{
	left:150px;
}
#talentstable{
	left:200px;
	width: 450px;
}
#tipdivs{
	font-size:14px;
}
#tipdivs input{
	font-size:15px;
}
.last_exe_btn_common{
	padding:0px 4px;
	height: 20px;
	line-height: 20px;
}
.mainFrameBody
{
	margin-top: 10px;
	background-color: #ffffff;
	margin-left: 10px
}
</style>

</head>

<body topmargin="0" leftmargin="0">
	<form name="lookApplyForm" id="lookApplyForm" method="post">
		<div style="position: relative;">
			<div class="tipdiv" id="tipdivs" style="background: url('./images/invite.png') no-repeat;display:none;">
				<div id="inbg">
					<div id="talentstable" align="left">
						<ul>
							<li style="height: 25px;"><font color="#000000">尊敬的<font
									class="sendName"></font><span class="sexSpan"></span> </font>
							</li>
							<li><font color="#000" style="line-height:30px;"
								class="font_input"> &nbsp;&nbsp;您好，我们很高兴的通知您,<input
									type="text" value="${session.companyName}" name="company.cname" readonly="readonly"
									id="companyName" class="companyName" style="height: 23px;">诚邀您于
									<input type="text" name="time" id="informtimes"
									class="informtimes" style="height: 23px;" value="">(时间)到
									<input type="text" name="address" id="tipAddress"
									style="height: 23px;" class="tipAddress" value="">(地点)<span id="whatDo">面试</span><input readonly="readonly"
									type="text" value=" " name="job.jobName" id="jobName"
									class="jobName" style="height: 23px;"><span
									class="showJob">(职位),联系方式<input type="text" id="contactPhone" style="width:100px;"></span>。 </font>
							</li>
							<li class="liButton"><input type="button" value="确定" id="sendToUserBtn"/> <input type="button" value="取消"
								onclick="closeTipdiv();" />
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="exeBtns" style="display:none;">
			<a  style="text-decoration: none" target="wqnmlgb">
				<div class="leftIconBtn notyBtn" onclick="changeEmployState(1);">
					<span class="btn_icon btn_disp_none"><img src="images/btn_icon_add.png"/></span>
					<span class="btn_text">通知面试</span>	
				</div>
			</a>
			<a style="cursor: hand;text-decoration: none;" target="wqnmlgb">
				<div class="leftIconBtn empBtn" onclick="changeEmployState(1);">
					<span class="btn_icon btn_disp_none"><img src="images/btn_icon_del.png"/></span>
					<span class="btn_text">录&nbsp;用</span>	
				</div>
			</a>
			<a style="cursor: hand;text-decoration: none;" href="excel!excel?jid=${jid}" target="wqnmlgb">
				<div class="leftIconBtn exportBtn">
					<span class="btn_icon"><img src="images/btn_icon_add.png"/></span>
					<span class="btn_text">导&nbsp;出</span>	
				</div>
			</a>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="float: left;">
			<tr>
				<td height="215" valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="215" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr align="center" class="dataTittleBg">
										<td><input type="checkbox" id="ifAll" value="checkbox"
											onClick="checkAll()" title="全选/反选">
										</td>
										<td>申请人</td>
										<td>职位类别</td>
										<td>性别</td>
										<td>出生年月</td>
										<td>籍贯</td>
										<td>所属公司</td>
										<td>申请时间</td>
										<td>状态</td>
										<td>通知时间</td>
									</tr>
									<c:if test="${empty divPage.dataMap['jobApplications']}">
										<tr align="center">
											<td height="35" class="rd8" colspan="10"><font
												color="red">没有符合条件的记录!</font></td>
										</tr>
									</c:if>
									<c:forEach items="${divPage.dataMap['jobApplications']}" var="jobApplication"
										varStatus="status">
										<tr align="center" id="${status.count}" height="29"
											onmouseover="this.style.background='#e6e6e6'"
											onmouseout="this.style.background=''">
											<td class="r8"><input type="checkbox" name="selectFlag"
												class="checkbox1 dataIds" value="${jobApplication.id}" mytag="testaaa">
											</td>
											<td align="center" class="r8""><a
												href="resume!queryResumeByUserId?user.id=${jobApplication.userId}" target="mainFrame"> 
												<span onmouseover="tips(event,'${divPage.dataMap['users'][jobApplication.id].name}','${divPage.dataMap['users'][jobApplication.id].sex}','${divPage.dataMap['users'][jobApplication.id].phone}',
												'${divPage.dataMap['resumes'][jobApplication.id].locationPlace}',
													'${divPage.dataMap['resumes'][jobApplication.id].workExperience}','${divPage.dataMap['resumes'][jobApplication.id].hopeJob}','${divPage.dataMap['resumes'][jobApplication.id].jobRequirement}','${divPage.dataMap['isBoughts'][jobApplication.id]}','${divPage.dataMap['users'][jobApplication.id].birth}')"
														onmouseout="tips(event)"> ${divPage.dataMap['users'][jobApplication.id].name} 
												</span>
											</a>
										</td>
										<td align="center" class="r8">
											<c:choose>
												<c:when test="${fn:contains(divPage.dataMap['jobs'][jobApplication.id].category,'-')}">
													${fn:split(divPage.dataMap['jobs'][jobApplication.id].category,"-")[1]}
												</c:when>
												<c:otherwise>
													${divPage.dataMap['jobs'][jobApplication.id].category}
												</c:otherwise>
											</c:choose>
										</td>
										<td align="center" class="r8">
											${divPage.dataMap['users'][jobApplication.id].sex}
										</td>
										<td align="center" class="r8">
											${divPage.dataMap['users'][jobApplication.id].birth}
										</td>
										<td align="center" class="r8">
											${divPage.dataMap['users'][jobApplication.id].birthplace}
										</td>
										<td>
											${divPage.dataMap['companies'][jobApplication.id].name}
										</td> 
										<td align="center" class="r8">
											${jobApplication.applyTime}
										</td>
										<td align="center" class="r8 stateTd" id="${jobApplication.id}">
											<c:choose>
												<c:when test="${empty jobApplication.applyStatus||jobApplication.applyStatus<=0||empty divPage.dataMap['limitPush'][jobApplication.id]}">
													<c:choose>
														<c:when test="${comType==0}">
															<a title="点击发送通知消息" href="javascript:notifyUser(${jobApplication.id},-1,'${name}','${divPage.dataMap['jobs'][jobApplication.id].id}','${divPage.dataMap['users'][jobApplication.id].name}','${divPage.dataMap['users'][jobApplication.id].userName}','${divPage.dataMap['users'][jobApplication.id].deviceType}',1,'${divPage.dataMap['jobs'][jobApplication.id].category}','${divPage.dataMap['users'][jobApplication.id].sex}','${divPage.dataMap['jobs'][jobApplication.id].workplace}','${divPage.dataMap['jobs'][jobApplication.id].contactPhone}');">
																<span class=" last_exe_btn_common last_exe_btn_valid">未通知</span>
															</a>
														</c:when>
														<c:otherwise>
															<a title="点击发送通知消息" href="javascript:notifyUser(${jobApplication.id},'${divPage.dataMap['companies'][jobApplication.id].id}','${divPage.dataMap['companies'][jobApplication.id].name}','${divPage.dataMap['jobs'][jobApplication.id].id}','${divPage.dataMap['users'][jobApplication.id].name}','${divPage.dataMap['users'][jobApplication.id].userName}','${divPage.dataMap['users'][jobApplication.id].deviceType}',1,'${divPage.dataMap['jobs'][jobApplication.id].category}','${divPage.dataMap['users'][jobApplication.id].sex}','${divPage.dataMap['jobs'][jobApplication.id].workplace}','${divPage.dataMap['jobs'][jobApplication.id].contactPhone}');">
																<span class=" last_exe_btn_common last_exe_btn_valid">未通知</span>
															</a>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:when test="${jobApplication.applyStatus==1}">
													<c:choose>
														<c:when test="${divPage.dataMap['limitPush'][jobApplication.id]==0}">
															<c:choose>
																<c:when test="${comType==0}">
																	<a title="通知消息已发送，可以再次发送通知" href="javascript:notifyUser(${jobApplication.id},-1,'${name}','${divPage.dataMap['jobs'][jobApplication.id].id}','${divPage.dataMap['users'][jobApplication.id].name}','${divPage.dataMap['users'][jobApplication.id].userName}','${divPage.dataMap['users'][jobApplication.id].deviceType}',-1,'${divPage.dataMap['jobs'][jobApplication.id].category}','${divPage.dataMap['users'][jobApplication.id].sex}','${divPage.dataMap['jobs'][jobApplication.id].workplace}','${divPage.dataMap['jobs'][jobApplication.id].contactPhone}');">
																		<span class=" last_exe_btn_common last_exe_btn_other">已通知</span>
																	</a>
																</c:when>
																<c:otherwise>
																	<a title="通知消息已发送，可以再次发送通知" href="javascript:notifyUser(${jobApplication.id},'${divPage.dataMap['companies'][jobApplication.id].id}','${divPage.dataMap['companies'][jobApplication.id].name}','${divPage.dataMap['jobs'][jobApplication.id].id}','${divPage.dataMap['users'][jobApplication.id].name}','${divPage.dataMap['users'][jobApplication.id].userName}','${divPage.dataMap['users'][jobApplication.id].deviceType}',-1,'${divPage.dataMap['jobs'][jobApplication.id].category}','${divPage.dataMap['users'][jobApplication.id].sex}','${divPage.dataMap['jobs'][jobApplication.id].workplace}','${divPage.dataMap['jobs'][jobApplication.id].contactPhone}');">
																		<span class=" last_exe_btn_common last_exe_btn_other">已通知</span>
																	</a>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:when test="${divPage.dataMap['limitPush'][jobApplication.id]==1}">
															<span title="通知消息最近发送过,${divPage.dataMap['pushDays'][jobApplication.id]}天后才能再次发送！" class=" last_exe_btn_common last_exe_btn_invalid">已通知</span>
														</c:when>
														<c:when test="${divPage.dataMap['limitPush'][jobApplication.id]==2}">
															<span title="通知消息已发送两次，不能再次推送" class=" last_exe_btn_common last_exe_btn_invalid">已通知</span>
														</c:when>
													</c:choose>
												</c:when>
												<c:otherwise>
													<span class=" last_exe_btn_common last_exe_btn_invalid">已通知</span>
												</c:otherwise>
											</c:choose> 
										</td>
										<td align="center" class="r8 timeTd" id="${status.index}">
											<c:choose>
												<c:when
													test="${!empty divPage.dataMap['limitPush'][jobApplication.id]}">
													${jobApplication.employTime}
												</c:when>
												<c:otherwise>
													--
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
								</table>
									<div>
									<jsp:include page="../page.jsp">
										<jsp:param name="url" value="job!lookApply" />
										<jsp:param name="para" value="${pageUrl}" />
									</jsp:include>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	<div id="tipsWin" style="display:none">
		<table width="450"
			style="margin-top: 20px;margin-left: 35px;"
			class="envelope_content" cellspacing="0" cellpadding="0">
			<tr class="envelope_tr_bg">
				<td align="left">&nbsp;&nbsp;申请人：<span
					id="applyName"></span></td>
				<td colspan="3"></td>
			</tr>
			<tr class="envelope_tr">
				<td>&nbsp;&nbsp;出生年月：<span id="birth"></span></td>
				<td colspan="3">性别：<span id="sex"></span>
			</tr>
			<tr class="envelope_tr_bg">
				<td>&nbsp;&nbsp;联系电话：<span id="phone"></span>
				<td colspan="3">工作经验：<span id="workExperience"></span>
				</td>

			</tr>
			<tr class="envelope_tr">
				<td colspan="3">&nbsp;&nbsp;期望工作：<span id="hopework"></span></td>
			</tr>
			<tr class="envelope_tr_bg">
				<td colspan="4">&nbsp;&nbsp;所在城市：<span id="address"></span>
				</td>
			</tr>
			<tr class="envelope_tr_bg"
				style="background-color: #f2f3f3;height: 5px;">
				<td colspan="4"></td>
			</tr>
			<tr class="envelope_tr_bg" style="height: 65px;">
				<td colspan="4">&nbsp;&nbsp;人个简介：<span
					id="selfAssess"></span></td>
			</tr>
		</table>
	</div>
</body>
</html>
