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
function change(x){//根据所点击的字母通过AJAX查询数据库中首字拼音等于该字母的数据
	
	$("#ul1 li.active").removeClass("active");
	x.setAttribute("class","active");
	var y = x.getElementsByTagName("a")[0].innerHTML;
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
		$("#borad").empty();
	    var x=xmlhttp.responseText.split(",");
		var node;
		for( var i = 0;i<x.length;i++)
		{
			node = $('<li style="cursor:pointer;" onClick="fill(this)">'+x[i]+'</li>');
			$("#borad").append(node);
		}
	    }
	  }
	  xmlhttp.open("GET","FindListPY?PY="+y+"&type=list",true);
	  xmlhttp.send();

	}
	
function fill(x){
	var val = x.innerHTML;
	$("#list").attr("value",val);
	$("#ul2 li.active").removeClass("active");
	$("#borad1").empty();
	$("#listButton").click();
}
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
	  xmlhttp.open("GET","CheckDuplicate?value="+$("#family").val()+"&type=family",true);
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
				<li >
					 <a href="addList.jsp">添加目</a>
				</li>
				<li class="active">
					 <a href="addFamily.jsp">添加科</a>
				</li>
				<li>
					 <a href="addCategory.jsp">添加属</a>
				</li>
			</ul>
		</div>
		<div class="col-md-9 column">
		<form role="form" id="form1" action="CommonInsert?type=family"  method="post">
		<div class="form-group">
					 <label for="list">目</label><input class="form-control" name="list" id="list" type="text" readonly = "readonly"/>
                      <a class="btn" id="modal-513628" role="button" href="#modal-container-513628" data-toggle="modal">点击浏览</a>
				</div>
			<div class="modal fade" id="modal-container-513628" role="dialog" aria-hidden="true" aria-labelledby="myModalLabel">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 <button class="close" aria-hidden="true" type="button" data-dismiss="modal">×</button>
							<h4 class="modal-title" id="myModalLabel">
								目
							</h4>
						</div>
						<div class="modal-body">
							<ul id="ul1" class="nav nav-tabs">
				<li onClick="change(this)">
					 <a href="#">a</a>
				</li>
				<li onClick="change(this)">
					 <a href="#">b</a>
				</li>
				<li onClick="change(this)">
					 <a href="#">c</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">d</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">e</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">f</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">g</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">h</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">i</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">j</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">k</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">l</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">m</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">n</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">o</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">p</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">q</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">r</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">s</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">t</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">u</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">v</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">w</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">x</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">y</a>
				</li>
                <li onClick="change(this)">
					 <a href="#">z</a>
				</li>			
			</ul>
<ul class="list-unstyled list-inline" id="borad">
			
			</ul>
            

						</div>
						<div class="modal-footer">
							 <button id="listButton" class="btn btn-default" type="button" data-dismiss="modal">关闭</button> 
						</div>
					</div>
				</div>
			</div>
		<div class="form-group">
					 <label for="family">科名</label><input class="form-control" id="family" name="family" type="text" />
		</div>
		<input type="button" value="提交" onClick="beforeSubmit()">
		</form>
		</div>
	</div>
</div>
</body>
</html>	