<%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>
 <%@ page import="Dao.FishDao" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>消息提示</title>
  </head>
 <body>
     成功
     ${message }
     ${path }
     
     <%
     FishDao  fishdao = new FishDao();
     String message = request.getParameter("message");
     String list = request.getParameter("list");
     String family = request.getParameter("family");
     String category = request.getParameter("category");
     String img = "img\\"+request.getParameter("path");
     out.println(list+family+category+img);
     %>
     <p>
   如果长时间未响应请点击<a href="addFish.jsp">返回</a>
   </p>
     <span id="span1"></span><span>秒后返回  </span>
 <script type="text/javascript">
 var i=5;
 span = document.getElementById("span1");
 function a(){
 span.innerHTML=i;
 i--;
 if(i>0){
 setTimeout(a,1000);
 }
 else{
 location.href="addFish.jsp";
 }
 } 
 a();
 </script> 
 </body>
	 </html>