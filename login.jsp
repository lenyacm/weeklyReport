<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp"%>

<%!
    String name = null;
    String password = new String();
%>

<%
    name = new String(request.getParameter("name").toString().getBytes("ISO-8859-1"), "gbk");
    password = request.getParameter("password").toString();
    
    session.setAttribute("name", name);
%>

<html>
    <head>
        <meta charset="gb2312">
        <title>Loading</title>
        <style>
            p {text-align: center;}
        </style>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>

        <%
        	if (checkPassword(name, password)) {
        		response.sendRedirect("form.jsp");
       		}
        	out.println("<p>用户名不存在或密码错误，请重新填写。<a href=\"javascript:history.go(-1)\">（返回）</a>");
        %>

    </body>
</html>