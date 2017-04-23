<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Dao.ListDao,entity.List,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% int currentPage;
   int sumList;
   String character;
   if(request.getParameter("page") == null) 
   currentPage = 1;
   else
   currentPage = Integer.parseInt(request.getParameter("page").toString());
   if(request.getParameter("character") == null)
	   character = "All";
   else
   character = request.getParameter("character");
   String userType = "common";
   if(session.getAttribute("userType")!=null)
   userType = (String)session.getAttribute("userType");
   ListDao listDao = new ListDao();
   if(character.equals("All"))
   sumList = listDao.getSumListNum();
   else 
   sumList = listDao.getSumListPYNum(character);
   final int PAGENUM = 30;
   final int COWNUM = 3;
   int sumPage;
   if(sumList%PAGENUM == 0) sumPage = sumList/PAGENUM;
   else sumPage = sumList/PAGENUM + 1;
%>

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
<div class="container" style="margin:0 auto; width:900px; background:#fff; border-radius:15px;" >
  
  <div class="path row clearfix" >
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
      <ul id="navigateUl" class="nav nav-pills" style="margin:20px auto 0 auto;width:68%;">
                <%if(character.equals("All"))
				out.println("<li  class=\"active\"><a href=\"main.jsp?page=1&character=All\">All</a></li>");
                else
                out.println("<li  ><a href=\"main.jsp?page=1&character=All\">All</a></li>");
				%>
				<%
				for(int i = 'A';i <= 'Z'; i++){
			    if(character.equals(String.valueOf((char)i)))
				out.println("<li class=\"active\"><a href=\"main.jsp?page=1&character="+(char)i+"\">"+(char)i+"</a></li>"); 
			    else
			    	out.println("<li><a href=\"main.jsp?page=1&character="+(char)i+"\">"+(char)i+"</a></li>"); 
				}%>			
      </ul>
    </div>
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
                <button type="button" onClick="Update('list')" id="updateSubmit" class="btn btn-primary">提交更改</button>
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
            
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onClick="Insert('list')" id="insertSubmit" class="btn btn-primary">添加</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
  <%
  Vector <List>list;
  if(character.equals("All"))
  list = listDao.getListByPage(currentPage, PAGENUM);
  else
  list = listDao.getListByPinYin(character, currentPage, PAGENUM);
  %>
  <% if(userType.equals("admin")){
  out.println("<div class=\"row clearfix\">");
  out.println("<div class=\"col-md-12 column\">");
  out.println("<button  onClick=\"editModeChange(this)\" style=\"margin-top:30px\" type=\"button\" class=\"btn btn-sm btn-primary\">编辑 <span class=\"glyphicon glyphicon-pencil\"></span></button>");
  out.println("<button style=\"margin:30px 10px 0px 0px;\" type=\"button\"  data-toggle=\"modal\" data-target=\"#insertModal\" class=\"btn btn-sm btn-success\">添加<span class=\"glyphicon glyphicon-plus\"></span></button>");
  out.println("</div></div>");
  }
  %>
  <div class="row clearfix" style="margin-top:10px; text-align:center;">
    <div class="col-md-4 column">
      <div class="page-header">
      <%for(int i = 0; i<list.size(); i+=COWNUM) //i表示数组的下标
      {
    	  if(list.get(i)!=null){
    		  out.println("<h3><a id=\"valueA"+i+"\" href=\"family.jsp?page=1&list="+list.get(i).getName()+"\">"
    		    	  +list.get(i).getName()+"</a><button style=\"display:none\" type=\"button\" onClick=\"Del(this,'list')\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"+
    		    	  "<button onClick=\"getUpdateVal(this,"+i+")\" style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\" data-toggle=\"modal\" data-target=\"#updateModal\">更改</button></h3>");
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
    		  out.println("<h3><a id=\"valueA"+i+"\" href=\"family.jsp?page=1&list="+list.get(i).getName()+"\">"
    		    	  +list.get(i).getName()+"</a><button style=\"display:none\" type=\"button\" onClick=\"Del(this,'list')\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"+
    		    	  "<button onClick=\"getUpdateVal(this,"+i+")\" style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\" data-toggle=\"modal\" data-target=\"#updateModal\">更改</button></h3>");
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
    		  out.println("<h3><a id=\"valueA"+i+"\" href=\"family.jsp?page=1&list="+list.get(i).getName()+"\">"
    		    	  +list.get(i).getName()+"</a><button style=\"display:none\" type=\"button\" onClick=\"Del(this,'list')\" class=\"btn btn-danger btn-xs btn-delete\">删除</button>"+
    		    	  "<button onClick=\"getUpdateVal(this,"+i+")\" style=\"display:none\" type=\"button\" class=\"btn btn-primary btn-xs btn-update\" data-toggle=\"modal\" data-target=\"#updateModal\">更改</button></h3>");
    	      
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
  </div>
  <div class="row clearfix" >
    <div class="col-md-12 column">
      <ul class="page pagination" >	
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
<span style="text-align:center; display:block; width:900px;margin:50px auto 10px auto;">Copyright © 2017 - 2020 鱼的特征与分类信息管理系统  F	isher.com All Rights Reserved.  </span>
<span style="text-align:center;display:block;width:900px; margin:0px auto 50px auto;"><a href="admin.jsp">管理员登录</a></span>
</body>

</html>