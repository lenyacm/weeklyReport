<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312" %>

<html>
    <head>
        <meta charset="gb2312">
        <title>�˺�ע��</title>
        <style type="text/css">
            h2 {text-align: center;}
        </style>
        <link rel="stylesheet" type="text/css" href="type.css">
    </head>
    <body>
        <h2>�˺�ע��</h2>
        <form name="user_info" action="register_result.jsp" method=POST>
            <table>
                <tr>
                    <td>�û�����</td>
                    <td><input type="text" name="name"></td>
                </tr>
                <tr>
                    <td>���룺</td>
                    <td><input type="password" name="password1"></td>
                </tr>
                <tr>
                    <td>�ٴ��������룺</td>
                    <td><input type="password" name="password2"></td>
                </tr>
            </table>
            <div class=center>
                <input type="submit" value="�ύ">
                <input type="reset" value="����">
            </div>
        </form>
    </body>
</html>
