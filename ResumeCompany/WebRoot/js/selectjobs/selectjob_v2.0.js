var showJob,sType,currentSelected;
var firstTitle = [ "技术制造类","生活服务类", "商务销售类","文化教育类", "环保医疗类", "其他职位" ];
	var secondTitle = [
			[ "普工/技工", "生产/制造", "服装/食品", "质控/安防", "汽车服务", "网络/通信", "电子/电气",
				"机械/仪表", "建筑 " ],
			[ "餐饮", "家政/安保", "美容/美发", "酒店/旅游", "娱乐/休闲", "保健按摩", "运动健身", "网店",
					"百货/零售" ],
			[ "人事/行政", "司机", "销售", "客服", "财务/审计", "金融/投资", "保险", "贸易/采购",
					"物流/仓储", "房产中介", "物业/商业" ],
			[ "市场/公关", "广告/咨询", "美术/创意", "法律", "教育培训", "咨询顾问", "翻译", "编辑/印刷" ],
			[ "农/林/牧/渔业", "医院/护理", "环保" ], [ "其它" ] ];
	var contents = [
			[
				[ "普工", "学徒工", "综合维修工", "制冷工", "锅炉工", "水暖工", "电工", "木工",
						"钳工", "切割工/焊工", "钣金工", "油漆工", "缝纫工", "锅炉工",
						"车工/铣工", "铲车工/叉车工", "铸造/注塑工", "模具工", "电梯工", "操作工",
						"组装工", "包装工", "手机维修", "建筑工", "水泥工", "钢筋工", "管道工",
						"瓦工", "印刷工", "样衣工", "染工", "纺织工", "印花工", "压熨工",
						"洗车工" ],
				[ "质量管理", "设备管理维护", "工艺设计", "车间主任", "生产计划", "化验/检验",
						"维修工程师", "材料工程师", "技术工程师", "生产线长", "生产主管" ],
				[ "服装设计师", "纺织品设计师", "服装打样/制版", "生产管理", "食品饮料", "样衣工",
						"电脑放码员", "纸样师/车板工" ],
				[ "质量管理", "测试经理", "质量检验员", "测试员", "测试工程师", "安全消防",
						"认证工程师/审核员安全管理" ],
				[ "汽车销售", "汽车/摩托车修理", "4S店管理", "汽车检验/检测", "汽车美容", "二手车评估师",
						"理赔专员/顾问", "停车管理员", "加油站工作员", "轮胎工" ],
				[ "程序员", "安卓开发", "IOS开发", "软件工程师", "硬件工程师 ", "质量工程师", "系统架构师",
						" 测试工程师", "网页设计/制作", "网站运营", "网站编辑",
						" 网站策划网络管理员", "网络推广", "网络与信息安全工程师", "数据库管理",
						" 游戏设计/开发 ", "语音/视频/图形" ],
				[ "自动化工程师", "电子/电气工程师 ", "电路工程师", 
						"产品工艺/规划工程师", "音频/视频工程师", "灯光/照明设计工程师", "电子/电器维修","无线电工程师测试/可靠性工程师 " ],
				[ "机电工程师", "机械工程师", "版图设计工程师", "仪器/仪表/计量" ],
				[ "工程项目管理", "工程监理", "土木/土建工程师", "造价师/预算师", "幕墙工程师",
						"安防工程师", "安全管理/安全员", "道路桥梁技术", "给排水/制冷/暖通",
						"测绘/测量", "园林/景观设计", "资料员", "市政工程师", "综合布线/弱电" ] ],
			[
					[ "收银员", "服务员", "送餐员", "厨师", "厨师长", "西厨", "后厨", "传菜员",
							"配菜/打荷", "洗碗工", "切配工", "勤杂工", "面点师", "茶艺师",
							"迎宾/接待", "大堂经理", "领班", "餐饮管理", "学徒工", "咖啡师", "调酒师",
							"预订员", "内勤", "仓管" ],
					[ "保洁", "保姆", "月嫂", "育婴师/保育员", "洗衣工", "钟点工", "保安", "护工",
							" 送水工" ],
					[ "发型师", "美发助理", "美容师", "美容助理", "美甲师", "宠物美容师", "美容顾问",
							"彩妆培训师", "美体师", "店长" ],
					[ "前台", "客房服务员", "餐厅服务员", "楼面经理", "行李员", "救生员", "酒店管理",
							"订票员", "导游", "计调", "签证专员", "旅游顾问", "讲解员" ],
					[ "酒吧服务员", "娱乐厅服务员", "礼仪/迎宾", "主持人", "调酒师", "音效师" ],
					[ "按摩师", "足疗师", "搓澡工", "针灸推拿" ],
					[ "健身教练", "瑜伽教练", "舞蹈老师", "游泳教练", "台球教练", "高尔夫教练", "高尔夫球助理" ],
					[ "网店店长", "淘宝客服", "淘宝美工", "店铺文案", "编辑", "店铺推广活动策划" ],
					[ "店员", "营业员", "收银员", "促销员", "导购员", "理货员", "陈列员", "防损员",
							"内保店长", "卖场经理", "招商经理", "督导", "奢侈品业务", "停车管理员 ",
							"消防中控员" ] ],
			[
					[ "文员", "前台/总机/接待", "人事专员/助理", "人事经理", "人事主管", "经理助理/秘书",
							"薪酬/绩效/员工关系", "猎头顾问", "培训专员/助理", "培训经理", "培训主管",
							"招聘专员/助理", "招聘主管", "招聘经理", "行政专员/助理", "行政主管", "后勤" ],
					[ "商务司机", "客运司机", "货运司机", "出租车司机", "班车司机", "特种车司机",
							"驾校教练/陪练", "公交车司机", "代驾" ],
					[ "销售代表", "电话销售", "销售助理", "销售主管", "销售经理" ],
					[ "客服专员", "呼叫中心", "客服主管", "客服经理", "售前售后", "客服关系" ],
					[ "财务助理", "财务主管", "主办会计", "会计", "出纳", "审计专员", "统计员",
							"税务专员", "成本管理员" ],
					[ "证券/期货/外汇经纪人", "银行会计/柜员", "信用卡/银行卡业务", "投资/理财顾问 " ],
					[ "保险客户经理", "车险专员", "保险内勤", "保险客服", "保险经纪人", "项目经理",
							"保险其他职位" ],
					[ "外贸专员", "外贸主管", "采购专员", "采购助理", "国内贸易", "采购主管","报关员", "跟单员" ],
					[ "物流专员", "物流助理", "物流主管","调度员", "快递员", "仓库管理员", "仓库主管",
							"装卸/搬运工", "供应链管理", "单证员", "国际货运" ],
					[ "房产经纪人", "置业顾问", "房产店长", "房产评估师", "房产开发/策划", "其他房产职位" ],
					[ "物业管理员", "物业维修", "物业主管", "物业经理", "合同管理", "招商主管", "招商经理" ] ],
			[
					[ "市场专员", "市场拓展", "市场调研", "市场策划", "会务会展专员", "品牌专员", "公关专员",
							"企划主管" ],
					[ "广告设计/制作", "广告创意媒介策划/管理", "会展策划/设计", "婚礼策划师", "咨询顾问" ],
					[ "美编/美术设计", "服装设计", "家具/家居用品设计", "平面设计", "美术指导",
							"店面/陈列/展览设计", "工艺/珠宝设计", "多媒体/动画设计", "产品/包装设计",
							"装修装潢设计", "CAD设计/制图" ],
					[ "律师", "法律顾问", "法务专员", "产权/专利顾问", "合规管理", "其他职位" ],
					[ "教师", "家教", "助教", "幼教", "培训师", "课程顾问", "野外拓展" ],
					[ "企管顾问", "咨询员", "调研员", "培训师/讲师", "涉外咨询师", "咨询经理" ],
					[ "英语翻译", "日语翻译", "韩语翻译", "法语翻译", "俄语翻译", "德语翻译", "西班牙语翻译",
							"意大利语翻译", "葡萄牙语翻译", "阿拉伯语翻译", "小语种翻译" ],
					[ "出版/发行", "排版设计/制作", "印刷操作", "装订/烫金" ] ],
			[
					[ "饲料业务养殖人员", "农艺师", "花艺师", "畜牧师" ],
					[ "护士", "护士长", "导医", "药剂师", "理疗师", "验光师", "营养师", "宠物护理",
							"兽医", "医疗器械维修" ],
					[ "污水处理工程师", "环境工程技术", "EHS管理", "环保工程师", "环保检测", "水质检测员",
							"环境绿化" ] ], [ [ "实习生", "储备干部", "志愿者" ] ] ];
			$(function(){
				var allDataHtml="";
				for(var row=0;row<firstTitle.length;row++)
				{
					var rowItemHtml="";
			        if(row % 2 == 0){
			        	rowItemHtml="<tr class='grayline'><td class='job_left_td' align='center'>"+firstTitle[row]+"</td>"+"<td><ul class='secondRow'>";
			        }else{
			        	rowItemHtml="<tr><td class='job_left_td' align='center'>"+firstTitle[row]+"</td>"+"<td><ul class='secondRow'>";
			        }
					for(var second=0;second<secondTitle[row].length;second++)
					{
						rowItemHtml+="<li id='"+row+"|"+second+"' class='second_li'><div class='show_second_title'>"+secondTitle[row][second]+"</div><div style='position:absolute;z-index:14;'><s><i></i></s><div class='show_job_content'></div></div></li>";
					}
					rowItemHtml+="</ul></td></tr>";
					allDataHtml+=rowItemHtml;
				}
				$("#dialog_show_table").html(allDataHtml);
				$(".secondRow").each(function(){
					$(this).find(".show_second_title").click(function(e){
						e.stopPropagation();
						var liId=$(this).parent("li").attr("id");
						var splitIndex=liId.indexOf("|");
						var firstIndex=parseInt(liId.substring(0,splitIndex));
						var secondIndex=parseInt(liId.substring(splitIndex+1));
						var itemData=contents[firstIndex][secondIndex];
						var showItem=$(this).parent("li").find(".show_job_content");
						var thisS=$(this).parent("li").find("s");
						if(showItem.css("display")!="none")
						{
							showItem.slideUp(300);
							setTimeout(function(){
								thisS.hide();
							},300);
							return;
						}
						var contentRowHtml="<ul class='contentRow'>";
						for(var contentIndex=0;contentIndex<itemData.length;contentIndex++)
						{
							contentRowHtml+="<li id='"+firstIndex+"|"+secondIndex+"|"+contentIndex+"' class='content_li'><span class='content_item'>"+itemData[contentIndex]+"</span></li>";
						}
						contentRowHtml+="</ul>";
						showItem.html(contentRowHtml);
						initContentItem();
						showItem.slideDown(300);
						currentSelected=showItem;
						if($(this).text().length<=2)
						{
							if(myBrowser()=="IE")
							{
								thisS.css("left","-30px");
							}else
							{
								thisS.css("left","8px");
							}
						}
						thisS.show();
						showItem.focus();
						$(".show_job_content").each(function(){
							$(this).unbind("mouseleave");
							$(this).unbind("blur");
							var guideIcon=$(this).prev("s");
							if($(this).css("display")!="none")
							{
								$(this).bind("mouseleave",function(e){
									e.stopPropagation(); 
									$(this).slideUp(300);
									setTimeout(function(){
										guideIcon.hide();
									},300);
								});
								$(this).bind("blur",function(e){
									e.stopPropagation(); 
									$(this).slideUp(300);
									setTimeout(function(){
										guideIcon.hide();
									},300);
								});
							}
						});
					});
				});
			});
			function initContentItem()
			{
				$(".show_job_content").each(function(){
					$(this).hide();
					var showJobContent=$(this);
					showJobContent.prev("s").hide();
					showJobContent.click(function(e){
						 e.stopPropagation(); 
					});
					$(this).find(".content_li").each(function(){
						$(this).unbind("click");
						$(this).click(function(e){
							 e.stopPropagation();    //  阻止事件冒泡
							 var guideIcon=$(this).parents(".show_job_content").prev("s");
//							 showJobContent.slideUp(300);
//							 setTimeout(function(){
//									guideIcon.hide();
//								},300);
							 showJobContent.hide();
							 guideIcon.hide();
							 var selectedIds=$(this).attr("id");
							 var firstSplitIndex=selectedIds.indexOf("|");
							 var lastSplitIndex=selectedIds.lastIndexOf("|");
							 var firTiId=parseInt(selectedIds.substring(0,firstSplitIndex));
							 var secTiId=parseInt(selectedIds.substring(firstSplitIndex+1,lastSplitIndex));
							 var contentTypeId=parseInt(selectedIds.substring(lastSplitIndex+1));
							 var secTi=secondTitle[firTiId][secTiId];
							 var contentType=contents[firTiId][secTiId][contentTypeId];
							 if(sType=="input")
							 {
								 showJob.val(contentType);
							 }else
							 {
								 showJob.text(contentType);
							 }
							 $("#submitJobType").val(secTi+"-"+contentType);
							 showJob.blur();
							$("#select_job_dialog").slideUp(300);
						});
					});
					
				});
			}
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
			//初始化，传显示所选值的jquery对象
			function jobInit(jobText,showType)
			{
				showJob=jobText;
				sType=showType;
				jobText.click(function(){
					jobText.blur();
					$("#select_job_dialog").unbind("mouseleave");
					if($("#select_job_dialog").css("display")!="none")
					{
						$("#select_job_dialog").slideUp(300);
						currentSelected.hide();
						currentSelected.prev("s").hide();
					}else
					{
						$("#select_job_dialog").slideDown(300);
						$("#select_job_dialog").bind("mouseleave",function(e){
							$("#select_job_dialog").slideUp(300);
							 e.stopPropagation();
							 currentSelected.hide();
							 currentSelected.prev("s").hide();
						});
					}
				});
				$("form").append("<input type='hidden' name='job.category' id='submitJobType'/>")
			}