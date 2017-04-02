<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Dao.ListDao,entity.List,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% int currentPage;
   if(request.getParameter("page") == null) 
   currentPage = 1;
   else
   currentPage = Integer.parseInt(request.getParameter("page").toString());

   ListDao listDao = new ListDao();
   int sumList = listDao.getSumListNum();
   final int PAGENUM = 30;
   final int COWNUM = 3;
   int sumPage;
   if(sumList%PAGENUM == 0) sumPage = sumList/PAGENUM;
   else sumPage = sumList/PAGENUM + 1;
%>
<script>
function Del(x){
    var parent = x.parentNode;
    var childNode = parent.firstChild;
    
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
	    	alert("删除失败!");
	    else{
	    	parent.remove();
	    }
	    
	    }
	  }
	  xmlhttp.open("GET","deleteWork?deleteValue="+childNode.innerHTML+"&deleteType=list",true);
	  xmlhttp.send();
}	
	



</script>
<title>Fisher</title>
</head>
<link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="bootstrap-3.3.7-dist/js/jquery-3.1.1.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="bootstrap-3.3.7-dist/js/fisherJS.js"></script>
<link href="bootstrap-3.3.7-dist/css/fisherStyle.css" rel="stylesheet">
<body>
<div class="container">
  <div>
    <h1>淡水鱼百科</h1>
  </div>
  <div class="path row clearfix">
    <div class="col-md-12 column">
      <ul class="breadcrumb">
        <li class="active"> <a href="main.jsp?page=1">首页</a> </li> 
      </ul>
      <form class="form1" method="get" action="SearchServlet">
        <div class="input-group input-group-lg">
        <div class="input-group-btn">
                        <button type="button" class="btn btn-default 
                        dropdown-toggle" data-toggle="dropdown" id="btn-type" value="fish" >鱼名
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#" onClick="switchValue(this)" value="list">目名<span class="caret"></span></a>
                            </li>
                            <li>
                                <a href="#" onClick="switchValue(this)" value="family">科名<span class="caret"></span></a>
                            </li>
                            <li>
                                <a href="#" onClick="switchValue(this)" value="category">属名<span class="caret"></span></a>
                            </li>
                            
                        </ul>
                    </div>
          <input type="hidden" name="type" id="typeId">
          <input type="text" class="form-control" placeholder="通过关键字查找" name="content">
          <span class="input-group-btn ">
          <button class="btn btn-primary" type="button" onClick="submit1()">搜索</button>
          </span> </div>
      </form>
    </div>
  </div>
  <% Vector <List>list = new ListDao().getListByPage(currentPage, PAGENUM); %>
  <div class="row clearfix">
  <div class="col-md-12 column">
  <button  onClick="editModeChange(this)" style="margin-top:30px" type="button" class="btn btn-sm btn-primary">编辑 <span class="glyphicon glyphicon-pencil"></span></button>
  <button style="margin:30px 10px 0px 0px;" type="button" class="btn btn-sm btn-success">添加<span class="glyphicon glyphicon-plus"></span></button>
  </div>
  </div>
  <div class="row clearfix">
    <div class="col-md-4 column">
      <div class="page-header">
      <%for(int i = 0; i<list.size(); i+=COWNUM) //i表示数组的下标
      {
    	  if(list.get(i)!=null){
    		  out.println("<h2><a href=\"family.jsp?page=1&list="+list.get(i).getName()+"\">"
    		    	  +list.get(i).getName()+"</a><button style=\"display:none\" type=\"button\" onClick=\"Del(this)\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"+
    		    	  "<button style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\">更改</button></h2>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
    <div class="col-md-4 column">
      <div class="page-header">
       <%for(int i = 1; i<list.size(); i+=COWNUM) 
      {
    	  if(list.get(i)!=null){
    		  out.println("<h2><a href=\"family.jsp?page=1&list="+list.get(i).getName()+"\">"
    		    	  +list.get(i).getName()+"</a><button style=\"display:none\" type=\"button\" onClick=\"Del(this)\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"+
    		    	  "<button style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\">更改</button></h2>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
    <div class="col-md-4 column">
      <div class="page-header">
         <%for(int i = 2; i<list.size(); i+=COWNUM) 
      {
    	  if(list.get(i)!=null){
    		  out.println("<h2><a href=\"family.jsp?page=1&list="+list.get(i).getName()+"\">"
    		    	  +list.get(i).getName()+"</a><button style=\"display:none\" type=\"button\" onClick=\"Del(this)\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"+
    		    	  "<button style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\">更改</button></h2>");
    	      
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
  </div>
  <div class="row clearfix">
    <div class="col-md-12 column">
      <ul class="page pagination">	
      <%
int left = currentPage-2 > 0 ? currentPage-2 : 1;
int right = currentPage+2 < sumPage ? currentPage+2 : sumPage;
out.println("<li><a href=\"main.jsp?page=1\">&laquo;</a></li>");
for(int i = left; i<=right; i++){
	if(i == currentPage){
		out.println("<li class=\"active\"><a href=\"main.jsp?page="+i+"\">"+i+"</a></li>");
	}
	else
	out.println("<li><a href=\"main.jsp?page="+i+"\">"+i+"</a></li>");
}
out.println("<li><a href=\"main.jsp?page="+sumPage+"\">&raquo;</a></li>");
%>
       
      </ul>
    </div>
  </div>
</div>
</body>

</html>