<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>职米官方网站</title>
    <meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <script src="./js/jquery/jquery-1.7.2.min.js" type="text/javascript" language="javascript"></script>
	<link href="./css/base.css" type="text/css" rel="stylesheet" />
	<link href="./css/common.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="./js/common.js"></script>
	<script type="text/javascript" src="./js/checkCode.js"></script>
	<link href="./js/mydialog/mydialog-v.1.0.0.css" rel="stylesheet" type="text/css"  />
	<script src="./js/mydialog/mydialog-v.1.0.0.js" type="text/javascript" language="javascript"></script>
	<jsp:include page="./admin/processbar.jsp"></jsp:include>
	<script type="text/javascript">
	</script>
	<style type="text/css">
		body{
			font-family:"微软雅黑";
			background:#f7f7f7;
		}
		#league_head_inner{
			background:url("./images/index/league_head_2.png") no-repeat;
			height: 581px;
			width:1000px; 
			margin:0 auto; 
		}
		#league_head_bottom{
			height:24px;
			background:#ffa304; 
		}
		#league_content_inner{
			width:900px; 
			margin:0 auto; 
			padding-top:30px; 
		}
		.league_guide_title{
			color:#6195f9;
			font-size:51px; 
		}
		.league_content_split{
			background:url("./images/index/league_split.png") repeat-x; 
			height:4px; 
			margin:60px 0px; 
		}
		.league_guide_content{
			color:#646464;
			font-size:21px; 
			line-height:32px; 
			margin-top:40px; 
		}
		#league_step1_content{
			border:2px dashed #ffa304;
			border-radius:3px;
			line-height:32px; 
			padding:20px 25px; 
		}
		#league_step_2_table td{
			width:300px; 
		}
		.league_step4_row{
			height:120px;
			line-height:30px;
			float:left;
			margin:0px 10px; 
		}
		.league_step4_next{
			height:120px;
			float:left;
			vertical-align:middle;
			
		}
		.league_step4_next img{
			position:relative;
    		top:50%;
		}
		.league_step4_row div{
			clear:both;
		}
		.league_step4_text
		{
			margin-top:10px;
		}
	</style>
  </head>
  <body>
    	<div id="league_head">
    		<div id="league_head_inner">
    		</div>
    		<div id="league_head_bottom">
    		</div>
    	</div>
    	<div id="league_content">
    		<div id="league_content_inner">
	    		<div>
	    			<img alt="logo" src="./images/index/index_logo.png" class="logo"/>
	    			<span class="league_guide_title" style="position: relative;top:-5px;left:5px; ">关于职米</span>
	    		</div>
	    		<div class="league_guide_content">
	    			<div style="text-indent:2em;">职米专注为大众提供企业直接招聘与活动发布的信息平台，以“真实、便捷、趣味”为开发理念，力求让每一位用户感受到科技带来的新奇与新意！</div>
	    			<div style="margin:20px 0px;text-indent:2em;">职米行业首创多功能用户体验交流平台，让招聘企业与求职者都能用不同新意且高效的招求方式满足对方的需求，职米服务于亿级的大中小企业与数亿级的大众用户群体，市场规模庞大！</div>
	    			<div style="text-indent:2em;">2015年职米正式启动“百城战略”计划，选拔优秀城市运营商，依托职米的运营体系，将职米运营模式和经验与广大代理商分享，共同拓展当地巨大潜在市场。</div>
	    		</div>
	    		<div class="league_content_split"></div>
	    		<div>
	    			<img src="./images/index/league_step_1.png"/>
	    			<img src="./images/index/league_contactway.png" style="margin-left:300px; "/>
	    		</div>
	    		<div class="league_guide_content">
	    			<div id="league_step1_content"> 
	    				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;职米将为授权合作伙伴提供完整的支持体系，多维度有效地扶持合作伙伴专注于本地市场的业务开拓，促使合作伙伴良性、平稳的发展。
	    			</div>
	    		</div>
	    		<div class="league_content_split"></div>
	    		<div>
	    			<img src="./images/index/league_step_2.png"/>
	    			<img src="./images/index/league_contactway.png" style="margin-left:300px; "/>
	    		</div>
	    		<div class="league_guide_content">
	    			<table cellpadding="0" border="0" style="width:900px;margin-top:20px;font-size:17px;  " id="league_step_2_table">
	    				<tr align="center">
	    					<td>
	    						<img src="./images/index/league_step2_ico_1.png"/>
	    					</td>
	    					<td>
	    						<img src="./images/index/league_step2_ico_2.png"/>
	    					</td>
	    					<td>
	    						<img src="./images/index/league_step2_ico_3.png"/>
	    					</td>
	    				</tr>
	    				<tr align="center">
	    					<td valign="top">一定的加盟费用</td>
	    					<td valign="top">招聘、活动、会员代理业务</td>
	    					<td style="text-align:left;">单个城市有多个竞争者，职米<br>将采用竞标方式确定加盟商</td>
	    				</tr>
	    				<tr align="center">
	    					<td>
	    						<img src="./images/index/league_step2_ico_4.png"/>
	    					</td>
	    					<td>
	    						<img src="./images/index/league_step2_ico_5.png"/>
	    					</td>
	    					<td>
	    					</td>
	    				</tr>
	    				<tr align="center">
	    					<td valign="top">当地城市站点独家运作</td>
	    					<td valign="top">费用在加盟站点上线前付清</td>
	    					<td></td>
	    				</tr>
	    			</table>
	    		</div>
	    		<div class="league_content_split"></div>
	    		<div>
	    			<img src="./images/index/league_step_3.png"/>
	    			<img src="./images/index/league_contactway.png" style="margin-left:300px; "/>
	    		</div>
	    		<div class="league_guide_content">
	    			<ul style="list-style: url('./images/index/league_order_pre.png');">
	    				<li>拥有合法的公司资质，（如初创者，职米可协助办理相关资质，加入职米创业联盟）；</li>
	    				<li>从业者，对互联网事业拥有无限的热情并全身心的投入；</li>
	    				<li>运营者具备网络或媒体经验，熟悉计算机相关操作；</li>
	    				<li>有丰富的本地区销售资源，创业型互联网从事者优先考虑；</li>
	    				<li>服务商需提供初步运营计划书。</li>
	    			</ul>
	    		</div>
	    		<div class="league_content_split"></div>
	    		<div>
	    			<img src="./images/index/league_step_4.png"/>
	    			<img src="./images/index/league_contactway.png" style="margin-left:300px; "/>
	    		</div>
	    		<div class="league_guide_content" style="margin-top:80px;">
	    			<div class="league_step4_row">
	    				<div><img src="./images/index/league_step4_ico_1.png"/></div>
	    				<div class="league_step4_text">意向客户</div>
	    			</div>
	    			<div class="league_step4_next">
	    				<img src="./images/index/league_step4_ico_next.png"/>
	    			</div>
	    			<div class="league_step4_row">
	    				<div><img src="./images/index/league_step4_ico_2.png"/></div>
	    				<div class="league_step4_text">资质审核</div>
	    			</div>
	    			<div class="league_step4_next">
	    				<img src="./images/index/league_step4_ico_next.png"/>
	    			</div>
	    			<div class="league_step4_row">
	    				<div><img src="./images/index/league_step4_ico_3.png"/></div>
	    				<div class="league_step4_text">签订协议</div>
	    			</div>
	    			<div class="league_step4_next">
	    				<img src="./images/index/league_step4_ico_next.png"/>
	    			</div>
	    			<div class="league_step4_row">
	    				<div><img src="./images/index/league_step4_ico_4.png"/></div>
	    				<div class="league_step4_text">缴纳代理费</div>
	    			</div>
	    			<div class="league_step4_next">
	    				<img src="./images/index/league_step4_ico_next.png"/>
	    			</div>
	    			<div class="league_step4_row">
	    				<div><img src="./images/index/league_step4_ico_5.png"/></div>
	    				<div class="league_step4_text">参加职米运营培训</div>
	    			</div>
	    		</div>
    		</div>
    	</div>
    	
  </body>
</html>
