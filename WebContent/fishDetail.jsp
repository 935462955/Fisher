<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Dao.FishDao,entity.Fish,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>Fisher</title>
<%
String fishName;
if(session.getAttribute("listName") == null)  response.sendRedirect("main.jsp");
if(request.getParameter("fishName")!=null){
	fishName = request.getParameter("fishName");
    session.setAttribute("fishName", fishName);
}
else{
	if(session.getAttribute("fishName") != null)
		fishName = (String)session.getAttribute("fishName");
		else{
			fishName = "";
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
<body>
<div class="container">
  <div>
    <h1>淡水鱼百科</h1>
  </div>
  <div class="path row clearfix">
    <div class="col-md-12 column">
     <ul class="breadcrumb">
        <li> <a href="main.jsp?page=1">首页</a> </li>
         <% 
         out.println("<li><a href=\"family.jsp?page=1\">"+session.getAttribute("listName")+"</a></li>");
         out.println("<li><a href=\"category.jsp?page=1\">"+session.getAttribute("familyName")+"</a></li>");
         out.println("<li><a href=\"fishMenu.jsp\">"+session.getAttribute("categoryName")+"</a></li>");
         out.println("<li class=\"active\"><a href=\"fishDetail.jsp\">"+fishName+"</a></li>");
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
    <%
    Fish fish = new FishDao().getFishByName(fishName);
    %>
		<div class="col-md-12 column">
			<h2 class="text-center">
			   <% fish.getName(); %>
			</h2><img style="position:relative;left:35%;width:300px;height:300px;"alt="140x140" src="<% out.println(fish.getPicture()); %>" />
			<dl  class="dl-horizontal">
				<dt>
					别名
				</dt>
				<dd>
					<% out.println(fish.getLocalNameByString()); %>
				</dd>
				<dt>
					英文名
				</dt>
				<dd>
					<% out.println(fish.getEnglishName()); %>
				</dd>
				<dt>
					分类
				</dt>
				<dd>
					<% out.println(fish.getList()+","+fish.getFamily()+","+fish.getCategory()); %>
				</dd>
                <dt>
					发源地
				</dt>
				<dd>
					<% out.println(fish.getOrigin()); %>
				</dd>
			</dl>
			<h2>
				介绍
			</h2>
			<p>
			<% out.println(fish.getIntroduction()); %>


			</p>
		</div>

	</div>
</body>
</html>