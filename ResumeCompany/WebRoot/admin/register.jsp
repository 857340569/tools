<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.awt.*,
java.awt.image.*,java.util.*,javax.imageio.*,java.io.OutputStream"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>职米企业用户注册页面</title>
<base href="<%=basePath%>">
<link href="./js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="./css/base.css" type="text/css" />
<link rel="stylesheet" href="./css/style.css" type="text/css" />
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"language="javascript"></script>
<script language="JavaScript" src="./js/swfobject.js"></script>
<script src="./js/jquery/select-jquery.js" type="text/javascript"
	language="javascript"></script>
<script src="./js/my.placeholder.js" type="text/javascript" language="javascript"></script>
<script src="./js/common.js" type="text/javascript" language="javascript"></script>
<script src="./js/validform/Validform_v5.3.2_min.js"type="text/javascript" language="javascript"></script>
<script src="./js/validform/Validform_more.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="./js/area/data.js"></script>
<link href="./js/area/areaselect.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./js/area/areaselect.js"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<script language="JavaScript" type="text/JavaScript">
	$(function(){
		$(".iselect").iSimulateSelect();
		$("#registerForm").Validform({
			tiptype:2,
			showAllError:true
		});
	});
function check(){
	var checkResult=checkCustom();
	if(!checkResult)
		 return false;
	 else
	 	checkAllOk();
      var data;
      var data1 = $("#pr2").text();
      var data2 = $("#ci2").text();
      var data3 = $("#co2").text();
      if(data3=="-请选择-"){
      	data = data1+data2;
      }else{
      	data = data1+data2+data3;
      }
      $("#provCity").val(data);
      return true;
}
function setError(idName,tips)
{
	 $("#"+idName).attr("class","Validform_wrong");
     $("#"+idName).text(tips);
}
function resetTips(idName,tips)
{
	 $("#"+idName).removeAttr("class");
	 $("#"+idName).attr("class","Validform_right");
     $("#"+idName).text(tips);
}
function checkAllOk(){
	resetTips("proTips","通过信息验证！");
	resetTips("indTips","通过信息验证！");
	resetTips("scaleTips","通过信息验证！");
	resetTips("addressTips","通过信息验证！");
}
function checkSelectAddress()
{
	var isPassed=false;
	 if($("#pr2").text()=="-请选择-")
	 {
	 	setError("addressTips","请选择省份！");
	 	isPassed=false;
	 }
     else
     {
     	if($("#ci2").text()=="-请选择-")
     	{
     	   setError("addressTips","请选择城市！");
           isPassed=false;
     	}
       else
       {	
       		if($("#co2").css("display")!="none")
	        {
	        	$("#addressTips").removeAttr("style");	
	       		if($("#co2").text()=="-请选择-")
	       		{
		     	   setError("addressTips","请选择区域！");
		           isPassed=false;
		     	}
      			else
      			{
      				resetTips("addressTips","通过信息验证！");
      				isPassed=true;
      			}
	        }
	        else
	       	 {
	       	 	$("#addressTips").css("left","-150px");
   				resetTips("addressTips","通过信息验证！");
   				isPassed=true;
      		}	
       	}
     }
     return isPassed;
}
function checkCustom()
{
	var markCount=0;
	if(document.getElementById("properties").selectedIndex==0){
	 		  setError("proTips","请选择企业性质！");
	 		  markCount++;
     }else
     {
     	resetTips("proTips","通过信息验证！");
     }
	if(document.getElementById("industry").selectedIndex==0){
              setError("indTips","请选择企业行业！");
              markCount++;
     }
     else
     {
     	resetTips("indTips","通过信息验证！");
     }
  	 if(document.getElementById("scaleCompany").selectedIndex==0){
  	 		 setError("scaleTips","请选择企业规模！");
             markCount++;
      }
      else
     {
     	resetTips("scaleTips","通过信息验证！");
     }
     var checkAddress=checkSelectAddress();
      if(markCount==0&&checkAddress)
      	return true;
     return false;
}
function showInvitationCompany(obj)
{
	var checkTipCls=$("#invite_tips").attr("class");
	if(checkTipCls.indexOf("Validform_right") != -1)
	{
		$.ajax({
			type : "post",
			async : false,
			dataType:"json",
			url : "ajax!queryInvComName",
			data : {
				"param" : $(obj).val()
			},
			beforeSend : function() {
			},
			success : function(jsondata) {
				var checkResult = jsondata.info;
				alert(checkResult);
			}
		});
	}
}
$(function(){
	var count=0;
	var tipsContent=["请选择企业性质！","请选择企业行业！","请选择企业规模！"];
	
	$(".i_currentselected").each(function(){
// 		$(this).bind("DOMNodeInserted",function(e){
// 			alert($(e.target).html());
// 		});//不支持ie
		$(this).parents("li").attr("id",count);
		$(this).bind("contentchange",function(){
			var tipsDiv=$(this).parents("li").next(".li_tips").find("div");
			var tipsId=tipsDiv.attr("id");
			if($(this).parents("li").find("select").find("option:selected").index()==0)
			{
				setError(tipsId,tipsContent[$(this).parents("li").attr("id")]);
			}else
			{
				resetTips(tipsId,"通过信息验证！");
			}
		});
		count++;
	});
	$(".sel_address").each(function(){
		$(this).bind("contentchange",function(){
			checkSelectAddress();	
		});
	});
});
function isNullOrEmpty(strVal) {
	if (strVal == '' || strVal == null || strVal == undefined) {
		return true;
	} else {
		return false;
	}
}
var isShow = false;
function submitForm(){
	$("input").each(function(){
			$(this).blur();
	});
	$("select").each(function(){
		$(this).blur();
	});
	$("textarea").each(function(){
		$(this).blur();
	});
	var checkInput=check();
	if(isAuth)
	{
		 var urlStr = $("#licenceupdImg").attr("src");
		 if(isNullOrEmpty(urlStr))
		 {
		 	$("#supd_tips").attr("class","Validform_checktip Validform_wrong");
			$("#supd_tips").text("请上传营业执照！");
		 	return;
		 }
	 	 var filePathName = saveLicencePath+urlStr.substring(urlStr.lastIndexOf("/")+1);
	 	 $("#licensePath").val(filePathName);
	 	 $("#authType").val(-1);
	}
	if(checkInput)
	{
		with($("#registerForm"))
		{
			submit();
		}
	}
}
	var saveLicencePath="upload/company/licence/";
  	function smallAsConfig() {
		var param = {
			url : "/badou_upload",
			action : "ajax!flashUploadImg",
			limitSize : 1100,//单位kb,max 2*1024
			dir : saveLicencePath
		};
		return param;
	}
	function smallCallBack(type, data) {
		$("#supd_tips").attr("class","Validform_checktip");
		$("#supd_tips").text("支持jpg/gif/png/jpeg格式");
		switch (type) {
		case -1://禁止上传,超出大小限制
			$("#supd_tips").attr("class","Validform_checktip Validform_wrong");
			$("#supd_tips").text("上传的图片不能超过1M");
			break;
		case 0://开始上传
			$("#updImg_div").html("<label class='tle'>图片上传中</label><br><label id='pro_small' class='prog'>已上传0%</label>");
			// 			resetTips("upd_tips", "图片正在上传中！");
			break;
		case 1://上传进度
			$("#pro_small").text(data);
			break;
		case 2://上传完成
			// 			resetTips("upd_tips", "图片已上传完成！");
			uploaded=true;
			$("#supd_tips").attr("class","Validform_checktip Validform_right");
			$(".btn_div").attr("style","margin-top:290px;");
			$("#supd_tips").text("图片已上传完成！");
			$("#updImg_div").html("<img src='"+data+"' class='licenceupdImg' id='licenceupdImg' >");
			break;
		case -2://上传失败
			// 			setError("upd_tips", data);
			break;
		default:
			break;
		}
	}
	 function showLogoSwf() {
		swfobject.embedSWF("uploadLicense.swf", "licenceswfcontent", "120", "40", "10.0.0",
					 null, null, {wmode: 'transparent'});
	}
	var isAuth=true;
	function doAuthChange(val)
	{
		if(val==0)//选择认证
		{
			isAuth=true;
			$("#uploadLicence").show();
			var urlStr = $("#licenceupdImg").attr("src");
			 if(!isNullOrEmpty(urlStr))
			 {
				$("#licenceSwf").attr("style","margin-top:10px;");
				$(".btn_div").attr("style","margin-top:290px;");
			 }
		}else
		{
			isAuth=false;
			$("#uploadLicence").hide();
			$(".btn_div").attr("style","margin-top:145px;");
		}
	}
</script>

<style type="text/css">
#addressTips{
	position:relative;	
}
.zhanghao {
	width: 100%;
	margin-top: 15px;
	margin-left: 20%;
}

.zhanghao div {
	text-align: left;
}

.title_inputss {
	color: #227fbc;
	font-size: 18px;
	font-weight: bold;
	text-align: left;
}

.title_div {
	margin-top: 10px;
}

ul {
	list-style: none outside none;
	clear: both;
}

ul li {
	height: 34px;
	line-height: 34px;
	font-size: 15px;
	vertical-align: middle;
	margin-bottom: 10px;
}

.li_tips {
	font-size: 12px !important;
	padding-left: 20px;
}

.registInputss {
	width: 100%;
	height: 32px;
	padding-left: 6px;
	line-height: 32px;
}

.li_ul {
	width: 100%;
}

.li_ul li {
	width: 33.3%;
	float: left;
	height: 34px;
	line-height: 34px;
	text-align: center;
	margin-top: 5px;
	vertical-align: middle;
}

.Validform_checktip {
	margin-top: 10px;
}

.btn_div {
	margin-top:145px;
	padding-bottom:150px;
	padding-left: 35%;
}

#submitBtn {
	height: 45px;
	width: 71px;
	background-image: url("images/rg_submit.png");
	border: 0px;
	margin-left: -10%;
}

#cancelBtn {
	height: 45px;
	width: 71px;
	background-image: url("images/rg_cancel.png");
	border: 0px;
	margin-left: 2%;
}

.footer_divs {
	width: 100%;
	height: 32px;
	background: #4680d1;
	position: fixed;
	bottom: 0;
	z-index: 999;
}

.select_city {
	clear: both;
}

.select_city li {
	float: left;
}

.select {
	margin: 0px -4px 0px;
	font-size: 13px;
	padding-top: 4px;
	padding-bottom: 4px;
}

.Validform_checktip {
	margin-left: 20px;
	*margin-left: 20px;
}
/*style for iSimulateSelect*/
.i_selectbox {
	margin-top: 20px;
	height: 32px;
	position: relative;
	font-size: 13px;
}

.i_selectbox .i_currentselected {
	width: 234px;
	height: 32px;
	background: #fff url('images/bg-selectt.png') right center no-repeat;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 10px;
	line-height: 32px;
	cursor: pointer
}

.i_selectbox .i_selectoption {
	overflow-x: hidden;
	overflow-y: auto;
	position: absolute;
	left: -5px;
	top: -2px;
	padding: 5px;
	background-color: #fff;
	background: rgba(255, 255, 255, .9);
	-webkit-box-shadow: -2px 3px 5px rgba(0, 0, 0, .3);
	-moz-box-shadow: -2px 3px 5px rgba(0, 0, 0, .3);
	box-shadow: -2px 3px 5px rgba(0, 0, 0, .3);
	border-radius: 5px;
	-moz-border-radius:5px;
	-webkit-border-radius:5px;
	border-right: 1px solid #eee;
	border-left:1px solid #eee;
}

.i_selectbox .i_selectoption dt {
	height: 24px;
	background-color: #eee;
	text-indent: 5px;
	font-style: italic;
	color: #555;
	line-height: 24px;
}

.i_selectbox .i_selectoption dd {
	height: 30px;
	border-bottom: 1px dashed #ccc;
	cursor: pointer;
	text-indent: 10px;
	line-height: 30px
}

.i_selectbox .i_selectoption dd:hover {
	background-color: #888;
	color: #fff
}

.i_selectbox .i_selectoption dd.selected {
	background-color: #555;
	color: #fff
}

.input_select {
	height: 32px;
	padding-left: 6px;
	font-size: 13px;
	width: 120px;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 2px;
	line-height: 32px;
	background: #fff url('images/bg-selectt.png') right center no-repeat;
	cursor: pointer;
	color: #000000;
	display: inline-block;
	text-align: left;
	overflow: hidden;
	white-space: nowrap;
}
input[type="text"],input[type="password"],textarea{
	border:1px solid #ccc;
	width: 224px;
}
.exeBaseBtn{
		width:150px;
		height:40px;
		line-height:40px;
		vertical-align:middle;
		color:#fff;
		float: left;
		border:none;
		font-size:20px;
		cursor:pointer;
}
.exeRegBtn
{
		background:#4680d1;
		margin-right: 15px;
}
.exeRegBtn:hover{
		background:#6fa1e7;
}
.exeCancelBtn
{
		background:#feb311;
}
.exeCancelBtn:hover{
		background:#ffc954;
}
.licenceupdImg{
	width:280px;
	height:180px;
}
</style>
</head>
<body>
	<form name="registerForm" target="_self" id="registerForm"
		method="post" action="register!register" class="registerForm">
		<div
			style="width: 100%;height:80px;line-height:80px;vertical-align:middle;background: #4680d1;position:fixed;top: 0px;z-index:9980"
			align="center">
			<div style="width: 950px;" align="left">
				<img src="./images/login_title_new.png">
			</div>
		</div>

		<div align="center">
			<div class="div_content"
				style="width: 950px; display: block;position: relative;top:70px"
				align="center">

				<div style="margin: 35px 0px 20px;">
					<font size=4 color="#717171" face="Arial">
						<h2 style="margin-left: 0px">企业会员申请</h2> </font>
				</div>
				<div style="margin-left: 5%;" align="left">注：带*的为必填项</div>
				<div class="zhanghao">
					<div class="title_inputss">账号信息</div>
					<div class="title_div">
						<ul>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>账户名称：</li>
									<li style="width: 25%;margin-left: -3%;" class="li_center">
										<input class="registInputss" type="text" name="company.loginAccount" id="userName"
										ajaxurl="ajax!checkComUserName" datatype="usName"
										nullmsg="用户名不能为空！"
										title="登录系统所使用的帐号名，请务必牢记" autocomplete="off" />
									</li>
									<li
										style="height: 40px;line-height: 40px;text-align: center;vertical-align: middle;width:550px; "><div
											class="Validform_checktip"></div></li>
								</ul>
							</li>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>账户密码：</li>
									<li style="width: 25%;margin-left: -3%;"><input
										class="registInputss" type="password" name="company.loginPassword"
										id="password1" datatype="*6-15" nullmsg="请设置密码！"
										errormsg="密码范围在6到15位之间！" autocomplete="off" ></li>
									<li><div class="Validform_checktip"></div></li>
								</ul>
							</li>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>确认密码：</li>
									<li style="width: 25%;margin-left: -3%;"><input
										class="registInputss" type="password" 
										name="password2" id="password2" datatype="*6-15"
										nullmsg="请再次输入密码！" errormsg="两次密码不一致！" recheck="company.loginPassword"
										autocomplete="off"></li>
									<li><div class="Validform_checktip"></div></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div style="height: 25px;"></div>
				<div class="zhanghao">
					<div class="title_inputss" spellcheck="false">企业信息</div>
					<div class="title_div">
						<ul>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>企业名称：</li>
									<li style="width: 25%;margin-left: -3%;"><input
										class="registInputss" type="text" name="company.name"
										id="companyName" ajaxurl="ajax!checkCompanyName"
										datatype="*2-20" nullmsg="公司名称不能为空！" errormsg="公司名称在2到20字符之间！"
										title="公司名称注册成功后不可以修改！"></li>
									<li><div class="Validform_checktip"></div></li>
								</ul>
							</li>

							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>企业性质：</li>
									<li style="width: 25%;margin-left: -3%;margin-top: -16px;">
										<select class="iselect" id="properties" name="company.nature">
											<option value="" style="color: #a9a9a9;">请选择企业性质</option>
											<option value="私营企业">私营企业</option>
											<option value="民营企业">民营企业</option>
											<option value="国有企业">国有企业</option>
											<option value="港资企业">港资企业</option>
											<option value="台资企业">台资企业</option>
											<option value="日资企业">日资企业</option>
											<option value="韩资企业">韩资企业</option>
											<option value="欧美企业">欧美企业</option>
											<option value="中外合资">中外合资</option>
											<option value="其它">其它</option>
									</select>
									</li>
									<li class="li_tips"><div class="Validform_checktip"
											id="proTips"></div></li>
								</ul>
							</li>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>企业行业：</li>
									<li style="width: 25%;margin-left: -3%;margin-top: -16px;">
										<select name="company.industry" class="iselect" id="industry">
											<option value="" style="color: #a9a9a9;">请选择企业行业</option>
											<option value="服务业">服务业</option>
											<option value="制造业">制造业</option>
											<option value="其他行业">其他行业</option>
									</select>
									</li>
									<li class="li_tips"><div class="Validform_checktip"
											id="indTips"></div></li>
								</ul>
							</li>
							<li class="li_ul">
								<ul class="select_option">
									<li style="width: 20%;"><span>*</span>企业规模：</li>
									<li style="width: 25%;margin-left: -3%;margin-top: -16px;">
										<select id="scaleCompany" class="iselect" name="company.scale">
											<option value="" style="color: #a9a9a9;">请选择企业规模</option>
											<option value="1-50人">1-50人</option>
											<option value="50-100人">50-100人</option>
											<option value="100-500人">100-500人</option>
											<option value="500人以上">500人以上</option>
									</select>
									</li>
									<li class="li_tips"><div class="Validform_checktip"
											id="scaleTips"></div></li>
								</ul>
							</li>
							<li class="li_ul" style="height:90px;">
								<ul class="select_option">
									<li style="width: 20%;"><span>*</span>企业简介：</li>
									<li  style="width:355px;margin-left:-2.6%;*margin-left:-2.4%;">
										<textarea name="company.description" class="registInputss" style="height:140px;width:350px;" datatype="*2-4000" nullmsg="企业简介不能为空！" errormsg="企业简介在2到4000字符之间！" ></textarea>
									</li>
									<li class="li_tips" style="padding-left: 0px;"><div class="Validform_checktip" ></div></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div style="height: 25px;"></div>
				<div class="zhanghao">
					<div class="title_inputss">联系方式</div>
					<div class="title_div">
						<ul>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>联系人：&nbsp;&nbsp;</li>
									<li style="width: 25%;margin-left: -3%;"><input
										class="registInputss" type="text" name="company.linkman"
										id="linkman" datatype="*2-8" nullmsg="请输入联系人姓名！" errormsg="联系人姓名应在2～8个字符之间！"></li>
									<li><div class="Validform_checktip"></div></li>
								</ul>
							</li>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>联系电话：</li>
									<li style="width: 25%;margin-left: -3%;"><input
										class="registInputss" type="text" name="company.contactWay"
										id="telephone" datatype="m|tel" nullmsg="请输入联系电话！"></li>
									<li><div class="Validform_checktip">如是座机请在区号后加“-”例：0512-88888888</div></li>
								</ul>
							</li>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>邮箱地址：</li>
									<li style="width: 25%;margin-left: -3%;"><input
										class="registInputss" type="text" name="company.email" id="mailbox"
										datatype="e" errormsg="请填写正确的邮箱地址！"
										title="用于找回密码操作，请保证填写邮箱真实有效" nullmsg="邮箱地址不能为空！" ></li>
									<li><div class="Validform_checktip"></div></li>
								</ul>
							</li>
						</ul>
						</ul>
					</div>
				</div>
				<div style="height: 25px;"></div>
				<div class="zhanghao">
					<div class="title_inputss">企业地址<span style="margin-left: 10px; color:#ffc954;" class="Validform_checktip">为保证定位准确请填写真实详细地址!</span></div>
					<div class="title_div">
						<ul>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>企业地址：</li>
									<li
										style="width: 44%;margin-left: -3.2%;margin-top: -2px;*margin-top: -2px;">
										<ul class="select_city">
											<li style="width: 33%;"><span id="pr2" type="text"
												class="input_select sel_address"
												style="*margin-left: -4.0%; margin-left:-3.8%; width: 120px;"
												name="seachprov">-请选择-</span>
											</li>
											<li style="width: 33%;"><span id="ci2" type="text"
												class="input_select sel_address" name="seachcity">-请选择-</span>
											</li>
											<li style="width: 33%;"><span id="co2" type="text"
												class="input_select sel_address" name="seachdistrict">-请选择-</span>
											</li>
										</ul>
									</li>
									<li class="li_tips"><div class="Validform_checktip"
											id="addressTips"></div></li>
								</ul>
							</li>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>详细地址：</li>
									<li style="width: 25%;margin-left: -3.2%;*margin-left: -2.8%;"><input
										class="registInputss" type="text" name="addrDetail" id="address"
										datatype="*3-200" nullmsg="地址不能为空！" errormsg="公司地址在3到200字符之间！">
									</li>
									<li><div class="Validform_checktip"></div></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div style="height: 25px;"></div>
				<div class="zhanghao">
					<div class="title_inputss">资格认证</div>
					<div class="title_div">
						<ul>
							<li class="li_ul">
								<ul>
									<li style="width: 20%;"><span>*</span>是否认证：</li>
									<li style="width: 25%;margin-left: -10.2%;*margin-left: -9.8%;">
										<label for="agreeAuth" hideFocus="true"><input id="agreeAuth"  name="authCheck" type="radio" checked="checked" value="0" onclick="doAuthChange(this.value)">是</label>&nbsp;&nbsp;
		    							<label for="disagreeAuth" hideFocus="true"><input id="disagreeAuth" name="authCheck" type="radio" value="1"  onclick="doAuthChange(this.value)">否</label>
									</li>
									<li><div class="Validform_checktip"></div></li>
								</ul>
								<ul id="uploadLicence">
									<li style="width: 20%;"><span>*</span>营业执照：</li>
									<li style="width: 30%;margin-left: -3.2%;*margin-left: -2.8%;">
										<div id="dialogContent">
											<div id="updImg_div">
											</div>
											<div id="licenceSwf">
												<div><span id='licenceswfcontent'>
													<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
														codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0"
														WIDTH="120" HEIGHT="40" id="myMovieName">
														<PARAM NAME=movie VALUE="uploadLicense.swf">
														<PARAM NAME=quality VALUE=high>
														<PARAM NAME=bgcolor VALUE=#FFFFFF>
														<EMBED src="uploadLicense.swf" quality=high bgcolor=#FFFFFF WIDTH="120"
															HEIGHT="40" wmode="transparent"
															NAME="myMovieName" ALIGN="" TYPE="application/x-shockwave-flash"
															allowScriptAccess="always"
															PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">
														</EMBED>
														</OBJECT>
												</span></div>
											</div>
										</div>
									</li>
									<li><div class="Validform_checktip" id="supd_tips"></div></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div class="btn_div">
					<input type="button" class="exeBaseBtn exeRegBtn" value="注&nbsp;册" onclick="submitForm()"> <input
						type="button" class="exeBaseBtn exeCancelBtn" value="重&nbsp;置"
						onclick="javascript:history.go(-1)">
				</div>
			</div>
		</div>
		<input type="hidden" name="provCity" id="provCity">
		<input type="hidden" name="company.authType" value="0" id="authType">
		<input type="hidden" name="company.license" id="licensePath">
		<div class="footer_divs"></div>
	
		<script type="text/javascript">
            new locationCard({
                ids: ['pr2', 'ci2', 'co2']
            }).init();
        </script>
	</form>

</body>
</html>