<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ include file="function.jsp"%>

<%!
    String name = new String();
    String password1 = new String();
    String password2 = new String();
%>

<%
    name = request.getParameter("name").toString();
    password1 = request.getParameter("password1").toString();
    password2 = request.getParameter("password2").toString();
%>

<html>
    <head>
        <meta charset="gb2312">
        <title>注册结果</title>
        <style>
            h2 {text-align: center; color: red;}
            p {text-align: center;}
        </style>
    </head>
    <body>

<%
	try {
		if (name.equals("")){
        	out.println("<h2>注册失败</h2>");
            out.println("<p>用户名不能为空！<a href=\"javascript:history.go(-1)\">返回</a></p>");
        } else if (judgeExists(name)) {
            out.println("<h2>注册失败</h2>");
            out.println("<p>用户名已存在！<a href=\"javascript:history.go(-1)\">返回</a></p>");
        } else if (!password1.equals(password2)) {
            out.println("<h2>注册失败</h2>");
            out.println("<p>两次输入的密码不同！<a href=\"javascript:history.go(-1)\">返回</a></p>");
        } else if (addUser(name, password1)) {
            out.println("<h2>注册成功</h2>");
            out.println("<p>注册成功！<a href=\"index.jsp\">登陆</a></p>");
        } else {
            out.println("<h2>注册失败</h2>");
            out.println("<p>注册失败，发生了点意外……<a href=\"javascript:history.go(-1)\">返回</a></p>");
            throw new Exception("Register failed!");
        }
	}catch (Exception e) {
		e.printStackTrace();
    }
%>

    </body>
</html>