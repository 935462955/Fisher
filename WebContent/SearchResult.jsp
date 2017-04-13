<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Dao.ListDao,entity.List,entity.Family,entity.Category,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Fisher</title>
</head>
<link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="bootstrap-3.3.7-dist/js/jquery-3.1.1.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="bootstrap-3.3.7-dist/js/fisherJS.js"></script>
<link href="bootstrap-3.3.7-dist/css/fisherStyle.css" rel="stylesheet">
<body style="background-image:url(img/background.gif);">
<div style="width:900px;margin:10px auto;  ">
    <img src="img/title.png"/>
  </div>
<div class="container" style="margin:0 auto; width:900px; background:#fff; border-radius:15px;">
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
  <div class="row clearfix" style="margin-top:10px; text-align:center;">
<% int currentPage;
   if(request.getParameter("page") == null) 
   currentPage = 1;
   else
   currentPage = Integer.parseInt(request.getParameter("page").toString());
   String type = request.getParameter("type");
   final int PAGENUM = 30;
   final int COWNUM = 3;
   int sumPage;
   Vector v;
   if(type.equals("list")){  //传来的是LIST集合
	  v = (Vector<List>)request.getSession().getAttribute("searchReturn");
	  int sumList = v.size();
	   int startNum = (currentPage - 1) * PAGENUM;
	   if(sumList%PAGENUM == 0) sumPage = sumList/PAGENUM;
	   else sumPage = sumList/PAGENUM + 1;
	   %>
	   
    <div class="col-md-4 column">
      <div class="page-header">
      <%
      List l;
      for(int i = startNum+0; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) //i表示数组的下标，如果这一页的元素不足PAGENUM定义的个数那么就取到最后一个元素
      {
    	  if(v.get(i)!=null){
    		  l = (List)v.get(i);
    		  out.println("<h2><a href=\"family.jsp?page=1&list="+l.getName()+"\">"+l.getName()+"</a></h2>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
    <div class="col-md-4 column">
      <div class="page-header">
       <%for(int i = startNum+1; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) 
      {
    	  if(v.get(i)!=null){
    		  l = (List)v.get(i);
    		  out.println("<h2><a href=\"family.jsp?page=1&list="+l.getName()+"\">"+l.getName()+"</a></h2>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
    <div class="col-md-4 column">
      <div class="page-header">
         <%for(int i = startNum+2; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) 
      {
    	  if(v.get(i)!=null){
    		  l = (List)v.get(i);
    		  out.println("<h2><a href=\"family.jsp?page=1&list="+l.getName()+"\">"+l.getName()+"</a></h2>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>	   
   <% }
   else if(type.equals("family")){//传来的是Family
	   v = (Vector<Family>)request.getSession().getAttribute("searchReturn");
		  int sumFamily = v.size();
		   int startNum = (currentPage - 1) * PAGENUM;
		   if(sumFamily%PAGENUM == 0) sumPage = sumFamily/PAGENUM;
		   else sumPage = sumFamily/PAGENUM + 1;
		   %>
	    <div class="col-md-4 column">
	      <div class="page-header">
	      <%
	      Family l;
	      for(int i = startNum+0; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) //i表示数组的下标，如果这一页的元素不足PAGENUM定义的个数那么就取到最后一个元素
	      {
	    	  if(v.get(i)!=null){
	    		  l = (Family)v.get(i);
	    		  out.println("<h2><a href=\"category.jsp?page=1&family="+l.getName()+"\">"+l.getName()+"</a></h2>");
	    	  }
	    	  else break;
	      }
	      %>
	      </div>
	    </div>
	    <div class="col-md-4 column">
	      <div class="page-header">
	       <%for(int i = startNum+1; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) 
	      {
	    	  if(v.get(i)!=null){
	    		  l = (Family)v.get(i);
	    		  out.println("<h2><a href=\"category.jsp?page=1&list="+l.getName()+"\">"+l.getName()+"</a></h2>");
	    	  }
	    	  else break;
	      }
	      %>
	      </div>
	    </div>
	    <div class="col-md-4 column">
	      <div class="page-header">
	         <%for(int i = startNum+2; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) 
	      {
	    	  if(v.get(i)!=null){
	    		  l = (Family)v.get(i);
	    		  out.println("<h2><a href=\"family.jsp?page=1&list="+l.getName()+"\">"+l.getName()+"</a></h2>");
	    	  }
	    	  else break;
	      }
	      %>
	      </div>
	    </div>
	<% 
   }
   else {
	    v = (Vector<Category>)request.getSession().getAttribute("searchReturn");
	  int  sumCat = v.size();
	  int startNum = (currentPage - 1) * PAGENUM;
	   if(sumCat%PAGENUM == 0) sumPage = sumCat/PAGENUM;
	   else sumPage = sumCat/PAGENUM + 1;
	   %>
   <div class="col-md-4 column">
     <div class="page-header">
     <%
     Category l;
     for(int i = startNum+0; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) //i表示数组的下标，如果这一页的元素不足PAGENUM定义的个数那么就取到最后一个元素
     {
   	  if(v.get(i)!=null){
   		  l = (Category)v.get(i);
   		  out.println("<h2><a href=\"fishMenu.jsp?page=1&categoryName="+l.getName()+"\">"+l.getName()+"</a></h2>");
   	  }
   	  else break;
     }
     %>
     </div>
   </div>
   <div class="col-md-4 column">
     <div class="page-header">
      <%for(int i = startNum+1; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) 
     {
   	  if(v.get(i)!=null){
   		  l = (Category)v.get(i);
   		  out.println("<h2><a href=\"fishMenu.jsp?categoryName="+l.getName()+"\">"+l.getName()+"</a></h2>");
   	  }
   	  else break;
     }
     %>
     </div>
   </div>
   <div class="col-md-4 column">
     <div class="page-header">
        <%for(int i = startNum+2; i<((startNum+PAGENUM)>v.size()?v.size():startNum+PAGENUM); i+=COWNUM) 
     {
   	  if(v.get(i)!=null){
   		  l = (Category)v.get(i);
   		  out.println("<h2><a href=\"fishMenu.jsp?categoryName="+l.getName()+"\">"+l.getName()+"</a></h2>");
   	  }
   	  else break;
     }
     %>
     </div>
   </div>
  <%
   }
   %>
</div>
  <div class="row clearfix" >
    <div class="col-md-12 column">
      <ul class="page pagination">
      <%
int left = currentPage-2 > 0 ? currentPage-2 : 1;
int right = currentPage+2 < sumPage ? currentPage+2 : sumPage;
out.println("<li><a href=\"SearchResult.jsp?page=1&type="+type+"\">&laquo;</a></li>");
for(int i = left; i<=right; i++){
	if(i == currentPage){
		out.println("<li class=\"active\"><a href=\"SearchResult.jsp?page="+i+"&type="+type+"\">"+i+"</a></li>");
	}
	else
	out.println("<li><a href=\"SearchResult.jsp?page="+i+"&type="+type+"\">"+i+"</a></li>");
}
out.println("<li><a href=\"SearchResult.jsp?page="+sumPage+"&type="+type+"\">&raquo;</a></li>");
%>
       
      </ul>
    </div>
  </div>
</div>
<span style="text-align:center; display:block; width:900px;margin:50px auto;">Copyright © 2017 - 2020 鱼的特征与分类信息管理系统  F	isher.com All Rights Reserved.  </span>
</body>

</html>