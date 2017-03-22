$.Datatype.zh = /^[\u4E00-\u9FA5\uf900-\ufa2d]{1,}$/;
$.Tipmsg.w.zh = "请输入中文字符！";
$.Datatype.le = /^[A-Za-z\d_^\s]{1,}$/;
$.Tipmsg.w.le = "请输入英文字符！";
$.Datatype.nozh = /^[^\u4E00-\u9FA5\uf900-\ufa2d]{1,}$/;
$.Tipmsg.w.nozh = "请输入英文字符！";
$.Datatype.nospace = /^[^\s]{1,}$/;
$.Tipmsg.w.nospace= "不能包含空格！";
//errormsg="联系电话输入有误，请输入手机或电话！" 
//datatype="m|tel" 不要写errormsg
$.Datatype.tel=/^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/;
$.Tipmsg.w.tel= "请输入正确的手机或座机号码！";
$.Datatype.specialpass = /^[A-Za-z\d_\s]{1,}$/;
$.Tipmsg.w.specialpass = "密码只能为数字，字母，下画线及空格！";
$.Datatype.morespace=/^\s{1,}$/;
$.Datatype.floatint= /^(([1-9]\d*)|0)(\.\d*)?$/;
$.Tipmsg.w.floatint="请输入大于零的数！";
$.Datatype.intl= /^[0-9]$/;
$.Tipmsg.w.intl="请选择！";
$.Datatype.month= /^[1-9]\d*?$/;
$.Tipmsg.w.month="请输入正整数！";
$.Datatype.gcardid=/^\d{8}(0\d|1[012])([012]\d|3[01])\d{3}$/;
$.Tipmsg.w.gcardid="一代身份证格式不正确！";
$.Datatype.sgcardid=/^\d{6}(18|19|20)\d{2}(0\d|1[012])([012]\d|3[01])\d{3}(\d|X)$/;
$.Tipmsg.w.sgcardid="二代身份证格式不正确！";
$.Datatype.percent=/^(([1-9]\d?|0)(\.\d*)?|100(\.0{1,2})?)$/;
$.Tipmsg.w.percent="百分比不正确！";
$.Datatype.ft= /^(\d{1,}|0)(\.\d{1,2})?$/;
$.Tipmsg.w.ft="最多只能保留两位小数！";
$.Datatype.betweenMoney= /^(\d{1,5}|0)(\.\d{1,})?$/;
$.Tipmsg.w.betweenMoney="金额不能超过10亿！";
$.Datatype.maxMoney= /^10{5}(\.0|\.00)?$/;
$.Tipmsg.w.maxMoney="金额不能超过10亿！";
$.Datatype.spenum= /^-?([1-9]\d*|0)(\.\d+)?$/;
$.Tipmsg.w.spenum="请输入正确的数字！";
//验证需求人数
$.Datatype.rqNum=/^[1-9]\d{0,2}$|\u82e5\u5e72$/;
$.Tipmsg.w.rqNum="人数为1～3位整数且不能为0或若干！";
//收货地址
$.Datatype.lstTen= /^.{10,}$/;
$.Tipmsg.w.lstTen="不能少于10个汉字！";
$.Datatype.moreTwoH= /^.{1,200}$/;
$.Tipmsg.w.moreTwoH="不能多于200个汉字！";
$.Datatype.junguanReg= /^\d{8}$/;
$.Tipmsg.w.junguanReg="正确军官证号为8位数字！";
$.Datatype.eMinLength= /^.{4,}$/;
$.Tipmsg.w.eMinLength="邮箱地址不能少于4个字符！";
$.Datatype.eMaxLength= /^.{1,200}$/;
$.Tipmsg.w.eMaxLength="邮箱地址不能多于200个字符！";
$.Datatype.email=/^[0-9a-z][a-z0-9\._-]{1,}@[a-z0-9-]{1,}[a-z0-9]\.[a-z\.]{1,}[a-z]$/;
$.Tipmsg.w.email="邮箱地址格式不正确！";
//验证日期格式
$.Datatype.date=/^\d{4}-(\d{2}|\d)-\d\d?$/;
$.Tipmsg.w.date="日期格式不正确！";
//可以验证闰年
$.Datatype.sdate=/^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;
$.Tipmsg.w.sdate="输入的日期不存在！";
//验证上传证书文件只能为pdf,word,images(png,gif)等文件类型
$.Datatype.sfile= /^.+(\.png|\.gif|\.jpg|\.bmp|\.jpeg|\.pdf|\.doc|\.docx)$/;
$.Tipmsg.w.sfile="请选择pdf、word、images类型文件！";

//验证用户名[_a-zA-Z][_a-zA-Z0-9]{4,19}
$.Datatype.usName= /^[_a-zA-Z][_a-zA-Z0-9]{4,19}$/;
$.Tipmsg.w.usName="长度为5~20位字符,以下划线或者英文开头,由“数字/字母/下划线”组成";