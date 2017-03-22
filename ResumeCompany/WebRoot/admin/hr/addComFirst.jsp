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
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增公司</title>
<link rel="stylesheet" href="./css/style.css" type="text/css"
	media="all" />
<link rel="stylesheet" href="./css/base.css" type="text/css" />
<link rel="stylesheet" href="./css/common.css" type="text/css" />
<link href="./js/validform/validform_style.css" type="text/css"
	rel="stylesheet" />
<link href="./js/area/areaselect.css" type="text/css" rel="stylesheet" />
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"
	language="javascript"></script>
<script src="./js/validform/Validform_v5.3.2_min.js"
	type="text/javascript" language="javascript"></script>
<script src="./js/validform/Validform_more.js" type="text/javascript"
	language="javascript"></script>
<script type="text/javascript" src="./js/area/data.js"></script>
<script type="text/javascript" src="./js/area/areaselect.js"></script>
<script src="./js/jquery/select-jquery.js" type="text/javascript"
	language="javascript"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<script type="text/javascript">
// 	window.onbeforeunload = function(){
// 		return "企业信息尚未保存,离开后将无法找回!";
//   	}
	$(function() {
		$(".iselect").iSimulateSelect();
		$("#companyForm").Validform({
			tiptype : 2,
			showAllError : true
		});
	});
	var data="";
	function checkData() {
	 	data="";
		var checkResult = checkCustom();
		if (!checkResult)
			return false;
		else
			checkAllOk();
		
		var data1 = $("#pr2").text();
		var data2 = $("#ci2").text();
		var data3 = $("#co2").text();
		if (data3 == "-请选择-") {
			data = data1 + data2;
		} else {
			data = data1 + data2 + data3;
		}
		return true;
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
		resetTips("proTips", "通过信息验证！");
		resetTips("scaleTips", "通过信息验证！");
		resetTips("indTips", "通过信息验证！");
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
			$("#addressTips").css("left","-222px");
		if(count==3)
			$("#addressTips").css("left","-130px");
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
					$("#addressTips").css("left","-232px");
				}
			}
		}
		return isPassed;
	}
	function checkCustom() {
		var markCount = 0;
		if (document.getElementById("properties").selectedIndex == 0) {
			setError("proTips", "请选择企业性质！");
			markCount++;
		} else {
			resetTips("proTips", "通过信息验证！");
		}
		if (document.getElementById("industry").selectedIndex == 0) {
			setError("indTips", "请选择企业行业！");
			markCount++;
		} else {
			resetTips("indTips", "通过信息验证！");
		}
		if (document.getElementById("scaleCompany").selectedIndex == 0) {
			setError("scaleTips", "请选择企业规模！");
			markCount++;
		} else {
			resetTips("scaleTips", "通过信息验证！");
		}
		
		var checkAddress = checkSelectAddress();
		if (markCount == 0 && checkAddress)
			return true;
		return false;
	}
	$(function() {
		var count = 0;
		var tipsContent = [ "请选择企业性质！", "请选择企业行业！", "请选择企业规模！" ];

		$(".i_currentselected").each(function() {
			$(this).parents("td").attr("id", count);
			$(this).bind("contentchange",function() {
				var tipsDiv = $(this).parents("td").next("td").find("div");
				var tipsId = tipsDiv.attr("id");
				if ($(this).parents("td").find("select").find("option:selected").index() == 0) {
					setError(tipsId, tipsContent[$(this).parents("td").attr("id")]);
				} else {
					resetTips(tipsId, "通过信息验证！");
				}
			});
			count++;
		});
		$(".sel_address").each(function() {
			$(this).bind("contentchange", function() {
				checkSelectAddress();
			});
		});
	});
	function formSubmit(){
		$("input").each(function(){
			$(this).blur();
		});
		$("select").each(function(){
			$(this).blur();
		});
		$("textarea").each(function(){
			$(this).blur();
		});
		var count = 0;
		var dataHtml="";
		if($("#hd_da_ta").length==0)
		{
			$("form").append("<div id='hd_da_ta'></div>");
		}
		var checkDataResult=checkData();
		if(!checkDataResult)
			return;
		dataHtml+=inputHiddenHtml("provCity",data);
		$("#hd_da_ta").html(dataHtml);
		with($("#companyForm"))
		{
			submit();
		}
	}
	
	function inputHiddenHtml(nameStr,valueStr){
		return "<input type='hidden' name='"+nameStr+"' value='"+valueStr+"'/>";
	}
</script>
<style type="text/css">
body{
	padding-top:10px;
	padding-left:10px; 
}
/*style for iSimulateSelect*/
.i_selectbox {
	margin-top: 15px;
	height: 20px;
	position: relative;
	font-size: 13px;
	left: 3px;
}

.i_selectbox .i_currentselected {
	width:103%;
	height: 30px;
	background: #fff url('images/bg-selectt.png') right center no-repeat;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 10px;
	line-height: 30px;
	cursor: pointer;
	top: -15px;
	position: relative;
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
	border-right: 1px solid #eee
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
	height: 30px;
	padding-left: 6px;
	font-size: 13px;
	width: 100px;
	border: 1px solid #cccccc;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	text-indent: 2px;
	line-height: 30px;
	background: #fff url('images/bg-selectt.png') right center no-repeat;
	cursor: pointer;
	color: #000000;
	display: inline-block;
	text-align: left;
	overflow:hidden;
}

* {
	margin: 0;
	padding: 0;
}

.li_tips {
	font-size: 12px !important;
	padding-left: 10px;
}

.td_select {
	width: 230px;
}

.lefttd {
	width: 160px;
	height: 45px;
	font-size: 14px;
	text-align: center;
}

ul,ol {
	list-style: none outside none;
}
#addressTips{
	position: relative;
}
input,textarea {
	border:1px solid #ccc;
}
</style>
</head>
<body>
	<form name="companyForm" target="_self" method="post" class="company"
		action="company!addCom" id="companyForm"> 
		<table width="100%" style="table-layout:fixed;" border="0"
			cellspacing="2" cellpadding="2">
			<tr>
				<td class="lefttd" style="width:150px; height:32px"><font
					class="releaseJob_need">*</font> 企业名称：</td>
				<td style="width:245px;"><input type="text" name="company.name"
					class="inp006" datatype="*2-18" nullmsg="公司名称不能为空！"
					ajaxurl="ajax!checkCompanyName" errormsg="公司名称至少2个字符,最多18个字符！" /></td>
				<td style="width:230px;"><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;登录账号：</td>
				<td><input type="text" value="" name="company.loginAccount"
					class="inp006" ajaxurl="ajax!checkComUserName" datatype="s2-18"
					nullmsg="请输入登录名称！" errormsg="登录名称至少2个字符,最多18个字符！" />
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font> 登录密码：</td>
				<td><input type="password" value=""
					name="company.loginPassword" class="inp006" datatype="*6-16"
					nullmsg="请输入用户密码！" errormsg="密码范围在6~16位之间！" autocomplete="off" />
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;企业性质：</td>
				<td class="td_select"><select class="iselect" id="properties"
					name="company.nature" datatype="*" nullmsg="请选择出公司性质！"
					errormsg="请选择公司性质！">
						<option value="">-请选择-</option>
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
				</select></td>
				<td><div id="proTips" class="Validform_checktip"></div></td>

			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;所属行业：</td>
				<td class="td_select"><select class="iselect" id="industry"
					name="company.industry" datatype="*" nullmsg="请选择企业所属行业！"
					errormsg="请选择企业所属行业！">
						<option value="">-请选择-</option>
						<option value="服务业">服务业</option>
						<option value="制造业">制造业</option>
						<option value="其他行业">其他行业</option>
				</select></td>
				<td><div id="indTips" class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;企业规模：</td>
				<td class="td_select"><select name="company.scale"
					class="iselect" id="scaleCompany" datatype="*" nullmsg="请选择企业规模！"
					errormsg="请选择企业规模！">
						<option value="">-请选择-</option>
						<option value="10-50人">10-50人</option>
						<option value="50-100人">50-100人</option>
						<option value="100-500人">100-500人</option>
						<option value="500人以上">500人以上</option>
				</select>
				</td>
				<td><div id="scaleTips" class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;联系人：</td>
				<td><input type="text" name="company.linkman" class="inp006"  datatype="*2-8" nullmsg="请输入联系人姓名！" errormsg="联系人姓名应在2～8个字符之间！"/>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;联系电话：</td>
				<td><input type="text" name="company.contactWay" class="inp006" nullmsg="联系电话不能为空！"
					datatype="m|tel"/>
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd">电子邮箱：</td>
				<td><input type="text" name="company.email" id="mailbox"
					class="inp006" datatype="e" nullmsg="电子邮箱不能为空！" ignore="ignore"
					errormsg="输入的邮箱格式不正确！" />
				</td>
				<td><div class="Validform_checktip"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font> 企业地址：</td>
				<td colspan="2"><span id="pr2" class="input_select sel_address"
					style="*margin-left: 3px;width: 100px; margin-left: 3px;"
					name="seachprov">-请选择-</span> <span id="ci2" type="text"
					class="input_select sel_address" name="seachcity">-请选择-</span> <span
					id="co2" class="input_select sel_address" name="seachdistrict">-请选择-</span>
				</td>
				<td class="li_tips" colspan="1" style="padding-left: 0px;"><div
						class="Validform_checktip" id="addressTips"></div></td>
			</tr>
			<tr>
				<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;详细地址：</td>
				<td><input type="text" value="" name="company.address"
					class="inp006" datatype="*3-200" nullmsg="地址不能为空！"
					errormsg="详细地址在3到200字符之间！" />
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
			<tr>
				<td class="lefttd" height="28px">公司介绍：</td>
				<td colspan="2"><textarea name="company.description" datatype="*3-1000" style="margin-left: 4px;" ignore="ignore"
					errormsg="公司介绍应在3到1000字符之间！
						class="seachTextarea"></textarea>
				</td>
				<td><div class="Validform_checktip"></div></td>
			</tr>
				<td class="lefttd" height="20px" style="background-color: #ffffff;">&nbsp;</td>
				<td colspan="3"><span id="led_img_sn"> </span> <span id="flsu"
					class="flstyle" style="margin-left:4px;"> </span></td>
			</tr>
			<tr>
				<td colspan="4" align="center" style="padding-left: 100px;">
					<input type="button" style="margin-top:20px; " value="下一步" class="exeCommonBtn" onclick="formSubmit();"/>
				</td>
			</tr>
		</table>
		<script type="text/javascript">
			new locationCard({
				ids : [ 'pr2', 'ci2', 'co2' ]
			}).init();
		</script>

	</form>

	<iframe id="childframe" src="" width="0" height="0"></iframe>
</body>
</html>