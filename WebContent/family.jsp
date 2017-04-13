<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dao.FamilyDao,java.util.*,entity.Family" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fisher
</title>
<% 
request.setCharacterEncoding("UTF-8");
String listName;
if(request.getParameter("list")!=null){
listName = request.getParameter("list");
session.setAttribute("listName", listName);
}
else{
	if(session.getAttribute("listName") != null)
	listName = (String)session.getAttribute("listName");
	else{
	 listName = "";
	  response.sendRedirect("main.jsp");
	}
		
}
int currentPage;
if(request.getParameter("page") == null) 
currentPage = 1;
else
currentPage = Integer.parseInt(request.getParameter("page").toString());


int sumFamily = new FamilyDao().getSumFamilyNum(listName);
final int PAGENUM = 30;
final int COWNUM = 3;
int sumPage;
if(sumFamily%PAGENUM == 0) sumPage = sumFamily/PAGENUM;
else sumPage = sumFamily/PAGENUM + 1;
%>
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
        <li> <a href="main.jsp?page=1">首页</a> </li>
        <% 
         out.println("<li class=\"active\"><a href=\"family.jsp?page=1\">"+listName+"</a></li>");
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
    <!-- update模态框 -->
  <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">更改</h4>
            </div>
            <div class="modal-body">
            <input id="updateInput" type="text" style="border-radius:5px; border:1px solid;" />
            <span id="oldValue" style="display:none"></span><!-- 当做变量使用保存原来的值 -->
            <span id="index" style="display:none"></span><!--当做变量使用保存下标 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onClick="Update('family')" id="updateSubmit" class="btn btn-primary">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
 <!-- insert模态框 -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="insertModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">输入你想添加的目</h4>
            </div>
            <div class="modal-body">
            <input id="insertInput" type="text" style="border-radius:5px; border:1px solid;" />
            <span id="listName" style="display:none"><%out.print(listName);%></span><!-- 保存当前目名 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onClick="Insert('family')" id="insertSubmit" class="btn btn-primary">添加</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
  </div>
  <% Vector <Family>family = new FamilyDao().getFamilyByPage(listName,currentPage,PAGENUM);%>
  <div class="row clearfix">
  <div class="col-md-12 column">
  <button  onClick="editModeChange(this)" style="margin-top:30px" type="button" class="btn btn-sm btn-primary">编辑 <span class="glyphicon glyphicon-pencil"></span></button>
  <button style="margin:30px 10px 0px 0px;" type="button"  data-toggle="modal" data-target="#insertModal" class="btn btn-sm btn-success">添加<span class="glyphicon glyphicon-plus"></span></button>
  </div>
  </div>
  <div class="row clearfix" style="margin-top:10px; text-align:center;">
    <div class="col-md-4 column">
      <div class="page-header">
      <%for(int i = 0; i<family.size(); i+=COWNUM) //i表示数组的下标
      {
    	  if(family.get(i)!=null){
    		  out.println("<h3><a id=\"valueA"+i+"\" href=\"category.jsp?familyName="+family.get(i).getName()+"\">"+family.get(i).getName()+"</a>"
    		  +"<button style=\"display:none\" type=\"button\" onClick=\"Del(this,'family')\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"
    		  +"<button onClick=\"getUpdateVal(this,"+i+")\" style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\" data-toggle=\"modal\" data-target=\"#updateModal\">更改</button></h3>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
    <div class="col-md-4 column">
      <div class="page-header">
       <%for(int i = 1; i<family.size(); i+=COWNUM) 
      {
    	  if(family.get(i)!=null){
    		  out.println("<h3><a id=\"valueA"+i+"\" href=\"category.jsp?familyName="+family.get(i).getName()+"\">"+family.get(i).getName()+"</a>"
    	    		  +"<button style=\"display:none\" type=\"button\" onClick=\"Del(this,'family')\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"
    	    		  +"<button onClick=\"getUpdateVal(this,"+i+")\" style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\" data-toggle=\"modal\" data-target=\"#updateModal\">更改</button></h3>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
    <div class="col-md-4 column">
      <div class="page-header">
         <%for(int i = 2; i<family.size(); i+=COWNUM) 
      {
    	  if(family.get(i)!=null){
    		  out.println("<h3><a id=\"valueA"+i+"\" href=\"category.jsp?familyName="+family.get(i).getName()+"\">"+family.get(i).getName()+"</a>"
    	    		  +"<button style=\"display:none\" type=\"button\" onClick=\"Del(this,'family')\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"
    	    		  +"<button onClick=\"getUpdateVal(this,"+i+")\" style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\" data-toggle=\"modal\" data-target=\"#updateModal\">更改</button></h3>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
  </div>
  <div class="row clearfix" style="padding-bottom:20px;">
    <div class="col-md-12 column">
      <ul class="page pagination">
      <%
int left = currentPage-2 > 0 ? currentPage-2 : 1;
int right = currentPage+2 < sumPage ? currentPage+2 : sumPage;
out.println("<li><a href=\"family.jsp?page=1\">&laquo;</a></li>");
for(int i = left; i<=right; i++){
	if(i == currentPage){
		out.println("<li class=\"active\"><a href=\"family.jsp?page="+i+"\">"+i+"</a></li>");
	}
	else
	out.println("<li><a href=\"family.jsp?page="+i+"\">"+i+"</a></li>");
}
out.println("<li><a href=\"family.jsp?page="+sumPage+"\">&raquo;</a></li>");
%>
       
      </ul>
    </div>
  </div>
</div>
<span style="text-align:center; display:block; width:900px;margin:50px auto;">Copyright © 2017 - 2020 鱼的特征与分类信息管理系统  F	isher.com All Rights Reserved.  </span>
</body>

</html>