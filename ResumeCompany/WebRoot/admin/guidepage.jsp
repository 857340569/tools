<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>职米网企业后台管理系统</title>
<link rel="icon" href="http://img.91zhimi.com/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="http://img.91zhimi.com/favicon.ico" type="image/x-icon" />
<script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
<link href="./css/base.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script>
<script type="text/javascript" src="./js/contenListener.js"></script>
<jsp:include page="./processbar.jsp"></jsp:include>
<style type="text/css">
ul {
	list-style: none;
	margin: 0;
	padding: 0;
	clear: both;
}

#left div {
	clear: both;
}

#contentLeft {
	float: left;
	width: 210px;
}
#contentMain {
	margin-left: 210px;
}


.menu1Title {
	letter-spacing: 2px;
	display: block;
	float: left;
	font-size: 16px;
	font-family: 宋体;
	font-weight: bold;
}
.menu1Status {
	position: relative;
	width: 25px;
	height: 25px;
	display: block;
	float: left;
	position: relative;
	top:18px;
}
.menu1Status img{
	width: 11px;
	height: 8px;
	line-height: 8px;
	vertical-align:middle;
	margin-left: 15px;
}
.menu2Title {
	letter-spacing: 2px;
	display: block;
	font-size: 15px;
	font-family: 宋体;
}

.menul1,.menul1_exit {
	cursor: pointer;
	height: 47px;
	line-height: 47px;
	vertical-align: middle;
}
.menul2{
	position:relative;
	zoom:1;
}
.menul2 li {
	padding-left: 35px;
	letter-spacing: 1px;
	cursor: pointer;
	height: 35px;
	line-height: 35px;
	vertical-align: middle;
}

.menu2Icon {
	float: left;
	width: 15px;
	height: 15px;
	position: relative;
	top: 10px;
	margin-right: 3px;
}

#left {
	height:1000px;
	width: 210px;
	float: left;
	border-right: 1px solid #ddd;
	background: #4680d1;
	color:#fff;
}

.menu1Icon {
	width: 25px;
	height: 25px;
	margin-left: 10%;
	display: block;
	float: left;
	margin-right: 8px;
	position: relative;
	top:12px;
}
.menu1Icon img{
	width: 25px;
	height: 25px;
	line-height: 25px;
	vertical-align:middle;
}
a {
	text-decoration: none;
	color: #fff;
	outline: none;
}

#leftTop {
	width: 100%;
	height: 80px;
	line-height: 80px;
	background: #4680d1;
	text-align: center;
	vertical-align: middle;
	padding-top: 15px;
}

#mainTop {
	background: #4680d1;
	height: 60px;
	line-height:60px;
	vertical-align:middle;
	color:#fff;
}

#adminInfo{
	height: 60px;
	float:right;
	margin-right: 45px;
	position: relative;
	top: 10px;
} 
#adminInfo_info{
	float:left;
	width: 130px;
	height:60px;
	background:rgb(130,175,111);
}
#info_icon_div
{
	float:left;
}
#main_top_adminName
{
	height: 60px;
	float:right;
	margin-right: 45px;
	font-size: 20px;
	font-family: 宋体;
}
#info_icon_div,#show_adne{
	position:relative;
	top:8px;
	left:8px;
}
#show_adne
{
	width:65px;
	left:15px;
	font-size:18px;
	overflow:hidden;
}

#info_icon_div img{
	width:45px;
	height:45px;
}
#adminInfo_exit{
	float:left;
	width:80px;
	height:60px;
	line-height: 60px;
	vertical-align:middle;
	background:rgb(130,177,243);
	margin-left: 15px;
	text-align:center;
}

#main {
	float: left;
}

#mainCenter {
	color: #4680d1;
	background: #ecf0f1;
	font-size: 16px;
	font-family: 宋体;
	font-weight: bold;
	height: 40px;
	line-height: 40px;
	vertical-align: middle;
}

#mainCenter span {
	margin-left: 15px;
}
.menu_split_line{
	width:100%;
	height:2px;
	background:url('images/menu_split_line.png') no-repeat;
	position:relative;
	left:12%;
}
#gd_deal_url img {
	border:0px;
	width: 20px;
	height: 20px;
	left: 10px;
	position:relative;
	top:5px;
}
#currentItem{
	display:inline-block;
}
#toTop_div{
	position:fixed;
	_position:absolute;
	bottom:30px;
	_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight)-230+"px");
	right:50px;
	width:70px;
	zoom:1;
}
#toTop_a{
	background:#FF7402;
	color:#fff;
	display:block;
	width:90px;
	height:30px;
	font:normal 12px/30px 'MicroSoft Yahei';
	text-align:center;
	-webkit-transition: all 0.2s ease-in-out;
	-moz-transition: all 0.2s ease-in-out;
	-o-transition: all 0.2s ease-in-out;
	-ms-transition: all 0.2s ease-in-out;
	transition: all 0.2s ease-in-out;
	zoom:1;
}
#toTop_a:hover{
	background:#ff6100;
	width:100px;
}
</style>
<script type="text/javascript">
	function loadCompleted(){
		document.getElementById("load").style.display="none";
	}
	$(function() {
		
		$("#toTop_a").click(function(){
			mainTop();
		});
		$(".menu1Status").each(function(){
			$(this).find("img").attr("src","images/menu1_close.png");
		});
	    $("#mainFrame").load(function(){
				iFrameSize("mainFrame");
				var childHeight=window.frames["mainFrame"].getHeight();
				if(childHeight>1000)
				{
					$("#left").css("height", (childHeight+60)+"px");
				}
				if(childHeight<600)
				{
					childHeight=600;
				}
				$(this).removeAttr("style");
				$(this).css("height",(childHeight+60)+"px");
				$("#load").css("height",(childHeight+60)+"px");
				var childIsEdit= $(window.frames["mainFrame"].document).find("#show_top_execute");
				if(childIsEdit.val()!="isShow"){
					setExeContent(false);
				}
			});
		/*
			菜单
		 */
		$(".menul2").each(function() {
		});
		$(".menul2 li").each(function() {
			$(this).mouseover(function() {
				$(this).css("background", "#d5d5d5");
				$(this).find("a").css("color", "#4680d1");
			});
			$(this).mouseout(function() {
				$(this).css("background", "");
				$(this).find("a").css("color", "#fff");
			});
			$(this).click(function() {
				$(".menul2 li").each(function() {
					//重置，重新绑定
					$(this).css("background","");
					$(this).find("a").css("color","#fff");
					$(this).bind("mouseover",function() {
						$(this).css("background","#d5d5d5");
						$(this).find("a").css("color", "#4680d1");
					});
					$(this).bind("mouseout",function() {
						$(this).css("background","");
						$(this).find("a").css("color", "#fff");
					});
				});
				$(this).unbind("mouseout");
				$(this).unbind("mouseover");
// 				$(this).css("background", "url('images/menu_selected_bg.png')");
				$(this).css("background", "#FFB448");
				$(this).find("a").css("color","#fff");
				setTitle($(this).find("a").text().substring(2));
				window.open($(this).find("a").attr("href"),"mainFrame");
			});
		});
		//设置默认选择
		$(".menul2 li:first").unbind("mouseout");
		$(".menul2 li:first").unbind("mouseover");
// 		$(".menul2 li:first").css("background",
// 				"url('images/menu_selected_bg.png')");
		$(".menul2 li:first").css("background", "#FFB448");
		$(".menul2 li:first").find("a").css("color", "#fff");
// 		$("#left").css("height", ($(window).height()+60)+"px");
	});
	function iFrameSize(iframeId) {
		var ifm = document.getElementById(iframeId);
		var subWeb = document.frames ? document.frames[iframeId].document
				: ifm.contentDocument;
		if (ifm != null && subWeb != null) {
			//ifm.height = subWeb.body.scrollHeight;
// 			$("#left").css("height", (subWeb.body.scrollHeight+40)+"px");
			var leftWidth = document.getElementById("contentLeft").scrollWidth;
			ifm.width = document.body.clientWidth - leftWidth - 3;
		}
	}
	$(window).resize(function() {
		iFrameSize("mainFrame");
	});
	function exit() {
		if (confirm("确定要退出系统吗?")) {
		window.top.location.href="login!logout";
			window.top.location.href="login!logout";
		}
	}
	function mainTop(){
		window.location.hash ="mainAnchor";
	}
	function setTitle(title) {
		$("#currentItem").text(title);
	}
	var isShow = false;
	function tips() {
		if (isShow) {
			$("#load").css("display", "none");
			isShow = false;
		} else {
			$("#load").css("display", "block");
			isShow = true;
		}
	}
	$(function(){
		var currentClick=$(".menul1").eq(0);
		$(".menul1").each(function(){
			$(this).next(".menul2").css("display", "none");
			currentClick.next(".menul2").css("display", "block");
			$(this).click(function(){
				$(".menu1Status").each(function(){
					$(this).find("img").attr("src","images/menu1_close.png");
				});
				if(currentClick.html()!=$(this).html()){
					currentClick.next(".menul2").css("display", "none");
				}
				var isShow=$(this).next(".menul2").css("display");
					if(isShow=="none"){
						$(this).next(".menul2").slideDown(300);
						$(this).find(".menu1Status").find("img").attr("src","images/menu1_open.png");
					}else{
						$(this).next(".menul2").slideUp(350);
						$(this).find(".menu1Status").find("img").attr("src","images/menu1_close.png");
					}
				currentClick=$(this);
			});
		});
		$(".menul1").eq(0).find(".menu1Status").find("img").attr("src","images/menu1_open.png");
		$("#currentItem").bind("contentchange",function(){
			if($(this).text()!="我的资料"){
				$("#gd_deal_url").css("display","none");
			}
		});
	});
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
	function setExeContent(isShow,title,imgUrl,exeUrl)
	{
		if(isShow||isShow=="true"||isShow=="block")
		{
			$("#gd_deal_url").css("display","inline");
			$("#gd_deal_url").find("img").attr("src",imgUrl);
			$("#gd_deal_url").find("img").attr("title",title);
			$("#gd_deal_url").attr("href",exeUrl);
			
		}else
		{
			$("#gd_deal_url").css("display","none");
		}
	}
	$(function(){
		if("${type eq 'direct_regist'}"=="true")
		{
			$("#mainFrame").attr("src","job!toAddPage");
		}
	});
</script>
</head>
<body>
	<div id="load" align="center" style="display: none;">
		<img style="margin-top: 400px" src="./images/badou_load.gif">
	</div>
	<div id="content">
		<div id="contentLeft">
			<div id="leftTop">
				<img alt="" src="./images/admin_logo.png">
			</div>
			<div id="left">
				<div class="menul1">
					<span class="menu1Icon"><img  src="./images/guide_icon_job.png"/></span>
					<span class="menu1Title">职位管理</span>
					<span class="menu1Status"><img/></span>
				</div>
				<ul class="menul2">
					<li><span class="menu2Icon"></span> <span class="menu2Title"><a hideFocus="true"
							href="job!queryJobs" onclick="tips()" target="mainFrame">>&nbsp;职位查询</a>
					</span></li>
					<li><span class="menu2Icon"></span> <span class="menu2Title"><a hideFocus="true"
							href="job!toAddPage" onclick="tips()" target="mainFrame">>&nbsp;发布职位</a>
					</span></li>
					<li><span class="menu2Icon"></span> <span class="menu2Title"><a hideFocus="true"
							href="job!queryOutlineJobs" onclick="tips()" target="mainFrame">>&nbsp;已下线</a>
					</span></li>
					<li><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="comApplyManage.jsp"  onclick="tips()" hideFocus="true"
							target="mainFrame">>&nbsp;申请信息</a>
					</span></li>
				</ul>
				<div class="menu_split_line"></div>
				<div class="menul1">
					<span class="menu1Icon"><img src="./images/guide_icon_myinfo.png" style="width:22px;"/></span>
					<span class="menu1Title">个人中心</span>
					<span class="menu1Status"><img/></span>
				</div>
				<ul class="menul2" style="display:block">
					<li><span class="menu2Icon"></span> <span class="menu2Title"><a hideFocus="true"
							href="myInfo!myInfo?type=queryInfo" onclick="tips()" target="mainFrame">>&nbsp;我的资料</a>
					</span></li>
					<li onclick=""><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="myInfo!myInfo?type=queryAccount" hideFocus="true"
							onclick="tips()" target="mainFrame">>&nbsp;账户充值</a> </span>
					</li>
					<li><span class="menu2Icon"></span> <span class="menu2Title"><a hideFocus="true"
							href="admin/editPassword.jsp" onclick="tips()" target="mainFrame">>&nbsp;修改密码</a>
					</span></li>
					<li><span class="menu2Icon"></span> <span class="menu2Title"><a hideFocus="true"
							href="pay!queryAllExpenseRecord" onclick="tips()" target="mainFrame">>&nbsp;消费记录</a>
					</span></li>
					<li><span class="menu2Icon"></span> <span class="menu2Title"><a hideFocus="true"
							href="invoice!toAddPage" onclick="tips()" target="mainFrame">>&nbsp;申请发票</a>
					</span></li>
				</ul>
				<div class="menu_split_line"></div>
				<div class="menul1">
					<span class="menu1Icon"><img  src="./images/guide_icon_dymic.png"/></span>
					<span class="menu1Title">我的动态</span>
					<span class="menu1Status"><img/></span>
				</div>
				<ul class="menul2" style="display:block">
					<li onclick=""><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="news!toAddPage" onclick="tips()" hideFocus="true"
							target="mainFrame">>&nbsp;发布动态</a>
						</span>
					</li>
					<li><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="news!queryAllNews" onclick="tips()" hideFocus="true"
							target="mainFrame">>&nbsp;查看动态</a>
						</span>
					</li>
				</ul>
				<div class="menu_split_line"></div>
				<div class="menul1">
					<span class="menu1Icon"><img  src="./images/guide_icon_activity.png"/></span>
					<span class="menu1Title">我的活动</span>
					<span class="menu1Status"><img/></span>
				</div>
				<ul class="menul2" style="display:block">
					<li onclick=""><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="activities!toAddPage" onclick="tips()" hideFocus="true"
							target="mainFrame">>&nbsp;发布活动</a>
						</span>
					</li>
					<li><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="activities!queryAllActivities" onclick="tips()" hideFocus="true"
							target="mainFrame">>&nbsp;查看活动</a>
						</span>
					</li>
				</ul>
				<div class="menu_split_line"></div>
				<div class="menul1">
					<span class="menu1Icon"><img src="./images/guide_icon_resume.png"/></span>
					<span class="menu1Title">云简历库</span>
					<span class="menu1Status"><img/></span>
				</div>
				<ul class="menul2" style="display:block">
					<li onclick=""><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="admin/searchResumeIndex.jsp" hideFocus="true"
							onclick="tips()" target="mainFrame">>&nbsp;查看简历</a> </span>
					</li>
					<li onclick=""><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="admin/suitableResume.jsp" hideFocus="true"
							onclick="tips()" target="mainFrame">>&nbsp;适合我的</a> </span>
					</li>
					<li onclick=""><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="./admin/nearbyResume.jsp" hideFocus="true"
							onclick="tips()" target="mainFrame">>&nbsp;附近简历</a> </span>
					</li>
					<li onclick=""><span class="menu2Icon"></span> <span
						class="menu2Title"><a href="resume!queryAllBtRecords" hideFocus="true"
							onclick="tips()" target="mainFrame">>&nbsp;已购买简历</a> </span>
					</li>
				</ul>
				<div class="menu_split_line"></div>
				<div class="menul1_exit" onclick="return exit()">
					<span class="menu1Icon"><img src="./images/guide_icon_exit.png"/></span>
					<span class="menu1Title">退出系统</span>
				</div>
			</div>
		</div>
		<div id="contentMain">
			<a href="javascript:void(0);" name="mainAnchor"></a>
			<div id="mainTop">
				<div id="main_top_adminName"><span style="font-size: 28px;position:relative;top:-5px; ">${adminName}</span><c:if test="${company.authType>0}"><img src="images/comvip.png" style="width:55px;height:20px;margin-left:5px;"/></c:if></div>
			</div>
			<div id="mainCenter">
				<span>【<label id="currentItem">职位查询</label>】<a id="gd_deal_url" target="mainFrame" style="display:none;"><img/></a></span>
			</div>
			<div id="main">
				<iframe src="job!queryJobs" scrolling="no" frameborder="0" onload="iFrameSize('mainFrame');" name="mainFrame" id="mainFrame"></iframe>
			</div>
		</div>
	</div>
	<div id="toTop_div">
    		<a id="toTop_a">回到顶部</a>
    </div>
</body>
</html>
