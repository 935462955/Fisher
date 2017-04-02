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
<body>
<div class="container">
  <div>
    <h1>淡水鱼百科</h1>
  </div>
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
  <% Vector<Fish> f = (Vector<Fish>)request.getSession().getAttribute("searchReturn");
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
  %>
	</div>
</body>
</html>
