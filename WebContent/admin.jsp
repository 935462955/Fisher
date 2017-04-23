<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fisher</title>
<link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="bootstrap-3.3.7-dist/js/jquery-3.1.1.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="bootstrap-3.3.7-dist/js/fisherJS.js"></script>
<link href="bootstrap-3.3.7-dist/css/fisherStyle.css" rel="stylesheet">
<script>
$(document).ready(function(){
	$("#cover").css("width",$(window).width());
    $("#cover").css("height",$(window).height());
})

function AccountCheck(x){
	    var xmlhttp; 
	   
		if (window.XMLHttpRequest)
		  {// code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		  }
		else
		  {// code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		  xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    { 
		    var x=xmlhttp.responseText;
		    if(x == "false")
		    	alert("账户名或密码错误");
		    else
		    	window.location.href="main.jsp";
		    }
		  }
		  
		  xmlhttp.open("post","AccountCheck",true);
		  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		  xmlhttp.send("account="+$("#account").val()+"&password="+$("#password").val());
}
</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden;background-size:cover;background-image:url(img/timg.jpg)">
<div id="cover" style="background:#000;width:1000px;height:1000px;opacity:0.5;">
</div>
<div  style="background:#fff;width:40%;height:60%;z-index:10;position:absolute;left:30%;top:20%;border-radius:15px;">
			<form class="form-horizontal"  >
			     <span style="display:block;text-align:center;width:60%;margin:30px auto;font-size:30px;font-family:Arial,Microsoft,YaHei,'黑体','宋体',sans-serif;">用户登录</span>
				<div style="width:80% ;margin:0 auto 15px auto;">
						<input class="form-control" id="account" placeholder="用户名" name="account" type="text" style="font-size:18px;color:#000;height:45px" />
				</div>
				
					
					<div style="width:80% ;margin:0 auto 15px auto;">
						<input class="form-control" placeholder="密码" id="password" name="password" type="password"  style="height:45px;font-size:18px;color:#000;" />
					</div>

				<div style="width:80%; margin:40px auto 40px auto">
					<button onClick="AccountCheck(this)" class="btn btn-default" style="width:100%;height:50px;background:#484848;border-radius:30px;font-size:30px;color:#fff; font-family:Arial,Microsoft,YaHei,'黑体','宋体',sans-serif;" type="button"  >登录</button>
				
				</div>
			</form>
		</div>
		<span style="position:absolute;left:10%;top:80%;text-align:center; display:block; width:80%;margin:50px auto 10px auto;color:#B8B8B8;">Copyright © 2017 - 2020 鱼的特征与分类信息管理系统  F	isher.com All Rights Reserved. 图侵删 </span>
</body>
</html>