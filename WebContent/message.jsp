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
 </body>
	 </html>