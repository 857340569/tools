var code ; //在全局 定义验证码  
function createCode()  
{  
    code = "";  
    var codeLength = 4;//验证码的长度  
    //所有候选组成验证码的字符，可以用中文  
    var selectChar = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');  
    for(var i=0;i<codeLength;i++)  
    {  
        var charIndex = Math.floor(Math.random()*60);  
        code +=selectChar[charIndex];  
    }  
    return code;  
}  
function validate()  
{  
    var inputCode = document.getElementById("vcode").value.toLowerCase();  
    if(inputCode.length <=0)  
    {  
    	alertDialog("请输入验证码！");  
        return false;  
    }  
    else if(inputCode != code.toLowerCase())  
    {  
    	alertDialog("验证码输入错误！");  
        show();//刷新验证码  
        return false;  
    }  
    else  
    {  
        return true;  
    }  
}  
function show(){  
        //显示验证码  
        document.getElementById("code").src="code!createCode?code="+createCode();  
}  
window.onload = function() {//document.onload=show();  
	  show();//页面加载时加载验证码  
  //这时无论在ie还是在firefox中，js没有加载完，页面的东西是不会被执行的；  
} 
