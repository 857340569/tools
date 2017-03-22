	//初始化
var mark=0;
var othType=0;
function mySelectInit()
	{
		$("select").each(function(){
			var itemSelect=$(this);
			$(this).css("display","none");
			//不能设置默认选择
//			$(this).find("option:nth-child(1)").attr("selected" , "selected");
			var currentOptionHtml="<div class='zjp_myselect'><div class='zjp_myselect_currentSelect'><span class='zjp_myselect_currentSelect_show'>当前选择</span><span class='zjp_myselect_currentSelect_icon'></span></div><div class='zjp_myselect_options' tabindex='0' hidefocus='true'>";
			var selectVal="";
			$(this).find("option").each(function(){
// 				alert($(this).val());
				var thisValu=$(this).text();
				currentOptionHtml+="<div class='zjp_myselect_option_item'>"+thisValu+"</div>"
				currentOptionHtml+="<div class='zjp_myselect_option_splitline'></div>"
			});
			currentOptionHtml+="</div><div style='clear:both;'></div></div>";
			$(this).before("<div style='clear:both;'></div>");
			$(this).after(currentOptionHtml);
// 			alert($(this).find("option").length);
			var selectAfterDiv=$(this).next(".zjp_myselect");
			var thisValu=$(this).find("option:selected").text();
			selectAfterDiv.find(".zjp_myselect_currentSelect_show").text(thisValu);
			//失去焦点后自动关闭
			selectAfterDiv.find(".zjp_myselect_options").blur(function(){
				selectAfterDiv.find(".zjp_myselect_options").slideUp(300);
			});
			
			//模拟点击select显示option
			selectAfterDiv.find(".zjp_myselect_currentSelect").click(function(){
				//关闭之前打开的选项,下面方法由div失去焦点关闭，效果比较好
 				$(".zjp_myselect").each(function(){
 					var eachOptionShowStatus=$(this).find(".zjp_myselect_options").css("display");
 					if(optionShowStatus!="none"&&selectAfterDiv.find(".zjp_myselect_options").html()!=$(this).find(".zjp_myselect_options").html())
 					{
 						$(this).find(".zjp_myselect_options").hide();
// 						return false;
 					}
 				});
				 $("body").unbind("click");
				 mark=0;
				 var currentSelect=$(this);
				 $("body").click(function(e){
					closeOptionOnBlur(e,currentSelect.next(".zjp_myselect_options"));
					mark=0;
					if(othType==1)
					{
						closeOptionClick(e,$("#data_option_dialog"));
					}
    			});
    			mark=1;
				var optionShowStatus=selectAfterDiv.find(".zjp_myselect_options").css("display");
				if(optionShowStatus!="none")
				{
					selectAfterDiv.find(".zjp_myselect_options").slideUp(300);
				}else
				{
					selectAfterDiv.find(".zjp_myselect_options").slideDown(300);
//					selectAfterDiv.find(".zjp_myselect_options").focus();
				}
			});
			selectAfterDiv.find(".zjp_myselect_option_item").each(function(){
				//设置每个条目的鼠标经过及点击事件
				$(this).mouseover(function(){
					$(this).css("background","#eeeeee");
				});
				$(this).mouseout(function(){
					$(this).css("background","");
				});
				$(this).attr("onmouseover","this.style.background='#eeeeee'");
				$(this).attr("onmouseout","this.style.background=''");
				$(this).click(function(){
					selectVal=$(this).text();
					itemSelect.find("option").each(function(){
						if($(this).text()==selectVal){
							$(this).attr("selected" , "selected");
						}
					});
					//触发select的onchange事件；
					itemSelect.change();
					//暂时不容易获取selectedItemIndex
// 					itemSelect.find("option:nth-child("+selectedItemIndex+")").attr("selected" , "selected");
					selectAfterDiv.find(".zjp_myselect_currentSelect_show").text(selectVal);
					selectAfterDiv.find(".zjp_myselect_options").slideUp(300);
					itemSelect.focus();
					itemSelect.blur();
				});
				
// 				初始化所有option背景颜色
// 				selectAfterDiv.find(".zjp_myselect_option_item").each(function(){
// 					$(this).css("background","#fff");
// 				});
			});
		});
	}
	//根据select得新设置大小
	function mySelectResize(){
		$("select").each(function(){
			var itemSelect=$(this);
			var itemSelectWidthPx=itemSelect.css("width");
			var itemSelectHeightPx=itemSelect.css("height");
			var itemSelectFontSizePx=itemSelect.css("font-size");
			var itemSelectMarginLeftPx=itemSelect.css("margin-left");
// 			alert(itemSelectWidthPx+itemSelectHeightPx+itemSelectFontSizePx+itemSelectMarginLeftPx);
			var itemSelectWidthInt=itemSelectWidthPx.substring(0,itemSelectWidthPx.lastIndexOf("px"));
			var itemSelectHeightInt=itemSelectHeightPx.substring(0,itemSelectHeightPx.lastIndexOf("px"));
			itemSelectHeightInt=parseInt(itemSelectHeightInt)+4;
			//设置myselect的宽度
			var myselectAfterDiv=itemSelect.next(".zjp_myselect");
			myselectAfterDiv.css("width",itemSelectWidthPx);
			myselectAfterDiv.css("margin-left",itemSelectMarginLeftPx);
			
			var myselectCurrentSelect=myselectAfterDiv.find(".zjp_myselect_currentSelect");
			myselectCurrentSelect.css("height",itemSelectHeightInt+"px");
			myselectCurrentSelect.css("line-height",itemSelectHeightInt+"px");
			myselectCurrentSelect.css("font-size",itemSelectFontSizePx);
			
			var myselectOptions=myselectAfterDiv.find(".zjp_myselect_options");
			myselectOptions.css("width",(parseInt(itemSelectWidthInt)-2)+"px");
			
			myselectAfterDiv.find(".zjp_myselect_option_item").each(function(){
				$(this).css("height",itemSelectHeightInt+"px");
				$(this).css("line-height",itemSelectHeightInt+"px");
				$(this).css("font-size",itemSelectFontSizePx);
			});
		});
	}
	//根据select得新设置大小
	function mySelectResizeParam(selectWidth,selectHeight,fontSize,selectMarginLeft){
		selectHeight+=2;
		$("select").each(function(){
			var itemSelect=$(this);
			//设置myselect的宽度
			var myselectAfterDiv=itemSelect.next(".zjp_myselect");
			myselectAfterDiv.css("width",selectWidth+"px");
			myselectAfterDiv.css("margin-left",selectMarginLeft+"px");
			
			var myselectCurrentSelect=myselectAfterDiv.find(".zjp_myselect_currentSelect");
			myselectCurrentSelect.css("height",selectHeight+"px");
			myselectCurrentSelect.css("line-height",selectHeight+"px");
			myselectCurrentSelect.css("font-size",fontSize+"px");
			
			var myselectOptions=myselectAfterDiv.find(".zjp_myselect_options");
			myselectOptions.css("width",(selectWidth-2)+"px");
			
			myselectAfterDiv.find(".zjp_myselect_option_item").each(function(){
				myselectCurrentSelect.css("height",selectHeight+"px");
				myselectCurrentSelect.css("line-height",selectHeight+"px");
				myselectCurrentSelect.css("font-size",fontSize+"px");
			});
		});
	}
	function closeOptionOnBlur(e,obj){
		var x=e.clientX; 
	    var y=e.clientY; 
	    var divx1 = obj.offset().left; 
	    var divy1 = obj.offset().top; 
	    var divx2= divx1 + obj.width(); 
	    var divy2 =divy1+ obj.height();
	    if(x> divx1&&x <divx2 &&y> divy1&&y <divy2)
	    {
// 	    	 alert("in");  
	    }else
	    {
//	    	alert("outer");
    	 if(mark!=1)
    	 {
    	 	 obj.slideUp(300);
    	 }
	    }
	}
	function setOtherParam(type)
	{
		
		othType=type;
	}
	function closeOptionClick(e,obj){
		var isInClick=testIn(e,$("#show_secom_name"));
		var isInDialog=testIn(e,obj);
    	if(!isInClick&&!isInDialog&&obj.css("display")!="none")
    	{
    		obj.slideUp(300);
    	}
	}
	function testIn(e,obj)
	{
		var x=e.clientX; 
	    var y=e.clientY; 
	    var divx1 = obj.offset().left; 
	    var divy1 = obj.offset().top; 
	    var divx2= divx1 + obj.width(); 
	    var divy2 =divy1+ obj.height();
	    if(x> divx1&&x <divx2 &&y> divy1&&y <divy2)
	    {
	    	return true; 
	    }else
	    {
	    	return false;
	    }
	}