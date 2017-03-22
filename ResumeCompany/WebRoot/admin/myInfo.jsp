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
<link rel="stylesheet" href="css/style.css" type="text/css"
	media="all" />
<script src="js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
<link rel="stylesheet" href="./css/common.css" type="text/css"  />
<link rel="stylesheet" href="./css/base.css" type="text/css"  />
<script language="JavaScript" src="./js/framechild.js"></script>
<script language="JavaScript" src="./js/common.js"></script>
<link rel="stylesheet" href="./js/flash_upload/flash_upl.css" type="text/css"  />
<script language="JavaScript" type="text/JavaScript">
	$(function() {
		window.parent.mainTop();
//       	  window.parent.setExeContent(true,"编辑","images/top_edit_btn.png","myInfo!myInfo?type=queryEdit&company.id=${company.id}");
	});
	//判断网页是否加载完成  
  document.onreadystatechange = function () {   
      if(document.readyState=="complete") {         
          window.parent.loadCompleted(); 
      }  
  };
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
		width:500px;
		height: 30px;
		line-height: 30px;
		vertical-align: middle;
		font-size:13px;
		padding-left: 5px;
	}
	.centerIpt select{
		padding-top:3px;
		font-family : Trebuchet MS;
		height:100%;
	}
	.centerIpt input,.centerIpt select{
		width:225px;
		height: 30px;
		line-height: 30px;
		vertical-align: middle;
		font-size:13px;
	}
	.centerIpt textarea{
		width:385px;
	}
	.centerIpt select {
		font-family: Trebuchet MS ;
		font-size: 14px;
		width: 97%;
		height: 30px;
		line-height: 30px;
		vertical-align: middle;
		font-size: 13px;
		padding-bottom: 5px;
		padding-right: 8px;
		padding-top: 5px;
	}
	.tips{
		width:170px;
	}
	#toAuto{
		padding: 5px 5px;;
		background: #008ce6;
		font-size: 13px;
		position: relative;
		top: 3px;
		left: 5px;
		cursor: pointer;
	}
	#toAuto a,#toAuto a:VISITED {
		color: #ffffff;
	}
</style>
</head>
<body topmargin="0" leftmargin="0">
	<table width="100%" style="table-layout:fixed;" border="0"
		cellspacing="2" cellpadding="2">
		<tr>
			<td class="lefttd">
			&nbsp;企业名称：</td>
			<td class="centerIpt">${company.name}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd">
			&nbsp;企业认证：</td>
			<td class="centerIpt">
				<c:if test="${company.authType<0 }">
					待审核
				</c:if>
				<c:if test="${empty company.authType||company.authType==0 }">
					未认证
					<c:if test="${comType==0}">
						<span id="toAuto">
							<a href="myInfo!myInfo?type=toUpdateAuth" target="mainFrame" hideFocus="true">我要认证</a>
						</span>
					</c:if>
				</c:if>
				<c:if test="${company.authType==1 }">
					百家大咖联盟
				</c:if>
			</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;企业性质：</td>
			<td class="centerIpt">${company.nature}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;企业LOGO：</td>
			<td class="centerIpt" style="height:90px;width:90px; "><img style="height:90px;width:90px;padding:3px;" src="${company.logo}" alt="企业LOGO" title="企业LOGO"/></td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd">&nbsp;所属行业：
			</td>
			<td class="centerIpt">${company.industry}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd" height="28px">&nbsp;企业规模：</td>
			<td class="centerIpt">${company.scale}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd">&nbsp;企业简介：
			</td>
			<td class="centerIpt">${company.description}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
			<tr>
			<td class="lefttd">&nbsp;联系电话：
			</td>
			<td class="centerIpt">${company.contactWay}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd"">&nbsp;电子邮箱：
			</td>
			<td class="centerIpt">${company.email}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd">&nbsp;企业地址：
			</td>
			<td class="centerIpt">${company.address}</td>
			<td class="tips"></td>
			<td></td>
		</tr>
		<tr>
			<td class="lefttd">&nbsp;企业图片：
			</td>
			<td colspan="2" valign="middle" style="padding-left: 4px;">
				<span id="led_img_sn">
					<c:choose>
						<c:when test="${!empty descImgs}">
							<c:forEach items="${descImgs}" var="imgSrc"
							varStatus="status">
								<span class="uld_img" id="${status.count}">
									<img src="${imgSrc}" class="upd_img"> 
									<img class="remove" id="rem${status.count}" src="images/remove.png">
								</span>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<font color="#9d9d9d">未上传企业图片</font>
						</c:otherwise>
					</c:choose>
	 			</span>
			</td>
		</tr>
		</table>
		<div id="submit_div" >
			<a href="myInfo!myInfo?type=queryEdit&company.id=${company.id}" style="margin-left: 145px;text-align:center;" target="mainFrame"  class="exeCommonBtn">修&nbsp;改</a>
		</div>
		<div id="upded">
		</div>
</body>
</html>