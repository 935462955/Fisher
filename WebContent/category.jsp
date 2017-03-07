	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dao.CateDao,java.util.*,entity.Category" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fisher
</title>
<% 
String familyName;
if(request.getParameter("familyName")!=null){
familyName = request.getParameter("familyName");
session.setAttribute("familyName", familyName);
}
else{
	familyName = (String)session.getAttribute("familyName");
}
int currentPage;
if(request.getParameter("page") == null) 
currentPage = 1;
else
currentPage = Integer.parseInt(request.getParameter("page").toString());


int sumFamily = new CateDao().getSumCateNum(familyName);
final int PAGENUM = 30;
final int COWNUM = 3;
int sumPage;
if(sumFamily%PAGENUM == 0) sumPage = sumFamily/PAGENUM;
else sumPage = sumFamily/PAGENUM + 1;

%>
</head>
<body>
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
        <li> <a href="main.jsp?page=1">首页</a> </li>
        <% 
         out.println("<li><a href=\"family.jsp?page=1\">"+session.getAttribute("listName")+"</a></li>");
         out.println("<li class=\"active\"><a href=\"category.jsp?page=1\">"+familyName+"</a></li>");
         %>
      </ul>
      <form class="form1">
        <div class="input-group input-group-lg">
        <div class="input-group-btn">
                        <button type="button" class="btn btn-default 
                        dropdown-toggle" data-toggle="dropdown" id="btn-type" value="fish" name="btn-type">鱼名
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
          <input type="text" class="form-control" placeholder="通过关键字查找">
          <span class="input-group-btn ">
          <button class="btn btn-primary" type="button">搜索</button>
          </span> </div>
      </form>
    </div>
  </div>
  <% Vector <Category>category = new CateDao().getCateByPage(familyName,currentPage,PAGENUM);%>
  <div class="row clearfix">
    <div class="col-md-4 column">
      <div class="page-header">
      <%for(int i = 0; i<category.size(); i+=COWNUM) //i表示数组的下标
      {
    	  if(category.get(i)!=null){
    		  out.println("<h2><a href=\"fishMenu.jsp?categoryName="+category.get(i).getName()+"\">"+category.get(i).getName()+"</a></h2>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
    <div class="col-md-4 column">
      <div class="page-header">
       <%for(int i = 1; i<category.size(); i+=COWNUM) 
      {
    	  if(category.get(i)!=null){
    		  out.println("<h2><a href=\"fishMenu.jsp?categoryName="+category.get(i).getName()+"\">"+category.get(i).getName()+"</a></h2>");
    	  }
    	  else break;
      }
      %>
      </div>
    </div>
    <div class="col-md-4 column">
      <div class="page-header">
         <%for(int i = 2; i<category.size(); i+=COWNUM) 
      {
    	  if(category.get(i)!=null){
    		  out.println("<h2><a href=\"fishMenu.jsp?categoryName="+category.get(i).getName()+"\">"+category.get(i).getName()+"</a></h2>");
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
out.println("<li><a href=\"category.jsp?page=1\">&laquo;</a></li>");
for(int i = left; i<=right; i++){
	if(i == currentPage){
		out.println("<li class=\"active\"><a href=\"category.jsp?page="+i+"\">"+i+"</a></li>");
	}
	else
	out.println("<li><a href=\"category.jsp?page="+i+"\">"+i+"</a></li>");
}
out.println("<li><a href=\"category.jsp?page="+sumPage+"\">&raquo;</a></li>");
%>
       
      </ul>
    </div>
  </div>
</div>
</body>

</html>