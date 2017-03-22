<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script src="js/validform/Validform_v5.3.2_min.js" type="text/javascript" language="javascript"></script>
        <script language="JavaScript" type="text/JavaScript" src="./js/common.js"></script> 
        <title>process bar</title>  
        <style type="text/css">
        	#load {
				position: absolute;
				z-index: 22;
				background: #ffffff;
				height: 100%;
				width: 100%;
				filter: alpha(opacity=60); 
				opacity: 0.7;
			}
        </style>
        <script type="text/javascript" language="JavaScript">  
              
            //判断网页是否加载完成  
            document.onreadystatechange = function () {   
                if(document.readyState=="complete") {         
                    document.getElementById('load').style.display='none';   
                }  
            };
              
        </script>  
    </head>  
    <body>  
      <div id="load" align="center" style="width: 100%;height: 100%;">
		<img style="margin-top: 400px" src="./images/badou_load.gif">
	</div>
    </body>  
</html> 