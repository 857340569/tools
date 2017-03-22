(function(a) {
	a.Placeholder = {
		settings : {
			color : "rgb(169,169,169)",
			dataName : "original-font-color"
		},
		init : function(b) {
			if (b) {
				a.extend(a.Placeholder.settings, b)
			}
			var c = function(b) {
				return a(b).val()
			};
			var d = function(b, c) {
				a(b).val(c)
			};
			var e = function(b) {
				return a(b).attr("placeholder")
			};
			var f = function(a) {
				var b = c(a);
				return b.length === 0 || b == e(a)
			};
			var g = function(b) {
				a(b).data(a.Placeholder.settings.dataName, a(b).css("color"));
				a(b).css("color", a.Placeholder.settings.color)
			};
			var h = function(b) {
				a(b).css("color", a(b).data(a.Placeholder.settings.dataName));
				a(b).removeData(a.Placeholder.settings.dataName)
			};
			var i = function(a) {
				d(a, e(a));
				g(a)
			};
			var j = function(b) {
				if (a(b).data(a.Placeholder.settings.dataName)) {
					d(b, "");
					h(b)
				}
			};
			var k = function() {
				if (f(this)) {
					j(this)
				}
			};
			var l = function() {
				if (f(this)) {
					i(this)
				}
			};
			var m = function() {
				if (f(this)) {
					j(this)
				}
			};
			a("textarea,input[type='text']").each(function(b, c) {
				if (a(c).attr("placeholder")) {
					a(c).focus(k);
					a(c).blur(l);
					a(c).bind("parentformsubmitted", m);
					a(c).trigger("blur");
					a(c).parents("form").submit(function() {
						a(c).trigger("parentformsubmitted")
					})
				}
			});
			   //对password框的特殊处理1.创建一个text框 2获取焦点和失去焦点的时候切换
			var count=0;
			$("input[type=password]").each(function(){
				var pwdField=$(this);
				var pwdVal= $(this).attr('placeholder');
				$(this).after('<input id="pwdPlaceholder'+count+'" type="text" value='+pwdVal+' autocomplete="off" />');
				var pwdPlaceholder = $('#pwdPlaceholder'+count);
				pwdPlaceholder.attr("class","registInputss");
		        pwdPlaceholder.data(a.Placeholder.settings.dataName, pwdPlaceholder.css("color"));
		        pwdPlaceholder.css("color", a.Placeholder.settings.color)
		        pwdPlaceholder.show();
		        pwdField.hide();
		        pwdPlaceholder.focus(function(){
		        	pwdPlaceholder.hide();
		        	pwdField.show();
		        	pwdField.focus();
		        });
		        
		        pwdField.blur(function(){
		        	if(pwdField.val() == '') {
		        		pwdPlaceholder.show();
		        		pwdField.hide();
		        	}
		        });
				 count++;
			});
		},
		cleanBeforeSubmit : function(b) {
			if (!b) {
				b = a("form")
			}
			a(b).find("textarea, input[type='text']").trigger(
					"parentformsubmitted");
			return b
		}
	}
})(jQuery)