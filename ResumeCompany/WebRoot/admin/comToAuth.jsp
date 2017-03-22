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
<title>上传企业logo</title>
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
	$(function(){
		window.parent.setTitle("企业认证");
	});
	var saveLicencePath="upload/company/licence/";
	var isUploaded=false;
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
		switch (type) {
		case -1://禁止上传,超出大小限制
			$("#supd_tips").attr("class","Validform_checktip Validform_wrong");
			$("#supd_tips").text("上传的图片不能超过1M");
			break;
		case 0://开始上传
			$("#updImg_div").attr("class","uploading");
			$("#updImg_div").show();
			$("#supd_tips").attr("class","Validform_checktip");
			$("#supd_tips").text("支持jpg/gif/png/jpeg格式");
			$("#updImg_div").html("<label class='tle'>图片上传中</label><br><label id='pro_small' class='prog'>已上传0%</label>");
			// 			resetTips("upd_tips", "图片正在上传中！");
			break;
		case 1://上传进度
			$("#pro_small").text(data);
			break;
		case 2://上传完成
			isUploaded=true;
			$("#updImg_div").attr("class","licenceupdImg");
			// 			resetTips("upd_tips", "图片已上传完成！");
			$("#licenceSwf").css("margin-top","10px");
			$("#supd_tips").attr("class","Validform_checktip Validform_right");
			$("#supd_tips").text("营业执照已上传完成！");
			$("#updImg_div").html("<img src='"+data+"' class='licenceupdImg' id='licenceupdImg' >");
			break;
		case -2://上传失败
			// 			setError("upd_tips", data);
			break;
		default:
			break;
		}
	}
  function subForm() {
  		var imgsDataHtml="";
  		if(isUploaded)
  		{
  			var licenceSrc=$("#licenceupdImg").attr("src");
  			imgsDataHtml+=inputHiddenHtml("company.license",saveLicencePath+licenceSrc.substring(licenceSrc.lastIndexOf("/")+1));
  		}
  		var tips=isUploaded?"通过信息验证!":"请上传企业营业执照!";
  		fixTips(isUploaded,"supd_tips",tips);
  		if(!isUploaded)
  			return;
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
		font-size:14px;
		text-align:center;
	}
	.centerIpt{
		width:250px;
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
		cursor: pointer;
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
	#wx_tips{
	background:#E9967A;
	border-radius:3px;
	padding:0px 15px;
	line-height:25px;
	color:#fff;
	font-size:14px;
	position:relative;
	vertical-align:middle;
	width:850px;
	height:35px;
	line-height:35px;
	margin-top:5px;
	word-break:break-all;
/* 	display:none; */
}
#tips{
	display: inline-block;
	float:left;
	width:830px;
}
#close{
	background:url("images/icons.png") no-repeat scroll -310px 0px;
	width: 15px;
	height: 12px;
	display: inline-block;
	float:right;
	cursor:pointer;
	margin-top:5px;
}
.licenceupdImg{
	width:250px;
	height:180px;
}
.uploading{
	width:120px;
	height: 120px;
}
#updImg_div{
	border:1px solid #9d9d9d;
	display:none;
}
#licenceSwf{
	width:120px; 
}
</style>
</head>
<body topmargin="0" leftmargin="0">
	<div id="wx_tips">
		<span id="tips">&nbsp;&nbsp;&nbsp;&nbsp;认证通过后，将会享受到更多优惠！
		</span>
		<span id="close" style="display:none;"></span>
	</div>
	<form name="updateInfo"  id="updateInfo" action="myInfo!updateInfo" method="post">
	<input type="hidden" name="company.id" value="${company.id}">
	<input type="hidden" name="company.authType" value="-1">
	<input type="hidden" name="type" value="updateAuth">
	<table width="100%" style="table-layout:fixed;" border="0"
		cellspacing="2" cellpadding="2">
		<tr>
			<td class="lefttd">企业名称：</td>
			<td class="centerIpt">&nbsp;${company.name}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">认证名称：</td>
			<td class="centerIpt" style="padding-left: 4px;">
				百家大咖联盟
			</td>
			<td class="tips"> <div class="Validform_checktip"></div></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd"><font class="releaseJob_need">*</font>&nbsp;营业执照：</td>
			<td colspan="2" valign="middle" style="padding-left: 4px;">
				<div id="dialogContent">
					<div id="updImg_div">
					</div>
					<div id="licenceSwf">
						<span id='licenceswfcontent'>
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
						</span>
					</div>
				</div>
			</td>
			<td class="tips"><div class="Validform_checktip" id="supd_tips" style="position:relative;left:-100px; "></div></td>
			<td></td>
		</tr>
		</table>
		<div id="hid_da_ta"></div>
		<div id="submit_div">
			<input type="button"  value="申&nbsp;请" class="exeCommonBtn" id="exeCommonBtn" onclick="subForm();"/>
		</div>
		<div id="upded">
		</div>
	</form>
</body>
</html>