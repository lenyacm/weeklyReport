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
        <title>ע����</title>
        <style>
            h2 {text-align: center; color: red;}
            p {text-align: center;}
        </style>
    </head>
    <body>

<%
	try {
		if (name.equals("")){
        	out.println("<h2>ע��ʧ��</h2>");
            out.println("<p>�û�������Ϊ�գ�<a href=\"javascript:history.go(-1)\">����</a></p>");
        } else if (judgeExists(name)) {
            out.println("<h2>ע��ʧ��</h2>");
            out.println("<p>�û����Ѵ��ڣ�<a href=\"javascript:history.go(-1)\">����</a></p>");
        } else if (!password1.equals(password2)) {
            out.println("<h2>ע��ʧ��</h2>");
            out.println("<p>������������벻ͬ��<a href=\"javascript:history.go(-1)\">����</a></p>");
        } else if (addUser(name, password1)) {
            out.println("<h2>ע��ɹ�</h2>");
            out.println("<p>ע��ɹ���<a href=\"index.jsp\">��½</a></p>");
        } else {
            out.println("<h2>ע��ʧ��</h2>");
            out.println("<p>ע��ʧ�ܣ������˵����⡭��<a href=\"javascript:history.go(-1)\">����</a></p>");
            throw new Exception("Register failed!");
        }
	}catch (Exception e) {
		e.printStackTrace();
    }
%>

    </body>
</html>