
	var xmlhttp;
    var pathDir;
    var firstMargin=true;
    //saveDir 保存的位置，firstIsMargin左边第一个是否要调整位置
    function initFlashUpload(saveDir,firstIsMargin)
    {
    	pathDir=saveDir;
    	firstMargin=firstIsMargin;
    	$("#flsu").html("<span id='swfcontent'></span>");
    	showSwf();
    	resetImg(false);
    }
    function getInfo()
    {
	    // 创建XMLHTTPRequest对象
	 	xmlhttp=window.XMLHttpRequest?(new XMLHttpRequest()):(new ActiveXObject("Microsoft.XMLHTTP"));//选择合适的xmlhttprequest控件 
	    var url = "/badou_upload/api!lessGet?path_key=company";     
	    xmlhttp.open("get", url, false);   
	    xmlhttp.onreadystatechange = stateChange;  
	    xmlhttp.send(null);  
    }
    function stateChange()
    {
      if(xmlhttp.readyState == 4)
      {
	       var info = xmlhttp.responseText;
	       eval("var json= " + info);
	       pathDir=json.path_val;
      }
    }
    function asConfig()
	{
    	var param={
			url:"/badou_upload",
			action:"ajax!flashUploadImg",
			limitSize:2048,//单位k,max 2*1024
			dir:pathDir
    	};
		return param;
	}
	var count=100;//避免与前面已读取的图片id重复
	function callBack(type,data)
	{	
		$("#upd_tips").attr("class","Validform_checktip");
		$("#upd_tips").text("最多可上传3张图片，支持jpg/gif/png/jpeg格式");
		switch(type)
		{
			case -1://禁止上传,超出大小限制
				$("#upd_tips").attr("class","Validform_checktip Validform_wrong");
				$("#upd_tips").text("上传的图片不能超过2M");
			break;
			case 0://开始上传
				$("#led_img_sn").append("<span class='uld_img' id='"+count+"'><label class='tle'>图片上传中</label><br><label id='progre"+count+"' class='prog'></label></span>");
				if($(".uld_img").length>=3)
				{
//					$("#flsu").attr("class","addFull");
//					$("#plgi").attr("class","addFull");
//					$("#flsu").attr("class", "addFull");
//					$("#flsu").find("object").attr("class", "addFull");
					//$("#flsu").after("<div id='hid_fsh' style='float:left;height:120px;width:120px;position:relative;left:-110px;background:#fff;'></div>")
					$("#flsu").after("<div id='hid_fsh' style='height:102px;width:102px;position:relative;background:#fff;float:left;left:-102px;'></div>")
				}else{
					resetImg(false);
				}
			break;
			case 1://上传进度
				$("#progre"+count).text(data);
			break;
			case 2://上传完成
				$("#"+count).html("<img src='"+data+"' class='upd_img' > <img class='remove' id='rem"+count+"' src='images/remove.png' title='删除'>");
				$("#"+count).mouseout(function(){
					$(this).find(".remove").css("display","none");
				});
				$("#"+count).mouseover(function(){
					$(this).find(".remove").css("display","block")
				});
				resetImg(false);
				count++;
			break;
			default:
			break;
		}
		if(firstMargin)
		{
			$(".uld_img:first").css("margin-left","160px");
		}
	}
	function bindEvent(isDelFile){
		unbindEvent();
		var isSwfShow=false;
		$(".uld_img").each(function(){
        	$(this).mouseout(function(){
    			$(this).find(".remove").css("display","none");
    		});
    		$(this).mouseover(function(){
    			$(this).find(".remove").css("display","block");
    		});
    		$(this).find(".remove").click(function(){
				isSwfShow=$(".uld_img").length<3;
				var urlStr=$(this).prev("img").attr("src");
				var fileName=urlStr.substring(urlStr.lastIndexOf("/")+1);
//				alert(fileName);
				$(this).parent(".uld_img").remove();
				if(isDelFile){
					deleteImg(pathDir,fileName);
				}
				reloadLocation();
				if(!isSwfShow&&$(".uld_img").length<3)
				{
//					$("#plgi").attr("class","addLess");
//					$("#flsu").attr("class","addLess");
//					$("#flsu").css("display","inline");
					showSwf();
				}
			});
      	 });
	}
	function unbindEvent(){
		$(".uld_img").each(function(){
			$(this).unbind("mouseout");
        	$(this).unbind("mouseover");
        	$(this).find(".remove").unbind("click");
      	 });
	}
	 function resetImg(isDelFile){
		 reloadLocation();
		 bindEvent(isDelFile);
		 if($(".uld_img").length>=3){
			 	closeSwf();
			 	$("#flsu").next("#hid_fsh").remove();
			}
	 }
	 function reloadLocation(){
		 if($(".uld_img").length<=0)
			{
				if(firstMargin){
					$("#flsu").css("margin-left","160px");
				}
			}else
			{
				if(firstMargin){
					$(".uld_img:first").css("margin-left","160px");
				}
				$("#flsu").css("margin-left","8px");
			}
	 }
	 function deleteImg(savePath,fileName){
		 	$.ajax({
				type:"post",
				async:false,
				dataType:"json",
				url:"ajax!deleteUnusedImg",
				data:{
					"savePath":savePath,
					"fileName":fileName
				},
				success:function(data){
				}
			});	
		 }
	 function showSwf() {
			$("#flsu").attr("class", "addLess");
			$("#flsu").show();
			swfobject.embedSWF("upload_img_do.swf", "swfcontent", "100", "100", "10.0.0",
					"upload_img_do.swf", null, {wmode: "transparent"});
		}
	 function closeSwf() {
			$("#flsu").hide();
			$("#flsu").html("<span id='swfcontent'></span>");
	 }