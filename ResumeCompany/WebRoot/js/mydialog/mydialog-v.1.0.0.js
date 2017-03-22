var topPer="130px";
var hiddenPer="40%";
function initDialog(isFrame)
{
	if(isFrame)
	{
		topPer="18%";
	}else{
		topPer="130px";
	}
}
function baseDialog(){
		if($("#dialog_home").length==0)
		{
			$("body").append("<div id='dialog_home'></div>")
		}
		var dialogHtml="<div id='my_dialog'>"+
			"	<div id='dialog_title'>"+
			"		<div style='float:left;width:145px;' id='dialog_title_name'></div>"+
			"		<div onclick='closeDialog()' id='dialog_remove'><img alt='' src='images/remove.png'></div>"+
			"	</div>"+
			"	<div id='dialog_content'></div>"+
			"	<div id='dialog_bottom'></div>"+
			"</div>";
		$("#dialog_home").html(dialogHtml);
		
	}
	function alertDialog(content){
		baseDialog();
		resetDialogSize("300px","180px");
		$("#my_dialog").show();
		var contentHtml="<div id='alert_img' style='float:left;'><img src='images/alert_img.png'></div><div id='alert_content_text'></div>";
		var bottomHtml="<input style='width:110px;' type='button' id='cancelBtn' class='cgBtn' hidefocus='true' onclick=\"closeDialog();\" value='确&nbsp;定'/>";
		$("#dialog_content").html(contentHtml);
		$("#dialog_bottom").html(bottomHtml);
		$("#dialog_remove").hide();
		$("#dialog_content").css("height","100px");
		$("#alert_img").find("img").css("top","21px");
		$("#alert_content_text").css("width","190px");
		$("#dialog_bottom").css("text-align","center");
		$("#alert_content_text").css("overflow","hidden");
		if(content.length>13)
		{
			$("#alert_content_text").css("padding","25px 0px");
			var contentTempHtml="<div style='height:30px;line-height:25px;word-break: break-all;'>"+content+"</div>";
			$("#alert_content_text").html(contentTempHtml);
		}else
		{
			$("#alert_content_text").css("height","100px");
			$("#alert_content_text").css("line-height","100px");
			$("#alert_content_text").css("vertical-align","middle");
			$("#alert_content_text").text(content);
		}
		$("#dialog_title_name").text("信息提示");
		
		
		$("#my_dialog").animate({top:topPer},400);
	}
	function closeDialog(){
// 		$("#my_dialog").hide();
// 		$("#my_dialog").css("top","-100px");
		$("#my_dialog").animate({top:"-"+hiddenPer},400);
	}
	function resetDialogSize(width,height)
	{
		$("#my_dialog").css("width",width);
		$("#my_dialog").css("height",height);
	}