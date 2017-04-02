<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="Dao.FishDao" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fisher</title>

</head>
<link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="bootstrap-3.3.7-dist/js/jquery-3.1.1.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="bootstrap-3.3.7-dist/css/fisherStyle.css" rel="stylesheet">
<style>
.unit{
	margin-top:30px;
}
.span1{
margin:10px 10px;	
}
</style>
<script>
function beforeSubmit(){
	var xmlhttp;
	if($("#list").val() == "") alert("请输入数据");
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
	    	alert("数据已存在！");
	    else
	    	 $("#form1").submit();
	    
	    }
	  }
	  xmlhttp.open("GET","CheckDuplicate?value="+$("#list").val()+"&type=list",true);
	  xmlhttp.send();
}	
</script>
<body>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-3 column">
			<ul  class="nav nav-stacked nav-pills">
				<li>
					 <a href="addFish.jsp">添加品种</a>
				</li>
				<li class="active">
					 <a href="addList.jsp">添加目</a>
				</li>
				<li>
					 <a href="addFamily.jsp">添加科</a>
				</li>
				<li>
					 <a href="addCategory.jsp">添加属</a>
				</li>
			</ul>
		</div>
		<div class="col-md-9 column">
		<form role="form" id="form1" action="CommonInsert?type=list"  method="post">
		<div class="form-group">
					 <label for="list">目名</label><input class="form-control" id="list" name="list" type="text" />
		</div>
		<input type="button" value="提交" onClick="beforeSubmit()">
		</form>
		</div>
	</div>
</div>
</body>
</html>	