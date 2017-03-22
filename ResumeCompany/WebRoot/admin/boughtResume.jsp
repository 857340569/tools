<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/My97DatePicker/WdatePicker.js" type="text/javascript" language="javascript"></script>
<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<link href="./css/informa-tip.css" rel="stylesheet" type="text/css">
<title>公共简历库-职米</title>
<style type="text/css">
.span_nubenr b {
	color: #ee2200
}
.account{
	font-weight: bold;
	font-size: 16px;
	font-size:16px;
	font-family: sans-serif;
	color:#ffb137;
}
body {
	background-color: #ffffff;
	margin-left: 10px
}
#tipdivs{
	left:150px;
}
#talentstable{
	left:200px;
	width: 455px;
	word-break:break-all;
}
#tipdivs{
	font-size:14px;
}
#tipdivs input{
	font-size:15px;
}
.show_com_content{
	float:left;
	width: 42%;
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
.show_job_content{
	float:left;
	width: 29%;
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
.show_com_content:hover,.show_job_content:hover{
	background: #4b8af6;
	color:#fff;
}
</style>
<script type="text/javascript">
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
	//判断网页是否加载完成  
	document.onreadystatechange = function() {
		if (document.readyState == "complete") {
			window.parent.loadCompleted();
		}
	}
	//弹出
	function treatments(uName,sex) {
	   if("${comType}"=="0")
		{
			comId="${id}";
			comName="${name}";
		}
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
	}
	var msgContent="";
	//弹出，确定按钮
	function sureTipButton(userName) {
		if ($.trim($("#companyName").val())== "") {
			alert("请选择招骋公司！");
			return false;
		}
		if ($.trim($("#informtimes").val()) == "") {
			alert("请填写面试时间！");
			return false;
		}
		if ($.trim($("#tipAddress").val()) == "") {
			alert("请填写面试地点！");
			return false;
		}
		if ($.trim($("#jobName").val()) == "") {
			alert("请选择招骋职位！");
			return false;
		}
		msgContent="&&您非常符合我们招聘"+$("#jobName").val()+"的要求，请您于"+$("#informtimes").val()+"到"+$("#tipAddress").val()+"参加面试，一定要来哟！";
		return true;
	}
	//关闭弹出框
	function closeTipdiv() {
		$(".tipdiv").css("display", "none");

	}
	// 判断网页是否加载完成  
      document.onreadystatechange = function () {   
          if(document.readyState=="complete") {         
              window.parent.loadCompleted();   
          }  
      };
      var comId="-1";
      var comName="";
      var jobId="-1";
      var jobName="";
      function notifyUser(uName,userName,sex,deviceType)
      {
      	treatments(uName,sex);
      	$("#sendToUserBtn").unbind("click");	
      	$("#sendToUserBtn").click(function(){
      		var checkInput=sureTipButton(uName);
      		if(checkInput)
      		{
				if (confirm("通知后将不能取消,确定要发送通知吗?")) {
					$.ajax({
						type:"post",
						async:false,
						url:"push!notifyResumeUser",
						dataType:"json",
						data:{
							"company.id":parseInt(comId),
							"company.name":comName,
							"job.id":parseInt(jobId),
							"pushMessage.msgContent":msgContent,
							"user.userName":userName,
							"user.deviceType":parseInt(deviceType)
						},
						success:function(jsondata){
							closeTipdiv();
							if(jsondata.type=="y")
							{
							}
							alert(jsondata.message);
						},
						error:function()
						{
							alert("系统内部错误，请刷新后重试！");
						}
					
					});
				}
      		}
      	});	
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
				comName=$(this).attr("title");
				var comNameTemp=$(this).attr("title");
				if(comNameTemp.length>10)
				{
					comNameTemp=comNameTemp.substring(0,10)+"...";
				}
				$("#companyName").val(comNameTemp);
				$("#jobName").val("");//清空之前选择的职位
				comId=$(this).attr("id");
				comIsChanged=true;
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
		if(timeoutEvent!=undefined)
			clearTimeout(timeoutEvent);
		var dialogDisStatus=$("#data_option_dialog").css("display");
		if(dialogDisStatus!="none")
		{
			$("#data_option_dialog").slideUp(300);
			return;
		}
		if(contentHtml!="")
		{
			checkShow(1);
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
				var contentTemp="";
				if(jsondata.companies.length<=0)
				{
					comIsPassed=false;
// 					alert("您还没有发布任何企业,请先在<<企业管理>>中发布！");
					contentTemp="您还没有发布任何企业,立即<a href='./admin/hr/addComMain.jsp'>添加</a>！";
					$("#op_dia_content").html("<span style='font-size:14px;'>"+contentTemp+"</span>");
				}else{
					totalPageCount=jsondata.totalPageCount;
					contentHtml="<ul>";
					for(var i=0;i<jsondata.companies.length;i++)
					{
						var comName=jsondata.companies[i].name;
						if(comName.length>9)
						{
							comName=comName.substring(0,7)+"...";
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
				checkShow(1);
				$("#data_option_dialog").slideDown(300);
			},
			error:function(jsondata)
			{
				comIsPassed=false;
				alert("系统内部错误，请刷新后重试！");
			}
		});
	}
	var timeoutEvent;
	function checkOptionClose()
	{
		timeoutEvent=setTimeout(function(){
			if(isLeave)
			{
				$("#data_option_dialog").slideUp(300);
			}
		},300);
	}
	
	
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
				jobName=$.trim($(this).text());
				$("#jobName").val(jobName);
				jobId=$(this).attr("id");
				$("#job_data_option_dialog").slideUp(300);
			});
		});
	}
	var jobCurrentPage=1;
	var jobPageSize=15;
	var jobTotalPageCount=0;
	var jobIsPassed=false;
	var jobContentHtml="";
	var comIsChanged=true;
	function showJobOptionDialog(){
		if(jobTimeoutEvent!=undefined)
			clearTimeout(jobTimeoutEvent);
		var dialogDisStatus=$("#job_data_option_dialog").css("display");
		if(dialogDisStatus!="none")
		{
			$("#job_data_option_dialog").slideUp(300);
			return;
		}
// 		if(jobContentHtml!="")
		if(!comIsChanged)
		{
			checkShow(2);
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
		if(comId=="-1")
		{
			contentTemp="您还没有选择招聘企业，请先选择！";
			$("#job_op_dia_content").html("<span style='font-size:14px;'>"+contentTemp+"</span>");
			checkShow(2);
			$("#job_data_option_dialog").slideDown(300);
			return;
		}
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"job!queryComJobs",
			data:{
				"company.id":comId,
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
						jobContentHtml+="<li class='show_job_content' id='"+jsondata.jobs[i].id+"'>"+jsondata.jobs[i].category+"</li>";
					}
					jobContentHtml+="</ul>";
					$("#job_op_dia_content").html(jobContentHtml);
					reloadJobDataEvent();
					comIsPassed=false;
					if(totalPageCount>1){
						$("#job_op_dia_footer").show();
					}
				}
				comIsChanged=false;
				checkShow(2);
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
		if("${comType}"=="1")
		{
			$("#data_option_dialog").mouseleave(function(){
				isLeave=true;
				$("#data_option_dialog").slideUp(300);
				if(timeoutEvent!=undefined)
					clearTimeout(timeoutEvent);
			});
			$("#data_option_dialog").mouseenter(function(){
				isLeave=false;
			});
		}
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
	function checkShow(currentIndex){
		if(currentIndex==1)
		{
			var jobIsShow=$("#job_data_option_dialog").css("display");
			if(jobIsShow!="none")
			{
				$("#job_data_option_dialog").hide();
			}
		}else if(currentIndex==2)
		{
			var comIsShow=$("#data_option_dialog").css("display");
			if(comIsShow!="none")
			{
				$("#data_option_dialog").hide();
			}
		}
		
	}
</script>
</head>
<body>
	<div style="position: relative;">
			<div class="tipdiv" id="tipdivs" style="background: url('./images/invite.png') no-repeat;display:none;">
				<div id="inbg">
					<div id="talentstable" align="left">
						<ul>
							<li style="height: 25px;"><font color="#000000">尊敬的<font
									class="sendName"></font><span class="sexSpan"></span> </font>
							</li>
							<li><font color="#000" style="line-height:30px;"
								class="font_input"> &nbsp;&nbsp;您好，我们很高兴的通知您,<span style="position:relative;display:inline;"><input
									type="text" value="${session.companyName}" name="company.cname"  readonly="true" <c:if test="${comType ==1}">onclick="showOptionDialog();" onblur="checkOptionClose()"; </c:if>
									id="companyName" class="companyName" style="height: 23px;">
										 <c:if test="${comType ==1}">
											<div id="data_option_dialog" style="display:none;position:absolute;left:4px;top:39px;z-index: 10000;border:1px solid #9d9d9d;height:210px;width:400px;background:#fff; ">
												<div style="padding:5px 10px;">
													<div style="float: left;">请选择公司:</div><div style="float:right;cursor:pointer;" onclick="$('#data_option_dialog').slideUp(300);"><img title="关闭" alt="关闭" src="./images/remove.png"></div>
												</div>
												<div style="padding:5px 20px;height:130px;margin-top:10px;clear: both;" id="op_dia_content">
												</div>
												<div id="op_dia_footer" style="text-align: right;padding-right:10px;display:none;" class="page_a">
													<<<a href="javascript:prePage();">上一页</a>&nbsp;|&nbsp;<a href="javascript:nextPage();">下一页</a>>>
												</div>
											</div>
										 </c:if>
									</span>诚邀您于
									<input type="text" name="time" id="informtimes"
									class="informtimes" style="height: 23px;" value="">(时间)到 <input type="text" name="address" id="tipAddress"
									style="height: 23px;" class="tipAddress" value="">(地点)<span id="whatDo">面试</span>
									<span style="position: relative;">
										<input type="text" value=" " name="job.jobName" id="jobName" class="jobName" style="height: 23px;" readonly="true" onclick="showJobOptionDialog();" onblur="checkJobOptionClose()";>
										<div id="job_data_option_dialog" style="display:none;position:absolute;left:4px;top:39px;z-index: 10000;border:1px solid #9d9d9d;height:210px;width:400px;background:#fff; ">
											<div style="padding:5px 10px;">
												<div style="float: left;">请选择职位:</div><div style="float:right;cursor:pointer;" onclick="$('#job_data_option_dialog').slideUp(300);"><img title="关闭" alt="关闭" src="./images/remove.png"></div>
											</div>
											<div style="padding:5px 20px;height:130px;margin-top:10px;clear: both;" id="job_op_dia_content">
											</div>
											<div id="job_op_dia_footer" style="text-align: right;padding-right:10px;display:none;" class="page_a">
												<<<a href="javascript:preJobPage();">上一页</a>&nbsp;|&nbsp;<a href="javascript:nextJobPage();">下一页</a>>>
											</div>
										</div>
									</span>
									<span class="showJob">(职位)</span>。 
								</font>
							</li>
							<li class="liButton"><input type="button" value="确定" id="sendToUserBtn"/> <input type="button" value="取消"
								onclick="closeTipdiv();" />
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	<div style="float:right;padding-right:15px;height:30px;line-height:30px;">*说明：--表示该项信息用户未填写。</div>
	<form name="userForm" id="userForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="float: left;">
			<tr>
				<td height="215" valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="215" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr align="center" class="dataTittleBg">
										<td>姓名</td>
										<td>性别</td>
										<td>出生年月</td>
										<td>手机号</td>
										<td>现居地</td>
										<td>目前工作状态</td>
										<td>操作</td>
									</tr>
									<c:if test="${empty divPage.dataMap['boughtResumes']}">
										<tr align="center">
											<td height="35" class="rd8" colspan="7"><font
												color="red">
													暂无购买的简历
<!-- 												<span style="font-size:14px; "> -->
<!-- 													即将开放 敬请等待   如在使用中遇到任何问题或意见，请反馈至 电话：0512-89990082  邮箱：fuwu@91zhimi.com  感谢您的信任！ -->
<!-- 													--职米Family -->
<!-- 												</span> -->
												</font>
											</td>
										</tr>
									</c:if>
									<c:forEach items="${divPage.dataMap['boughtResumes']}"
										var="boughtResume" varStatus="status">
										<tr align="center" id="${status.count}" height="29"
											onmouseover="this.style.background='#eeeeee'"
											onmouseout="this.style.background=''">
											<c:choose>
												<c:when test="${!empty divPage.entitysMap[boughtResume.id]&&!empty divPage.dataMap['users'][boughtResume.resumeId]}">
													<td align="center" class="r8 useName">
														${divPage.dataMap['users'][boughtResume.resumeId].name}
													</td>
													<td align="center" class="r8"><c:out
															value="${divPage.dataMap['users'][boughtResume.resumeId].sex}" />
													</td>
													<td align="center" class="r8"><c:out
															value="${divPage.dataMap['users'][boughtResume.resumeId].birth}" />
													</td>
													<td align="center" class="r8">
														${divPage.dataMap['users'][boughtResume.resumeId].phone}
													</td>
													<td align="center" class="r8"><c:out
															value="${divPage.dataMap['users'][boughtResume.resumeId].birthplace}" />
													</td>
													<td align="center" class="r8" style="width: 15%;">
															<c:choose>
																<c:when test="${!empty divPage.entitysMap[boughtResume.id].currentState}">
																	<c:if test="${divPage.entitysMap[boughtResume.id].currentState eq '0'}">
																		离职中，马上可以上岗 
																	</c:if>
																	<c:if test="${divPage.entitysMap[boughtResume.id].currentState eq '1'}">
																		任职中，想换个工作环境
																	</c:if>
																	<c:if test="${divPage.entitysMap[boughtResume.id].currentState eq '2'}">
																		目前暂无换工作打算
																	</c:if>
																</c:when>
																<c:otherwise>
																	--
																</c:otherwise>
															</c:choose>
													</td>
													<td align="center">
														<a href="resume!queryResumeById?resume.id=${boughtResume.resumeId}"
															target="mainFrame"><span class="last_exe_btn_common last_exe_btn_other">查看</span></a>
														<a title="点击发送通知消息" href="javascript:notifyUser('${divPage.dataMap['users'][boughtResume.resumeId].name}','${divPage.dataMap['users'][boughtResume.resumeId].userName}','${divPage.dataMap['users'][boughtResume.resumeId].sex}','${divPage.dataMap['users'][boughtResume.resumeId].deviceType}');">
															<span class="last_exe_btn_common last_exe_btn_valid" title="邀请该用户前来面试">面试</span>
														</a>
														<a href="resume!deleteBoughtResume?boughtResume.id=${boughtResume.id}" onclick="return confirm('删除后将无法恢复,确定要删除吗?')">
															<span class=" last_exe_btn_common last_exe_btn_valid">删除</span>
														 </a>
												</td>
												</c:when>
												<c:otherwise>
													<td colspan="6">该简历已被删除</td>
													<td>
														<span class="last_exe_btn_common last_exe_btn_invalid" title="该简历已被删除">查看</span>
														<span class=" last_exe_btn_common last_exe_btn_invalid" title="该简历已被删除">面试</span>
														<a href="resume!deleteBoughtResume?boughtResume.id=${boughtResume.id}" onclick="return confirm('删除后将无法恢复,确定要删除吗?')">
															<span class=" last_exe_btn_common last_exe_btn_valid">删除</span>
														</a>
													</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</table>
								<div class="r8">
									<jsp:include page="page.jsp">
										<jsp:param name="url" value="resume!queryAllBtRecords" />
									</jsp:include>
								</div></td>
						</tr>
					</table>
		</table>
	</form>
</body>
</html>