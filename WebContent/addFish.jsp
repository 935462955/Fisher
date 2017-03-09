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

function change1(x){
	
	$("#ul2 li.active").removeClass("active");
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
		$("#borad1").empty();
	    var x=xmlhttp.responseText.split(",");
		var node;
		for( var i = 0;i<x.length;i++)
		{
			node = $('<li style="cursor:pointer;" onClick="fill1(this)">'+x[i]+'</li>');
			$("#borad1").append(node);
		}
	    }
	  }
	  xmlhttp.open("GET","FindListPY?PY="+y+"&list="+$("#list").attr("value")+"&type=family",true);
	  xmlhttp.send();

	}
	
function change2(x){
	
	$("#ul3 li.active").removeClass("active");
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
		$("#borad2").empty();
	    var x=xmlhttp.responseText.split(",");
		var node;
		for( var i = 0;i<x.length;i++)
		{
			node = $('<li style="cursor:pointer;" onClick="fill2(this)">'+x[i]+'</li>');
			$("#borad2").append(node);
		}
	    }
	  }
	  xmlhttp.open("GET","FindListPY?PY="+y+"&family="+$("#family").attr("value")+"&type=category",true);
	  xmlhttp.send();

	}
function beforeSubmit(){
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
	    	alert("数据已存在！");
	    else{
	    	$("#form1").submit();
	    }
	    }
	  }
	  xmlhttp.open("GET","CheckDuplicate?value="+$("#fishName").val()+"&type=fish",true);
	  xmlhttp.send();
}	
function fill1(x){
	var val = x.innerHTML;
	$("#family").attr("value",val);
	$("#category").attr("value","");
	$("#ul3 li.active").removeClass("active");
	$("#borad2").empty();
	$("#familyButton").click();
}

function fill(x){
	var val = x.innerHTML;
	$("#list").attr("value",val);
	$("#family").attr("value","");
	$("#ul2 li.active").removeClass("active");
	$("#borad1").empty();
	$("#listButton").click();
}
function fill2(x){
	var val = x.innerHTML;
	$("#category").attr("value",val);
	$("#categoryButton").click();
}
</script>
<body>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-3 column">
			<ul class="nav nav-stacked nav-pills">
				<li class="active">
					 <a href="#">首页</a>
				</li>
				<li>
					 <a href="#">简介</a>
				</li>
				<li class="disabled">
					 <a href="#">信息</a>
				</li>
				<li class="dropdown pull-right">
					 <a class="dropdown-toggle" href="#" data-toggle="dropdown">下拉<strong class="caret"></strong></a>
					<ul class="dropdown-menu">
						<li>
							 <a href="#">操作</a>
						</li>
						<li>
							 <a href="#">设置栏目</a>
						</li>
						<li>
							 <a href="#">更多设置</a>
						</li>
						<li class="divider">
						</li>
						<li>
							 <a href="#">分割线</a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
		<div class="col-md-9 column">
			<form role="form" id="form1" action="UploadServlet" enctype="multipart/form-data" method="post">
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
					 <label for="family">科</label><input class="form-control" name="family" id="family" type="text" readonly = "readonly"/>
                      <a class="btn" id="modal-513629" role="button" href="#modal-container-513629" data-toggle="modal">点击浏览</a>
				</div>
			<div class="modal fade" id="modal-container-513629" role="dialog" aria-hidden="true" aria-labelledby="myModalLabel">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 <button class="close" aria-hidden="true" type="button" data-dismiss="modal">×</button>
							<h4 class="modal-title" id="myModalLabel">
								科
							</h4>
						</div>
						<div class="modal-body">
							<ul id="ul2" class="nav nav-tabs">
				<li  onClick="change1(this)">
					 <a href="#">a</a>
				</li>
				<li onClick="change1(this)">
					 <a href="#">b</a>
				</li>
				<li onClick="change1(this)">
					 <a href="#">c</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">d</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">e</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">f</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">g</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">h</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">i</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">j</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">k</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">l</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">m</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">n</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">o</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">p</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">q</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">r</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">s</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">t</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">u</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">v</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">w</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">x</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">y</a>
				</li>
                <li onClick="change1(this)">
					 <a href="#">z</a>
				</li>			
			</ul>
<ul class="list-unstyled list-inline" id="borad1">
			
			</ul>
			</div>
						<div class="modal-footer">
							 <button id="familyButton" class="btn btn-default" type="button" data-dismiss="modal">关闭</button> 
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
					 <label for="category">属</label><input class="form-control" name="category" id="category" type="text" readonly = "readonly"	/>
                      <a class="btn" id="modal-513627" role="button" href="#modal-container-513627" data-toggle="modal">点击浏览</a>
				</div>
			<div class="modal fade" id="modal-container-513627" role="dialog" aria-hidden="true" aria-labelledby="myModalLabel">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							 <button class="close" aria-hidden="true" type="button" data-dismiss="modal">×</button>
							<h4 class="modal-title" id="myModalLabel">
								属
							</h4>
						</div>
						<div class="modal-body">
							<ul id="ul3" class="nav nav-tabs">
				<li  onClick="change2(this)">
					 <a href="#">a</a>
				</li>
				<li onClick="change2(this)">
					 <a href="#">b</a>
				</li>
				<li onClick="change2(this)">
					 <a href="#">c</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">d</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">e</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">f</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">g</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">h</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">i</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">j</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">k</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">l</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">m</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">n</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">o</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">p</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">q</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">r</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">s</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">t</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">u</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">v</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">w</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">x</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">y</a>
				</li>
                <li onClick="change2(this)">
					 <a href="#">z</a>
				</li>			
			</ul>
<ul class="list-unstyled list-inline" id="borad2">
			
			</ul>
            

						</div>
						<div class="modal-footer">
							 <button id="categoryButton" class="btn btn-default" type="button" data-dismiss="modal">关闭</button> 
						</div>
					</div>
				</div>
			</div>
				<div class="form-group">
					 <label for="exampleInputEmail1">名称</label><input class="form-control" id="fishName" name="name" type="text" />
				</div>
				<div class="form-group">
					 <label for="exampleInputPassword1">别名(若有多个别名请用逗号隔开)</label><input class="form-control" name="localName" type="text" />
				</div>
                <div class="form-group">
					 <label for="exampleInputEmail1">英文名</label><input class="form-control" name="EnglishName" type="text" />
				</div>
				<div class="form-group">
					 <label for="exampleInputEmail1">发源地</label><input class="form-control" name="origin" type="text"  />
				</div>
				<div class="form-group">
					 <label for="exampleInputEmail1">介绍</label><textarea class="form-control" name="introduction"></textarea>
				</div>
				<div class="form-group">
					 <label for="exampleInputFile">图片</label><input name="file1" type="file" />
					<p class="help-block">
						Example block-level help text here.
					</p>
				</div>
				<div class="checkbox">
					 <label><input type="checkbox" />Check me out</label>
				</div> <input type="button" value="提交" onClick="beforeSubmit()">
			</form>
		</div>
	</div>
</div>
</body>
</html>