<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entity.Fish,Dao.FishDao,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fisher</title>
<% 
String categoryName = "";
String listName = ""; 
String familyName = "";
if(session.getAttribute("listName") == null)  response.sendRedirect("main.jsp");
if(request.getParameter("categoryName")!=null){
	listName = (String)session.getAttribute("listName");
	familyName = (String)session.getAttribute("familyName");
	categoryName = request.getParameter("categoryName");
    session.setAttribute("categoryName", categoryName);
}
else{
	if(session.getAttribute("categoryName") != null){
		categoryName = (String)session.getAttribute("categoryName");
	    listName = (String)session.getAttribute("listName");
	   familyName = (String)session.getAttribute("familyName");
	}
		else{
		  response.sendRedirect("main.jsp");
		}
}
%>
</head>
<link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="bootstrap-3.3.7-dist/js/jquery-3.1.1.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="bootstrap-3.3.7-dist/js/fisherJS.js"></script>
<link href="bootstrap-3.3.7-dist/css/fisherStyle.css" rel="stylesheet">
<style>
.unit{
	margin-top:30px;
}
</style>
<body style="background-image:url(img/background.gif);">
<div style="width:1250px;margin:10px auto;  ">
    <img src="img/title.png"/>
  </div>
<div class="container" style="margin:0 auto; width:1250px; background:#fff; border-radius:15px;">
  
  <div class="path row clearfix">
    <div class="col-md-12 column">
      <ul class="breadcrumb">
        <li> <a href="main.jsp?page=1">首页</a> </li>
         <% 
         out.println("<li><a href=\"family.jsp?page=1\">"+session.getAttribute("listName")+"</a></li>");
         out.println("<li><a href=\"category.jsp?page=1\">"+session.getAttribute("familyName")+"</a></li>");
         out.println("<li class=\"active\"><a href=\"fishMenu.jsp\">"+categoryName+"</a></li>");
         %>
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
    <div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="insertModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加鱼种</h4>
            </div>
            <div class="modal-body">
            <form role="form" id="form1" action="UploadServlet" enctype="multipart/form-data" method="post">
            <span ><%out.print(listName); %></span>
            <input type="hidden" id="list" name="list" value="<%out.print(listName);%>"/>
            <span ><%out.print(familyName);%></span><!-- 保存当前目名 -->
             <input type="hidden" id="family" name="family" value="<%out.print(familyName);%>"/>
            <span><%out.print(categoryName); %></span>
             <input type="hidden" id="category" name="category" value="<%out.print(categoryName);%>" />
            <br/>
            <div class="form-group">
					 <label for="exampleInputEmail1">名称</label><input class="form-control" id="fishName" name="name" type="text" />
				</div>
				<div class="form-group">
					 <label for="exampleInputPassword1">别名(若有多个别名请用逗号隔开)</label><input class="form-control" id="localName" name="localName" type="text"  />
				</div>
                <div class="form-group">
					 <label for="exampleInputEmail1">英文名</label><input class="form-control" id="EnglishName" name="EnglishName" type="text" />
				</div>
				<div class="form-group">
					 <label for="exampleInputEmail1">发源地</label><input class="form-control" id="origin" name="origin" type="text"  />
				</div>
				<div class="form-group">
					 <label for="exampleInputEmail1">介绍</label><textarea class="form-control" id="introduction" name="introduction"></textarea>
				</div>
				<div class="form-group">
					 <label for="exampleInputFile">图片</label><input name="file1" type="file" />
				</div>
				</form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onClick="beforeSubmit()" id="insertSubmit" class="btn btn-primary">添加</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
  </div>
  </div>
  <div class="row clearfix">
  <div class="col-md-12 column">
  <button  onClick="editModeChange(this)" style="margin-top:30px" type="button" class="btn btn-sm btn-primary">编辑 <span class="glyphicon glyphicon-pencil"></span></button>
  <button style="margin:30px 10px 0px 0px;" type="button"  data-toggle="modal" data-target="#insertModal" class="btn btn-sm btn-success">添加<span class="glyphicon glyphicon-plus"></span></button>
  </div>
  </div>
  <div class="row clearfix" style="margin-top:10px; text-align:center;">	
  <% Vector<Fish> f = new FishDao().getFishsByCate(categoryName);
     Fish fish = null;
     if(f.size() > 0){
     for(int i = 0 ; i < f.size() ; i++){
    	 if(f.get(i) != null){
         fish = f.get(i);
    	 out.println("<div class=\"col-md-4 column unit\">");
    	 out.println("<a href=\"fishDetail.jsp?fishName="+fish.getName()+"\"><img class=\"img-rounded\" alt=\"200x200\" src=\""+fish.getPicture()+"\" width=\"200px\" height=\"200px\" /></a>");
    	 out.println("<h2>"+fish.getName()+"</h2>");
    	 out.println("<p style=\"height:100px; width:350px;overflow:hidden;text-overflow:ellipsis;\">");
    	 out.println(fish.getIntroduction());
    	 out.println("</p>");
    	 out.println("<p><a href=\"fishDetail.jsp?fishName="+fish.getName()+"\">查看详情>></a></p>");
    	 out.println("<button style=\"display:none\" type=\"button\" onClick=\"Del(this,'fish')\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"
    	 +"<button onClick=\"getUpdateVal(this,"+i+")\" style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\" data-toggle=\"modal\" data-target=\"#updateModal\">更改</button>");
    	 out.println("</div>");
    	 
    	 }
    	 }
     }
     else{
         out.println("<div class=\"col-md-12 column unit\">");
         out.println("<p style=\"height:200px;\">抱歉！暂无结果</p>");
         out.println("</div>");
         }
  %>
	</div>
	</div>
	<span style="text-align:center; display:block; width:900px;margin:50px auto;">Copyright © 2017 - 2020 鱼的特征与分类信息管理系统  F	isher.com All Rights Reserved.  </span>
</body>
</html>
