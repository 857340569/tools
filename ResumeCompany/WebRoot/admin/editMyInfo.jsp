<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.awt.*,
java.awt.image.*,java.util.*,javax.imageio.*,java.io.OutputStream"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业用户修改页面</title>
<base href="<%=basePath%>">
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/style.css" type="text/css"
	media="all" />
<link rel="stylesheet" href="./css/base.css" type="text/css"  />
<link rel="stylesheet" href="./js/flash_upload/flash_upl.css" type="text/css"  />
<script language="JavaScript" src="./js/flash_upload/upload.js"></script>
<script language="JavaScript" src="./js/swfobject.js"></script>
<script language="JavaScript" src="./js/common.js"></script>
<link href="./js/validform/validform_style.css" type="text/css" rel="stylesheet" />
<script src="./js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>
<script src="./js/validform/Validform_more.js" type="text/javascript" language="javascript"></script>
<link href="./js/myselect/myselect-v.1.0.0.css" rel="stylesheet" type="text/css"  />
<script src="./js/myselect/myselect-v.1.0.0.js" type="text/javascript" language="javascript"></script>
<script language="JavaScript" type="text/JavaScript">
	var uploaded=false;
	var changedLogo=false;
	var comId="";
	if("${comType}"=="0")
	{
		comId="${id}";
	}else if("${comType}"=="1")
	{
		comId="${company.id}";
	}
	var saveLogoPath="upload/company/"+comId+"/logo/";
	var saveComImgPath="upload/company/"+comId+"/images/";
	$(function() {
		initFlashUpload(saveComImgPath,true);
		$("#updateInfo").Validform({
			tiptype :2,
			showAllError : true
		});
		/*
		上传图片
		*/
      	 bindChangeLogoEvent();
      	 window.parent.setTitle("资料编辑");
      	 showLogoSwf();
      	 mySelectInit();
		 mySelectResize();
		 window.parent.mainTop();
	});
	function bindChangeLogoEvent()
	{
		 $("#imgDiv").mouseover(function(){
      	 	$("#changeLogoDiv").show();
      	 });
     	  $("#changeLogoDiv").mouseout(function(){
     	 	 $(this).hide();
     	 });
	}
	function unbindChangeLogoEvent()
	{
		 $("#imgDiv").unbind("mouseover");
     	 $("#changeLogoDiv").unbind("mouseout");
	}
  	function smallAsConfig() {
		var param = {
			url : "/badou_upload",
			action : "ajax!flashUploadShopSmallImg",
			limitSize : 1100,//单位kb,max 2*1024
			dir : saveLogoPath
		};
		return param;
	}
	function smallCallBack(type, data) {
		$("#supd_tips").attr("class","Validform_checktip");
		$("#supd_tips").text("支持jpg/gif/png/jpeg格式,建议尺寸:100*100");
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
			$("#supd_tips").text("图片已上传完成！");
			$("#updImg_div").html("<img src='"+data+"' class='logoupdImg' id='logoupdImg' >");
			break;
		case -2://上传失败
			// 			setError("upd_tips", data);
			break;
		default:
			break;
		}
	}
	 function showLogoSwf() {
			var flashvars = {};
			var params = {};
			params.wmode = "transparent";
			params.menu = "true";
			params.quality = "high";
			var attributes = {
				id : "FlashID",
				name : "FlashID"
			};
		
			swfobject.embedSWF("upload_single_small_img.swf", "logoswfcontent", "120", "60", "10.0.0",
					"upload_single_small_img.swf");
	}
	function closeDialog(){
		$("#chooseLogoDialog").hide(); 
		bindChangeLogoEvent();
	}
	function showDialog()
	{
		$("#changeLogoDiv").hide();
		$("#chooseLogoDialog").show();
		unbindChangeLogoEvent();
	}
	//修改图片
	function cgOkEt(){
		if(uploaded){
			$("#comLogoImg").attr("src",$("#logoupdImg").attr("src"));
			closeDialog();
			changedLogo=true;
		}
		else{
			$("#supd_tips").attr("class","Validform_checktip Validform_wrong");
			$("#supd_tips").text("还没上传的图片!");
		}	
	}
  //判断网页是否加载完成  
  document.onreadystatechange = function () {   
      if(document.readyState=="complete") {         
          window.parent.loadCompleted();   
      }  
  };
  function subForm() {
  		var imgsDataHtml="";
  		if(changedLogo)
  		{
  			var logoSrc=$("#comLogoImg").attr("src");
  			imgsDataHtml+=inputHiddenHtml("company.logo",saveLogoPath+logoSrc.substring(logoSrc.lastIndexOf("/")+1));
  		}
  		var checkImgIsPassed=$(".upd_img").length>=1;
  		var tips=checkImgIsPassed?"通过信息验证!":"请至少上传一张企业图片!";
  		fixTips(checkImgIsPassed,"upd_tips",tips);
  		if(!checkImgIsPassed)
  			return;
  		var count=0;
		 $(".upd_img").each(function(){
	 		count++;
	 		if(count>3)
	 		  return false;
		    var urlStr = $(this).attr("src");
	 		var filePathName = saveComImgPath+urlStr.substring(urlStr.lastIndexOf("/")+1);
			imgsDataHtml+=inputHiddenHtml("company.descrImage"+count,filePathName);
		});
		$("#hid_da_ta").html(imgsDataHtml);
		with($("#updateInfo"))
		{
			submit();
		}
	}
	function fixTips(isPassed,tipsId,tipsContent){
		if(isPassed)
		{
			$("#"+tipsId).attr("class","Validform_checktip Validform_right");
		}else{
			$("#"+tipsId).attr("class","Validform_checktip Validform_wrong");
		}
		$("#"+tipsId).text(tipsContent);
	}
	function inputHiddenHtml(nameStr,valueStr){
		return "<input type='hidden' name='"+nameStr+"' value='"+valueStr+"'/>";
	}
</script>

<style type="text/css">
	body {
		margin-top: 10px;
		background-color: #ffffff;
		margin-left: 10px
	}
	.remove{
		background-image:url("/images/remove.png");
	}
	#s_udimg{
		padding-top:10px;
	}

	#upd_tips_div li{
		float:left;
		height:45px;
		line-height:45px;
		vertical-align:middle;
	}
	#upd_li_left{
	}
	#upd_li_right{
		width:350px;
		margin-left:5px;
	}
	#submit_div{
		clear:both;
	}
	.lefttd{
		width: 160px;
		height:45px;
		font-size:14px;
		text-align:center;
	}
	.centerIpt{
		width:240px;
		height: 30px;
		line-height: 30px;
		vertical-align: middle;
		font-size:13px;
	}
	select{
		width: 235px;
		height: 30px;
		margin-left:4px;
	}
	.centerIpt input{
		width:225px;
		height: 30px;
		line-height: 30px;
		vertical-align: middle;
		font-size:13px;
	}
	.centerIpt textarea{
		width:385px;
	}
	.tips{
		width:170px;
	}
	#change_submit:hover {
		background-image:url("./images/change_focus.png");
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
	#comLogoTd{
	}
	#imgDiv,#comLogoImg{
		width:100px;
		height:100px;
	}
	#imgDiv
	{
		border:1px solid #9d9d9d; 
		margin-left:4px;
		float:left;
	}
	#changeLogoDiv{
		position:relative;
		left:-102px;
		width:102px;
		height:102px;
		line-height:102px;
		vertical-align:middle;
		background:#000;
		opacity: 0.6;                 /* Firefox, Safari(WebKit), Opera)*/
		filter: "alpha(opacity=60)"; /* IE 8 */
		filter: alpha(opacity=60);   /* IE 4-7 */
		color:#fff;
		text-align:center;
		display:none;
		float:left;
		
	}
	.logoupdImg{
		width:120px;height: 120px;
	}
	.exeCommonBtn:hover{
		background:#6fa1e7;
	}
	.cgBtn{
		background:#303030;
		border:1px solid #9d9d9d;
		border-radius:3px;
		font-size: 14px;
		margin-right: 8px;
		width:110px;
		height:35px;
	}
	#chgOK{
		background:#ffb137;
		color:#fff;
	}
	#cancelBtn{
		background:	#E0E0E0;
	}
	#chooseLogoDialog{
		display:none;
		border:1px solid #9d9d9d;
		width:400px;
		height:230px;
		position:fixed;
		top:180px;
		left:220px;
		background:#fff;
		z-index:1000;
	}
	#dialog_title{
		background:#4680d1;
		height:35px;
		line-height:35px;
		vertical-align:middle;
		padding-left:15px;
		color:#fff;
		font-size:14px;
	}
	#dialog_remove{
		outline:none;
		float:right;
		width:15px;
		height:15px;
		margin-right:10px;
		margin-top:7px;
	}
	#dialogContent{
		height:130px;
		padding-top:20px !important;
		padding:0px 10px; 
	}
	#updImg_div{
		float:left;
		width:120px;
		height: 120px;
		border:1px solid #9d9d9d;
	}
</style>
</head>
<body topmargin="0" leftmargin="0">
	<form name="updateInfo"  id="updateInfo" action="myInfo!updateInfo" method="post">
	<input type="hidden" name="company.id" value="${company.id}">
	<table width="100%" style="table-layout:fixed;" border="0"
		cellspacing="2" cellpadding="2">
		<tr>
			<td class="lefttd">
			<font class="releaseJob_need">*</font>&nbsp;企业名称：</td>
			<td class="centerIpt">&nbsp;${company.name}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd">
			<font class="releaseJob_need">*</font>&nbsp;企业认证：</td>
			<td class="centerIpt">&nbsp;
				<c:if test="${company.authType<0}">
					待审核
				</c:if>
				<c:if test="${empty company.authType||company.authType==0 }">
					未认证
				</c:if>
				<c:if test="${company.authType==1}">
					百家大咖联盟
				</c:if>
			</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;企业LOGO：</td>
			<td class="centerIpt" id="comLogoTd">
				<div id="imgDiv">
					<img id="comLogoImg" src="${company.logo}" />
				</div>
				<div id="changeLogoDiv" onclick="showDialog();">点击修改</div>
				<div id="chooseLogoDialog">
					<div id="dialog_title">
						<div style="float:left;width:150px;">修改企业LOGO</div>
						<div onclick="closeDialog()" id="dialog_remove"><img alt="" src="images/remove.png"></div>
					</div>
					<div id="dialogContent">
						<div id="updImg_div">
							<img src="images/head.png" class="logoupdImg">
						</div>
						<div id="logoSwf" style="float:right;width:200px;height: 120px;">
							<div><span id='logoswfcontent'></span></div>
							<div class="Validform_checktip" id="supd_tips" style="margin-top: 10px;">请选择企业logo图片!</div>
							
						</div>
					</div>
					<div style="float: right;">
						<input style="width:110px;" type="button" id="chgOK" class="cgBtn" onclick="cgOkEt();" hideFocus="true" value="确&nbsp;定"/>
						<input style="width:110px;" type="button" id="cancelBtn" class="cgBtn" hidefocus="true" onclick="closeDialog()" value="取&nbsp;消"/>
					</div>
				</div>
			</td>
			<td class="tips"> <div class="Validform_checktip"></div></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd" height="28px"><font class="releaseJob_need">*</font>&nbsp;企业性质：</td>
			<td class="centerIpt"><select name="company.nature" datatype="s1-18"
				nullmsg="请选择公司性质！" errormsg="请选择公司性质！">
			 			<option value="">-请选择-</option>
						<option value="私营企业 " <c:if test="${company.nature eq '私营企业' }">selected="selected"</c:if>>私营企业</option>
						<option value="民营企业" <c:if test="${company.nature eq '民营企业' }">selected="selected"</c:if>>民营企业</option>
						<option value="国有企业" <c:if test="${company.nature eq '国有企业' }">selected="selected"</c:if>>国有企业</option>
						<option value="港资企业" <c:if test="${company.nature eq '港资企业' }">selected="selected"</c:if>>港资企业</option>
						<option value="台资企业" <c:if test="${company.nature eq '台资企业' }">selected="selected"</c:if>>台资企业</option>
						<option value="日资企业" <c:if test="${company.nature eq '日资企业' }">selected="selected"</c:if>>日资企业</option>
						<option value="韩资企业" <c:if test="${company.nature eq '韩资企业' }">selected="selected"</c:if>>韩资企业</option>
						<option value="欧美企业" <c:if test="${company.nature eq '欧美企业' }">selected="selected"</c:if>>欧美企业</option>
						<option value="中外合资 " <c:if test="${company.nature eq '中外合资' }">selected="selected"</c:if>>中外合资</option>
						<option value="其它" <c:if test="${company.nature eq '其它' }">selected="selected"</c:if>>其它</option>
			</select>
			</td>
			<td colspan="2" class="tips"><div class="Validform_checktip">请选择企业性质!</div></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;所属行业：
			</td>
			<td class="centerIpt">
				<select name="company.industry" id="industry" datatype="s1-18"
				nullmsg="请选择企业行业！" errormsg="请选择行业名称！">
				    <option value="">-请选择-</option>
				    <option value="服务业"
						<c:if test="${company.industry eq '服务业' }">selected="selected"</c:if>>服务业</option>
					<option value="制造业"
						<c:if test="${company.industry eq '制造业' }">selected="selected"</c:if>>制造业</option>
					<option value="其他行业"
						<c:if test="${company.industry eq '其他行业' }">selected="selected"</c:if>>其他行业</option>
				</select>
			</td>
			<td class="tips"><div class="Validform_checktip">请选择公司所属的行业!</div></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd" height="28px"><font class="releaseJob_need">*</font>&nbsp;企业规模：</td>
			<td class="centerIpt"><select name="company.scale" datatype="*1-18"
				nullmsg="请选择公司规模！" errormsg="请选择公司规模！">
					 <option value="">-请选择-</option>
					<option value="1-50人"
						<c:if test="${company.scale eq '1-50人' }">selected="selected"</c:if>>1-50人</option>
					<option value="50-100人"
						<c:if test="${company.scale eq '50-100人' }">selected="selected"</c:if>>50-100人</option>
					<option value="100-500人"
						<c:if test="${company.scale eq '100-500人' }">selected="selected"</c:if>>100-500人</option>
					<option value="500人以上"
						<c:if test="${company.scale eq '500人以上' }">selected="selected"</c:if>>500人以上</option>
			</select>
			</td>
			<td class="tips"><div class="Validform_checktip">请选择公司规模!</div></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;企业简介：
			</td>
			<td class="centerIpt" colspan="2" valign="middle">
				<textarea name="company.description" datatype="*4-4000" nullmsg="请填写公司简介！" errormsg="公司简介在4到4000字符之间！！"
					style="height:100px;overflow-y:visible;margin-left:4px;"
					altercss="gray" class="gray">${company.description}</textarea>
			</td>
			<td class="tips"><div class="Validform_checktip">请填写公司简介!</div>
			</td>
		</tr>
		<tr>
			<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;联系电话：
			</td>
			<td class="centerIpt"><input type="text" name="company.contactWay" id="telephone" class="inp006" datatype="m|tel"
				errormsg="输入的手机号码格式不对！" value="${company.contactWay}"></td>
			<td class="tips"><div class="Validform_checktip">请输入您的联系方式!</div></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd"">&nbsp;电子邮箱：
			</td>
			<td class="centerIpt"><input type="text" name="company.email" id="mailbox"
				class="inp006" datatype="e" nullmsg="电子邮箱不能为空！" ignore="ignore"
				errormsg="输入的邮箱格式不正确！" value="${company.email}"></td>
			<td class="tips"><div class="Validform_checktip">请输入您的邮箱!</div></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;企业地址：
			</td>
			<td class="centerIpt"><input type="text" name="company.address" id="address"
				class="inp006" value="${company.address}" datatype="*4-200"
				nullmsg="企业不能为空！" errormsg="企业地址在2到100字之间！"></td>
			<td class="tips"><div class="Validform_checktip">请输入详细的地址!</div>
			</td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd"><font class="releaseJob_need">*</font> &nbsp;上传图片：
			</td>
			<td colspan="2" valign="middle" style="padding-left: 4px;">
				<font id="upd_tips" color="#afafaf"  style="line-height:22px; ">为了更好的提高招聘效率，请上传公司环境、团队活动类照片。（最多可上传3张图片，支持jpg/gif/png/jpeg格式）</font>
			</td>
		</tr>
		</table>
		<div id="s_udimg">
	 		<span id="led_img_sn">
 				<c:forEach items="${descImgs}" var="imgSrc"
					varStatus="status">
					<span class="uld_img" id="${status.count}">
						<img src="${imgSrc}" class="upd_img"> 
						<img class="remove" id="rem${status.count}" src="images/remove.png">
					</span>
				</c:forEach>
	 		</span>
	 		<span id="flsu" class="flstyle" style="margin-left:4px;">
			</span>
		</div>
		<div id="hid_da_ta"></div>
		<div id="submit_div">
			<input type="button"  value="提&nbsp;交" class="exeCommonBtn" id="exeCommonBtn" onclick="subForm();"/>
		</div>
		<div id="upded">
		</div>
	</form>
</body>
</html>