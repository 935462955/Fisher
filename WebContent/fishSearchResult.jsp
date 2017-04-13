<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entity.Fish,Dao.FishDao,java.util.*" %>
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
<style>
.unit{
	margin-top:30px;
}
</style>
<body style="background-image:url(img/background.gif);">
<div style="width:1250px;margin:10px auto;  ">
    <img src="img/title.png"/>
  </div>
<div class="container"  style="margin:0 auto; width:1250px; background:#fff; border-radius:15px;">
  
  <div class="path row clearfix">
    <div class="col-md-12 column">
      <ul class="breadcrumb">
        <li> <a href="main.jsp?page=1">首页</a> </li>
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
  <% Vector<Fish> f = (Vector<Fish>)request.getSession().getAttribute("searchReturn");
     if(f.size() > 0){
     Fish fish = null;
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
