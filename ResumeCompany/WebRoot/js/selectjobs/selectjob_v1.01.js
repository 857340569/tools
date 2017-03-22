var jobShowId;
var jobShowType;
var typeTitles=["商务服务岗位","生活服务岗位","技术/制造岗位"];
	var typeContents=[["销售员","客服","话务员","人事","司机","快递员","仓管","搬运工","调度员","采购员","会计","统计员","文员","主管","经理","店长","平面设计"],
		["服务员","厨师","面点师","传菜员","配菜打荷","洗碗工","后厨","迎宾","大堂经理","送餐员","学徒","酒店前台","订票员","导游","营业员","导购员","收银员","理货员","发型师","美容师","化妆师","洗头工","美甲师","按摩师","足疗师","保洁","保姆","保安","月嫂","洗衣工","小时工","调酒师","门卫","领班"],
		["普工","电工","木工","钳工","焊工","钣金工","油漆工","缝纫员","叉手工","操作工","包装工","水泥工","管道工","纺织员","印花工","压熨工","组装工","厂长","样衣工","养殖员","汽车维修","汽车美容","洗车工","轮胎工","技术员","作业员","品检","线长"]];
	$(function(){
		var titleHtml="";
		for(var i=0;i<typeTitles.length;i++)
		{
			if(i==0)
			{
				titleHtml+="<li class='select_type_item_li type_item_li_selected' arryIndex="+i+">"+typeTitles[i]+"</li>";
			}else{
				titleHtml+="<li class='select_type_item_li' arryIndex="+i+">"+typeTitles[i]+"</li>";
			}
		}
		$("#type_title_ul").html(titleHtml);
		var contentInit=typeContents[0];
		setContentHtml(contentInit);
		$(".select_type_item_li").each(function(){
			$(this).click(function(){
				$(".select_type_item_li").each(function(){
					$(this).attr("class","select_type_item_li");
				});
				var currentItem=$(this).attr("arryIndex");
				var typeContentItem=typeContents[currentItem];
				setContentHtml(typeContentItem);
				$(this).attr("class","select_type_item_li type_item_li_selected");
			});
		});
	});
	function setContentHtml(contentItemArray)
	{
		var typeContentHtml="";
		for(var i=0;i<contentItemArray.length;i++)
		{
			typeContentHtml+="<li class='select_type_content_item_li'>"+contentItemArray[i]+"</li>";
		}
		$("#type_content_ul").html(typeContentHtml);
		reloadTypeCotentEvent();
	}
	
	function reloadTypeCotentEvent()
	{
		$(".select_type_content_item_li").each(function(){
			$(this).unbind("click");
		});
		$(".select_type_content_item_li").each(function(){
			$(this).click(function(){
				$(".select_type_content_item_li").each(function(){
					$(this).attr("class","select_type_content_item_li");
				});
				$(this).attr("class","select_type_content_item_li select_type_content_item_selected");
				var selectedVal=$.trim($(this).text());
				if(jobShowType==1)
				{
					$("#"+jobShowId).val(selectedVal);
				}else
				{
					$("#"+jobShowId).text(selectedVal);
				}
				$('.mna_selectName_dialog').slideUp(300);
				$("#"+jobShowId).focus();
			});
		});
	}
	//jobShowId:显示职位的控件id,jobShowType显示控件的类型，1 input 其它 
	function initSelectJob(jobShowIdPara,jobShowTypePara)
	{
		jobShowId=jobShowIdPara;
		jobShowType=jobShowTypePara;
		$("#"+jobShowId).click(function(){
			$('.mna_selectName_dialog').slideDown(300);	
		});
	}